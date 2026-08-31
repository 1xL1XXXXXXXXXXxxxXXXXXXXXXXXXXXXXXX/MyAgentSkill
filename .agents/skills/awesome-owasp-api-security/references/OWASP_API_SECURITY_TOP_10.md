# OWASP API Security Top 10 — 2023 Edition

&gt; Source: OWASP API Security Project (owasp.org/www-project-api-security/)
&gt; Official list: owasp.org/API-Security/editions/2023/en/0x11-t10/

## Overview
The OWASP API Security Top 10 2023 was released in June 2023. It reflects the evolving API threat landscape, with three new categories, several renamed/modified categories, and one category dropped.

## Changes from 2019 to 2023
- **New:** API6:2023, API7:2023, API10:2023
- **Modified:** API3:2023 (merged two 2019 items), API4:2023 (renamed), API9:2023 (renamed)
- **Dropped from 2019:** Insufficient Logging and Monitoring (replaced by API10:2023)

---

## API1:2023 — Broken Object Level Authorization (BOLA)

**Description:** APIs expose endpoints that handle object identifiers, creating a wide attack surface for object-level access control issues. Authorization checks should be performed in every function that accesses a data source using an ID from the user.

**Why it matters:** BOLA has remained #1 since 2019 and is present in approximately 40% of API attacks. It allows attackers to access or modify data belonging to other users by manipulating object references (e.g., changing a `user_id` or `order_id` parameter).

**Defensive patterns:**
- Implement authorization checks at every data access point.
- Use indirect reference maps (e.g., UUIDs instead of sequential integers) to reduce predictability.
- Validate that the authenticated user owns the requested resource.
- Avoid relying solely on client-side controls.

**Safe testing guidance (Requires explicit authorization):**
- With owned test accounts, attempt to access resources using identifiers belonging to other test accounts.
- Verify that the API returns `403 Forbidden` or `404 Not Found` (with consistent messaging to avoid IDOR information leakage).
- Confirm that administrative endpoints require elevated roles.

---

## API2:2023 — Broken Authentication

**Description:** Authentication mechanisms are often implemented incorrectly, allowing attackers to compromise authentication tokens or exploit implementation flaws to assume other users' identities.

**Why it matters:** If the system cannot reliably identify the client/user, all subsequent authorization decisions are untrustworthy.

**Defensive patterns:**
- Use standardized authentication protocols (OAuth 2.0, OpenID Connect) rather than custom schemes.
- Enforce strong password policies and multi-factor authentication (MFA).
- Implement secure session/token lifecycle: short expiration, secure rotation, and revocation.
- Protect against brute force and credential stuffing via rate limiting and account lockouts.
- Store credentials using strong, adaptive hashing functions.

**Safe testing guidance (Requires explicit authorization):**
- Review token expiration, rotation, and revocation mechanisms in documentation.
- Test session timeout behavior with owned test accounts.
- Verify that failed authentication attempts are logged and rate-limited.

---

## API3:2023 — Broken Object Property Level Authorization

**Description:** This category merges two 2019 issues: **Excessive Data Exposure** and **Mass Assignment**. The root cause is lack of or improper authorization validation at the object property level, leading to information exposure or manipulation by unauthorized parties.

**Why it matters:** APIs may return more data than necessary (e.g., internal fields in a JSON response) or allow clients to write fields they should not (e.g., setting `is_admin=true` during profile update).

**Defensive patterns:**
- Define explicit data schemas (DTOs) for request and response bodies.
- Use allowlists for writable properties; reject unknown fields.
- Apply the principle of least privilege to data exposure: return only what the client needs.
- Validate property-level access before serialization.

**Safe testing guidance (Requires explicit authorization):**
- Inspect API responses for unexpected fields (e.g., internal IDs, password hashes, PII).
- Attempt to send extra properties in POST/PUT/PATCH requests and verify they are rejected.
- Compare responses across different user roles to ensure property-level filtering.

---

## API4:2023 — Unrestricted Resource Consumption

**Description:** Satisfying API requests requires resources (CPU, memory, storage, bandwidth) and may consume paid-per-request services (SMS, email, biometrics). Unrestricted consumption can lead to Denial of Service or increased operational costs.

**Why it matters:** APIs without rate limits or resource quotas are susceptible to brute force, scraping, and cost-abuse attacks.

**Defensive patterns:**
- Implement rate limiting per client/IP/user.
- Set maximum payload sizes and query depth limits (especially for GraphQL).
- Enforce pagination on list endpoints.
- Monitor resource usage and alert on anomalies.
- Implement circuit breakers for expensive operations.

**Safe testing guidance (Requires explicit authorization):**
- Send incrementally large payloads to verify size limits.
- Request large page sizes to confirm pagination enforcement.
- Verify that rate limit headers (`X-RateLimit-*` or `Retry-After`) are present and enforced.

---

## API5:2023 — Broken Function Level Authorization (BFLA)

**Description:** Complex access control policies with different hierarchies, groups, and roles lead to authorization flaws. Attackers may gain access to other users' resources or administrative functions.

**Why it matters:** Even if object-level checks exist, function-level checks may be missing. A regular user might invoke an admin endpoint by guessing the URL.

**Defensive patterns:**
- Deny by default: all functions require explicit authorization.
- Maintain a clear separation between administrative and regular API functions.
- Implement centralized authorization enforcement (e.g., policy engines, middleware).
- Validate user roles and permissions at every endpoint.

**Safe testing guidance (Requires explicit authorization):**
- Attempt to access administrative endpoints with a regular user test account.
- Verify that changing HTTP methods (GET → DELETE) on the same path is properly authorized.
- Confirm that role escalation requires proper workflow and validation.

---

## API6:2023 — Unrestricted Access to Sensitive Business Flows

