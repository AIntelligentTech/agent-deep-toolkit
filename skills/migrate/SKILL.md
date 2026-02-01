---
name: migrate
description: Safely plan and execute data, schema, or API migrations with rollback strategies
command: /migrate
aliases: ["/migration", "/upgrade"]
synonyms: ["/migrating", "/migrated", "/migrates", "/upgrading", "/upgraded", "/upgrades"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Migrate Workflow

<scope_constraints>
This workflow instructs Cascade to plan and execute migrations safely, minimizing risk and ensuring rollback capability.
</scope_constraints>

<context>
Migrations involve moving data, schemas, or systems to new states. Success requires clear planning, careful execution, comprehensive testing, and reliable rollback.
</context>

<instructions>

## Inputs

- Migration scope: What is being migrated (database schema, data, APIs, services, infrastructure)?
- Current state: Documentation of existing system including schemas, data volumes, dependencies
- End state definition: What will things look like after migration?
- Success criteria: Data integrity, performance targets, feature parity
- Constraints: Downtime tolerance, rollback requirements, resource availability

## Step 1: Define Migration Scope and Goals

- Clarify what is being migrated:
  - Database schema, data, APIs, services, infrastructure.
- Define the end state:
  - What will things look like after migration?
- Identify success criteria:
  - Data integrity, performance targets, feature parity.

### Step 2: Assess Current State

- Document the current system:
  - Schema, data volumes, usage patterns.
  - Existing integrations and dependencies.
- Identify potential issues:
  - Data quality problems, edge cases.
  - Performance bottlenecks, compatibility concerns.

### Step 3: Design Migration Strategy

- Choose the migration approach:
  - **Big bang**: All at once with downtime.
  - **Parallel run**: Old and new running together.
  - **Gradual migration**: Incremental with feature flags.
  - **Strangler fig**: New system gradually replaces old.
- Consider:
  - Downtime tolerance.
  - Rollback requirements.
  - Data synchronization needs.

### Step 4: Plan Rollback Strategy

- Define rollback triggers:
  - What conditions require rollback?
- Design rollback mechanism:
  - How quickly can we revert?
  - What data loss is acceptable?
- Test rollback procedure before migration.

### Step 5: Create Migration Scripts and Tools

- Build migration tooling:
  - Schema migration scripts.
  - Data transformation scripts.
  - Validation scripts.
- Ensure scripts are:
  - Idempotent where possible.
  - Resumable after failure.
  - Well-tested.

### Step 6: Plan Data Validation

- Define validation checks:
  - Row counts, checksums.
  - Business rule compliance.
  - Referential integrity.
- Plan for discrepancy resolution.
- Automate validation where possible.

### Step 7: Execute Migration

- Follow the planned sequence:
  - Pre-migration checks.
  - Backup current state.
  - Execute migration steps.
  - Run validation checks.
  - Switch traffic (if applicable).
- Monitor closely:
  - Performance, errors, data integrity.
- Document any issues encountered.

### Step 8: Validate and Clean Up

- Verify migration success:
  - All validation checks pass.
  - Application functions correctly.
  - Performance meets targets.
- Clean up:
  - Remove temporary migration infrastructure.
  - Archive old data as appropriate.
  - Update documentation.

### Step 9: Post-Migration Review

- Document lessons learned:
  - What went well, what didn't.
  - Improvements for future migrations.
- Update runbooks and procedures.
- Celebrate success!

## Error Handling

- **Pre-migration validation fails:** Stop migration, address issues, retry validation
- **Migration script error:** Activate rollback immediately, investigate, test thoroughly before retry
- **Data validation failures:** Halt traffic switch, investigate discrepancies, fix data or rollback
- **Partial completion:** Document state precisely, resume from checkpoint if supported, else full rollback
- **Monitoring indicates issues:** Activate rollback canary (test subset), investigate, decide: retry with fixes or full rollback

</instructions>

<output_format>

Provide a comprehensive migration plan as the output:

1. **Migration Strategy Document**: Outline chosen approach (big bang, parallel run, gradual, strangler fig) with rationale
2. **Risk Assessment**: Document triggers for rollback and contingency plans
3. **Step-by-step Execution Plan**: Itemized sequence with checkpoints, validation steps, and rollback points
4. **Validation Framework**: Define success criteria and measurements for each phase
5. **Rollback Procedure**: Clear steps to revert if issues occur

</output_format>
