# Field Checklist — API Recon Session

## Pre-flight
- [ ] Authorization confirmed + scope re-read
- [ ] `scope.txt` / `out_of_scope.txt` current
- [ ] Rate-limit & active-testing rules noted
- [ ] Folder structure created (`scripts/setup_workspace.sh`)

## Passive Recon
- [ ] subfinder / amass passive / assetfinder → `domains/subs.txt`
- [ ] dnsx resolve → `domains/resolved.txt`
- [ ] gau / waybackurls / waymore → `urls/urls.txt` (uro-cleaned)
- [ ] GitHub / gh CLI: SDKs, base URLs, docs
- [ ] Postman public workspace search
- [ ] Archived JS + source maps checked

## Active Recon (Throttled, In-Scope Only)
- [ ] httpx probe (status/title/tech/content-type, rate-limited)
- [ ] `api_hosts.txt` filtered
- [ ] katana / hakrawler crawl (rate-limited)
- [ ] getJS + download JS (sleep between requests)
- [ ] xnLinkFinder / LinkFinder → `endpoints/raw_endpoints.txt`

## JS Mining
- [ ] `/api` `/v1` `/graphql` `/admin` `/upload` `/oauth` patterns
- [ ] fetch/axios/XHR/WebSocket calls
- [ ] GraphQL operation names
- [ ] Base URLs extracted
- [ ] `endpoints_clean.txt` deduped
- [ ] Secrets masked and reported (never used)

## Docs & Schema
- [ ] Curated doc-path check on alive hosts (no mass fuzz)
- [ ] OpenAPI parsed: paths / methods / servers / security / tags
- [ ] GraphQL: identify only; introspection ONLY if permitted

## Mobile (Static)
- [ ] jadx / apktool decompile
- [ ] apkleaks (mask secrets)
- [ ] Manifest: exported components, deep links
- [ ] `network_security_config` reviewed (read-only)
- [ ] `mobile_endpoints.txt` built
- [ ] Dynamic interception ⚠️ requires authorization + owned device

## Consolidation
- [ ] Merge all sources → `inventory_grouped.txt`
- [ ] Web vs mobile vs docs diffs run
- [ ] Auth mapped per endpoint
- [ ] `high_value.txt` built
- [ ] Risk matrix scored

## Evidence & Reporting
- [ ] Every item: source + command + timestamp + raw path + confidence
- [ ] Secrets masked, reported responsibly, never used
- [ ] Confidence labels applied (Observed/Documented/Archived/Referenced/Inferred/Generic/Unknown)
- [ ] Reports assembled (Surface Map, Inventory, Evidence Log, Risk Matrix, Validation Plan, Summary)

## Guardrails (Never)
- [ ] No auth bypass / IDOR against others / token abuse
- [ ] No mass fuzz / brute force without explicit authorization
- [ ] No destructive methods
- [ ] No out-of-scope pivoting
