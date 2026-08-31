---
name: api-reconnaissance
description: >
  A comprehensive, passive-first, evidence-driven API reconnaissance methodology 
  for authorized security engagements. Guides the agent through systematic 
  discovery, inventory building, risk scoring, and safe validation of API surfaces 
  without crossing into unauthorized or aggressive testing. Includes scripts, 
  templates, checklists, and a full command workflow.
triggers:
  - api recon
  - reconnaissance
  - bug bounty
  - pentest
  - API discovery
  - subdomain enumeration
  - endpoint discovery
  - security assessment
  - scope mapping
  - attack surface
---

# API Reconnaissance Skill

> **Philosophy:** Map before you touch. Prove before you claim. Never confuse a generic pattern with a finding.

This skill provides a complete, reusable methodology for API reconnaissance in **authorized engagements only**. It is built the way a senior researcher actually works: **passive-first**, **evidence-driven**, and **safe by default**.

## When to Use This Skill

Invoke this skill when you need to:
- Map the API attack surface of an authorized target
- Discover subdomains, endpoints, and API hosts systematically
- Build a defensible inventory with confidence labels and evidence trails
- Score risk and prioritize validation targets safely
- Perform reconnaissance that respects scope, rate limits, and ethical boundaries

## Prerequisites

Before starting any recon session:

1. **Confirm authorization** — re-read the program's scope, out-of-scope list, and testing constraints. Scopes change.
2. **Prepare scope files** — create `scope/scope.txt` (in-scope) and `scope/out_of_scope.txt`.
3. **Review rate-limit rules** — note any program-specific throttling or active-testing restrictions.
4. **Install tools** — ensure the tool stack (see [references/tool_stack.md](references/tool_stack.md)) is available.

## Core Principles

| Principle | Rule |
|-----------|------|
| **Authorization First** | Only test assets explicitly listed in scope. A subdomain resolving to your target's IP is **not** authorization. |
| **Passive Before Active** | Passive recon (archives, public code, DNS) is generally safe. Active recon (probing, crawling, fuzzing) touches the target and must respect rate limits and program rules. |
| **Evidence Everything** | Record source, command, timestamp, and raw output path for every finding. |
| **Never Use Secrets** | If you find a key/token, **mask it** (show first/last 4 chars max), note the location, and report responsibly. Never validate or store live secrets. |
| **Map, Don't Attack** | No exploit chains, auth bypass, token theft, rate-limit bypass, data exfiltration, or destructive requests. |

## Quick Start

Run the workspace setup, then follow the phases in order:

```bash
# 1. Setup workspace structure
bash scripts/setup_workspace.sh

# 2. Passive recon (safe, no target impact)
bash scripts/passive_recon.sh

# 3. Active recon (throttled, in-scope only)
bash scripts/active_recon.sh

# 4. JavaScript endpoint mining
bash scripts/js_mining.sh

# 5. Mobile static analysis (if APK available)
bash scripts/mobile_recon.sh

# 6. Build consolidated inventory
bash scripts/inventory_builder.sh
```

## Phase Overview

