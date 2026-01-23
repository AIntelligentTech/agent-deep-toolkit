---
description: Implement high-quality code using solid design principles, refactoring, and thorough testing
auto_execution_mode: 3
---

# Deep Code Workflow

This workflow instructs Cascade to focus on implementation quality: clear design, clean code, strong tests, and safe integration.

## 1. Understand Behavioral and Interface Requirements

- Restate what the code must do in precise terms:
  - Inputs, outputs, side effects, error conditions, and performance expectations.
- Identify callers and consumers:
  - Public API surface, internal modules, external systems.
- Note constraints:
  - Backwards compatibility, security/privacy requirements, latency budgets.

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

## 5. Refactor Continuously with Safety Nets

- After functionality is in place and tests pass:
  - Look for opportunities to simplify, remove duplication, and improve structure.
- Apply well-known refactorings (extract function, introduce parameter object, move method, etc.) in small steps.
- Run tests frequently to ensure behavior remains correct.

## 6. Integrate and Handle Cross-Cutting Concerns

- Ensure the new or changed code:
  - Fits existing error-handling and logging conventions.
  - Respects security constraints (input validation, data sanitization, least privilege).
- Consider observability:
  - Add or update logs/metrics where they will help diagnose future issues.
- Verify interactions with external systems:
  - API contracts, database schemas, message formats.

## 7. Final Review and Clean-Up

- Self-review the changes:
  - Readability, consistency with surrounding code, adherence to project standards.
- Confirm tests:
  - Ensure new tests are meaningful and not brittle.
- Remove temporary instrumentation or debugging code before finalizing.
- Summarize key implementation decisions briefly in comments or linked specs/ADRs where appropriate.
