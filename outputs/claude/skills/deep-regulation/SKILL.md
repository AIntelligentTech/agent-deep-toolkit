---
name: deep-regulation
description: Identify and align with relevant regulatory obligations for software and AI systems
disable-model-invocation: true
user-invocable: true
---

# Deep Regulation Workflow

This workflow instructs Cascade to systematically consider regulatory obligations, especially in UK/EU contexts, while recognizing that it does **not** replace qualified legal advice.

## 1. Clarify Jurisdictions, Domain, and Activities

- Identify where the organization operates and where users are located.
- Describe the product or feature:
  - Sector (e.g., finance, health, education), data processed, and AI involvement.
- Note cross-border data flows, third-party processors, and hosting locations.

## 2. Identify Potentially Applicable Regimes

- Use `/deep-search` to find up-to-date legal and regulatory frameworks relevant to the context and time (e.g., data protection, AI-specific laws, consumer protection, digital services, cybersecurity).
- Consider, as examples (not an exhaustive or authoritative list):
  - Data protection and privacy laws.
  - AI/automated-decision-making regulations.
  - Consumer protection and advertising rules.
  - Sector-specific regulations and professional standards.

## 3. Map Data, Roles, and Processing Activities

- Classify data:
  - Personal vs non-personal, sensitive/special categories, behavioral data, and telemetry.
- Determine roles:
  - Controllers, processors, joint controllers, and sub-processors where relevant.
- List processing purposes and legal bases as far as they can be inferred from documentation.

## 4. Assess Key Obligations and Risks

- For each identified regime, use `/deep-search` to:
  - Outline likely obligations (e.g., transparency, consent, data subject rights, security measures, risk assessments).
  - Identify high-risk processing activities (e.g., profiling, large-scale sensitive data, high-risk AI use cases).
- Highlight uncertainties or ambiguities that require professional legal interpretation.

## 5. Propose Controls, Documentation, and Processes

- Suggest practical steps aligned with likely obligations:
  - Data minimization, privacy-by-design measures, security controls, audit logging.
- Encourage creation or refinement of:
  - Policies, records of processing, risk/impact assessments, and user-facing notices.
- Align recommendations with `/deep-ethics` to go beyond bare compliance where appropriate.

## 6. Monitor Regulatory Change and Seek Expert Advice

- Recommend:
  - Following updates from relevant regulators and trusted legal/industry sources.
  - Periodic re-assessment of obligations as laws and guidance evolve.
- Clearly state limitations:
  - This analysis is not legal advice and should be complemented by consultation with qualified legal counsel for concrete compliance decisions.

## 7. Capture Regulatory Assumptions and Open Questions

- Document which laws and guidance were considered, and which were out of scope.
- Record assumptions, known gaps, and questions to be addressed with legal experts.
- Link this analysis to specs, risk registers, and decision logs for traceability.

