---
name: impact
description: Deeply assess the impact of a proposed change across code, performance, UX, security, governance, and cost
command: /impact
aliases: []
synonyms: ["/impacting", "/impacted", "/impacts", "/impact-analysis", "/assessing-impact"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: analysis
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill focuses on assessing the downstream effects of proposed changes across technical, UX, compliance, and operational dimensions. It produces analysis and recommendations but does not execute changes.
</scope_constraints>

<context>
This workflow instructs the agent to perform a rigorous impact analysis before making or shipping changes, ensuring all downstream effects are understood across code, performance, UX, security, governance, and cost dimensions.
</context>

<instructions>

## Inputs

- Description of the proposed change
- Current system state and dependencies
- Scope boundaries (what's in/out of scope)
- Success criteria for the change

## Step 1: Clarify the Change

- Restate what is changing:
  - Feature, refactor, migration, configuration, dependency update, policy change.
- Define the intended outcome and success criteria.
- Note the scope boundaries:
  - What is deliberately in and out of scope.

## Step 2: Map the Impact Surface

- Identify all areas potentially affected:
  - Code modules and services.
  - APIs and contracts.
  - Data schemas and stores.
  - Configuration and infrastructure.
  - Documentation and training materials.
  - External integrations.

## Step 3: Analyze Technical Impact

- **Code**: What files/modules change? What depends on them?
- **Performance**: Any effect on latency, throughput, resource usage?
- **Reliability**: Does this introduce new failure modes?
- **Security**: Any change to attack surface or trust boundaries?
- **Data**: Schema migrations, compatibility, backfill needs?

## Step 4: Analyze UX and Product Impact

- **User experience**: Does this change user flows or behaviors?
- **Accessibility**: Any impact on assistive technology users?
- **Documentation**: What user-facing docs need updating?
- **Feature flags**: Should this be gated for progressive rollout?

## Step 5: Analyze Data and Compliance Impact

- **Privacy**: Does this change what data is collected or how it's used?
- **Regulatory**: Any compliance implications (GDPR, etc.)?
- **Audit**: Are there audit log or reporting changes?

## Step 6: Evaluate Cost, Complexity, and Risk

- **Complexity**: How difficult is the change to implement and validate?
- **Cost**: Infrastructure costs, engineering time, opportunity cost?
- **Reversibility**: How easy is it to roll back?
- **Risk**: What could go wrong? What's the blast radius?

## Step 7: Synthesize Impact Assessment

- Summarize key impacts in a structured format.
- Highlight the highest-risk areas.
- Propose mitigation strategies.
- Recommend go/no-go based on analysis.

## Step 8: Prepare for Safe Propagation

- Define rollout strategy:
  - Phased, canary, feature-flagged?
- Set up monitoring for impact areas.
- Create rollback plan.
- Communicate changes to affected stakeholders.

## Error Handling

- **Missing impact information**: Flag what data is insufficient for full analysis
- **Uncertain dependencies**: Note where manual verification is required
- **High-risk areas**: Escalate and recommend mitigation or architectural review
- **Conflicting requirements**: Surface trade-offs explicitly

</instructions>

<output_format>
- **Impact summary**: High-level overview of major impact areas
- **Technical impact analysis**: Code, performance, reliability, security, data dimensions
- **UX/product impact**: User experience, documentation, feature gate needs
- **Compliance impact**: Privacy, regulatory, audit implications
- **Risk assessment**: Severity, blast radius, reversibility analysis
- **Mitigation strategies**: Proposed approaches to reduce risk
- **Recommendation**: Go/no-go decision with rationale
- **Rollout plan**: Phased strategy, monitoring, and rollback procedure
</output_format>
