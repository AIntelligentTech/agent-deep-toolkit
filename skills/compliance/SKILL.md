---
name: compliance
description: Evaluate and address ethical, regulatory, and legal obligations for software and AI systems
command: /compliance
aliases: ["/ethics", "/regulation", "/legal"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Compliance Workflow

This workflow combines ethical evaluation with regulatory alignment, providing a holistic view of compliance obligations. It does **not** replace qualified legal advice.

## Part A: Ethical Evaluation

### 1. Frame the System and Its Purpose

- Describe what the system does:
  - Core functionality, AI/ML components, automation level.
- Identify the context:
  - Domain, user base, scale, decision-making authority.
- Note where the system has significant influence on people's lives.

### 2. Identify Stakeholders and Potential Harms

- Map affected parties:
  - Direct users, indirect users, bystanders, society.
- Enumerate potential harms:
  - Discrimination, privacy violations, manipulation, safety risks.
  - Economic harm, psychological impact, environmental effects.
- Consider differential impacts on vulnerable groups.

### 3. Analyze Fairness, Transparency, and Autonomy

- **Fairness**: Are outcomes equitable across groups?
- **Transparency**: Can decisions be explained and understood?
- **Autonomy**: Do users have meaningful choice and control?
- **Accountability**: Who is responsible when things go wrong?

### 4. Design Mitigations

- Propose technical and process safeguards:
  - Bias testing, audit logging, human-in-the-loop.
  - Opt-out mechanisms, explanation interfaces.
- Balance competing values explicitly.

## Part B: Regulatory Alignment

### 5. Clarify Jurisdictions, Domain, and Activities

- Identify where the organization operates and where users are located.
- Describe the product or feature:
  - Sector, data processed, AI involvement.
- Note cross-border data flows and third-party processors.

### 6. Identify Applicable Regulatory Regimes

- Use `/search` to find up-to-date legal frameworks:
  - Data protection and privacy (GDPR, etc.).
  - AI/automated decision-making regulations.
  - Consumer protection.
  - Sector-specific requirements.

### 7. Map Data, Roles, and Processing Activities

- Classify data:
  - Personal vs non-personal, sensitive categories.
- Determine roles:
  - Controllers, processors, sub-processors.
- List processing purposes and legal bases.

### 8. Assess Obligations and Risks

- For each regime, outline likely obligations:
  - Transparency, consent, data subject rights, security.
- Identify high-risk processing activities.
- Highlight uncertainties requiring legal interpretation.

### 9. Propose Controls and Documentation

- Suggest practical steps:
  - Data minimization, privacy by design, security controls.
- Recommend documentation:
  - Policies, records of processing, impact assessments.

### 10. Monitor and Seek Expert Advice

- Recommend following regulatory updates.
- Plan periodic reassessment.
- **Clearly state this is not legal advice**—consult qualified counsel.

### 11. Capture Assumptions and Open Questions

- Document which laws were considered and which were out of scope.
- Record assumptions and gaps for legal review.
- Link to specs, risk registers, and decision logs.
