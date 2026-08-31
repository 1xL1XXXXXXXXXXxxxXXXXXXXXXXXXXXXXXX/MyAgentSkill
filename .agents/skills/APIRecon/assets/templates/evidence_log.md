# Evidence Log — {{PROGRAM_NAME}}

| Time | Item | Source | Command | Raw Path | Confidence | Notes |
|------|------|--------|---------|----------|-----------|-------|
| | | | | | | |

## Required Fields
- **Time**: ISO 8601 with timezone (e.g., `2026-08-31T13:43+03:30`)
- **Item**: The endpoint, host, or artifact discovered
- **Source**: Tool or origin (e.g., `httpx`, `gau`, `JS bundle`)
- **Command**: Exact command run (for reproducibility)
- **Raw Path**: File path to raw output/screenshot
- **Confidence**: See confidence model
- **Notes**: Context, auth requirements, next safe step

## Example Entry
```
| 2026-08-31T13:43+03:30 | /openapi.json | Probe | curl -sI ... | evidence/doc_probe.txt | Observed | 200 JSON, JWT auth |
```
