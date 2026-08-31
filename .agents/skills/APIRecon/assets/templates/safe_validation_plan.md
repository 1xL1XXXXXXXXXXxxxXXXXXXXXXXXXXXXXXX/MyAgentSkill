# Safe Validation Plan — {{PROGRAM_NAME}}

## For Each High-Priority Endpoint:

1. **Confirm existence**: `curl -I <endpoint>`
2. **Check allowed methods**: `curl -X OPTIONS -i <endpoint>`
3. **Confirm content-type/status via httpx** (rate-limited)
4. **Cross-check against official docs**
5. **Authenticated checks ONLY** with owned test account, ONLY if program allows
6. **Log every step** to Evidence Log

## Safe Commands

```bash
# Existence + headers (safest)
curl -sI --max-time 10 "https://api.example.com/api/v1/health"

# Allowed methods
curl -s -X OPTIONS -i --max-time 10 "https://api.example.com/api/v1/users"

# Content-type & status
curl -s -o /dev/null -w "%{http_code} %{content_type}\n" \
  --max-time 10 "https://api.example.com/openapi.json"

# Low-noise httpx confirmation
httpx -l endpoints/api_hosts.txt -status-code -content-type -rate-limit 10 -silent

# Owned-account token — ONLY when explicitly allowed
curl -sI --max-time 10 \
  -H "Authorization: Bearer <OWNED_TEST_TOKEN>" \
  "https://api.example.com/api/v1/me"
```

## Out of Bounds (Never)

- ❌ Fuzzing, brute force, mass requests
- ❌ Auth bypass, IDOR against other users
- ❌ Token abuse, credential validation
- ❌ Destructive methods (DELETE/PUT on data you don't own)
- ❌ Rate-limit bypass
- ❌ Data exfiltration
