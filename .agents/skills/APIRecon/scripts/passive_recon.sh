#!/usr/bin/env bash
# API Reconnaissance — Passive Recon Phase
# Zero target impact. Uses public sources, archives, and DNS.

set -euo pipefail

RATE_LIMIT="${RATE_LIMIT:-20}"

echo "[+] Phase 1: Scope Preparation"
sort -u scope/roots.txt -o scope/roots.txt

# Separate in-scope vs out-of-scope (if out_of_scope.txt has content)
if [ -s scope/out_of_scope.txt ]; then
    grep -vxF -f scope/out_of_scope.txt scope/roots.txt       > scope/in_scope_hosts.txt 2>/dev/null || cp scope/roots.txt scope/in_scope_hosts.txt
else
    cp scope/roots.txt scope/in_scope_hosts.txt
fi

echo "[+] Phase 2: Passive Subdomain Enumeration"
subfinder -dL scope/roots.txt -all -silent 2>/dev/null | anew domains/subs.txt || true
amass enum -passive -df scope/roots.txt 2>/dev/null | anew domains/subs.txt || true
cat scope/roots.txt | assetfinder --subs-only 2>/dev/null | anew domains/subs.txt || true

echo "[+] Phase 3: DNS Resolution"
dnsx -l domains/subs.txt -a -resp -silent 2>/dev/null | tee domains/resolved.txt || true
awk '{print $1}' domains/resolved.txt 2>/dev/null | sort -u > domains/resolved_hosts.txt || true

echo "[+] Phase 4: Archive URL Collection (Passive)"
cat scope/roots.txt | gau --threads 5 2>/dev/null | anew urls/urls.txt || true
cat scope/roots.txt | waybackurls 2>/dev/null | anew urls/urls.txt || true
waymore -i "$(head -1 scope/roots.txt)" -mode U -oU urls/waymore.txt 2>/dev/null && cat urls/waymore.txt | anew urls/urls.txt || true

echo "[+] Phase 5: Normalize & Dedupe URLs"
cat urls/urls.txt | uro 2>/dev/null | sort -u > urls/urls_clean.txt || sort -u urls/urls.txt > urls/urls_clean.txt

echo "[+] Phase 6: Extract API-looking Patterns from Archives"
# API-looking + versioned
rg -i '/api/|/v[0-9]+/|/rest/|/rpc/' urls/urls_clean.txt 2>/dev/null | sort -u > endpoints/urls_api.txt || true
# JSON endpoints
rg -i '\.json(\?|$)|/json/' urls/urls_clean.txt 2>/dev/null | sort -u > endpoints/urls_json.txt || true
# GraphQL paths
rg -i '/graphql|/gql' urls/urls_clean.txt 2>/dev/null | sort -u > endpoints/urls_graphql.txt || true
# Swagger / OpenAPI files
rg -i 'swagger|openapi|api-docs|redoc' urls/urls_clean.txt 2>/dev/null | sort -u > docs/doc_urls.txt || true
# Upload/download surfaces
rg -i '/upload|/download|/export|/import|/file' urls/urls_clean.txt 2>/dev/null | sort -u > endpoints/urls_fileops.txt || true
# Auth/session/token-related PATHS (mapping only)
rg -i '/oauth|/token|/session|/login|/logout|/auth' urls/urls_clean.txt 2>/dev/null | sort -u > endpoints/urls_auth.txt || true

echo "[+] Phase 7: GitHub / Public Code Search (gh CLI)"
for root in $(cat scope/roots.txt); do
    gh search code "$root" --limit 30 2>/dev/null | tee evidence/gh_search_$root.txt || true
    gh search code "openapi" "$root" --limit 20 2>/dev/null | tee -a evidence/gh_search_$root.txt || true
    gh search repos "$root sdk" --limit 10 2>/dev/null | tee -a evidence/gh_search_$root.txt || true
done

echo "[+] Passive recon complete."
echo "    - Subdomains: $(wc -l < domains/subs.txt 2>/dev/null || echo 0)"
echo "    - Resolved:   $(wc -l < domains/resolved_hosts.txt 2>/dev/null || echo 0)"
echo "    - URLs:       $(wc -l < urls/urls_clean.txt 2>/dev/null || echo 0)"
