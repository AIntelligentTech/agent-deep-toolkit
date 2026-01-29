---
name: decide
description: Carefully consider and make rigorous decisions using structured frameworks,
  trade-off analysis, and evidence
activation: auto
---

# Decide Workflow

This workflow combines deep consideration with decisive action. It instructs Cascade to apply structured decision-making techniques, then move from options to a clear, justified decision.

## 1. Frame the Decision and Purpose

- Restate the decision as a concrete question (including time horizon and scope).
- Apply a **Golden Circle** pass:
  - **Why** – underlying purpose, goals, and principles.
  - **How** – broad strategies that could achieve the why.
  - **What** – concrete options or actions under consideration.
- Enumerate explicit options, including:
  - The status quo (do nothing/change nothing).
  - At least one "minimal" and one "maximal" option where applicable.

## 2. Map Context, Uncertainty, and Complexity

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

## 3. Define Evaluation Criteria

- Co-create or infer criteria aligned with the **Why**:
  - Value/impact, cost, risk, reversibility, strategic alignment, learning potential, user experience, team health.
- Distinguish **must-have** vs **nice-to-have** criteria.
- Weight criteria where necessary to reflect priorities.

## 4. Evaluate Options with Structured Tools

- For multi-criteria choices, use a **decision matrix**:
  - List options vs criteria.
  - Assign weights to criteria based on importance.
  - Score options and compute weighted totals.
- For roadmap / initiative prioritization, optionally apply **RICE/ICE**:
  - Reach, Impact, Confidence, Effort (RICE) or Impact, Confidence, Ease (ICE).
- When economics dominate, outline a **Cost-Benefit Analysis**.

## 5. Explore Edge Cases and Failure Modes

- Perform a lightweight **pre-mortem**:
  - Assume the chosen option failed badly in 6–12 months – list reasons why.
- For each major option, consider:
  - Technical failure modes (scalability, security, maintainability, data integrity).
  - Organizational and product impacts (team workload, UX, customer trust, legal/compliance).
  - Second-order effects and path dependence (lock-in, opportunity cost, future flexibility).

## 6. Choose and Record the Decision

- Select the preferred option based on the chosen framework and evidence.
- Make trade-offs explicit:
  - What is being optimized, what is being deferred, and what risks are accepted.
- Record the decision in a durable form (e.g., ADR, decision log) with:
  - Context, options, criteria, rationale, and expected outcomes.

## 7. Plan Implementation and Guardrails

- Define concrete next steps, owners, and timelines.
- Set leading indicators and guardrails to detect if the decision is going badly.
- Decide on review checkpoints and conditions that would trigger reconsideration.

## 8. Review and Learn from Decisions

- At review time, compare outcomes with expectations:
  - What worked, what surprised, and what assumptions were wrong.
- Capture lessons for future decision-making.
- Update documentation based on what was learned.