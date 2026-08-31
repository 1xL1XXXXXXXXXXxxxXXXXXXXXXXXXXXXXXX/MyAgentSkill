# Example: Safe API Security Review

## Context
- **API:** E-Commerce Order API v2.1
- **Environment:** Staging
- **Auth:** OAuth 2.0 + JWT
- **Reviewer:** Security Engineer (authorized)

## Step 1: Documentation Review
Reviewed OpenAPI 3.0 spec. Identified 34 endpoints across 5 resources: `/orders`, `/products`, `/users`, `/admin`, `/webhooks`.

## Step 2: Configuration Review
- TLS 1.3 enforced: **Pass**
- Security headers present (`Strict-Transport-Security`, `X-Content-Type-Options`): **Pass**
- CORS allows `*` on staging (acceptable for staging, flagged for prod): **Flag**
- Rate limit headers (`X-RateLimit-Limit`) present: **Pass**

## Step 3: Safe Authorization Testing (Requires explicit authorization)
Used three owned test accounts:
- `buyer_a@example.com` (regular user)
- `buyer_b@example.com` (regular user, for BOLA tests)
- `admin@example.com` (admin)

### BOLA Test
- `GET /orders/{order_id}` with `buyer_a` token accessing `buyer_a`'s order: `200 OK`
- `GET /orders/{order_id}` with `buyer_a` token accessing `buyer_b`'s order: `403 Forbidden` ✅
- Attempted sequential ID enumeration: returned consistent `403` for all non-owned resources ✅

### BFLA Test
- `GET /admin/users` with `buyer_a` token: `403 Forbidden` ✅
- `DELETE /admin/users/{id}` with `buyer_a` token: `403 Forbidden` ✅

### Property Level Test
- `GET /users/me` response for `buyer_a` did not include `password_hash`, `internal_notes`, or `role` ✅
- `PATCH /users/me` with extra field `{"role": "admin"}`: `400 Bad Request` with "unknown field" error ✅

### Rate Limiting Test
- Sent 105 requests to `/products` within 60 seconds.
- Request 101+ returned `429 Too Many Requests` with `Retry-After: 60` ✅

## Findings
1. **Low:** CORS wildcard flagged for production hardening.
2. **Info:** Rate limit headers present and enforced.

## Conclusion
No critical or high findings. API demonstrates strong authorization controls. CORS policy should be reviewed before production deployment.