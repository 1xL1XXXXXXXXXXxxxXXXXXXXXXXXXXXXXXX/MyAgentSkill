# Safe Testing Notes

## Philosophy
All security validation must be:
1. **Authorized** — Written permission from the system owner.
2. **Safe** — No risk of data loss, service degradation, or legal violation.
3. **Minimal** — Use the least intrusive method necessary to validate a control.
4. **Reversible** — Prefer read-only observations over state-changing actions.

## Rules of Engagement

### Do
- Use dedicated test accounts and test data.
- Test in non-production environments when possible.
- Validate controls by observing responses (status codes, headers, error messages).
- Review documentation, code, and configuration before dynamic testing.
- Stop immediately if testing could affect real users or data.

### Do Not
- Attempt to access production data belonging to real users.
- Use automated scanners against systems without explicit authorization.
- Attempt credential stuffing, brute force, or password guessing against live systems.
- Inject payloads designed to extract, modify, or delete production data.
- Test denial-of-service conditions against shared infrastructure.
- Share findings publicly without the system owner's consent.

## Labeling
Any activity that requires explicit authorization must be labeled:
&gt; **"Requires explicit authorization."**

## Safe Testing Methods

| Method | Description | Risk Level |
|--------|-------------|------------|
| Documentation Review | Review API specs, auth docs, rate limit policies | None |
| Configuration Audit | Review security headers, CORS, TLS settings | None |
| Code Review | Static analysis of authorization logic | None |
| Owned Account Testing | Use your own test account to verify self-access controls | Low |
| Schema Validation | Verify request/response schemas match documentation | None |
| Header Inspection | Check for security headers, verbose errors | None |
| Rate Limit Probe | Send a small number of requests to confirm limits exist | Low |

## Escalation
If a test requires crossing into higher-risk territory (e.g., testing BOLA between two test accounts), ensure:
- Both accounts are owned by the tester or explicitly provisioned for testing.
- The target resources are synthetic/non-sensitive.
- A responsible party has approved the test scope.