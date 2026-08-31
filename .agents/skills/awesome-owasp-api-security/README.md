# awesome-owasp-api-security

A defensive, educational Agent Skill for OWASP Top 10 and OWASP API Security Top 10. Designed for AI agents assisting with authorized security education, secure code review, API security analysis, threat modeling, checklist generation, safe testing guidance, and defensive reporting.

## What's Inside

- **References:** Accurate, non-hallucinated deep dives into OWASP Web Top 10 and API Security Top 10
- **Templates:** Ready-to-use checklists, threat models, validation plans, and report structures
- **Examples:** Filled-in templates showing expected output quality
- **Safety First:** All guidance is defensive, authorized, and minimal

## OWASP API Security Top 10 2023 (Verified)

| ID | Category | Note |
|----|----------|------|
| API1:2023 | Broken Object Level Authorization | #1 since 2019 |
| API2:2023 | Broken Authentication | |
| API3:2023 | Broken Object Property Level Authorization | Merges 2019's Excessive Data Exposure + Mass Assignment |
| API4:2023 | Unrestricted Resource Consumption | Was "Lack of Resources & Rate Limiting" in 2019 |
| API5:2023 | Broken Function Level Authorization | |
| API6:2023 | Unrestricted Access to Sensitive Business Flows | New in 2023 |
| API7:2023 | Server Side Request Forgery | New in 2023 |
| API8:2023 | Security Misconfiguration | |
| API9:2023 | Improper Inventory Management | Was "Improper Assets Management" in 2019 |
| API10:2023 | Unsafe Consumption of APIs | New in 2023; replaces 2019's Insufficient Logging and Monitoring |

## OWASP Web Top 10 2021 (Verified)

| ID | Category |
|----|----------|
| A01:2021 | Broken Access Control |
| A02:2021 | Cryptographic Failures |
| A03:2021 | Injection |
| A04:2021 | Insecure Design |
| A05:2021 | Security Misconfiguration |
| A06:2021 | Vulnerable and Outdated Components |
| A07:2021 | Identification and Authentication Failures |
| A08:2021 | Software and Data Integrity Failures |
| A09:2021 | Security Logging and Monitoring Failures |
| A10:2021 | Server-Side Request Forgery (SSRF) |

&gt; **Note:** OWASP Top 10 2025 was released in late 2025. It introduces two new categories (Software Supply Chain Failures, Mishandling of Exceptional Conditions) and consolidates SSRF into Broken Access Control. See `references/OWASP_WEB_TOP_10.md` for details.

## Quick Start

1. **Explain a category:** Ask about any API1–API10 or A01–A10 category.
2. **Generate a checklist:** Use `templates/API_SECURITY_REVIEW_CHECKLIST.md`.
3. **Map a finding:** Use `templates/OWASP_FINDING_MAPPING_TEMPLATE.md`.
4. **Threat model an API:** Use `templates/API_THREAT_MODEL_TEMPLATE.md`.
5. **Plan safe validation:** Use `templates/SAFE_VALIDATION_PLAN.md`.
6. **Write a report:** Use `templates/REPORT_TEMPLATE.md`.

## Safety & Ethics

- This Skill is for **authorized defensive security work only**.
- All testing guidance assumes you own the target or have explicit written authorization.
- No exploit chains, no credential theft, no destructive testing advice is included.

## License

This Skill package is provided as educational material. OWASP content is licensed under CC-BY-SA 4.0 where applicable.