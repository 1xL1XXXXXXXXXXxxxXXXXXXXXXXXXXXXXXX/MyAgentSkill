# API Threat Model Template

## System Overview
- **API Name:**
- **Version:**
- **Environment(s):**
- **Data Classification:** Public / Internal / Confidential / Restricted
- **Authentication Method:**
- **Primary Consumers:** Web app, Mobile app, Third-party integrators

## Data Flow Diagram (DFD)
Describe or attach a DFD showing:
1. External entities (clients, third-party APIs)
2. API endpoints/processes
3. Data stores (databases, caches, object storage)
4. Trust boundaries

## Threat Categories (STRIDE + OWASP API Top 10)

### Spoofing
- Threat: 
- API category link: API2:2023 Broken Authentication
- Mitigation:

### Tampering
- Threat:
- API category link: API3:2023 Broken Object Property Level Authorization
- Mitigation:

### Repudiation
- Threat:
- API category link: API9:2023 Improper Inventory Management (logging gaps)
- Mitigation:

### Information Disclosure
- Threat:
- API category link: API3:2023 Broken Object Property Level Authorization
- Mitigation:

### Denial of Service
- Threat:
- API category link: API4:2023 Unrestricted Resource Consumption
- Mitigation:

### Elevation of Privilege
- Threat:
- API category link: API1:2023 BOLA, API5:2023 BFLA
- Mitigation:

## OWASP API Top 10 Specific Threats

| ID | Threat | Likelihood | Impact | Risk | Mitigation |
|----|--------|------------|--------|------|------------|
| API1 | BOLA | | | | |
| API2 | Broken Authentication | | | | |
| API3 | Property Level AuthZ | | | | |
| API4 | Resource Consumption | | | | |
| API5 | BFLA | | | | |
| API6 | Business Flow Abuse | | | | |
| API7 | SSRF | | | | |
| API8 | Misconfiguration | | | | |
| API9 | Inventory Gaps | | | | |
| API10 | Unsafe API Consumption | | | | |

## Assumptions
- 
- 

## Open Questions
- 
- 

## Review Date
YYYY-MM-DD