# OWASP ASVS Mapping for API Security

&gt; Source: OWASP Application Security Verification Standard (ASVS)

## Overview
ASVS provides testable security requirements across 14 chapters and 3 verification levels (L1, L2, L3). For API security, the most relevant chapters are V4 (Access Control), V5 (Validation), V9 (Communication), V11 (Business Logic), V13 (API and Web Service), and V14 (Configuration).

## ASVS Chapters (Verified)

| Chapter | Title | API Relevance |
|---------|-------|---------------|
| V1 | Architecture, Design and Threat Modeling | Threat modeling for API design |
| V2 | Authentication | API authentication mechanisms |
| V3 | Session Management | Token lifecycle, session binding |
| V4 | Access Control | BOLA, BFLA, authorization enforcement |
| V5 | Validation, Sanitization and Encoding | Input validation, injection prevention |
| V6 | Stored Cryptography | Encryption at rest, key management |
| V7 | Error Handling and Logging | Secure logging, error message safety |
| V8 | Data Protection | PII handling, data classification |
| V9 | Communication | TLS, certificate validation |
| V10 | Malicious Code | Dependency integrity, SCA |
| V11 | Business Logic | Anti-automation, workflow integrity |
| V12 | Files and Resources | File upload, path traversal |
| V13 | API and Web Service | REST, SOAP, GraphQL security |
| V14 | Configuration | Hardening, dependency management |

## API-Specific ASVS Mapping

### API1:2023 — Broken Object Level Authorization
- **ASVS V4.1** — Verify that the application enforces access control rules on a trusted service layer.
- **ASVS V4.2** — Verify that directory browsing is not enabled.
- **ASVS V4.3** — Verify the application defends against Insecure Direct Object Reference (IDOR) / BOLA.

### API2:2023 — Broken Authentication
- **ASVS V2.1** — Verify password security requirements.
- **ASVS V2.2** — Verify general authentication mechanisms.
- **ASVS V2.3** — Verify MFA where required.
- **ASVS V2.5** — Verify credential recovery mechanisms.

### API3:2023 — Broken Object Property Level Authorization
- **ASVS V4.1** — Verify access controls prevent unauthorized property access.
- **ASVS V5.1** — Verify input validation on all properties.
- **ASVS V8.1** — Verify protection of sensitive data exposure.

### API4:2023 — Unrestricted Resource Consumption
- **ASVS V11.1** — Verify business logic limits.
- **ASVS V13.2** — Verify rate limiting on API endpoints.
- **ASVS V14.2** — Verify resource quota enforcement.

### API5:2023 — Broken Function Level Authorization
- **ASVS V4.1** — Verify role-based access control.
- **ASVS V4.4** — Verify administrative functions require elevated privileges.

### API6:2023 — Unrestricted Access to Sensitive Business Flows
- **ASVS V11.1** — Verify anti-automation controls.
- **ASVS V11.2** — Verify workflow integrity checks.

### API7:2023 — Server Side Request Forgery
- **ASVS V5.2** — Verify protection against SSRF.
- **ASVS V12.6** — Verify that the application does not allow unauthorized file retrieval.

### API8:2023 — Security Misconfiguration
- **ASVS V14.1** — Verify build and deployment hardening.
- **ASVS V14.2** — Verify security headers and configuration.
- **ASVS V14.3** — Verify dependency management.

### API9:2023 — Improper Inventory Management
- **ASVS V1.1** — Verify documentation of application components.
- **ASVS V14.1** — Verify environment segregation.

### API10:2023 — Unsafe Consumption of APIs
- **ASVS V5.1** — Verify validation of data from upstream sources.
- **ASVS V9.2** — Verify mutual authentication for service-to-service calls.
- **ASVS V10.1** — Verify integrity checks on code and data.

## Verification Levels for APIs

| Level | Use Case |
|-------|----------|
| **L1** | Low-risk APIs, public data. Black-box testing sufficient. |
| **L2** | APIs handling sensitive data (PII, financial). Most enterprise APIs. |
| **L3** | Critical infrastructure, high-value financial/health APIs. |

## References
- OWASP ASVS: https://owasp.org/www-project-application-security-verification-standard/
- ASVS GitHub: https://github.com/OWASP/ASVS