---
description: Execute work in small, validated iterations until a clearly defined end goal is reached
auto_execution_mode: 3
---

# Deep Iterate Workflow

This workflow instructs Cascade to work iteratively: plan a step, execute, validate via an explicit mechanism, learn, and repeat.

## 1. Clarify Goal and Validation Mechanism

- Restate the ultimate goal in observable terms:
  - E.g., tests passing, metric thresholds met, UI behavior achieved, docs produced.
- Identify or negotiate a **validation mechanism** in the prompt:
  - Test command or suite, manual acceptance steps, metrics or logs to inspect, diff/format expectations.
- Define a rough limit on iterations or timebox if applicable.

## 2. Plan the Next Minimal Step

- Choose the smallest meaningful change that moves toward the goal.
- Prefer steps that:
  - Are easy to validate using the chosen mechanism.
  - Are reversible or low-risk.
- Make assumptions explicit so they can be confirmed or revised after validation.

## 3. Execute the Step

- Apply the planned change (code, config, docs, or other artifacts).
- Keep the change focused on the current step; avoid mixing unrelated edits.

## 4. Validate and Observe

- Run the agreed validation mechanism:
  - Execute tests, commands, or checks.
  - Inspect outputs, logs, or metrics as specified.
- Compare results with expectations:
  - Did this step move closer to the goal, fully achieve it, or reveal new information?

## 5. Adapt the Plan

- If validation succeeded and the goal is met:
  - Consider whether any final clean-up or documentation is needed.
- If validation partially succeeded or failed:
  - Update the mental model of the system or task.
  - Adjust assumptions, and refine or change the next step accordingly.
- If validation failed in a surprising way:
  - Optionally apply `/workflow-deep-debug` or `/workflow-deep-investigate` patterns before proceeding.

## 6. Iterate Until Done or Timeboxed

- Repeat steps 2–5, each time:
  - Planning a new minimal step.
  - Executing and validating.
  - Learning from the outcome.
- Stop when:
  - The goal is clearly achieved and validated, or
  - You reach the agreed timebox or iteration limit, in which case summarize current progress and remaining gaps.

## 7. Summarize Outcome and Next Steps

- Provide a concise summary of:
  - Steps taken and validation results.
  - Final state relative to the original goal.
- If the goal wasn’t fully achieved, clearly state:
  - What remains, and what you recommend as the next actions.
