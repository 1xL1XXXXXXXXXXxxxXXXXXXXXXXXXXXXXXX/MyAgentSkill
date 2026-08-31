---
name: awesome-api-security
version: 1.0.0
description: >
  A comprehensive API security skill derived from the awesome-api-security repository.
  Activates when the user discusses API penetration testing, REST/GraphQL/SOAP security,
  API fuzzing, Swagger/OpenAPI testing, BOLA/IDOR in APIs, OAuth/API key security,
  API vulnerability assessment, or API hardening.
  Triggers: API security, pentest API, GraphQL security, REST API test, API fuzzing,
  Swagger security, OpenAPI test, API vulnerability, BOLA, IDOR, API key leak,
  OAuth security, API WAF, API scanning, API hacking, API bug bounty.
---

# Awesome API Security — Pentester's Battle Manual

## Mission
When the user asks anything about API security testing, vulnerability discovery, or hardening,
use this skill to provide precise, categorized, battle-tested recommendations.

## Workflow

1. **Identify the API type**: REST, GraphQL, SOAP, gRPC, or generic.
2. **Identify the phase**: Recon → Enumeration → Scanning → Fuzzing → Exploitation → Hardening.
3. **Pick tools from the relevant section below.**
4. **Recommend vulnerable labs** if the user wants to practice.
5. **Reference checklists** to ensure nothing is missed.

---

## Phase 1: Reconnaissance & Enumeration

| Tool | Purpose |
|------|---------|
| **getallurls (gau)** | Fetch known URLs from AlienVault OTX, Wayback, Common Crawl |
| **unfurl** | Pull out bits of URLs for analysis |
| **noir** | Attack surface detector from source code |
| **kiterunner** | Contextual content discovery + API route brute-force |
| **API Routes Wordlists (Assetnote)** | Automated wordlists for API discovery |
| **Common API endpoints wordlist** | 3203 common endpoints for fuzzing |
| **List of Swagger endpoints** | Discover Swagger/OpenAPI docs |
| **Burp API enumeration** | Using Burp to enumerate REST APIs |
| **ZAP exploring** | Exploring APIs with OWASP ZAP |

### Wordlists for API Fuzzing
- API names wordlist
- API HTTP requests methods (by @danielmiessler)
- GraphQL SecList
- Hacking-APIs wordlists (@hapi_hacker)
- Kiterunner Wordlists
- SecLists for API web-content discovery
- GraphQL wordlist (60k+ schemas collected)

---

## Phase 2: Scanning & Discovery

| Tool | Purpose |
|------|---------|
| **Arjun** | HTTP parameter discovery suite |
| **graphinder** | Blazing fast GraphQL endpoints finder |
| **goctopus** | GraphQL discovery & fingerprinting toolbox |
| **graphw00f** | GraphQL Server Engine Fingerprinting |
| **clairvoyance** | Obtain GraphQL schema despite disabled introspection |
| **APIKit** | Discovery, Scan and Audit APIs Toolkit |
| **APICheck** | DevSecOps toolset for REST APIs |
| **mitmproxy2swagger** | Reverse-engineer REST APIs via traffic capture |
| **APIClarity** | Reconstruct OpenAPI specs from real-time traffic |
| **Optic** | Verify OpenAPI 3.x spec accuracy using real traffic |
| **wadl-dumper** | Dump all paths/endpoints from WADL files |

---

## Phase 3: Fuzzing & Automated Testing

### REST API Fuzzers
| Tool | Purpose |
|------|---------|
| **ffuf** | Fast web fuzzer written in Go |
| **APIFuzzer** | Fuzz test using OpenAPI/Swagger definition without coding |
| **CATS** | REST API Fuzzer and negative testing tool for OpenAPI |
| **fuzz-lightyear** | DAST framework for distributed microservices via Swagger fuzzing |
| **fuzzapi** | REST API pentesting fuzzer |
| **RESTler** | Stateful REST API fuzzing for cloud services (Microsoft) |
| **TnT-Fuzzer** | OpenAPI 2.0 fuzzer |
| **WuppieFuzz** | Coverage-guided REST API fuzzer (black/grey/white box) |
| **Automatic API Attack Tool** | Imperva's customizable API attack tool from spec |
| **OFFAT** | OWASP OFFAT — autonomous API vulnerability assessment |

