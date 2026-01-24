# Deep Threat Model Workflow

This workflow instructs Cascade to assess security and privacy risks in a structured, repeatable way.

## 1. Define Scope, Assets, and Stakeholders

- Clarify what is being modeled:
  - System, service, feature, or specific data flow.
- Identify key assets:
  - Sensitive data, critical operations, business secrets, availability requirements.
- Note stakeholders and threat actors:
  - End users, admins, internal services, external partners, attackers.

## 2. Map Architecture and Data Flows

- Outline components and trust boundaries:
  - Clients, services, databases, third-party APIs, message queues.
- Describe major data flows:
  - What data moves where, over which protocols, and under what authentication.
- Use a simple textual C4-style description if diagrams are not available.

## 3. Identify Threats (STRIDE and OWASP-Inspired)

- Apply a STRIDE-style lens to each component and data flow:
  - Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege.
- Cross-check with known vulnerability classes (e.g., OWASP Top 10) relevant to the stack.
- Record concrete threat scenarios, not just categories.

## 4. Assess Risk and Prioritize

- For each identified threat, estimate:
  - Likelihood (how easy is it to exploit?).
  - Impact (on confidentiality, integrity, availability, compliance, reputation).
- Use simple qualitative ratings (e.g., High/Medium/Low) if detailed quantification is not practical.
- Prioritize threats that are both high-impact and likely.

## 5. Define Mitigations and Controls

- For prioritized threats, propose mitigations at appropriate layers:
  - Design (isolate components, least privilege, defense in depth).
  - Implementation (input validation, output encoding, secure defaults, safe libraries).
  - Operations (monitoring, alerts, rate limits, WAF rules, incident response).
- Consider privacy and data-minimization strategies where applicable.

## 6. Capture, Integrate, and Revisit

- Summarize the threat model:
  - Scope, assets, key threats, mitigations, and residual risk.
- Link findings to tickets, backlog items, or security requirements.
- Plan periodic updates:
  - Re-run or extend the model when introducing new features, integrations, or data flows.

