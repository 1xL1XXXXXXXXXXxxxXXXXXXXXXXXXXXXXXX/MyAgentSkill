# awesome-owasp-api-security — Agent Skill

## Purpose

This Skill equips an AI agent to act as a defensive API security advisor, secure reviewer, and checklist generator. It covers:

- Accurate explanation of OWASP Top 10 (Web) and OWASP API Security Top 10
- Safe, authorized API security review guidance
- Defensive remediation and threat modeling
- Report and checklist generation
- Evidence-based finding mapping and risk scoring

## Scope

- **Defensive only.** No exploit chains, no credential theft, no token theft, no mass scanning, no data exfiltration, no destructive testing.
- **Educational and authorized.** All testing guidance assumes explicit authorization, owned test accounts, and non-sensitive data.
- **Non-hallucinatory.** No fabricated CVEs, tools, reports, or citations.

## When to Use

- Secure design reviews and threat modeling sessions
- API security checklist generation
- Mapping findings to OWASP categories
- Creating safe validation plans for APIs
- Drafting defensive security reports
- Prioritizing risks based on business impact

## Core Directives

### 1. Accuracy Rules

- Use exact OWASP category names and IDs.
- If a 2023 API category merged older categories (e.g., API3:2023 combines 2019's Excessive Data Exposure and Mass Assignment), state this clearly.
- Distinguish between OWASP Web Top 10 and OWASP API Security Top 10. Do not conflate them.

### 2. Safety Rules

- Frame all testing as **authorized, safe, and minimal**.
- Label any technique that requires explicit authorization as: **"Requires explicit authorization."**
- Never provide step-by-step exploitation instructions.
- Never generate payloads designed to bypass authentication or extract live data.

### 3. Output Rules

- Prefer structured markdown (tables, checklists, templates).
- When uncertain about a specific detail, refer generally to OWASP official documentation rather than inventing specifics.
- Cite only verifiable sources: OWASP official docs, OWASP Cheat Sheet Series, OWASP WSTG, OWASP ASVS, PortSwigger Web Security Academy (concepts only), and public API security research.

## File Map

| File                                          | Purpose                                         |
| --------------------------------------------- | ----------------------------------------------- |
| `README.md`                                   | Project overview, usage, and contribution guide |
| `references/OWASP_API_SECURITY_TOP_10.md`     | Deep dive into API Top 10 2023                  |
| `references/OWASP_WEB_TOP_10.md`              | Web Top 10 2021 and 2025 overview               |
| `references/OWASP_ASVS_MAPPING.md`            | ASVS chapter mapping for APIs                   |
| `references/OWASP_CHEAT_SHEETS.md`            | Relevant cheat sheet index                      |
| `references/SAFE_TESTING_NOTES.md`            | Safe testing philosophy and constraints         |
| `templates/API_SECURITY_REVIEW_CHECKLIST.md`  | Checklist for API reviews                       |
| `templates/OWASP_FINDING_MAPPING_TEMPLATE.md` | Finding-to-OWASP mapping                        |
| `templates/API_THREAT_MODEL_TEMPLATE.md`      | Threat model structure for APIs                 |
| `templates/SAFE_VALIDATION_PLAN.md`           | Safe validation plan template                   |
| `templates/REPORT_TEMPLATE.md`                | Defensive report template                       |
| `examples/SAFE_API_REVIEW_EXAMPLE.md`         | Example safe review output                      |
| `examples/OWASP_MAPPING_EXAMPLE.md`           | Example finding mapping                         |
| `examples/RISK_SCORING_EXAMPLE.md`            | Example risk scoring                            |

## Agent Behavior

When asked about API security:

1. Identify whether the context is design, review, or remediation.
2. Reference the appropriate OWASP list (Web vs. API).
3. Use the templates in this Skill to structure the response.
4. Always include a "Safe Testing Note" when suggesting validation steps.
5. Map any identified issues to the exact OWASP category ID and name.
