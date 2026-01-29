---
description: Safely propagate an approved change across code, tests, docs, infrastructure,
  and external systems in small, validated increments
auto_execution_mode: 2
---

# Propagate Workflow

This workflow instructs Cascade to systematically propagate an approved change across all affected areas, ensuring safety through incremental validation.

## 1. Define the Change and Scope

- Restate what change is being propagated.
- Identify all areas that need updating:
  - Source code, tests, documentation.
  - Configuration, infrastructure.
  - External systems and integrations.
  - Dependent services or consumers.

## 2. Plan Propagation Sequence

- Order updates to minimize risk:
  - Update tests first (expose any issues early).
  - Update core code with tests passing.
  - Update dependent code.
  - Update docs and config last.
- Identify dependencies between updates.
- Define validation checkpoints.

## 3. Execute in Small Increments

- Make changes in coherent, committable slices.
- Validate after each increment:
  - Run relevant tests.
  - Check for compilation/syntax errors.
  - Verify no regressions.
- Commit at logical boundaries with clear messages.

## 4. Handle Cross-System Updates

- For external systems and integrations:
  - Plan for versioning and backward compatibility.
  - Coordinate timing with dependent teams.
  - Use feature flags or gradual rollout where possible.

## 5. Update Documentation

- Ensure all affected docs are updated:
  - README, API docs, architecture docs.
  - Runbooks and troubleshooting guides.
  - User-facing documentation.

## 6. Validate End-to-End

- After all updates are complete:
  - Run full test suite.
  - Perform integration testing.
  - Verify in staging environment.
- Confirm with stakeholders if needed.

## 7. Deploy and Monitor

- Follow deployment best practices:
  - Canary or phased rollout.
  - Monitor for anomalies.
  - Have rollback plan ready.

## 8. Capture Lessons

- Document any issues encountered.
- Note patterns for future propagation.
- Update checklists or automation.