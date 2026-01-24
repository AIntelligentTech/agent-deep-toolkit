---
description: Execute work in small, validated iterations until a clearly defined end goal is reached
auto_execution_mode: 3
---

# Deep Iterate Workflow

This workflow instructs Cascade to work iteratively using the **Automated Iterative Development (AID)** methodology: plan phases, execute steps, validate outputs, commit at boundaries, adapt when issues arise, and repeat.

## The AID Process Loop

```text
┌─────────────────────────────────────────────────────────────────┐
│                    AUTOMATED ITERATION LOOP                      │
├─────────────────────────────────────────────────────────────────┤
│   ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐ │
│   │  PLAN    │───▶│ EXECUTE  │───▶│ VALIDATE │───▶│  COMMIT  │ │
│   │  Phase   │    │  Step    │    │  Output  │    │  Stage   │ │
│   └──────────┘    └──────────┘    └──────────┘    └──────────┘ │
│        │                                               │        │
│        │              ┌──────────┐                     │        │
│        │◀─────────────│  ADAPT   │◀────────────────────┘        │
│                       │  & Learn │                              │
│                       └──────────┘                              │
└─────────────────────────────────────────────────────────────────┘
```

For command-style agents that support `/deep-iterate <task>` syntax (such as Cursor), treat any text you type after the command as the specific task description; in agents like Windsurf and Claude Code, the entire prompt is treated as context and you can mention `/deep-iterate` anywhere without worrying about argument position.

## 1. Clarify Goal, Decompose, and Create Task List

- Restate the ultimate goal in observable terms:
  - E.g., tests passing, metric thresholds met, UI behavior achieved, docs produced.
- **Decompose into committable phases** that can be:
  - Executed independently
  - Validated with a specific mechanism
  - Committed as a logical unit
  - Rolled back if needed
- **Create explicit task list** with clear status:
  ```text
  [x] Completed phase
  [ ] Pending phase
  [>] In-progress phase (exactly one at a time)
  [!] Blocked phase (needs input)
  ```
- Identify or negotiate a **validation mechanism** for each phase:
  - Test command or suite, manual acceptance steps, metrics or logs to inspect.
- Define a rough limit on iterations or timebox if applicable.

## 2. Plan the Next Minimal Step

- Choose the smallest meaningful change that moves toward the goal.
- For each phase, define:
  - Specific changes to make
  - Validation mechanism (command, expected output)
  - Commit message template
  - Dependencies on previous phases
- Prefer steps that:
  - Are easy to validate using the chosen mechanism.
  - Are reversible or low-risk.
- Make assumptions explicit so they can be confirmed or revised after validation.

## 3. Execute the Step

- Apply the planned change (code, config, docs, or other artifacts).
- Keep the change focused on the current step; avoid mixing unrelated edits.
- **Best practices during execution:**
  - Read before writing: Always read existing code before modifying
  - Minimal edits: Make the smallest change that achieves the goal
  - Preserve style: Match existing code conventions and patterns
  - Handle edge cases: Consider error conditions and boundary cases

## 4. Validate and Observe

- **Apply validation hierarchy** in order of increasing scope:
  1. **Syntax**: Does the code parse/compile?
  2. **Unit**: Do individual functions work?
  3. **Integration**: Do components work together?
  4. **End-to-end**: Does the full flow work?
- Run the agreed validation mechanism:
  - Execute tests, commands, or checks.
  - Inspect outputs, logs, or metrics as specified.
- Compare results with expectations:
  - Did this step move closer to the goal, fully achieve it, or reveal new information?
- **When validation fails:**
  1. Do NOT proceed to next phase
  2. Diagnose root cause (use `/deep-debug` if complex)
  3. Fix minimally at the root cause, not symptoms
  4. Re-run validation from beginning
  5. Only proceed after validation passes

## 5. Commit at Phase Boundaries

- **After successful validation**, commit the completed phase:
  1. Stage all related changes
  2. Write descriptive commit message explaining what and why
  3. Commit the phase as one logical, working change
  4. Update task list to mark phase complete
  5. Proceed to next phase
- **Commit message template:**
  ```text
  Phase N: [Brief description]

  - [Specific change 1]
  - [Specific change 2]

  Part of [larger initiative] (Phase N of M).
  ```
- **Never commit broken or partial code.**

## 6. Adapt the Plan

- **Adaptation triggers and responses:**
  | Trigger                | Response                              |
  |------------------------|---------------------------------------|
  | Validation failure     | Debug, fix, re-validate               |
  | Unexpected complexity  | Break into smaller steps              |
  | Missing dependency     | Add prerequisite phase                |
  | Scope change           | Update task list, document change     |
  | Blocking issue         | Note for user, continue other phases  |

- If validation partially succeeded or failed:
  - Update the mental model of the system or task.
  - Adjust assumptions, and refine or change the next step accordingly.
- If validation failed in a surprising way:
  - Optionally apply `/deep-debug` or `/deep-investigate` patterns before proceeding.

## 7. Iterate Until Done or Timeboxed

- Repeat steps 2–6, each time:
  - Planning a new minimal step.
  - Executing and validating.
  - Committing at phase boundaries.
  - Learning from the outcome.
- **Autonomous completion criteria:**
  - All phases in task list are marked complete
  - All commits are made with descriptive messages
  - Documentation is updated (if applicable)
  - Final validation passes
- Stop when:
  - The goal is clearly achieved and validated, or
  - You reach the agreed timebox or iteration limit.

## 8. Summarize Outcome and Handoff

- Provide a comprehensive summary:
  ```text
  ## Summary

  ### Commits Made
  1. Phase 1: [description]
  2. Phase 2: [description]
  ...

  ### Deliverables
  - [file/component]: [description]
  ...

  ### Validation Results
  - [validation]: [result]
  ...

  ### Follow-ups (if any)
  - [item]
  ...
  ```
- If the goal wasn't fully achieved, clearly state:
  - What remains, and what you recommend as the next actions.
- Await user review before considering the task fully complete.

