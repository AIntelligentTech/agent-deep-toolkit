---
name: deep-prune
description: Systematically identify and remove dead or low-value code, configuration, and dependencies while preserving behavior
command: /deep-prune
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Deep Prune Workflow

This workflow instructs Cascade to clean a codebase thoughtfully, minimizing risk while reducing complexity and surface area.

## 1. Define Scope and Safety Constraints

- Clarify what kinds of artifacts are in-scope:
  - Unused functions/classes/modules, obsolete endpoints, legacy feature flags, stale configs, unused assets, dead tests.
- Establish guardrails:
  - No behaviour changes outside the agreed scope.
  - Prefer deprecation and staged removal for anything user-facing or externally integrated.

## 2. Discover Candidates for Removal

- Use static analysis and search to find:
  - Unreferenced symbols, unreachable branches, unused feature flags, dead routes.
- Use runtime data where available:
  - Logs, metrics, tracing, and analytics to identify rarely or never-used endpoints and features.
- Cross-check with documentation and stakeholders to avoid removing deliberately dormant or emergency-only paths.

## 3. Assess Risk and Prioritize

- Classify candidates by risk:
  - Internal-only vs external APIs.
  - Covered by tests vs untested.
  - Recently touched vs long-stable.
- Prioritize low-risk, high-clarity removals first to build confidence and reduce noise.

## 4. Plan Staged Pruning

- For higher-risk items:
  - Introduce deprecation warnings or feature flags.
  - Add logging around potential removal points to confirm lack of use over a defined window.
- Define clear cut-over dates and communication needs (e.g., for external consumers).

## 5. Execute Removals Safely

- Remove code, configuration, and assets in coherent slices rather than scattered edits.
- Keep commits narrowly focused and well-described for easy rollback.
- Update tests and docs to reflect removed behavior, avoiding references to dead features.

## 6. Validate and Monitor

- Run the full relevant test suite (including integration/e2e where available).
- Perform targeted smoke tests around the cleaned areas.
- Monitor logs, error rates, and user feedback after deployment for unexpected regressions.

## 7. Institutionalize Hygiene

- Where possible, add automated checks:
  - Linters or build steps that flag unused code, imports, and dependencies.
  - Dashboards or queries that track rarely used features over time.
- Capture guidelines for when to deprecate vs immediately remove, and how to communicate removals to stakeholders.
