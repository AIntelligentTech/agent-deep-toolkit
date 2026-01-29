---
name: dependency
description: Analyze, audit, and manage project dependencies for security and maintainability
activation: auto
---

# Dependency Workflow

This workflow instructs Cascade to help manage dependencies thoughtfully, balancing security, maintainability, and functionality.

## 1. Inventory Current Dependencies

- List all direct dependencies:
  - Name, version, purpose.
- Generate dependency tree:
  - Transitive dependencies.
  - Depth and complexity.
- Categorize by type:
  - Production vs development.
  - Optional vs required.

## 2. Assess Security

- Check for known vulnerabilities:
  - Use security scanning tools (npm audit, pip-audit, etc.).
  - Review CVE databases.
- Assess each vulnerability:
  - Severity and exploitability.
  - Whether it affects your usage.
- Prioritize remediation.

## 3. Evaluate Dependency Health

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

## 4. Identify Problematic Dependencies

Look for:
- **Abandoned projects**: No updates in 1+ years.
- **Excessive transitive deps**: Bloating bundle/install.
- **Duplicates**: Same function provided by multiple packages.
- **Mismatched versions**: Conflicting version requirements.
- **Heavy dependencies** for light usage.

## 5. Plan Dependency Updates

- Categorize updates:
  - Patch: Bug fixes (usually safe).
  - Minor: New features (review changes).
  - Major: Breaking changes (careful planning).
- Check changelogs for:
  - Breaking changes.
  - Deprecations.
  - Migration guides.

## 6. Manage Dependency Changes

- Add dependencies thoughtfully:
  - Is it really needed?
  - Are there lighter alternatives?
  - What's the maintenance burden?
- Remove unused dependencies.
- Pin versions appropriately:
  - Lock files for reproducibility.
  - Ranges for libraries.

## 7. Automate Dependency Management

- Set up automated updates:
  - Dependabot, Renovate, etc.
  - Review and test before merging.
- Configure security alerts.
- Add vulnerability scanning to CI.

## 8. Document Decisions

- Record significant dependency choices:
  - Why this library over alternatives.
  - Known limitations or concerns.
- Update when dependencies change.