### GraphQL Fuzzers & Testers
| Tool | Purpose |
|------|---------|
| **GraphQLmap** | Scripting engine to interact with GraphQL for pentesting |
| **graphql-cop** | Security Auditor Utility for GraphQL APIs |
| **graphql-path-enum** | Lists ways of reaching a type in GraphQL schema |
| **InQL** | Burp Extension for GraphQL Security Testing |
| **BatchQL** | GraphQL batch queries/mutations security auditing |

### SOAP
| Tool | Purpose |
|------|---------|
| **Wsdler** | WSDL Parser extension for Burp |
| **wsdl-wizard** | Detect and discover WSDL files via Burp |

---

## Phase 4: Exploitation & Specific Attacks

### API Key & Token Validation
| Tool | Purpose |
|------|---------|
| **API Guesser** | Guess API Key / OAuth Token |
| **Key-Checker** | Check API key / access token validity (Go) |
| **Keyhacks** | Quick ways to check leaked API keys validity |
| **Driftwood** | Verify if private key is used for TLS or GitHub SSH |
| **Mantra** | Hunt API key leaks in JS files and pages |

### Business Logic / AuthZ
- **BOLA (Broken Object Level Authorization)** — #1 OWASP API Top 10
- **IDOR** — Test every parameter that references an object
- **Mass Assignment** — Send unexpected fields in POST/PUT
- **Excessive Data Exposure** — Check responses for sensitive fields

---

## Phase 5: Defense & Hardening

### API Firewalls
| Tool | Purpose |
|------|---------|
| **BunkerWeb** | Open-source WAF with ModSecurity, bot blocking, rate limiting |
| **Wallarm Free API Firewall** | API proxy firewall for request/response validation by OpenAPI |

### API Security Posture
| Tool | Purpose |
|------|---------|
| **Akto** | API discovery, automated business logic testing, runtime detection |
| **Metlo** | Open-source API security — discover, inventory, test, protect |
| **Cherrybomb** | CLI tool to validate API specifications |
| **Astra** | Automated Security Testing for REST APIs |
| **dredd** | Language-agnostic HTTP API Testing Tool |
| **Step CI** | API Quality Assurance framework (REST, GraphQL, gRPC) |
| **SoapUI** | Functional testing for APIs and web services |

---

## Deliberately Vulnerable APIs — Training Grounds

| Lab | Type | Author |
|-----|------|--------|
| **crAPI** | REST | OWASP |
| **VAmPI** | REST (OWASP Top 10 for APIs) | erev0s |
| **vAPI** | REST (OWASP API Top 10 exercises) | roottusk |
| **Damn Vulnerable RESTaurant API** | REST (Game) | theowni |
| **Damn Vulnerable GraphQL Application** | GraphQL | dolevf |
| **Damn Vulnerable Micro Services** | Microservices | ne0z |
| **vulnerable-graphql-api** | GraphQL | CarveSystems |
| **node-api-goat** | REST (Express.js) | layro01 |
| **Pixi** | MEAN Stack (wildly insecure) | DevSlop |
| **REST API Goat** | REST | optiv |
| **APISandbox** | Multiple API scenarios | APISecurity Community |
| **Generic-University** | REST/GraphQL (Laravel) | InsiderPhD |
| **VulnerableApp4APISecurity** | .NET 7.0 API | Erdemstar |
| **Websheep** | ReSTful APIs | marmicode |

---

## Checklists — Never Miss a Finding

| Checklist | Focus |
|-----------|-------|
| **OWASP API Security Top 10** | Industry standard |
| **API-Security-Checklist (Shieldfy)** | Design, test, release countermeasures |
| **API penetration testing checklist (@api_sec)** | Common pentest steps |
| **31 days of API Security Tips (Inon Shkedy)** | Daily tips challenge |
| **OAuth2: Security checklist (Binary Brotherhood)** | OAuth 2.0 threat model |
| **GraphQL Security Checklist (Apollo)** | 9 ways to secure GraphQL |
| **GraphQL Vulnerability Checklist (LeapGraph)** | Complete GraphQL vuln checklist |
| **REST API Security Essentials** | REST-specific basics |

---

## Cheatsheets — Quick Reference

| Cheatsheet | Topic |
|------------|-------|
| **OWASP REST Assessment** | REST assessment steps |
| **OWASP REST Security** | REST security guidelines |
| **OWASP GraphQL** | GraphQL security |
| **OWASP JWT Security** | JSON Web Token security |
| **OWASP Injection Prevention** | General injection defense |
| **OWASP Microservices Security** | Microservices-specific |
| **42Crunch OWASP API Top 10** | API Top 10 breakdown |

