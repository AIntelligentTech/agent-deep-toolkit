# Deep Refactor Workflow

This workflow instructs Cascade to refactor codebases safely, evolving design while preserving behavior.

## 1. Understand Context and Constraints

- Clarify the motivation for refactoring:
  - Pain points (hard to change, bugs clustering, performance issues).
  - Desired properties (simpler interfaces, clearer boundaries, better testability).
- Identify constraints:
  - Timebox, risk tolerance, deployment cadence, availability of tests.
- Confirm that behavior must remain functionally equivalent except where explicitly stated.

## 2. Identify Smells, Hotspots, and Seams

- Use `code_search` and `grep_search` plus any metrics to locate:
  - Complex or frequently changed modules.
  - God classes/modules, long functions, duplicated logic, cyclical dependencies.
- Look for natural **seams**:
  - Existing interfaces, adapters, modules, or test boundaries.
  - Places where dependencies could be inverted or responsibilities split.

## 3. Design an Incremental Refactor Plan

- Define a series of **small, reversible steps** rather than a big‑bang change.
- For each step, specify:
  - Target code area and intended structural change (e.g., extract function, introduce interface, split module).
  - Tests that must continue to pass.
  - Any new tests needed to characterize current behavior before changing it.
- Prefer patterns like:
  - Strangler Fig (new structure coexists with old until migration is complete).
  - Branch‑by‑abstraction (introduce abstraction, move implementations behind it, then remove old usage).

## 4. Execute with Test and Git Discipline

- Before each step:
  - Ensure tests are passing and there is a clean working tree.
- During each step:
  - Make focused edits aligned with the plan.
  - Keep commits small and well described (what changed, why, and how behavior is preserved).
- After each step:
  - Run relevant tests (unit + integration) before proceeding.
  - Fix issues or adjust the plan as needed.

## 5. Validate Design Improvements

- After the main refactor steps:
  - Reassess complexity (smaller functions, fewer responsibilities per module).
  - Check for improved testability (easier to mock or isolate components).
  - Review dependency direction and boundaries (reduced coupling, clearer layering).
- Optionally perform a brief code review pass using agreed coding and architecture standards.

## 6. Institutionalize and Follow Up

- Capture key refactoring patterns and lessons learned:
  - What worked well, what was risky or noisy.
- Consider adding:
  - Lint rules, architecture tests, or CI checks to prevent regression into old patterns.
- Identify adjacent areas that would benefit from similar incremental refactors and schedule them appropriately.

