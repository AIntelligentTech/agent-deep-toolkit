---
name: audit
description: Perform structured audits of codebases or systems across multiple dimensions
command: /audit
aliases: []
synonyms: ["/auditing", "/audited", "/audits"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: assess
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Audit Workflow

This workflow instructs Cascade to perform comprehensive, structured audits of codebases or systems, examining multiple dimensions systematically.

<scope_constraints>
- Focuses on systematic, multi-dimensional audits of codebases and systems
- Covers security, quality, architecture, operations, and compliance dimensions
- Applies to greenfield and brownfield systems
- Produces findings with prioritization and recommendations
- Does not include detailed remediation (use specific skills like `/threat` or `/architect`)
</scope_constraints>

<context>
**Dependencies:**
- Understanding of the system being audited (code, architecture, operations)
- Knowledge of quality assessment techniques and security assessment basics
- Familiarity with audit frameworks and prioritization methods
- Access to relevant artifacts (code, documentation, deployment configs)

**Prerequisites:**
- Defined audit scope (what's in, what's out)
- Clear objectives (security review, quality assessment, compliance check, etc.)
- Identified key stakeholders and their concerns
- Access to codebase, documentation, and infrastructure
</context>

<instructions>

## Inputs

- System or codebase to be audited
- Audit objectives (security, quality, compliance, technical debt, operational readiness)
- Scope boundaries (entire system vs. specific modules)
- Key stakeholder concerns and priorities
- Relevant regulatory or compliance requirements
- Existing audit findings or previous assessments

## Steps

### Step 1: Define Audit Scope and Objectives

- Clarify what is being audited:
  - Entire codebase, specific modules, infrastructure, processes.
- Define objectives:
  - Security review, quality assessment, compliance check, technical debt inventory.
- Identify key stakeholders and their concerns.
- Set boundaries:
  - What's in scope, what's explicitly out.

### Step 2: Collect Artifacts and Context

- Gather relevant materials:
  - Source code, configuration, documentation.
  - Architecture diagrams, previous audits.
  - Deployment infrastructure, monitoring setup.
- Understand the history:
  - Age of codebase, team size, development practices.

### Step 3: Assess Architecture and Structure

- Evaluate overall architecture:
  - Clarity of boundaries, separation of concerns.
  - Dependency management, coupling, cohesion.
- Check for architectural issues:
  - God modules, circular dependencies, leaky abstractions.
- Review alignment with stated design intentions.

### Step 4: Assess Code Quality

- Evaluate coding practices:
  - Consistency, naming conventions, error handling.
  - Documentation, test coverage, complexity metrics.
- Identify code smells and technical debt.
- Check for common anti-patterns.

### Step 5: Assess Security Posture

- Apply `/threat` methodology to critical areas.
- Check for common vulnerabilities:
  - OWASP Top 10, dependency vulnerabilities.
- Review authentication, authorization, data protection.
- Check secrets management.

### Step 6: Assess Operational Readiness

- Review observability:
  - Logging, metrics, alerting.
- Check reliability practices:
  - Health checks, graceful degradation, recovery procedures.
- Review deployment practices:
  - CI/CD, rollback capability, environment parity.

### Step 7: Assess Compliance and Governance

- Check for regulatory compliance needs.
- Review data handling practices.
- Assess documentation completeness.
- Check license compliance for dependencies.

### Step 8: Synthesize and Prioritize Findings

- Categorize findings by:
  - Severity (critical, high, medium, low).
  - Type (security, quality, operations, compliance).
  - Effort to address.
- Highlight quick wins vs. major undertakings.
- Identify patterns across findings.

### Step 9: Produce Audit Report

- Structure the report:
  - Executive summary.
  - Methodology.
  - Detailed findings with evidence.
  - Prioritized recommendations.
  - Suggested follow-up.
- Make findings actionable.
- Link to relevant workflows for remediation.

## Error Handling

**Common audit pitfalls:**
- Audit scope creep without clear prioritization
- Findings without clear evidence or context
- Recommendations that are too vague or resource-intensive
- Missing follow-up on audit findings
- Failing to distinguish architectural vs. tactical issues

**Mitigation strategies:**
- Define scope clearly at start; document out-of-scope items
- Support each finding with specific evidence (code snippets, logs, metrics)
- Provide actionable recommendations with estimated effort
- Include a follow-up schedule and responsibility assignments
- Use severity/priority matrix to focus effort on high-impact issues

</instructions>

<output_format>

The output of this skill is a **comprehensive audit report** that includes:

1. **Executive Summary** — High-level findings and key recommendations
2. **Methodology** — Audit scope, objectives, and assessment approach
3. **Architecture Assessment** — Findings on design, structure, and decomposition
4. **Code Quality Assessment** — Technical debt, maintainability, consistency
5. **Security Assessment** — Vulnerabilities, secrets management, compliance
6. **Operational Readiness** — Observability, reliability, deployment practices
7. **Compliance & Governance** — Regulatory alignment and data handling
8. **Findings & Evidence** — Detailed findings with supporting evidence and severity
9. **Prioritized Recommendations** — Top issues and suggested remediation
10. **Action Items** — Owner, timeline, and success criteria for follow-up

Deliverables typically include:
- Executive summary document (1-2 pages)
- Detailed audit report (5-20 pages depending on system complexity)
- Finding registry with severity, effort estimate, and assigned owners
- Roadmap for remediation with phasing and milestones
- Links to specific remediation workflows (e.g., `/threat`, `/architect`, `/code`)

</output_format>
