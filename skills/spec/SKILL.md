---
name: spec
description: Write high-quality specs, design docs, and ADRs that align stakeholders and guide implementation
command: /spec
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Spec Workflow

This workflow instructs Cascade to produce specifications that are precise, actionable, and durable.

## 1. Clarify Problem, Goals, and Non-Goals

- Restate the problem in clear business and technical terms.
- Identify goals and success metrics (functional and non-functional).
- Explicitly list non-goals to prevent scope creep.

## 2. Gather Context and Constraints

- Collect relevant background:
  - Existing behavior, related systems, previous incidents, competing priorities.
- Identify constraints:
  - Deadlines, budget, regulatory requirements, tech stack limitations, team capacity.
- Use `code_search` and existing docs to ensure the spec reflects reality, not wishful thinking.

## 3. Explore Options and Trade-offs

- Generate multiple plausible solution approaches.
- For each option, outline:
  - High-level architecture/flow.
  - Pros, cons, risks, and dependencies.
- Optionally apply `/decide` techniques (decision matrix, cost-benefit thinking, pre-mortem) for important choices.

## 4. Choose and Justify the Preferred Approach

- Recommend an approach (or phased sequence) explicitly.
- Explain why it's preferred:
  - How it meets goals and balances trade-offs better than alternatives.
- Note open questions and assumptions that must be validated.

## 5. Structure the Spec

- Choose an appropriate format:
  - Design doc, ADR, RFC, or implementation plan.
- Include sections such as:
  - Background and problem statement.
  - Goals and non-goals.
  - Proposed solution (with diagrams if helpful).
  - Alternatives considered.
  - Risks and mitigations.
  - Rollout, migration, and monitoring.
- Ensure the spec is scoped to what the team can reasonably implement in the intended timeframe.

## 6. Review, Link, and Maintain

- Review the spec for clarity, completeness, and testability.
- Link it from relevant code locations, tickets, and documentation indexes.
- Encourage capturing significant changes as follow-up ADRs or spec revisions rather than informal chat decisions.
