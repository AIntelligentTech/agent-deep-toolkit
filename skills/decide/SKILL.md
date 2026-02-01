---
name: decide
description: Carefully consider and make rigorous decisions using structured frameworks, trade-off analysis, and evidence
command: /decide
aliases: ["/consider", "/choose", "/weigh"]
synonyms: ["/decision", "/choice", "/choose", "/choosing", "/chose", "/chosen", "/pick", "/select", "/deciding", "/decided", "/decides", "/selections", "/considering", "/considered", "/weighing", "/tradeoff", "/trade-off", "/comparison", "/compare"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Decide Workflow

This workflow combines deep consideration with decisive action. It instructs Cascade to apply structured decision-making techniques, then move from options to a clear, justified decision.

<scope_constraints>
**Operational Boundaries:**
- Scope: Complex decisions with multiple options and trade-offs
- Modes: Structured analysis, risk assessment, reversibility evaluation
- Defaults: Apply Cynefin framework; use weighted matrices for multi-criteria decisions
- Not in scope: Implementation planning (defer to /deploy or /estimate skills)
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Clear decision statement and time horizon
- Available options and relevant constraints
- Access to data, metrics, or evidence about options
- Stakeholder input where appropriate
- Understanding of organizational strategy and values
</context>

<instructions>

## Inputs
- Decision statement (what choice needs to be made)
- Available options and context
- Success criteria or decision constraints
- Relevant metrics or evidence
- Stakeholder perspectives (if applicable)

## Steps

### Step 1: Frame the Decision and Purpose

- Restate the decision as a concrete question (including time horizon and scope).
- Apply a **Golden Circle** pass:
  - **Why** – underlying purpose, goals, and principles.
  - **How** – broad strategies that could achieve the why.
  - **What** – concrete options or actions under consideration.
- Enumerate explicit options, including:
  - The status quo (do nothing/change nothing).
  - At least one "minimal" and one "maximal" option where applicable.

### Step 2: Map Context, Uncertainty, and Complexity

- Build a quick **CSD Matrix**:
  - Certainties (facts, constraints, invariants).
  - Suppositions (assumptions that need validation).
  - Doubts (unknowns and knowledge gaps).
- **Classify the Decision (Type 1 vs Type 2)**:
  - **Type 1 (Irreversible)**: High stakes, hard to reverse (e.g., changing database engines, major architectural shift). Requires maximum rigor.
  - **Type 2 (Reversible)**: Low stakes, easy to undo (e.g., adjusting a UI color, adding a non-breaking API field). Move fast and iterate.
- Classify the situation via the **Cynefin framework**:
  - Simple, Complicated, Complex, or Chaotic.
- Choose decision posture based on Cynefin:
  - Simple: follow proven best practices.
  - Complicated: analyze and consult expertise.
  - Complex: run safe-to-fail experiments and probe-sense-respond.
  - Chaotic: act to stabilize first, then reassess.

### Step 3: Define Evaluation Criteria

- Co-create or infer criteria aligned with the **Why**:
  - Value/impact, cost, risk, reversibility, strategic alignment, learning potential, user experience, team health.
- Distinguish **must-have** vs **nice-to-have** criteria.
- Weight criteria where necessary to reflect priorities.

### Step 4: Evaluate Options with Structured Tools

- For multi-criteria choices, use a **decision matrix**:
  - List options vs criteria.
  - Assign weights to criteria based on importance.
  - Score options and compute weighted totals.
- For roadmap / initiative prioritization, optionally apply **RICE/ICE**:
  - Reach, Impact, Confidence, Effort (RICE) or Impact, Confidence, Ease (ICE).
- When economics dominate, outline a **Cost-Benefit Analysis**.

### Step 5: Explore Edge Cases and Failure Modes

- Perform a lightweight **pre-mortem**:
  - Assume the chosen option failed badly in 6–12 months – list reasons why.
- For each major option, consider:
  - Technical failure modes (scalability, security, maintainability, data integrity).
  - Organizational and product impacts (team workload, UX, customer trust, legal/compliance).
  - Second-order effects and path dependence (lock-in, opportunity cost, future flexibility).

### Step 6: Choose and Record the Decision

- Select the preferred option based on the chosen framework and evidence.
- Make trade-offs explicit:
  - What is being optimized, what is being deferred, and what risks are accepted.
- Record the decision in a durable form (e.g., ADR, decision log) with:
  - Context, options, criteria, rationale, and expected outcomes.

### Step 7: Plan Implementation and Guardrails

- Define concrete next steps, owners, and timelines.
- Set leading indicators and guardrails to detect if the decision is going badly.
- Decide on review checkpoints and conditions that would trigger reconsideration.

### Step 8: Review and Learn from Decisions

- At review time, compare outcomes with expectations:
  - What worked, what surprised, and what assumptions were wrong.
- Capture lessons for future decision-making.
- Update documentation based on what was learned.

## Error Handling

- **Insufficient data**: Note gaps explicitly and make decision conditionally; plan to revisit with more data
- **Stakeholder disagreement**: Surface competing priorities transparently; document rationale for chosen direction
- **Decision becomes irreversible sooner than expected**: Escalate review and reconsideration timeline
- **Multiple equally valid options**: Document trade-offs clearly and commit to one; plan monitoring to validate choice

</instructions>

<output_format>
**Deliverables:**
- Decision statement with clear options evaluated
- CSD matrix and Cynefin classification
- Evaluation criteria with weights and scoring
- Pre-mortem analysis of failure modes
- Decision record with rationale, trade-offs, and guardrails
- Implementation plan and review timeline
</output_format>
