---
name: compliance
description: Evaluate and address ethical, regulatory, and legal obligations for software and AI systems
command: /compliance
aliases: ["/ethics", "/regulation", "/legal"]
synonyms: ["/complying", "/complied", "/complies"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: assess
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Compliance Workflow

This workflow combines ethical evaluation with regulatory alignment, providing a holistic view of compliance obligations. It does **not** replace qualified legal advice.

<scope_constraints>
- Focuses on ethical and regulatory assessment for software and AI systems
- Covers data protection, privacy, fairness, autonomy, and transparency
- Applies to new features, systems, and organizational policies
- Includes assessment of regulatory obligations and mitigations
- Provides informed risk assessment, not legal advice
- Requires engagement with qualified legal counsel for high-risk scenarios
</scope_constraints>

<context>
**Dependencies:**
- Understanding of ethical frameworks and stakeholder impact analysis
- Knowledge of relevant regulatory regimes (GDPR, AI regulations, sector-specific rules)
- Familiarity with data classification and handling
- Understanding of AI/ML systems and bias mechanisms
- Awareness of organizational risk tolerance

**Prerequisites:**
- Clear description of system, purpose, and user base
- Identification of where system operates (jurisdictions)
- Understanding of data processed and stakeholders affected
- Access to relevant documentation (architecture, policies, agreements)
- Clarity on decision-making scope (assessment vs. implementation)
</context>

<instructions>

## Inputs

- System description (functionality, AI/ML components, automation level)
- Domain and user base (who is affected, context of use)
- Data processed (types, sensitivity, volume, sources)
- Jurisdictions where system operates and where users are located
- Existing policies, compliance frameworks, or legal requirements
- Business context (industry, competitive pressures, risk tolerance)
- Stakeholder concerns and known risks

## Steps (Part A: Ethical Evaluation)

### Step 1: Frame the System and Its Purpose

- Describe what the system does:
  - Core functionality, AI/ML components, automation level.
- Identify the context:
  - Domain, user base, scale, decision-making authority.
- Note where the system has significant influence on people's lives.

### Step 2: Identify Stakeholders and Potential Harms

- Map affected parties:
  - Direct users, indirect users, bystanders, society.
- Enumerate potential harms:
  - Discrimination, privacy violations, manipulation, safety risks.
  - Economic harm, psychological impact, environmental effects.
- Consider differential impacts on vulnerable groups.

### Step 3: Analyze Fairness, Transparency, and Autonomy

- **Fairness**: Are outcomes equitable across groups?
- **Transparency**: Can decisions be explained and understood?
- **Autonomy**: Do users have meaningful choice and control?
- **Accountability**: Who is responsible when things go wrong?

### Step 4: Design Mitigations

- Propose technical and process safeguards:
  - Bias testing, audit logging, human-in-the-loop.
  - Opt-out mechanisms, explanation interfaces.
- Balance competing values explicitly.

## Steps (Part B: Regulatory Alignment)

### Step 5: Clarify Jurisdictions, Domain, and Activities

- Identify where the organization operates and where users are located.
- Describe the product or feature:
  - Sector, data processed, AI involvement.
- Note cross-border data flows and third-party processors.

### Step 6: Identify Applicable Regulatory Regimes

- Use `/search` to find up-to-date legal frameworks:
  - Data protection and privacy (GDPR, etc.).
  - AI/automated decision-making regulations.
  - Consumer protection.
  - Sector-specific requirements.

### Step 7: Map Data, Roles, and Processing Activities

- Classify data:
  - Personal vs non-personal, sensitive categories.
- Determine roles:
  - Controllers, processors, sub-processors.
- List processing purposes and legal bases.

### Step 8: Assess Obligations and Risks

- For each regime, outline likely obligations:
  - Transparency, consent, data subject rights, security.
- Identify high-risk processing activities.
- Highlight uncertainties requiring legal interpretation.

### Step 9: Propose Controls and Documentation

- Suggest practical steps:
  - Data minimization, privacy by design, security controls.
- Recommend documentation:
  - Policies, records of processing, impact assessments.

### Step 10: Monitor and Seek Expert Advice

- Recommend following regulatory updates.
- Plan periodic reassessment.
- **Clearly state this is not legal advice**—consult qualified counsel.

### Step 11: Capture Assumptions and Open Questions

- Document which laws were considered and which were out of scope.
- Record assumptions and gaps for legal review.
- Link to specs, risk registers, and decision logs.

## Error Handling

**Common compliance pitfalls:**
- Assuming one jurisdiction's requirements apply to all users
- Overlooking data flows and third-party processors
- Treating compliance as a one-time checklist rather than ongoing
- Failing to balance ethical concerns with business requirements
- Making legal interpretations without qualified counsel

**Mitigation strategies:**
- Map all jurisdictions where users are located
- Document all data flows and identify processors
- Build compliance review into development and release cycles
- Use multi-stakeholder review for high-impact systems
- Engage legal counsel early for regulatory interpretation
- Monitor regulatory changes and reassess periodically

</instructions>

<output_format>

The output of this skill is a **comprehensive compliance assessment** with findings and roadmap:

1. **System Summary** — Purpose, scope, data, and stakeholders affected
2. **Ethical Assessment** — Analysis of fairness, transparency, autonomy across stakeholder groups
3. **Regulatory Landscape** — Applicable laws and frameworks by jurisdiction
4. **Data & Processing Assessment** — Classification, flows, roles, and legal bases
5. **Compliance Obligations** — Key requirements from each applicable regime
6. **Risk Assessment** — High-risk processing activities and exposure
7. **Proposed Controls** — Technical and process safeguards to mitigate risks
8. **Recommended Documentation** — Policies, records, and assessments needed
9. **Assumptions & Gaps** — Uncertainties and areas requiring legal interpretation
10. **Action Items** — Owner, timeline, and success criteria for compliance work
11. **Monitoring Plan** — How to stay current with regulatory changes

Deliverables typically include:
- Compliance assessment summary (3-5 pages)
- Detailed risk register with identified obligations
- Recommended controls checklist (technical and process)
- Data processing documentation template
- Policy and governance recommendations
- Roadmap for compliance implementation
- Disclaimer: **Not legal advice—consult qualified counsel for final decisions**

</output_format>
