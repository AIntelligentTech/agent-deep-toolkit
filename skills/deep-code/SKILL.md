---
name: deep-code
description: Implement high-quality code using solid design principles, refactoring, and thorough testing
command: /deep-code
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Deep Code Workflow

This workflow instructs Cascade to focus on implementation quality: clear design, clean code, strong tests, safe integration, and disciplined version control following the **Automated Iterative Development (AID)** methodology.

For command-style agents that support `/deep-code <task>` syntax (such as Cursor), treat any text you type after the command as the specific task description; in agents like Windsurf and Claude Code, the entire prompt is treated as context and you can mention `/deep-code` anywhere without worrying about argument position.

## 1. Understand Behavioral and Interface Requirements

- Restate what the code must do in precise terms:
  - Inputs, outputs, side effects, error conditions, and performance expectations.
- Identify callers and consumers:
  - Public API surface, internal modules, external systems.
- Note constraints:
  - Backwards compatibility, security/privacy requirements, latency budgets.
- **Decompose complex work into committable phases** if the task spans multiple logical units.

## 2. Shape the Design at Code Level

- Choose appropriate abstractions:
  - Functions, classes, modules, interfaces, or patterns that map cleanly to the domain.
- Apply core design principles where they help:
  - Single Responsibility, Separation of Concerns, DRY, explicit dependencies.
- Define clear boundaries:
  - Pure vs impure code, domain vs infrastructure, sync vs async.

## 3. Plan Tests and Contracts

- Decide on test strategy:
  - Unit, integration, and/or property-based tests as appropriate.
- Identify key scenarios and edge cases:
  - Happy paths, invalid inputs, boundary values, external failures, concurrency issues.
- Where relevant, specify invariants and contracts:
  - Preconditions, postconditions, and assertions at module boundaries.

## 4. Implement in Small, Verifiable Steps

- Work in small increments:
  - Add or update a test, then implement or adjust code to satisfy it.
- Keep functions and methods focused:
  - Prefer composable, readable code over cleverness.
- Use clear naming and structure to make intent obvious.
- **Code quality checklist:**
  - [ ] Follows existing project conventions
  - [ ] Handles error cases gracefully
  - [ ] Includes necessary imports at file top
  - [ ] No hardcoded values that should be configurable
  - [ ] Compatible with strict modes (`set -e` for bash, `strict: true` for TypeScript)

## 5. Validate Before Committing

- **Apply validation hierarchy** before any commit:
  1. **Syntax**: Does the code parse/compile?
  2. **Unit**: Do individual functions work?
  3. **Integration**: Do components work together?
  4. **End-to-end**: Does the full flow work?
- **Validation commands by type:**
  | Artifact Type | Validation Method                                      |
  |---------------|--------------------------------------------------------|
  | Bash scripts  | `bash -n script.sh` (syntax), then execute with args   |
  | TypeScript    | `tsc --noEmit` or `bun run typecheck`                  |
  | Python        | `python -m py_compile file.py`, then test execution    |
  | JSON          | `jq . file.json`                                       |
- **When validation fails:**
  1. Diagnose root cause, not just the symptom
  2. Fix minimally
  3. Re-validate
  4. Document what went wrong for future reference

## 6. Refactor Continuously with Safety Nets

- After functionality is in place and tests pass:
  - Look for opportunities to simplify, remove duplication, and improve structure.
- Apply well-known refactorings (extract function, introduce parameter object, move method, etc.) in small steps.
- Run tests frequently to ensure behavior remains correct.

## 7. Commit at Logical Boundaries

- **Atomic commits**: Each commit represents one logical, working change.
- **Descriptive messages**: Explain what and why, not just what.
- **Phase boundaries**: Commit at the end of each logical phase.
- **Never commit broken or partial code.**
- **Commit message template:**
  ```text
  [Type]: [Brief description]

  - [Specific change 1]
  - [Specific change 2]

  [Context if part of larger work]
  ```

## 8. Integrate and Handle Cross-Cutting Concerns

- Ensure the new or changed code:
  - Fits existing error-handling and logging conventions.
  - Respects security constraints (input validation, data sanitization, least privilege).
- Consider observability:
  - Add or update logs/metrics where they will help diagnose future issues.
- Verify interactions with external systems:
  - API contracts, database schemas, message formats.

## 9. Final Review and Clean-Up

- Self-review the changes:
  - Readability, consistency with surrounding code, adherence to project standards.
- Confirm tests:
  - Ensure new tests are meaningful and not brittle.
- Remove temporary instrumentation or debugging code before finalizing.
- Summarize key implementation decisions briefly in comments or linked specs/ADRs where appropriate.
- **Provide summary** of commits made, deliverables created, and validation results.
