#!/usr/bin/env bash
# API Reconnaissance — Inventory Builder & Risk Scoring
# Consolidates all sources, dedupes, groups, scores risk, and generates reports.

set -euo pipefail

echo "[+] Phase 9: Build Endpoint Inventory"

# Merge all sources
cat endpoints/urls_api.txt endpoints/endpoints_clean.txt \
    schemas/openapi_paths.txt mobile/mobile_endpoints.txt 2>/dev/null \
  | uro 2>/dev/null | sort -u > endpoints/inventory_raw.txt || sort -u endpoints/endpoints_clean.txt > endpoints/inventory_raw.txt

# Collapse numeric/UUID IDs into placeholders
sed -E 's~/[0-9]+~/{id}~g; s~/[0-9a-f-]{36}~/{uuid}~g' endpoints/inventory_raw.txt \
  | sort -u > endpoints/inventory_grouped.txt

# Web vs Mobile diff
echo "[+] Phase 9: Web vs Mobile Surface Diff"
comm -13 <(sort endpoints/endpoints_clean.txt 2>/dev/null) <(sort mobile/mobile_endpoints.txt 2>/dev/null) > endpoints/mobile_only.txt 2>/dev/null || true

# Undocumented endpoints (JS/SDK vs official docs)
if [ -f schemas/openapi_paths.txt ]; then
    comm -23 <(sort endpoints/endpoints_clean.txt 2>/dev/null) <(sort schemas/openapi_paths.txt 2>/dev/null) > endpoints/undocumented.txt 2>/dev/null || true
fi

echo "[+] Phase 7: Docs / Schema Discovery (Curated, Low-Noise)"
# Check curated doc paths against known-alive API hosts
paths=(/openapi.json /swagger.json /api-docs /v1/swagger.json /v2/openapi.json)
while read -r host; do
    for p in "${paths[@]}"; do
        curl -s -o /dev/null -w "%{http_code} %{content_type} $host$p\n" \
          --max-time 10 "$host$p" 2>/dev/null || true
        sleep 1
    done
done < endpoints/api_hosts.txt 2>/dev/null | tee evidence/doc_probe.txt || true

# Parse any discovered OpenAPI specs
for f in docs/*.json; do
    [ -f "$f" ] || continue
    jq -r '.paths | keys[]' "$f" 2>/dev/null | sort -u >> schemas/openapi_paths.txt || true
    jq -r '.paths | to_entries[] | .key as $p | .value | keys[] | "\(.) \($p)"' "$f" 2>/dev/null >> schemas/openapi_methods.txt || true
    jq -r '.servers[]?.url' "$f" 2>/dev/null | sort -u >> endpoints/base_urls.txt || true
    jq -r '.components.securitySchemes // .securityDefinitions' "$f" 2>/dev/null > schemas/security_schemes.txt || true
    jq -r '.tags[]?.name' "$f" 2>/dev/null | sort -u > schemas/tags.txt || true
done

echo "[+] Phase 8: GraphQL Recon (Identify Only)"
# Benign GET to identify GraphQL behavior (no payload abuse)
while read -r host; do
    curl -s --max-time 10 "$host/graphql" -H 'accept: application/json' 2>/dev/null | jq . 2>/dev/null | head -20 > evidence/graphql_probe_$(echo "$host" | md5sum | cut -c1-8).txt || true
    sleep 1
done < endpoints/api_hosts.txt 2>/dev/null || true

echo "[+] Phase 13: High-Value Pattern Hunt"
rg -i '/admin|/internal|/export|/billing|/payment|/api-keys|/webhook|/oauth|/sessions|/invite|/roles|/audit|/search|/bulk|/import' \
  endpoints/inventory_grouped.txt 2>/dev/null | sort -u > endpoints/high_value.txt || true

echo "[+] Phase 12: Auth Mapping (from docs/headers)"
# Extract auth indicators from evidence
cat evidence/httpx_probe.txt 2>/dev/null | rg -i 'www-authenticate|authorization|x-api-key|bearer|jwt' > evidence/auth_headers.txt 2>/dev/null || true

echo "[+] Phase 18: Safe Validation (Headers Only)"
# Existence + headers for high-value endpoints
while read -r endpoint; do
    [ -n "$endpoint" ] || continue
    # Ensure URL scheme
    if [[ ! "$endpoint" =~ ^https?:// ]]; then
        endpoint="https://$endpoint"
    fi
    curl -sI --max-time 10 "$endpoint" 2>/dev/null | head -5 > evidence/validation_$(echo "$endpoint" | md5sum | cut -c1-8).txt || true
    sleep 1
done < <(head -50 endpoints/high_value.txt 2>/dev/null || true)

echo "[+] Generating Evidence Summary"
{
  echo "# Evidence Summary"
  echo "Run: $(date -Iseconds)"
  echo "- Subdomains: $(wc -l < domains/subs.txt 2>/dev/null || echo 0)"
  echo "- Alive hosts: $(wc -l < domains/alive.txt 2>/dev/null || echo 0)"
  echo "- API hosts: $(wc -l < endpoints/api_hosts.txt 2>/dev/null || echo 0)"
  echo "- Endpoints (raw): $(wc -l < endpoints/inventory_raw.txt 2>/dev/null || echo 0)"
  echo "- Endpoints (grouped): $(wc -l < endpoints/inventory_grouped.txt 2>/dev/null || echo 0)"
  echo "- High-value: $(wc -l < endpoints/high_value.txt 2>/dev/null || echo 0)"
  echo "- Mobile endpoints: $(wc -l < mobile/mobile_endpoints.txt 2>/dev/null || echo 0)"
  echo "- GQL operations: $(wc -l < schemas/gql_operations_from_js.txt 2>/dev/null || echo 0)"
  echo "- Doc URLs: $(wc -l < docs/doc_urls.txt 2>/dev/null || echo 0)"
} | tee reports/evidence_summary.md

echo "[+] Inventory builder complete."