---

## Mind Maps — Visual Attack Planning

| Mind Map | Author |
|----------|--------|
| **REST API defenses** | Abhay Bhargav |
| **API Pentesting — ATTACK** | Cypro AB |
| **API Pentesting — Recon** | Cypro AB |
| **GraphQL Attacking** | Cypro AB |
| **MindAPI** | David Sopas |
| **XML attacks** | Harsh Bothra |
| **GraphQL Security Testing** | Mosaad Sallam |
| **OWASP API Top 10** | Mosaad Sallam |
| **IDOR Techniques** | Mufaddal Masalawala |

---

## Books — Deep Knowledge

| Book | Author | Focus |
|------|--------|-------|
| **Hacking APIs** | Corey Ball | Offensive API testing |
| **API Security in Action** | Neil Madden | Building secure APIs |
| **Black Hat GraphQL** | Dolev Farhi & Nick Aleks | GraphQL attacks |
| **API Security for White Hat Hackers** | Confidence Staveley | Offensive + defense |
| **Defending APIs** | Colin Domoney | Developer-focused defense |
| **Secure APIs: Design, build, implement** | José Haro Peralta | Practical techniques |
| **Understanding API Security** | Richer & Sanso | Real-world context |
| **API Security for dummies** | Emily Freeman | High-level intro |

---

## Training & Labs

| Resource | Type |
|----------|------|
| **API Security University (APIsec)** | Courses |
| **API Security Academy (Escape)** | Interactive |
| **OWASP API Top 10 CTF (Grant Ongers)** | CTF walkthrough |
| **Kontra OWASP Top 10 for API** | Free interactive modules |
| **Pentester Academy REST Labs** | Attack & defense labs |
| **Hacker101 GraphQL challenges** | CTF challenges |
| **Semgrep Academy API Security Mini Course** | Short course |
| **ShipFast Practical API Security** | Mobile + API techniques |
| **Let's build an API to hack (@TheXSSrat)** | Hands-on exercises |
| **BankGround API (Karel Husa)** | Banking-like REST/GraphQL for training |

---

## HTTP 101 Reference

| Resource | What |
|----------|------|
| Know your HTTP Headers | Simplified headers table |
| Know your HTTP Methods | Methods table |
| Know your HTTP Status codes | Status codes reference |
| httpstatuses.com | Easy status code database |

---

## When to Use What — Decision Matrix

| Scenario | Recommended Tools |
|----------|-------------------|
| Black-box API pentest | gau + kiterunner + ffuf + Arjun + ZAP/Burp |
| GraphQL target | graphinder + clairvoyance + GraphQLmap + InQL + graphql-cop |
| SOAP target | Wsdler + wsdl-wizard + SoapUI |
| Swagger/OpenAPI available | CATS + TnT-Fuzzer + Swagger-EZ + Cherrybomb |
| API key leak suspected | Mantra + Keyhacks + Key-Checker |
| CI/CD API security | APICheck + dredd + Step CI + Astra |
| Runtime API protection | Metlo + Akto + BunkerWeb + Wallarm |
| Learning/practice | crAPI + VAmPI + vAPI + DVGA |

---

## Pro Tips from the Field

1. **Always start with recon**: Even if you have Swagger docs, run `gau` and `kiterunner` — undocumented endpoints are goldmines.
2. **GraphQL introspection is just the beginning**: If introspection is disabled, use `clairvoyance` to reconstruct the schema.
3. **BOLA is still king**: In 2025, Broken Object Level Authorization remains the #1 finding. Test every ID parameter.
4. **Fuzz with context**: Don't just throw wordlists. Use `kiterunner` for contextual discovery based on API behavior.
5. **Validate your findings**: Use `Key-Checker` or `Keyhacks` before reporting leaked keys — false positives kill credibility.
6. **Mind the business logic**: Automated scanners miss BOLA/IDOR. Manual testing with tools like `Burp` or `ZAP` is irreplaceable.
7. **Check JS files**: `Mantra` often finds API keys and endpoints buried in frontend JavaScript.

---

## References
- Source: https://github.com/arainho/awesome-api-security
- OWASP API Security Project: https://owasp.org/www-project-api-security/
- OWASP API Top 10 2023: https://owasp.org/API-Security/editions/2023/en/0x00-header/
