#!/usr/bin/env bash
# API Reconnaissance — Active Recon Phase
# Throttled probing and crawling against in-scope, known-alive hosts only.

set -euo pipefail

RATE_LIMIT="${RATE_LIMIT:-20}"

echo "[+] Phase 3 (continued): HTTP Probing with Tech Detection"
httpx -l domains/resolved_hosts.txt -silent \
  -status-code -title -tech-detect \
  -server -content-type -location -response-time -cdn \
  -rate-limit "$RATE_LIMIT" -o evidence/httpx_probe.txt 2>/dev/null || true

# Extract alive hosts
httpx -l domains/resolved_hosts.txt -silent -o domains/alive.txt 2>/dev/null || true

echo "[+] Phase 5: Isolate API-like Hosts"
grep -Ei '(^|[.-])(api|apis|gateway|graphql|gql|developer|devs?|staging|stg|sandbox|sbx|partner|mobile|m)([.-]|$)' \
  domains/alive.txt 2>/dev/null | sort -u > endpoints/api_hosts.txt || true

echo "[+] Phase 5: Web Crawling (Throttled)"
katana -list domains/alive.txt -jc -kf all -rl "$RATE_LIMIT" -silent 2>/dev/null | anew urls/urls.txt || true
cat domains/alive.txt | hakrawler -subs -u 2>/dev/null | anew urls/urls.txt || true

echo "[+] Phase 5: Extract JS File List"
cat domains/alive.txt | getJS --complete 2>/dev/null | anew urls/js_urls.txt || true
rg -i '\.js(\?|$)' urls/urls_clean.txt 2>/dev/null | sort -u | anew urls/js_urls.txt || true

echo "[+] Phase 5: Download JS Safely (Throttled)"
mkdir -p js
while read -r u; do
    fname="js/$(echo "$u" | md5sum | cut -c1-12).js"
    curl -s --max-time 15 -A "recon-authorized" "$u" -o "$fname" 2>/dev/null || true
    sleep 1
done < urls/js_urls.txt

echo "[+] Active recon complete."
echo "    - Alive hosts:   $(wc -l < domains/alive.txt 2>/dev/null || echo 0)"
echo "    - API hosts:     $(wc -l < endpoints/api_hosts.txt 2>/dev/null || echo 0)"
echo "    - JS files:      $(ls js/ 2>/dev/null | wc -l || echo 0)"
