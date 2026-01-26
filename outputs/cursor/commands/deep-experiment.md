# Deep Experiment

## Objective

Design and run high-quality experiments to validate ideas with evidence

## Requirements

# Deep Experiment Workflow

This workflow instructs Cascade to design and run rigorous experiments so decisions are grounded in evidence, not opinion.

## 1. Clarify Hypothesis and Decision

- Restate the experiment as a concrete question:
  - What do we want to learn and what decision will this inform?
- Formulate explicit hypotheses:
  - Null and alternative, or competing models of how the world works.
- Identify risk level and blast radius to choose an appropriate level of rigor.

## 2. Define Success Metrics and Guardrails

- Select **primary outcome metrics** tied to the decision (e.g., conversion, retention, task completion time).
- Add **secondary metrics** for richer insight (e.g., engagement, satisfaction).
- Define **guardrail metrics** to protect against hidden harms:
  - Error rates, latency, support tickets, churn, fairness indicators.
- Specify minimum detectable effect, if possible, to calibrate expectations.

## 3. Choose Experiment Design

- Pick an appropriate design based on context:
  - A/B or A/B/n, feature flag rollout, holdout groups, or quasi-experiments.
- Decide on unit of randomization:
  - User, account, session, request, or time-based.
- Consider contamination and interference:
  - Cross-device use, shared accounts, social/market effects.

## 4. Plan Sample, Duration, and Segmentation

- Estimate sample size and experiment duration where feasible:
  - Use rough power calculations or industry heuristics for guidance.
- Decide on key segments to track:
  - New vs existing users, geography, device, plan tier, or risk groups.
- Document stopping rules to avoid p-hacking and mid-stream overreaction.

## 5. Design Implementation and Instrumentation

- Map experiment conditions to concrete implementation:
  - Feature flags, configuration, routing, or model selection.
- Ensure instrumentation is in place **before** launch:
  - Events, properties, and identifiers required for analysis.
- Validate data quality on a small internal cohort or staging environment.

## 6. Run the Experiment Safely and Ethically

- Monitor guardrail metrics during the run for regressions.
- Define clear rollback or pause conditions if harm is detected.
- Respect legal, privacy, and ethical constraints:
  - Avoid manipulative patterns; treat users fairly across variants.

## 7. Analyze Results and Make the Decision

- Use appropriate statistical methods for the design:
  - Differences in means/medians, ratios, or regression where needed.
- Look for heterogeneity across key segments, but avoid fishing expeditions.
- Interpret results in terms of the original decision:
  - Ship, iterate, roll back, or run a follow-up experiment.

## 8. Capture Learnings and Feed Back into Strategy

- Summarize:
  - Hypothesis, design, metrics, results, and final decision.
- Record non-obvious insights and surprising null results.
- Link the experiment to specs, roadmaps, and documentation so future work benefits from the learning.
