---
name: deep-propagate
description: Safely propagate an approved change across code, tests, docs, infra, and external systems
disable-model-invocation: true
user-invocable: true
---

# Deep Propagate Workflow

This workflow instructs Cascade to take a change that has passed impact assessment and safely propagate it across all affected surfaces: code, tests, docs, infra, and external systems.

## 1. Confirm Preconditions and Scope

- Ensure a prior impact assessment has been done:
  - Preferably via `/deep-impact`.
  - At minimum, there should be a clear description of the change, its rationale, and known risks.
- Clarify propagation scope:
  - Which repositories, services, modules, components, docs, configs, and environments are in scope.
  - Whether this is a one-off change or part of a broader migration.

## 2. Build a Propagation Plan

- Use `/deep-architect` and `/deep-explore` to:
  - Map all code and system touchpoints.
  - Identify shared libraries, generated artifacts, and integration boundaries.
- Define a sequence of propagation steps:
  - Order by dependency and blast radius (core primitives before leaf features).
  - Include tests and docs alongside code changes.
- Where uncertainty is high, apply `/deep-experiment` to design small safe-to-fail pilots.

## 3. Prepare Safety Nets and Observability

- With `/deep-test`:
  - Ensure baseline test coverage exists for impacted behavior.
  - Add or refine tests to detect regressions specific to this change.
- With `/deep-observability`:
  - Define metrics, logs, and alerts that will indicate propagation issues.
  - Align on dashboards and runbooks to watch during rollout.

## 4. Execute Propagation Incrementally

- Apply `/deep-iterate`:
  - Work in small, reversible slices, completing each slice fully before moving on.
- For each slice:
  - Implement changes using `/deep-code` and `/deep-refactor` where needed.
  - Run targeted tests first, then broader suites as appropriate.
  - Commit with clear messages annotating the propagation step.
- Keep a running checklist of completed vs remaining propagation targets.

## 5. Coordinate Non-Code Artifacts

- Documentation and Specs:
  - Use `/deep-spec` and `/deep-document` to update specs, ADRs, and user-facing docs.
- Operational Procedures:
  - Ensure runbooks, SOPs, and on-call documentation reflect the new reality.
- External Integrations:
  - Communicate with dependent teams or external partners when contracts or behaviors change.

## 6. Rollout, Monitor, and Respond

- Choose an appropriate rollout strategy:
  - Feature flags, canary deployments, staged environment rollouts.
- During rollout:
  - Monitor the signals defined earlier (metrics, logs, errors, user feedback).
  - Be prepared to pause or roll back based on pre-agreed thresholds.
- Use `/deep-incident` if significant issues arise during propagation.

## 7. Close the Loop and Prevent Drift

- After propagation is complete and stable:
  - Run `/deep-audit` in relevant areas to ensure consistency and catch stragglers.
  - Apply `/deep-prune` to remove deprecated code paths and configs.
- Capture learnings:
  - Use `/deep-retrospective` to reflect on the propagation process.
  - Update any checklists or templates used for future propagations.
