# API Reconnaissance Skill for OpenHands

A comprehensive, passive-first, evidence-driven API reconnaissance methodology packaged as an OpenHands AgentSkill.

## Overview

This skill converts the "Practical API Recon Playbook" into a structured, reusable OpenHands skill that guides the agent through systematic API discovery, inventory building, risk scoring, and safe validation — all within authorized boundaries.

## Structure

```
api-recon-skill/
├── SKILL.md                           # Main skill file (metadata + instructions)
├── README.md                          # This file
├── scripts/
│   ├── setup_workspace.sh             # Creates canonical folder structure
│   ├── passive_recon.sh               # Zero-impact passive discovery
│   ├── active_recon.sh                # Throttled active probing & crawling
│   ├── js_mining.sh                   # Endpoint extraction from JS bundles
│   ├── mobile_recon.sh                # APK static analysis
│   └── inventory_builder.sh           # Consolidation, scoring, and reporting
├── references/
│   ├── tool_stack.md                  # Full tool stack with risk levels
│   ├── risk_matrix.md                 # 9-dimension risk scoring matrix
│   └── confidence_model.md            # Evidence labeling guide
└── assets/
    ├── templates/
    │   ├── findings_table.md          # Structured findings log
    │   ├── evidence_log.md            # Timestamped evidence trail
    │   └── safe_validation_plan.md    # Pre-test validation checklist
    └── checklists/
        └── field_checklist.md         # Complete session checklist
```

## Installation

### Option 1: Local Skills Directory

Copy the `api-recon-skill` folder into your project's `.agents/skills/` or `.openhands/skills/` directory:

```bash
cp -r api-recon-skill /path/to/your/project/.agents/skills/
```

### Option 2: OpenHands Marketplace

Install via the OpenHands SDK:

```python
from openhands.sdk.skills import install_skill

install_skill(source="/path/to/api-recon-skill", installed_dir="~/.openhands/skills/installed/")
```

### Option 3: Inline Usage

```python
from openhands.sdk.skills import load_skills_from_dir
from openhands.sdk import AgentContext

_, _, agent_skills = load_skills_from_dir("/path/to/api-recon-skill")
agent_context = AgentContext(skills=list(agent_skills.values()))
```

## Triggers

This skill auto-triggers on these keywords in user messages:

- `api recon`
- `reconnaissance`
- `bug bounty`
- `pentest`
- `API discovery`
- `subdomain enumeration`
- `endpoint discovery`
- `security assessment`
- `scope mapping`
- `attack surface`

## Usage Flow

1. **Setup**: Run `scripts/setup_workspace.sh <target.com>`
2. **Passive**: Run `scripts/passive_recon.sh` (zero target impact)
3. **Active**: Run `scripts/active_recon.sh` (throttled, in-scope only)
4. **JS Mining**: Run `scripts/js_mining.sh` (rich endpoint extraction)
5. **Mobile**: Run `scripts/mobile_recon.sh <app.apk>` (if applicable)
6. **Inventory**: Run `scripts/inventory_builder.sh` (consolidate + score)

## Key Principles

- **Authorization First** — Only test explicitly in-scope assets
- **Passive Before Active** — Archives and DNS before probing
- **Evidence Everything** — Source, command, timestamp, raw path
- **Never Use Secrets** — Mask and report only
- **Map, Don't Attack** — No exploitation during recon

## Confidence Labels

Every finding must be labeled:
- **Observed** — Live response captured
- **Documented** — Official docs/OpenAPI
- **Archived** — Wayback/archive
- **Referenced** — JS/SDK mention
- **Inferred** — Pattern deduction
- **Generic Pattern** — Common convention
- **Unknown** — Insufficient evidence

## License

This skill is derived from a public security research methodology. Use only on authorized targets.