| Phase | Goal | Risk Level | Key Output |
|-------|------|------------|------------|
| **Phase 1** — Scope Preparation | Clean, deduped scope files | None | `scope/roots.txt`, `scope/in_scope_hosts.txt` |
| **Phase 2** — Subdomain Discovery | Broad asset list, isolate API hosts | Low (passive) | `domains/subs.txt`, `endpoints/api_hosts.txt` |
| **Phase 3** — HTTP Probing | Enrich alive hosts with tech signals | Low–Med | `evidence/httpx_probe.txt` |
| **Phase 4** — Archive Recon | Historical endpoints, old docs | Low (passive) | `urls/urls_clean.txt` |
| **Phase 5** — Web Crawling | Frontend-called endpoints | Med (active) | `urls/urls.txt` |
| **Phase 6** — JS Mining | Extract endpoints from bundles | Low (local) | `endpoints/endpoints_clean.txt` |
| **Phase 7** — Docs Discovery | OpenAPI/Swagger/Redoc mapping | Low | `docs/openapi.json`, `schemas/openapi_paths.txt` |
| **Phase 8** — GraphQL Recon | Identify and characterize GraphQL | Low–Med | `schemas/gql_operations.txt` |
| **Phase 9** — REST Inventory | Consolidated, deduped endpoint list | None | `endpoints/inventory_grouped.txt` |
| **Phase 10** — Public Code | SDKs, changelogs, generated clients | Low (passive) | `endpoints/` (supplemental) |
| **Phase 11** — Mobile Recon | APK decompilation, static analysis | Low (static) | `mobile/mobile_endpoints.txt` |
| **Phase 12** — Auth Mapping | Understand auth boundaries | Low | Auth mapping table |
| **Phase 13** — High-Value Hunt | Locate admin, export, billing, etc. | None | `endpoints/high_value.txt` |

## Confidence Model

Every item must carry a confidence label. Never overstate.

| Label | Meaning |
|-------|---------|
| **Observed** | Directly seen live (probe/response captured) |
| **Documented** | Present in official docs/OpenAPI |
| **Archived** | Found in web archive; may be stale |
| **Referenced** | Mentioned in JS/SDK/code, not yet live-confirmed |
| **Inferred** | Deduced from patterns; unverified |
| **Generic Pattern** | Common convention, not target-specific |
| **Unknown** | Insufficient evidence |

## Risk Scoring

Score each dimension 1–5 (5 = highest concern), then sort inventory by total.

| Dimension | 1 | 3 | 5 |
|-----------|---|---|---|
| Exposure | Internal-only | Partner | Fully public |
| Sensitivity | Public data | Business data | PII / financial |
| Auth complexity | Strong, consistent | Mixed | None / weak |
| Authorization boundary risk | Strong isolation | Some checks | Sequential IDs, thin checks |
| Multi-tenancy | Single tenant | Some sharing | Cross-tenant params |
| Business impact | Cosmetic | Moderate | Revenue / trust critical |
| Legacy/undocumented | Current + documented | Deprecated | Undocumented + live |
| Evidence strength | Inferred | Referenced | Observed |
| Safe testability | Hard to validate safely | Partial | Fully validatable safely |

**Prioritize:** high exposure × sensitivity × weak auth, backed by strong evidence and safe testability.

## What Must Never Be Done

- ❌ No exploit chains, auth bypass, token/credential theft, rate-limit bypass, data exfiltration, or destructive requests.
- ❌ No IDOR exploitation against other users' data — mapping object-ID patterns is fine; pulling another tenant's records is not.
- ❌ No mass fuzzing, brute force, or dynamic mobile interception without **explicit authorization**.
- ❌ Never use, validate, or store live secrets. Mask and report only.
- ❌ Never pivot to out-of-scope hosts because they "look interesting."

## Templates & Checklists

Use the provided templates for consistent, credible reporting:

- [assets/templates/findings_table.md](assets/templates/findings_table.md) — Structured findings log
- [assets/templates/evidence_log.md](assets/templates/evidence_log.md) — Timestamped evidence trail
- [assets/templates/safe_validation_plan.md](assets/templates/safe_validation_plan.md) — Pre-test validation checklist
- [assets/checklists/field_checklist.md](assets/checklists/field_checklist.md) — Complete session checklist

## References

- [references/tool_stack.md](references/tool_stack.md) — Full tool stack with risk levels and safe commands
- [references/risk_matrix.md](references/risk_matrix.md) — Risk scoring matrix and prioritization logic
- [references/confidence_model.md](references/confidence_model.md) — Evidence and confidence labeling guide

## Full Workflow

For a complete, copy-adaptable command workflow from empty folder to scored inventory, see the scripts in `scripts/`. Each script is self-contained, throttled, and safe by default.

---

*Built for authorized security research. Passive-first. Evidence-driven. Safe by default.*
