---
name: dependency
description: Analyze, audit, and manage project dependencies for security and maintainability
command: /dependency
aliases: ["/deps", "/dependencies"]
synonyms: ["/deps", "/dependencies", "/managing-deps"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Dependency Workflow

This workflow instructs Cascade to help manage dependencies thoughtfully, balancing security, maintainability, and functionality.

<scope_constraints>
**Operational Boundaries:**
- Scope: Dependency analysis, security audits, health assessments, update planning
- Modes: Inventory, vulnerability scanning, health evaluation, update coordination
- Defaults: Prioritize security; evaluate both direct and transitive dependencies
- Not in scope: Actual implementation of dependency updates (defer to /code or /deploy skills)
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Access to dependency manifests (package.json, pyproject.toml, Cargo.toml, go.mod, etc.)
- Ability to run security scanning tools (npm audit, pip-audit, etc.)
- Understanding of the project's requirements and constraints
- Knowledge of the team's risk tolerance and update policies
</context>

<instructions>

## Inputs
- Project dependency files or manifest information
- Current versions and constraints
- Security vulnerabilities (if known)
- Update policy and constraints
- Risk tolerance level

## Steps

### Step 1: Inventory Current Dependencies

- List all direct dependencies:
  - Name, version, purpose.
- Generate dependency tree:
  - Transitive dependencies.
  - Depth and complexity.
- Categorize by type:
  - Production vs development.
  - Optional vs required.

### Step 2: Assess Security

- Check for known vulnerabilities:
  - Use security scanning tools (npm audit, pip-audit, etc.).
  - Review CVE databases.
- Assess each vulnerability:
  - Severity and exploitability.
  - Whether it affects your usage.
- Prioritize remediation.

### Step 3: Evaluate Dependency Health

For each significant dependency, assess:

- **Maintenance status**:
  - Last update, release frequency.
  - Open issues and response time.
  - Bus factor (who maintains it).
- **Adoption**:
  - Downloads, stars, community size.
- **License**:
  - Compatible with your project.
  - Any viral license concerns.

### Step 4: Identify Problematic Dependencies

Look for:
- **Abandoned projects**: No updates in 1+ years.
- **Excessive transitive deps**: Bloating bundle/install.
- **Duplicates**: Same function provided by multiple packages.
- **Mismatched versions**: Conflicting version requirements.
- **Heavy dependencies** for light usage.

### Step 5: Plan Dependency Updates

- Categorize updates:
  - Patch: Bug fixes (usually safe).
  - Minor: New features (review changes).
  - Major: Breaking changes (careful planning).
- Check changelogs for:
  - Breaking changes.
  - Deprecations.
  - Migration guides.

### Step 6: Manage Dependency Changes

- Add dependencies thoughtfully:
  - Is it really needed?
  - Are there lighter alternatives?
  - What's the maintenance burden?
- Remove unused dependencies.
- Pin versions appropriately:
  - Lock files for reproducibility.
  - Ranges for libraries.

### Step 7: Automate Dependency Management

- Set up automated updates:
  - Dependabot, Renovate, etc.
  - Review and test before merging.
- Configure security alerts.
- Add vulnerability scanning to CI.

### Step 8: Document Decisions

- Record significant dependency choices:
  - Why this library over alternatives.
  - Known limitations or concerns.
- Update when dependencies change.

## Error Handling

- **Conflicting version requirements**: Use dependency resolution tools; consider alternative libraries if no compatible versions exist
- **Unmaintained dependency with vulnerabilities**: Plan replacement or fork maintenance; escalate as risk if no path forward
- **Complex dependency tree**: Use visualization tools to understand transitive dependencies; consider splitting or modularizing
- **Breaking changes in major update**: Create comprehensive migration plan; test thoroughly in staging before production rollout

</instructions>

<output_format>
**Deliverables:**
- Dependency inventory with type, version, and purpose
- Security audit report with CVEs and remediation priorities
- Health assessment of key dependencies
- Problematic dependencies identified with recommendations
- Update plan with migration guides for major versions
- Automation recommendations (Dependabot, Renovate, etc.)
- Decision log for significant dependency choices
</output_format>
