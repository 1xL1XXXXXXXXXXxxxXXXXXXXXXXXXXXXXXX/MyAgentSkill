# Example: OWASP Finding Mapping

## Finding: Order ID Enumeration Allows Unauthorized Access

### Finding ID
DEMO-2026-001

### Title
BOLA via Predictable Order IDs in GET /orders/{id}

### Description
The GET /orders/{id} endpoint accepts sequential integer order IDs and returns order details without verifying that the requesting user owns the order. An attacker with a valid JWT could iterate through order IDs to access other customers' orders.

### Affected Component
- Endpoint: `https://api.example.com/v2/orders/{id}`
- Method: GET
- Parameter: `id` (path parameter)
- Environment: Staging

### OWASP Mapping

#### Primary Category
- **List:** OWASP API Security Top 10 2023
- **ID:** API1:2023
- **Name:** Broken Object Level Authorization
- **Rationale:** The endpoint fails to verify that the authenticated user is authorized to access the specific order object identified by `id`.

#### Secondary Category
- **List:** OWASP Web Top 10 2021
- **ID:** A01:2021
- **Name:** Broken Access Control
- **Rationale:** This is the broader web application category that encompasses BOLA/IDOR vulnerabilities.

### Evidence
- Observation: `GET /orders/1001` with `buyer_a` token returned order details for buyer_b.
- Response included: `customer_email`, `shipping_address`, `payment_last_four`.
- Sanitized log: `2026-08-31T10:00:00Z | 200 | buyer_a | /orders/1001 | order_owner: buyer_b`

### Risk Rating
| Factor | Score | Notes |
|--------|-------|-------|
| Likelihood | 5 | Easy to exploit; only requires valid auth token and ID guessing |
| Impact | 4 | Exposure of PII and payment data |
| **Overall** | **High** | |

### Remediation
1. **Immediate:** Add an ownership check in `GET /orders/{id}`: verify `order.user_id == jwt.sub` before returning data.
2. **Long-term:** Migrate order IDs from sequential integers to UUIDs to reduce predictability.
3. **Verification:** Re-run BOLA test with owned test accounts; confirm 403 for non-owned resources.

### Safe Validation Steps (Requires explicit authorization)
1. Create two test accounts: `buyer_a` and `buyer_b`.
2. Place an order with `buyer_b`; note the order ID.
3. Request that order ID using `buyer_a`'s token.
4. Confirm the API returns `403 Forbidden` or `404 Not Found`.

### References
- OWASP API Security Top 10 2023 — API1:2023
- OWASP Cheat Sheet: Authorization
- OWASP ASVS V4.1 — Access Control