---
name: threat
description: Systematically identify and mitigate security and privacy threats using modern threat-modeling practices
command: /threat
aliases: ["/threat-model", "/security"]
synonyms: ["/threat-modelling", "/threat-modeling", "/securing", "/secured", "/security-review"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: security
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Threat Workflow

This workflow instructs Cascade to assess security and privacy risks in a structured, repeatable way.

<scope_constraints>
Threat modeling scope: Systems, services, features, and data flows. Identifies STRIDE-class threats, OWASP vulnerabilities, and mitigation strategies. Not applicable to security policy, compliance audits, or incident response.
</scope_constraints>

<context>
Threat modeling is proactive risk management that shifts security left, preventing vulnerabilities before they're built. This workflow uses STRIDE and OWASP frameworks to systematically identify threats, assess risk, and propose mitigations at design, implementation, and operational layers.
</context>

<instructions>

## Inputs

- System, service, or feature to model
- Scope boundaries and assets to protect
- Known stakeholders and threat actors
- Existing architecture or data flows
- Compliance requirements and risk tolerance

### Step 1: Define Scope, Assets, and Stakeholders

- Clarify what is being modeled:
  - System, service, feature, or specific data flow.
- Identify key assets:
  - Sensitive data, critical operations, business secrets, availability requirements.
- Note stakeholders and threat actors:
  - End users, admins, internal services, external partners, attackers.

### Step 2: Map Architecture and Data Flows

- Outline components and trust boundaries:
  - Clients, services, databases, third-party APIs, message queues.
- Describe major data flows:
  - What data moves where, over which protocols, and under what authentication.
- Use a simple textual C4-style description if diagrams are not available.

### Step 3: Identify Threats (STRIDE and OWASP-Inspired)

- Apply a STRIDE-style lens to each component and data flow:
  - **S**poofing: Can an attacker impersonate a user or system?
  - **T**ampering: Can data be modified without detection?
  - **R**epudiation: Can actions be denied without proof?
  - **I**nformation Disclosure: Can sensitive data leak?
  - **D**enial of Service: Can the system be made unavailable?
  - **E**levation of Privilege: Can an attacker gain unauthorized access?
- Cross-check with known vulnerability classes (e.g., OWASP Top 10) relevant to the stack.
- Record concrete threat scenarios, not just categories.

### Step 4: Assess Risk and Prioritize

- For each identified threat, estimate:
  - Likelihood (how easy is it to exploit?).
  - Impact (on confidentiality, integrity, availability, compliance, reputation).
- Use simple qualitative ratings (e.g., High/Medium/Low) if detailed quantification is not practical.
- Prioritize threats that are both high-impact and likely.

### Step 5: Define Mitigations and Controls

- For prioritized threats, propose mitigations at appropriate layers:
  - **Design**: isolate components, least privilege, defense in depth.
  - **Implementation**: input validation, output encoding, secure defaults, safe libraries.
  - **Operations**: monitoring, alerts, rate limits, WAF rules, incident response.
- Consider privacy and data-minimization strategies where applicable.

### Step 6: Capture, Integrate, and Revisit

- Summarize the threat model:
  - Scope, assets, key threats, mitigations, and residual risk.
- Link findings to tickets, backlog items, or security requirements.
- Plan periodic updates:
  - Re-run or extend the model when introducing new features, integrations, or data flows.

## Error Handling

- If threats are too vague, ask for concrete attack scenarios.
- If mitigations are incomplete, identify gaps and residual risk explicitly.
- If risk is unacceptable and can't be mitigated, escalate for architectural redesign.
- If scope creeps, refocus on high-value assets and likely threat vectors.

</instructions>

<output_format>
Provide structured threat model with scope/assets/stakeholders, architecture diagram or textual description, enumerated STRIDE threats with concrete scenarios, risk assessment (likelihood × impact), prioritized mitigations at design/implementation/operational layers, and summary of residual risk.
</output_format>
