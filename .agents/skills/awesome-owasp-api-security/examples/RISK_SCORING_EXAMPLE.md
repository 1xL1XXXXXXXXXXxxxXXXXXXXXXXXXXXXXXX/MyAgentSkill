# Example: Risk Scoring

## Methodology
This example uses a simple Likelihood × Impact matrix aligned with OWASP API Security Top 10 categories.

### Scoring Scale
| Score | Likelihood | Impact |
|-------|------------|--------|
| 1 | Theoretical / Requires insider access | Minimal data exposure, no PII |
| 2 | Difficult / Requires multiple conditions | Limited non-sensitive data |
| 3 | Possible / Known technique | Moderate data exposure or business disruption |
| 4 | Easy / Publicly documented | Significant PII or financial impact |
| 5 | Trivial / Automated tools exist | Mass data breach or system compromise |

### Risk Rating
| Product | Rating |
|---------|--------|
| 1–3 | Low |
| 4–6 | Medium |
| 8–12 | High |
| 15–25 | Critical |

## Scored Findings

### 1. BOLA in Order API
- **Category:** API1:2023
- **Likelihood:** 5 (trivial with sequential IDs)
- **Impact:** 4 (PII + payment data)
- **Risk Score:** 20 → **Critical**

### 2. Missing Rate Limiting on Login
- **Category:** API2:2023 / API4:2023
- **Likelihood:** 4 (credential stuffing tools are public)
- **Impact:** 3 (account takeover possible)
- **Risk Score:** 12 → **High**

### 3. Verbose Error Messages in Production
- **Category:** API8:2023
- **Likelihood:** 3 (easy to trigger)
- **Impact:** 2 (stack traces aid reconnaissance)
- **Risk Score:** 6 → **Medium**

### 4. Deprecated API v1 Still Accessible
- **Category:** API9:2023
- **Likelihood:** 3 (known URL pattern)
- **Impact:** 3 (v1 lacks modern security controls)
- **Risk Score:** 9 → **High**

### 5. GraphQL Query Depth Unrestricted
- **Category:** API4:2023
- **Likelihood:** 3 (deep queries are easy to craft)
- **Impact:** 3 (DoS / resource exhaustion)
- **Risk Score:** 9 → **High**

## Prioritization Matrix

| Priority | Finding | Score | Quick Win? |
|----------|---------|-------|------------|
| P0 | BOLA in Order API | 20 | Yes (add ownership check) |
| P1 | Missing Rate Limiting | 12 | Yes (add middleware) |
| P1 | Deprecated v1 Accessible | 9 | Yes (add redirect/block) |
| P2 | GraphQL Depth Unrestricted | 9 | Yes (add depth limit) |
| P3 | Verbose Errors | 6 | Yes (config change) |

## Notes
- Prioritize findings that are both high-risk and quick to fix.
- BOLA (API1) consistently scores highest due to high likelihood and impact.
- Configuration issues (API8, API9) often score lower but are typically "quick wins."