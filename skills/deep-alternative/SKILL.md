---
name: deep-alternative
description: Systematically explore and evaluate alternative approaches, tools, patterns, and architectures
command: /deep-alternative
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---
# Deep Alternative Workflow

This workflow instructs Cascade to deeply consider alternative approaches for a problem, comparing tools, patterns, data structures, algorithms, and architectures.

## 1. Frame the Decision and Baseline Approach

- Restate the core decision:
  - What are we trying to achieve, and what is the current or assumed baseline approach?
- Use `/deep-think` to extract fundamental constraints and goals:
  - Performance, scalability, maintainability, developer experience, time-to-market, cost, compliance, etc.
- If the baseline is not well specified, align it with `/deep-spec` or `/deep-architect` first.

## 2. Generate Alternative Options

- Use `/deep-search` to identify plausible alternatives:
  - Different algorithms or data structures.
  - Alternative tools, frameworks, or services.
  - Architectural patterns (e.g. modular monolith vs microservices, message queues vs direct calls).
- For each alternative, sketch a brief description of how it would work in this context.

## 3. Define Evaluation Criteria

- Apply `/deep-consider`:
  - Define must-have vs nice-to-have criteria.
  - Typical criteria: value/impact, risk, reversibility, learning, maintenance, ecosystem maturity.
- Make sure criteria align with the broader goals and constraints captured earlier.

## 4. Compare Options Structurally

- Build a structured comparison:
  - Option vs criteria table (qualitative or rough scores).
  - Explicit pros/cons for each option.
- Consider different lenses:
  - Short-term vs long-term.
  - Team familiarity vs community support.
  - Operational complexity vs flexibility.

## 5. Synthesize a Recommendation

- Use `/deep-decision` to:
  - Recommend one option (or a phased sequence) with clear rationale.
  - Make trade-offs explicit: what you are optimizing for now vs later.
- Suggest guardrails:
  - Experiments or pilots to validate the chosen alternative.
  - Metrics and leading indicators that would trigger reconsideration.

## 6. Connect to Downstream Workflows

- For the chosen alternative:
  - Point to follow-up workflows for execution:
    - `/deep-architect`, `/deep-code`, `/deep-test`, `/deep-ux`, `/deep-infrastructure`.
  - Identify where `/deep-impact` and `/deep-propagate` will be needed.