**Description:** APIs expose business flows (e.g., purchasing, booking, commenting) without compensating controls for how automated, excessive use could harm the business.

**Why it matters:** This is not necessarily an implementation bug; it is a business-logic risk. Attackers may automate purchases, hoard inventory, or spam workflows.

**Defensive patterns:**
- Identify sensitive business flows through threat modeling.
- Implement anti-automation controls: CAPTCHA, proof-of-work, device fingerprinting.
- Apply business-level rate limits (e.g., max tickets per user).
- Monitor for anomalous patterns (e.g., 100 purchases in 1 minute).
- Design flows with business constraints in mind (e.g., deposit requirements for bulk bookings).

**Safe testing guidance (Requires explicit authorization):**
- Review business flows for missing anti-automation controls.
- Test flow repetition with owned test accounts to verify limits.
- Verify that monitoring and alerting exist for anomalous business flow usage.

---

## API7:2023 — Server Side Request Forgery (SSRF)

**Description:** SSRF flaws occur when an API fetches a remote resource without validating the user-supplied URI. Attackers can coerce the application to send requests to unexpected destinations.

**Why it matters:** Even behind firewalls/VPNs, APIs with SSRF can access internal services, metadata endpoints (e.g., cloud metadata services), or perform port scanning.

**Defensive patterns:**
- Validate and sanitize all user-supplied URIs using strict allowlists.
- Disable unnecessary URL schemas (e.g., `file://`, `ftp://`, `gopher://`).
- Enforce network segmentation; APIs should not reach internal metadata endpoints.
- Use a dedicated, hardened service for outbound fetching with restricted egress.
- Log all outbound requests.

**Safe testing guidance (Requires explicit authorization):**
- Review code and configuration for URI validation logic.
- Verify that the API cannot reach internal IP ranges or metadata endpoints.
- Confirm that only expected URL schemes are accepted.

---

## API8:2023 — Security Misconfiguration

**Description:** APIs and supporting systems contain complex configurations. Missed security settings, default credentials, unnecessary features, or verbose error messages create attack surface.

**Why it matters:** Misconfiguration is pervasive. It can expose stack traces, enable unsafe HTTP methods, or leave debug endpoints accessible.

**Defensive patterns:**
- Harden all environments (dev, staging, prod) consistently.
- Remove default accounts, sample data, and unused features.
- Disable verbose errors in production; return generic error messages.
- Configure security headers (HSTS, CSP, X-Content-Type-Options, etc.).
- Regularly audit configurations with automated scanners.

**Safe testing guidance (Requires explicit authorization):**
- Verify that default credentials are changed or disabled.
- Check for exposed debug endpoints, stack traces, or admin interfaces.
- Confirm that security headers are present on API responses.
- Review CORS policies for over-permissiveness.

---

## API9:2023 — Improper Inventory Management

**Description:** APIs expose more endpoints than traditional web apps. Outdated documentation, deprecated versions, and unknown hosts increase the attack surface.

**Why it matters:** You cannot protect what you do not know exists. Old API versions may lack security patches or modern controls.

**Defensive patterns:**
- Maintain an accurate, up-to-date API inventory.
- Document all endpoints, versions, and environments.
- Retire deprecated versions promptly.
- Ensure production and non-production APIs are segregated.
- Include third-party APIs in inventory.

**Safe testing guidance (Requires explicit authorization):**
- Compare documented endpoints against discovered endpoints.
- Identify deprecated versions still accessible in production.
- Verify that non-production APIs are not internet-facing without additional controls.

---

## API10:2023 — Unsafe Consumption of APIs

**Description:** APIs consume data from or integrate with other APIs. If these integrations bypass security controls, trust untrusted data, or fail to validate responses, they introduce risk.

**Why it matters:** Third-party API compromises, malicious redirects, or manipulated responses can cascade into your application.

**Defensive patterns:**
- Validate and sanitize all data received from upstream APIs.
- Do not blindly trust API responses; enforce schema validation.
- Use mutual TLS (mTLS) or certificate pinning where appropriate.
- Implement timeouts, retries, and circuit breakers for external calls.
- Monitor third-party API availability and integrity.

**Safe testing guidance (Requires explicit authorization):**
- Review third-party integration code for missing input validation.
- Verify that upstream API responses are schema-validated before processing.
- Check that sensitive operations do not rely solely on third-party assertions.

---

## Mapping to OWASP Web Top 10

| API Top 10 | Web Top 10 Relationship |
|------------|------------------------|
| API1: BOLA | Subset of A01:2021 Broken Access Control; also explicitly in A01:2025 |
| API2: Broken Authentication | Aligns with A07:2021 / A07:2025 Authentication Failures |
| API3: Broken Object Property Level Authorization | Subset of A01:2021 / A01:2025 Broken Access Control |
| API4: Unrestricted Resource Consumption | Related to A05:2021 / A02:2025 Security Misconfiguration and business logic |
| API5: BFLA | Subset of A01:2021 / A01:2025 Broken Access Control |
| API6: Unrestricted Access to Sensitive Business Flows | Related to A04:2021 / A06:2025 Insecure Design |
| API7: SSRF | Was A10:2021; merged into A01:2025 Broken Access Control |
| API8: Security Misconfiguration | Directly maps to A05:2021 / A02:2025 |
| API9: Improper Inventory Management | Related to A06:2021 / A03:2025 Software Supply Chain Failures |
| API10: Unsafe Consumption of APIs | Related to A08:2021 / A08:2025 Software or Data Integrity Failures |

---

## References
- OWASP API Security Project: https://owasp.org/www-project-api-security/
- OWASP API Security Top 10 2023: https://owasp.org/API-Security/editions/2023/en/0x11-t10/
- OWASP API Security Top 10 2023 PDF/Documentation: https://owasp.org/API-Security/