---
description: Perform structured audits of codebases or systems across multiple dimensions
auto_execution_mode: 2
---

# Audit Workflow

This workflow instructs Cascade to perform comprehensive, structured audits of codebases or systems, examining multiple dimensions systematically.

## 1. Define Audit Scope and Objectives

- Clarify what is being audited:
  - Entire codebase, specific modules, infrastructure, processes.
- Define objectives:
  - Security review, quality assessment, compliance check, technical debt inventory.
- Identify key stakeholders and their concerns.
- Set boundaries:
  - What's in scope, what's explicitly out.

## 2. Collect Artifacts and Context

- Gather relevant materials:
  - Source code, configuration, documentation.
  - Architecture diagrams, previous audits.
  - Deployment infrastructure, monitoring setup.
- Understand the history:
  - Age of codebase, team size, development practices.

## 3. Assess Architecture and Structure

- Evaluate overall architecture:
  - Clarity of boundaries, separation of concerns.
  - Dependency management, coupling, cohesion.
- Check for architectural issues:
  - God modules, circular dependencies, leaky abstractions.
- Review alignment with stated design intentions.

## 4. Assess Code Quality

- Evaluate coding practices:
  - Consistency, naming conventions, error handling.
  - Documentation, test coverage, complexity metrics.
- Identify code smells and technical debt.
- Check for common anti-patterns.

## 5. Assess Security Posture

- Apply `/threat` methodology to critical areas.
- Check for common vulnerabilities:
  - OWASP Top 10, dependency vulnerabilities.
- Review authentication, authorization, data protection.
- Check secrets management.

## 6. Assess Operational Readiness

- Review observability:
  - Logging, metrics, alerting.
- Check reliability practices:
  - Health checks, graceful degradation, recovery procedures.
- Review deployment practices:
  - CI/CD, rollback capability, environment parity.

## 7. Assess Compliance and Governance

- Check for regulatory compliance needs.
- Review data handling practices.
- Assess documentation completeness.
- Check license compliance for dependencies.

## 8. Synthesize and Prioritize Findings

- Categorize findings by:
  - Severity (critical, high, medium, low).
  - Type (security, quality, operations, compliance).
  - Effort to address.
- Highlight quick wins vs. major undertakings.
- Identify patterns across findings.

## 9. Produce Audit Report

- Structure the report:
  - Executive summary.
  - Methodology.
  - Detailed findings with evidence.
  - Prioritized recommendations.
  - Suggested follow-up.
- Make findings actionable.
- Link to relevant workflows for remediation.