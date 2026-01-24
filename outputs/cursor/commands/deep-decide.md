# Deep Decision Workflow

This workflow instructs Cascade to move from options to a clear, justified decision and follow-through.

## 1. Confirm Decision Scope and Ownership

- Restate the decision as a precise question, including scope and time horizon.
- Identify the decision owner and key stakeholders.
- Clarify decision type:
  - One-way door (hard to reverse) vs two-way door (easy to revisit).

## 2. Synthesize Context and Options

- Summarize relevant background, constraints, and goals.
- Enumerate candidate options, including:
  - Status quo and at least one minimal and one ambitious option.
- Use `/workflow-deep-consider` if the option space or context is complex.

## 3. Select Decision Frameworks and Criteria

- Choose appropriate tools:
  - Decision matrix, expected value, regret minimization, OODA loop, or similar.
- Define evaluation criteria aligned with goals and values:
  - Impact, cost, risk, reversibility, learning potential, strategic alignment.
- Weight criteria where necessary to reflect priorities.

## 4. Gather Evidence and Run Targeted Analyses

- Identify critical unknowns and assumptions.
- Use `/workflow-deep-search`, `/workflow-deep-experiment`, or `/workflow-deep-investigate` to reduce uncertainty.
- Avoid analysis paralysis:
  - Focus effort where it meaningfully changes the decision.

## 5. Choose and Record the Decision

- Select the preferred option based on the chosen framework and evidence.
- Make trade-offs explicit:
  - What is being optimized, what is being deferred, and what risks are accepted.
- Record the decision in a durable form (e.g., ADR, decision log) with:
  - Context, options, criteria, rationale, and expected outcomes.

## 6. Plan Implementation, Guardrails, and Monitoring

- Define concrete next steps, owners, and timelines.
- Set leading indicators and guardrails to detect if the decision is going badly.
- Decide on review checkpoints and conditions that would trigger reconsideration.

## 7. Review and Learn from Decisions

- At review time, compare outcomes with expectations:
  - What worked, what surprised, and what assumptions were wrong.
- Capture lessons:
  - How to improve future decision-making processes and heuristics.
- Update documentation, playbooks, or strategies based on what was learned.

