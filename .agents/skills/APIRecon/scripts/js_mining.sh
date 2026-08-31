#!/usr/bin/env bash
# API Reconnaissance — JavaScript Endpoint Mining
# Extracts endpoints, secrets (masked), GraphQL ops, and base URLs from JS bundles.

set -euo pipefail

echo "[+] Phase 6: Extract Endpoints from JS Bundles"

# Primary: xnLinkFinder
xnLinkFinder -i js/ -o endpoints/raw_endpoints.txt 2>/dev/null || true

# Secondary: LinkFinder per-file
for f in js/*.js; do
    [ -f "$f" ] || continue
    python linkfinder.py -i "$f" -o cli 2>/dev/null | anew endpoints/raw_endpoints.txt || true
done

# Path & route hunting
rg -oN -e '/api/[a-zA-Z0-9_./-]+' \
      -e '/v[0-9]+/[a-zA-Z0-9_./-]+' \
      -e '/(rest|rpc|graphql|admin|internal)/[a-zA-Z0-9_./-]*' \
      -e '/(upload|download|export|invoice|billing|webhook|token|session|oauth)[a-zA-Z0-9_./-]*' \
      js/ 2>/dev/null | sort -u | anew endpoints/raw_endpoints.txt || true

# Client-call hunting (fetch / axios / XHR / WebSocket)
rg -oN -e "fetch\(['"\`][^'"\`]+" \
      -e "axios\.(get|post|put|delete|patch)\(['"\`][^'"\`]+" \
      -e "new XMLHttpRequest" \
      -e "wss?://[a-zA-Z0-9_./:-]+" \
      js/ 2>/dev/null | sort -u >> endpoints/raw_endpoints.txt || true

# GraphQL operations in bundles
rg -oN -e '(query|mutation|subscription)\s+[A-Za-z0-9_]+' \
      -e 'gql`[^`]+`' \
      js/ 2>/dev/null | sort -u > schemas/gql_operations_from_js.txt || true

# Base URL discovery
rg -oN -e 'https?://[a-zA-Z0-9.-]+\.[a-z]{2,}(/[a-zA-Z0-9_./-]*)?' js/ 2>/dev/null \
  | rg -i 'api|graphql|gateway' 2>/dev/null | sort -u > endpoints/base_urls.txt || true

# Source map hunting
rg -o 'sourceMappingURL=[^ ]+' js/ 2>/dev/null | sort -u > endpoints/source_maps.txt || true

# Secret scanning (ethical — mask everything)
echo "[+] Phase 6: Secret Scan (mask + report only)"
for f in js/*.js; do
    [ -f "$f" ] || continue
    python SecretFinder.py -i "$f" -o cli 2>/dev/null | sed -E 's/([A-Za-z0-9]{4})[A-Za-z0-9_-]{10,}([A-Za-z0-9]{4})/\1****...****\2/g' | anew evidence/secrets_masked.txt || true
done

# Clean & dedupe pipeline
cat endpoints/raw_endpoints.txt \
  | sed -E 's/[)"'"'"'\`,].*$//' \
  | grep -E '^(/|https?://)' \
  | uro 2>/dev/null \
  | sort -u > endpoints/endpoints_clean.txt || sort -u endpoints/raw_endpoints.txt > endpoints/endpoints_clean.txt

# False-positive reduction: drop asset paths, library internals, analytics
cat > /tmp/noise_patterns.txt <<'NOISE'
\.png$
\.css$
\.woff$
\.woff2$
\.ttf$
\.eot$
/node_modules/
/google-analytics/
/gtag/
NOISE
grep -vFf /tmp/noise_patterns.txt endpoints/endpoints_clean.txt > endpoints/endpoints_clean_filtered.txt 2>/dev/null || true
mv endpoints/endpoints_clean_filtered.txt endpoints/endpoints_clean.txt 2>/dev/null || true

echo "[+] JS mining complete."
echo "    - Raw endpoints:    $(wc -l < endpoints/raw_endpoints.txt 2>/dev/null || echo 0)"
echo "    - Clean endpoints:  $(wc -l < endpoints/endpoints_clean.txt 2>/dev/null || echo 0)"
echo "    - GQL operations:   $(wc -l < schemas/gql_operations_from_js.txt 2>/dev/null || echo 0)"
echo "    - Base URLs:        $(wc -l < endpoints/base_urls.txt 2>/dev/null || echo 0)"
