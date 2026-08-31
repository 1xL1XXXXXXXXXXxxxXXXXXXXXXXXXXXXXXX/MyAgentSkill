# Safe Validation Plan

&gt; **Requires explicit authorization.** All activities in this plan must be approved by the system owner.

## Scope
- **Target API:** 
- **Environment:** Non-production / Production (specify)
- **Endpoints in scope:**
- **Endpoints out of scope:**

## Test Accounts
- **Account 1 (Regular User):** 
- **Account 2 (Admin User):** 
- **Account 3 (Other User for BOLA tests):** 
- **Data classification used:** Synthetic / Non-sensitive only

## Validation Activities

### 1. Documentation & Configuration Review (No risk)
- Review OpenAPI spec for missing auth requirements
- Check security headers on OPTIONS/GET responses
- Verify rate limit headers exist

### 2. Schema & Input Validation (Low risk)
- Send valid requests and confirm expected responses
- Send requests with extra/unknown properties; verify rejection
- Send oversized payloads; verify rejection

### 3. Authorization Validation (Low risk, requires explicit authorization)
- **BOLA:** Access own resources with Account 1. Attempt to access Account 3's resources using predictable IDs. Expect 403/404.
- **BFLA:** Access admin endpoint with Account 1. Expect 403.
- **Property Level:** Compare GET responses between Account 1 and Account 2 for field leakage.

### 4. Rate Limiting Validation (Low risk)
- Send sequential requests up to documented limit + 1. Expect throttling.
- Test pagination by requesting max page size + 1. Expect truncation/rejection.

### 5. Business Flow Validation (Low risk)
- Attempt to repeat a sensitive flow (e.g., booking) rapidly. Expect anti-automation or business limit response.

## Constraints
- No brute force or credential stuffing
- No production PII access
- No denial-of-service testing
- No SSRF against internal production services
- Stop immediately if unexpected errors or data exposure occurs

## Rollback Plan
- All test data created will be deleted via [method].
- Test accounts will be disabled after validation.

## Sign-off
| Role | Name | Date | Signature |
|------|------|------|-----------|
| System Owner | | | |
| Security Lead | | | |
| API Owner | | | |