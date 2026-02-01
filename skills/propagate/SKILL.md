---
name: propagate
description: Safely propagate an approved change across code, tests, docs, infrastructure, and external systems in small, validated increments
command: /propagate
aliases: []
synonyms: ["/propagating", "/propagated", "/propagates", "/rolling-out", "/rolled-out"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Propagate Workflow

<scope_constraints>
This workflow instructs Cascade to systematically propagate an approved change across all affected areas, ensuring safety through incremental validation. Covers code, tests, documentation, configuration, infrastructure, and external systems.
</scope_constraints>

<context>
Propagation is the dangerous phase—when an isolated change must spread without breaking things. Risk comes from missed dependencies, interdependent updates getting out of sync, and downstream consumers. Safe propagation requires a clear plan, small increments, continuous validation, and stakeholder coordination.
</context>

<instructions>

## Inputs

- Approved change: What is being propagated (feature, API change, dependency upgrade)?
- Affected areas: All code, tests, docs, config, infrastructure, external systems involved
- Deployment constraints: Rollout strategy (big bang, canary, phased), backward compatibility requirements
- Stakeholders: Teams and consumers impacted by the change

## Step 1: Define the Change and Scope

- Restate what change is being propagated.
- Identify all areas that need updating:
  - Source code, tests, documentation.
  - Configuration, infrastructure.
  - External systems and integrations.
  - Dependent services or consumers.

### Step 2: Plan Propagation Sequence

- Order updates to minimize risk:
  - Update tests first (expose any issues early).
  - Update core code with tests passing.
  - Update dependent code.
  - Update docs and config last.
- Identify dependencies between updates.
- Define validation checkpoints.

### Step 3: Execute in Small Increments

- Make changes in coherent, committable slices.
- Validate after each increment:
  - Run relevant tests.
  - Check for compilation/syntax errors.
  - Verify no regressions.
- Commit at logical boundaries with clear messages.

### Step 4: Handle Cross-System Updates

- For external systems and integrations:
  - Plan for versioning and backward compatibility.
  - Coordinate timing with dependent teams.
  - Use feature flags or gradual rollout where possible.

### Step 5: Update Documentation

- Ensure all affected docs are updated:
  - README, API docs, architecture docs.
  - Runbooks and troubleshooting guides.
  - User-facing documentation.

### Step 6: Validate End-to-End

- After all updates are complete:
  - Run full test suite.
  - Perform integration testing.
  - Verify in staging environment.
- Confirm with stakeholders if needed.

### Step 7: Deploy and Monitor

- Follow deployment best practices:
  - Canary or phased rollout.
  - Monitor for anomalies.
  - Have rollback plan ready.

### Step 8: Capture Lessons

- Document any issues encountered.
- Note patterns for future propagation.
- Update checklists or automation.

## Error Handling

- **Dependency discovered mid-propagation:** Stop, update plan, restart from correct dependency order
- **Tests fail during propagation:** Fix broken tests, revert incomplete changes, restart in smaller increments
- **Cross-system coordination fails:** Synchronize timing with dependent teams, use feature flags to decouple deployments
- **Rollback needed:** Execute rollback plan systematically, investigate root cause, plan for retry

</instructions>

<output_format>

Provide a complete propagation plan and execution summary as the output:

1. **Change Summary**: What is being propagated, why, who is affected
2. **Propagation Sequence**: Ordered list of updates with dependencies
3. **Incremental Steps**: Coherent slices, validation checkpoints, commit boundaries
4. **Cross-System Coordination**: Dependencies on external teams, backward compatibility strategy
5. **Documentation Updates**: All affected docs, runbooks, user-facing materials
6. **Deployment Plan**: Rollout strategy (canary/phased), monitoring, rollback procedure
7. **Validation Results**: Test status, integration tests, staging verification

</output_format>
