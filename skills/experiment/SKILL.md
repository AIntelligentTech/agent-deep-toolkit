---
name: experiment
description: Design and run high-quality experiments to validate ideas with evidence
command: /experiment
aliases: ["/test-hypothesis", "/ab-test"]
synonyms: ["/experimenting", "/experimented", "/experiments", "/hypothesising", "/hypothesizing", "/ab-testing"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Experiment Workflow

This workflow instructs Cascade to design and run experiments that produce reliable, actionable insights.

<scope_constraints>
**Operational Boundaries:**
- Scope: Experiment design, implementation planning, result analysis
- Modes: A/B testing, multivariate, before/after, feature flags
- Defaults: Prioritize statistical rigor; document success criteria before running; account for confounding variables
- Not in scope: Actual experiment execution or deployment (defer to /deploy); infrastructure setup
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Clear hypothesis and measurable outcomes
- Access to analytics and data collection infrastructure
- Understanding of sample size and statistical power requirements
- Ability to implement feature flags or experimental variations
- Data infrastructure for tracking and analysis
</context>

<instructions>

## Inputs
- Hypothesis statement with expected effect
- Target metrics and guardrail metrics
- Experiment design constraints (duration, sample size, audience)
- Implementation approach (feature flags, code branches, config)
- Ethical and user impact considerations

## Steps

### Step 1: Clarify Hypothesis and Goals

- State the hypothesis clearly:
  - "We believe [change] will cause [effect] for [users]."
- Define what you're trying to learn:
  - Validate an assumption, measure an impact, compare alternatives.
- Ensure the hypothesis is testable.

### Step 2: Define Success Metrics and Guardrails

- Identify primary metrics:
  - What will tell you if the hypothesis is true?
- Define guardrail metrics:
  - What must not get worse?
- Set success criteria before running:
  - What result would confirm/reject the hypothesis?

### Step 3: Choose Experiment Design

- Select appropriate design:
  - A/B test, multivariate, before/after, feature flag.
- Consider:
  - Sample size and statistical power.
  - Duration for reliable results.
  - Segment selection.
- Account for confounding variables.

### Step 4: Plan Implementation and Instrumentation

- Define how the experiment will be implemented:
  - Feature flags, code branches, configuration.
- Set up data collection:
  - Events, metrics, logging.
- Ensure proper tracking and attribution.
- Plan for debugging and monitoring.

### Step 5: Run Safely and Ethically

- Start small:
  - Canary or limited rollout first.
- Monitor for issues:
  - Performance problems, user complaints, metric anomalies.
- Have a kill switch ready.
- Consider ethical implications:
  - User consent, potential harm, fairness.

### Step 6: Analyze Results

- Wait for sufficient data.
- Apply appropriate statistical analysis.
- Check for:
  - Statistical significance.
  - Practical significance.
  - Segment-level effects.
- Look for unexpected results or side effects.

### Step 7: Decide and Act

- Based on results:
  - Roll out, iterate, or abandon.
- Document findings:
  - What was learned, regardless of outcome.
- Share insights with the team.

### Step 8: Capture Learnings

- Add to knowledge base:
  - What worked, what didn't, what surprised.
- Update hypotheses and assumptions.
- Inform future experiments.

## Error Handling

- **Insufficient data or statistical power**: Extend experiment duration; increase sample size; acknowledge lower confidence in results
- **Confounding variables detected**: Document impact; rerun with controls if possible; note as limitation for interpretation
- **Unexpected results or side effects**: Investigate root cause; adjust guardrails; plan follow-up experiments to clarify
- **Ethical concerns detected**: Stop experiment immediately; review impact; escalate for review; document decisions

</instructions>

<output_format>
**Deliverables:**
- Hypothesis statement with expected effect size
- Success metrics with statistical power requirements
- Experiment design with timeline and sample size
- Implementation plan (feature flags, tracking, monitoring)
- Ethical review and risk assessment
- Analysis of results with statistical significance
- Decision (rollout, iterate, or abandon)
- Learnings and implications for future hypotheses
- Knowledge base update with findings
</output_format>
