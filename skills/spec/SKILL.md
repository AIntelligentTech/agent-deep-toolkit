---
name: spec
description: Write high-quality specs, design docs, and ADRs that align stakeholders and guide implementation
command: /spec
synonyms: ["/requirement", "/design-doc", "/adr", "/specification", "/specifying", "/specified", "/specs", "/requirements", "/specifications"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: documentation
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Spec Workflow

This workflow instructs Cascade to produce specifications that are precise, actionable, and durable.

<scope_constraints>
Spec scope: Design documents, architecture decision records, requirements specifications, and implementation plans. Not applicable to minor documentation, comments, or ad-hoc communications.
</scope_constraints>

<context>
A well-written spec aligns stakeholders, reduces ambiguity, guides implementation, and serves as future reference. This workflow emphasizes clarity, completeness, testability, and durability through structured approaches to problem decomposition, option exploration, and decision justification.
</context>

<instructions>

## Inputs

- Problem statement or request
- Business context and goals
- Success metrics (functional and non-functional)
- Stakeholder list and constraints
- Existing related systems or documentation

### Step 1: Clarify Problem, Goals, and Non-Goals

- Restate the problem in clear business and technical terms.
- Identify goals and success metrics (functional and non-functional).
- **Risk-Based Scoping**: Categorize requirements by risk and uncertainty. Identify which parts of the spec are "safe bets" vs "high-risk spikes" that need early validation.
- Explicitly list non-goals to prevent scope creep.

### Step 2: Gather Context and Constraints

- Collect relevant background:
  - Existing behavior, related systems, previous incidents, competing priorities.
- Identify constraints:
  - Deadlines, budget, regulatory requirements, tech stack limitations, team capacity.
- Use `code_search` and existing docs to ensure the spec reflects reality, not wishful thinking.

### Step 3: Explore Options and Trade-offs

- Generate multiple plausible solution approaches.
- For each option, outline:
  - High-level architecture/flow.
  - Pros, cons, risks, and dependencies.
- Optionally apply `/decide` techniques (decision matrix, cost-benefit thinking, pre-mortem) for important choices.

### Step 4: Choose and Justify the Preferred Approach

- Recommend an approach (or phased sequence) explicitly.
- Explain why it's preferred:
  - How it meets goals and balances trade-offs better than alternatives.
- Note open questions and assumptions that must be validated.

### Step 5: Structure the Spec

- Choose an appropriate format:
  - Design doc, ADR, RFC, or implementation plan.
- **Gherkin Acceptance Criteria**: Use the **Given-When-Then** format for acceptance criteria to ensure they are unambiguous and easily translatable into automated tests.
- Include sections such as:
  - Background and problem statement.
  - Goals and non-goals.
  - Proposed solution (with diagrams if helpful).
  - Alternatives considered.
  - Risks and mitigations.
  - Rollout, migration, and monitoring.
- Ensure the spec is scoped to what the team can reasonably implement in the intended timeframe.

### Step 6: Review, Link, and Maintain

- Review the spec for clarity, completeness, and testability.
- Link it from relevant code locations, tickets, and documentation indexes.
- Encourage capturing significant changes as follow-up ADRs or spec revisions rather than informal chat decisions.

## Error Handling

- If problem statement is unclear, ask clarifying questions before proceeding.
- If constraints conflict with goals, explicitly document trade-offs and escalate for decision.
- If spec is too large, propose phasing or decomposition into smaller specs.
- If acceptance criteria are ambiguous, rewrite using Gherkin format.

</instructions>

<output_format>
Provide a structured specification with clear sections: problem statement, goals/non-goals, proposed solution, alternatives, risks/mitigations, and Gherkin acceptance criteria. Include diagrams where helpful and cite relevant background documents and constraints.
</output_format>
