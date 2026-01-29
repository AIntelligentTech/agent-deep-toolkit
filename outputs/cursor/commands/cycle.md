# Iterate Workflow

This workflow instructs Cascade to work in validated iterations following the **Automated Iterative Development (AID)** methodology. The `/relentless` mode multiplies effort and depth.

## Core Principles

1. **Small steps**: Each iteration is a minimal, complete unit of progress.
2. **Continuous validation**: Every step is verified before moving on.
3. **Adaptive planning**: The plan evolves based on what's learned.
4. **Clear goals**: Work stops when the goal is reached.

## 1. Clarify the End Goal

- State the goal precisely:
  - What does "done" look like?
  - What are the acceptance criteria?
- Distinguish between:
  - Must-have (required for success).
  - Nice-to-have (valuable but optional).
- Estimate scope:
  - Is this achievable in a few iterations or many?

## 2. Plan the Minimal Next Step

- Identify the smallest useful increment:
  - What single thing moves closest to the goal?
- Define success for this step:
  - How will you know it worked?
- Keep steps small enough to validate quickly.

## 3. Execute the Step

- Focus on one thing at a time.
- Apply quality practices from `/code`:
  - Clean implementation, error handling, tests.
- Avoid scope creep within the step.

## 4. Validate Immediately

| Validation Level | What to Check |
|------------------|---------------|
| Syntax | Does the code compile/parse? |
| Unit | Do individual functions work? |
| Integration | Do components work together? |
| End-to-end | Does the full flow work? |

- Run appropriate tests.
- Fix issues before proceeding.

## 5. Commit at Phase Boundaries

- Each completed, validated step should be committed.
- Write clear commit messages.
- Never commit broken code.

## 6. Adapt the Plan

- After each step:
  - Reassess the remaining work.
  - Update the plan based on learnings.
  - Identify new risks or blockers.
- Pivot if necessary.

## 7. Repeat Until Done

- Continue iterating until:
  - The goal is fully achieved, OR
  - A stop condition is reached.
- Track progress toward the goal.

## Relentless Mode (`/relentless`)

When maximum effort is needed:
- Explore more options at each step.
- Go deeper into edge cases.
- Try multiple approaches before selecting.
- Increase validation rigor.
- Document more thoroughly.

Use relentless mode for high-stakes work where thoroughness matters more than speed.

## 8. Summarize Outcomes

- At completion, document:
  - What was accomplished.
  - Commits made.
  - Validation results.
  - Any remaining follow-up.