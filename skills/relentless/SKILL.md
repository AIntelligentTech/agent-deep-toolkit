---
name: relentless
description: Multiply effort and depth; iterate until the goal is truly done
command: /relentless
aliases: ["/try-hard", "/dont-stop", "/ultrathink"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Relentless Mode

This workflow is the “maximum effort” variant of `/iterate`. Use it when
thoroughness matters more than speed.

## Operating principles

- **Keep going** until the user’s request is fully satisfied and verified.
- **Explore more options** before committing to an approach.
- **Go deeper on edge cases** (failure modes, weird inputs, compatibility).
- **Try multiple approaches before selecting** (when there are plausible alternatives).
- **Increase validation rigor** (more checks/tests, tighter sanity checks).
- **Document more thoroughly** (what changed, why, how it was verified).
- **Avoid premature stopping**: don’t end the turn while uncertainty remains.

## How to apply it

Follow the `/iterate` loop, but with stricter guardrails:

1. Clarify the end goal and acceptance criteria.
2. Plan the smallest meaningful step.
3. Execute the step with high-quality implementation discipline.
4. Validate immediately (prefer multiple validations when possible).
5. Adapt and repeat until completion criteria are met.

## When NOT to use

- Trivial one-liners
- Low-stakes questions where speed is preferred over depth

