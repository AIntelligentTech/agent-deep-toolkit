---
description: Perform a structured audit of a codebase or system across architecture, quality, security, and operational readiness
auto_execution_mode: 3
tags:
  - architecture
  - design
  - testing
  - documentation
  - security
  - performance
---
# Deep Audit Workflow

This workflow instructs Cascade to conduct a systematic review, producing a clear, prioritized findings report rather than ad-hoc comments.

## 1. Define Scope, Objectives, and Standards

- Clarify the audit scope:
  - Entire system vs specific service, module, or feature.
- Identify objectives:
  - Security posture, code quality, architecture health, performance readiness, compliance.
- Select reference standards and checklists:
  - OWASP Top 10, secure coding guidelines, internal style guides, architecture principles, testing standards.

## 2. Collect Artifacts and Context

- Gather:
  - Code, configs, infrastructure definitions, CI/CD pipelines, logs/metrics, existing docs.
- Understand constraints:
  - Regulatory requirements, SLAs/SLOs, uptime expectations, data residency.
- Use `search_web` sparingly to confirm current best practices for any unfamiliar frameworks or technologies.

## 3. Assess Architecture and Design

- Evaluate alignment with intended architecture (e.g., C4 diagrams, documented patterns).
- Look for:
  - Excessive coupling, unclear boundaries, and God components.
  - Data ownership clarity and cross-context dependencies.
  - Use (or misuse) of patterns like microservices, event-driven design, or CQRS.

## 4. Assess Code Quality and Maintainability

- Sample representative areas of the codebase:
  - Hot paths, complex modules, and recently changed files.
- Check for:
  - Readability, clear naming, and small, focused functions.
  - Encapsulation, duplication, and adherence to established conventions.
  - Test coverage and test quality around critical behavior.

## 5. Assess Security and Data Protection

- Review authentication and authorization flows.
- Check for common classes of vulnerabilities:
  - Injection, broken access control, insecure deserialization, weak crypto, secrets in code or configs.
- Verify logging and monitoring for security-relevant events.

## 6. Assess Operational Readiness

- Examine deployment and rollback mechanisms.
- Review observability:
  - Metrics, logging, tracing, alerts, and dashboards.
- Consider resilience and failure handling:
  - Timeouts, retries, backoff, circuit breakers, graceful degradation.

## 7. Synthesize Findings and Recommendations

- Group findings by category and severity (e.g., Critical, High, Medium, Low).
- For each finding:
  - Describe the issue, its impact, and supporting evidence.
  - Propose concrete remediation steps or next investigations.
- Summarize systemic themes (e.g., testing gaps, architectural drift, repeated security smells).
- Produce a concise report that can be tracked as work items in the backlog.
