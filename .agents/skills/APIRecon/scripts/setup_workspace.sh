#!/usr/bin/env bash
# API Reconnaissance — Workspace Setup
# Creates the canonical folder structure for evidence-driven recon.

set -euo pipefail

TARGET_ROOT="${1:-example.com}"
WORKSPACE="api-recon"

echo "[+] Setting up workspace for: $TARGET_ROOT"

mkdir -p "$WORKSPACE"/{scope,domains,urls,js,endpoints,docs,schemas,mobile,evidence,reports}
cd "$WORKSPACE"

# Seed working files
touch scope/{scope.txt,out_of_scope.txt,roots.txt}
touch domains/{subs.txt,resolved.txt,alive.txt}
touch urls/{urls.txt,js_urls.txt}
touch endpoints/{raw_endpoints.txt,endpoints_clean.txt,api_hosts.txt,inventory_raw.txt,inventory_grouped.txt,high_value.txt}
touch reports/{findings.md,evidence.md,notes.md}

# Populate roots
echo "$TARGET_ROOT" > scope/roots.txt

# Normalize roots
cat scope/roots.txt   | sed -E 's~https?://~~; s~/.*$~~'   | tr 'A-Z' 'a-z'   | sort -u > scope/roots.txt.tmp && mv scope/roots.txt.tmp scope/roots.txt

# Seed notes template
cat > reports/notes.md <<'EOF'
# Engagement Notes
- Program:
- Scope confirmed on:
- Rate-limit rules:
- Active testing allowed? (fuzzing/scan):
- Out-of-scope reminders:
EOF

# Seed findings template
cat > reports/findings.md <<'EOF'
# Findings
| ID | Item | Source | Confidence | Risk | Status |
|----|------|--------|-----------|------|--------|
EOF

# Seed evidence log template
cat > reports/evidence.md <<'EOF'
# Evidence Log
| Time | Source | Command | Raw Path | Confidence | Notes |
|------|--------|---------|----------|-----------|-------|
EOF

echo "[+] Workspace ready at: $(pwd)"
echo "[+] Structure:"
find . -maxdepth 2 -type d | sort
