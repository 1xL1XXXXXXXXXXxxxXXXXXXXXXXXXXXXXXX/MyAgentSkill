# API Security Review Checklist

&gt; Use this checklist during design reviews, code reviews, or pre-deployment assessments.

## Pre-Review
- [ ] Scope defined (endpoints, versions, environments)
- [ ] Authorization to review obtained
- [ ] API documentation available (OpenAPI/Swagger, GraphQL schema)
- [ ] Test accounts provisioned
- [ ] Non-production environment identified for dynamic testing

---

## API1:2023 — Broken Object Level Authorization
- [ ] Every endpoint that accepts an object ID performs an ownership check
- [ ] Authorization logic is enforced server-side, not client-side
- [ ] Indirect reference maps (UUIDs) are used instead of predictable sequential IDs
- [ ] Admin/resource access returns consistent 403/404 regardless of resource existence
- [ ] Batch endpoints validate ownership for every item in the collection

## API2:2023 — Broken Authentication
- [ ] Authentication uses standard protocols (OAuth 2.0, OIDC) or well-vetted libraries
- [ ] Passwords meet complexity requirements and are hashed with adaptive algorithms
- [ ] MFA is enforced for sensitive operations
- [ ] Tokens have short expiration and secure rotation
- [ ] Failed auth attempts are rate-limited and logged
- [ ] Session/token revocation is implemented and tested

## API3:2023 — Broken Object Property Level Authorization
- [ ] Request bodies use DTOs with explicit allowlists
- [ ] Unknown properties in requests are rejected (strict schema validation)
- [ ] Responses do not expose internal fields (password hashes, internal IDs, PII)
- [ ] Property filtering is role-aware
- [ ] Mass assignment protections are in place (e.g., `bind` protections in frameworks)

## API4:2023 — Unrestricted Resource Consumption
- [ ] Rate limiting is enforced per user/IP/API key
- [ ] Maximum payload size is enforced
- [ ] Pagination is mandatory on list endpoints
- [ ] GraphQL query depth and complexity limits are set
- [ ] Resource quotas exist for expensive operations
- [ ] Circuit breakers protect downstream services

## API5:2023 — Broken Function Level Authorization
- [ ] All endpoints require explicit authorization (deny by default)
- [ ] Admin and user endpoints are clearly separated
- [ ] HTTP method switching is authorized (e.g., GET → DELETE)
- [ ] Role hierarchy is enforced in a centralized policy engine or middleware
- [ ] Direct endpoint access without the expected UI flow is blocked

## API6:2023 — Unrestricted Access to Sensitive Business Flows
- [ ] Sensitive flows are identified (purchase, booking, transfer, etc.)
- [ ] Anti-automation controls exist (CAPTCHA, proof-of-work, device fingerprinting)
- [ ] Business-level rate limits apply (e.g., max purchases per hour)
- [ ] Anomaly detection monitors for automated abuse
- [ ] Flows include business constraints (deposits, cooling-off periods)

## API7:2023 — Server Side Request Forgery
- [ ] All user-supplied URIs are validated against an allowlist
- [ ] Dangerous URL schemes are disabled (file://, ftp://, gopher://)
- [ ] The API cannot reach internal metadata endpoints (e.g., 169.254.169.254)
- [ ] Outbound fetching uses a hardened proxy with restricted egress
- [ ] All outbound requests are logged

## API8:2023 — Security Misconfiguration
- [ ] Default accounts/credentials are removed or changed
- [ ] Debug endpoints, stack traces, and verbose errors are disabled in production
- [ ] Security headers are present (HSTS, CSP, X-Content-Type-Options, etc.)
- [ ] CORS policy is restrictive, not wildcard
- [ ] Unnecessary HTTP methods are disabled
- [ ] API versions and environments are segregated

## API9:2023 — Improper Inventory Management
- [ ] API inventory is accurate and up-to-date
- [ ] All endpoints are documented
- [ ] Deprecated versions are retired and inaccessible
- [ ] Non-production APIs are not exposed to the internet without extra controls
- [ ] Third-party APIs are included in inventory

## API10:2023 — Unsafe Consumption of APIs
- [ ] Upstream API responses are schema-validated
- [ ] Data from third-party APIs is sanitized before use
- [ ] Mutual TLS or certificate validation is used for service-to-service calls
- [ ] Timeouts, retries, and circuit breakers are configured
- [ ] Third-party API failures fail safely (graceful degradation)

---

## General
- [ ] TLS 1.2+ is enforced for all communications
- [ ] Security events are logged (auth, access control failures, anomalies)
- [ ] Logs are protected from tampering
- [ ] Error messages do not leak sensitive information
- [ ] API changes are reviewed for security impact