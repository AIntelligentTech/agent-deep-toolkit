---
description: Carefully consider complex decisions, options, and edge cases using formal decision-making frameworks and scenario analysis
auto_execution_mode: 3
---

# Deep Consider Workflow

This workflow instructs Cascade to slow down and apply structured decision-making and foresight techniques before recommending a path.

## 1. Frame the Decision and Purpose

- Restate the decision as a concrete question (including time horizon and scope).
- Apply a **Golden Circle** pass:
  - **Why** – underlying purpose, goals, and principles.
  - **How** – broad strategies that could achieve the why.
  - **What** – concrete options or actions under consideration.
- Enumerate explicit options, including:
  - The status quo (do nothing/change nothing).
  - At least one “minimal” and one “maximal” option where applicable.

## 2. Map Context, Uncertainty, and Complexity

- Build a quick **CSD Matrix**:
  - Certainties (facts, constraints, invariants).
  - Suppositions (assumptions that need validation).
  - Doubts (unknowns and knowledge gaps).
- Classify the situation via the **Cynefin framework**:
  - Simple, Complicated, Complex, or Chaotic.
- Choose decision posture based on Cynefin:
  - Simple: follow proven best practices.
  - Complicated: analyze and consult expertise.
  - Complex: run safe-to-fail experiments and probe-sense-respond.
  - Chaotic: act to stabilize first, then reassess.

## 3. Expand and Refine Options

- Check whether the option set is too narrow:
  - Derive variants that trade cost, speed, and quality differently.
  - Include options that defer or split the decision (phased approaches, pilots).
- For each option, capture enabling and blocking constraints (funding, skills, dependencies, risk appetite).

## 4. Define Evaluation Criteria

- Co-create or infer criteria aligned with the **Why**:
  - Value/impact, cost, risk, reversibility, strategic alignment, learning potential, user experience, team health.
- Distinguish **must-have** vs **nice-to-have** criteria.
- If monetary implications are central, plan for a cost-benefit style analysis.

## 5. Evaluate Options with Structured Tools

- For multi-criteria choices, use a **decision matrix**:
  - List options vs criteria.
  - Assign weights to criteria based on importance.
  - Score options and compute weighted totals.
- For roadmap / initiative prioritization, optionally apply **RICE/ICE**:
  - Reach, Impact, Confidence, Effort (RICE) or Impact, Confidence, Ease (ICE).
- When economics dominate, outline a **Cost-Benefit Analysis**:
  - Frame the question and current situation.
  - List and categorize costs/benefits (direct, indirect, short/long term).
  - Estimate magnitudes (even if rough) and compare net benefit.

## 6. Explore Edge Cases, Failure Modes, and Second-Order Effects

- Perform a lightweight **pre-mortem**:
  - Assume the chosen option failed badly in 6–12 months – list reasons why.
- For each major option, consider:
  - Technical failure modes (scalability, security, maintainability, data integrity).
  - Organizational and product impacts (team workload, UX, customer trust, legal/compliance).
  - Second-order effects and path dependence (lock-in, opportunity cost, future flexibility).
- Highlight where uncertainty is highest and could be reduced via experiments or prototypes.

## 7. Synthesize Recommendation and Guardrails

- Select the recommended option (or sequence of options) and justify it:
  - How it scores against key criteria.
  - Why its risks are acceptable relative to alternatives.
- Make trade-offs explicit:
  - What you are intentionally not optimizing for right now.
  - What you are postponing or consciously discarding.
- Propose guardrails:
  - Leading indicators/metrics to monitor.
  - Checkpoints to revisit the decision.
  - Preconditions that would trigger reconsideration.

## 8. Communicate Clearly and Capture the Decision

- Summarize the decision in a concise narrative for stakeholders:
  - Context and question.
  - Options considered.
  - Criteria and key arguments.
  - Recommendation and next steps.
- Capture remaining open questions and suggested experiments to further de-risk the path.
- When appropriate, structure the summary so it can be recorded as an ADR or decision log entry.

