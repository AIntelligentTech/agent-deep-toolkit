---
name: migrate
description: Safely plan and execute data, schema, or API migrations with rollback strategies
command: /migrate
aliases: ["/migration", "/upgrade"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Migrate Workflow

This workflow instructs Cascade to plan and execute migrations safely, minimizing risk and ensuring rollback capability.

## 1. Define Migration Scope and Goals

- Clarify what is being migrated:
  - Database schema, data, APIs, services, infrastructure.
- Define the end state:
  - What will things look like after migration?
- Identify success criteria:
  - Data integrity, performance targets, feature parity.

## 2. Assess Current State

- Document the current system:
  - Schema, data volumes, usage patterns.
  - Existing integrations and dependencies.
- Identify potential issues:
  - Data quality problems, edge cases.
  - Performance bottlenecks, compatibility concerns.

## 3. Design Migration Strategy

- Choose the migration approach:
  - **Big bang**: All at once with downtime.
  - **Parallel run**: Old and new running together.
  - **Gradual migration**: Incremental with feature flags.
  - **Strangler fig**: New system gradually replaces old.
- Consider:
  - Downtime tolerance.
  - Rollback requirements.
  - Data synchronization needs.

## 4. Plan Rollback Strategy

- Define rollback triggers:
  - What conditions require rollback?
- Design rollback mechanism:
  - How quickly can we revert?
  - What data loss is acceptable?
- Test rollback procedure before migration.

## 5. Create Migration Scripts and Tools

- Build migration tooling:
  - Schema migration scripts.
  - Data transformation scripts.
  - Validation scripts.
- Ensure scripts are:
  - Idempotent where possible.
  - Resumable after failure.
  - Well-tested.

## 6. Plan Data Validation

- Define validation checks:
  - Row counts, checksums.
  - Business rule compliance.
  - Referential integrity.
- Plan for discrepancy resolution.
- Automate validation where possible.

## 7. Execute Migration

- Follow the planned sequence:
  - Pre-migration checks.
  - Backup current state.
  - Execute migration steps.
  - Run validation checks.
  - Switch traffic (if applicable).
- Monitor closely:
  - Performance, errors, data integrity.
- Document any issues encountered.

## 8. Validate and Clean Up

- Verify migration success:
  - All validation checks pass.
  - Application functions correctly.
  - Performance meets targets.
- Clean up:
  - Remove temporary migration infrastructure.
  - Archive old data as appropriate.
  - Update documentation.

## 9. Post-Migration Review

- Document lessons learned:
  - What went well, what didn't.
  - Improvements for future migrations.
- Update runbooks and procedures.
- Celebrate success!
