---
description: Run effective, blameless retrospectives and postmortems that lead to real improvements
auto_execution_mode: 3
---

# Deep Retrospective Workflow

This workflow instructs Cascade to help teams learn from incidents and projects, not just document them.

## 1. Frame Scope and Objectives

- Define what the retrospective covers:
  - Specific incident, release, sprint, or project.
- Clarify objectives:
  - Understanding root causes, improving processes, strengthening collaboration.
- Emphasize a **blameless** approach focused on systems, not individuals.

## 2. Reconstruct the Timeline

- Collect key events:
  - When issues were introduced, detected, escalated, mitigated, and resolved.
- Use logs, tickets, chats, and deployment history to validate the sequence.
- Note where information was missing, delayed, or misunderstood.

## 3. Analyze Impact

- Describe impacts across dimensions:
  - Users and customers.
  - Business metrics and reputation.
  - Technical health (incurred debt, instability).
  - Team well-being (stress, burnout, confusion).

## 4. Identify Root Causes and Contributing Factors

- Apply 5 Whys to get beyond surface symptoms.
- Use a fishbone lens (People, Process, Platform, Code, Data) to explore systemic contributors.
- Distinguish between proximate causes and deeper systemic issues.

## 5. Capture What Worked and What Didn’t

- List practices or behaviors that helped:
  - Effective communication, quick detection, robust tooling, clear ownership.
- List things that hindered:
  - Slow detection, unclear roles, brittle systems, missing tests.
- Highlight surprises or invalidated assumptions.

## 6. Define Actionable Improvements

- Propose concrete actions across:
  - Code/architecture (e.g., refactors, additional tests, resilience patterns).
  - Tooling and observability (dashboards, alerts, runbooks).
  - Process and collaboration (on-call rotations, review practices, escalation paths).
- Assign rough priority and ownership where applicable.
- Encourage tracking follow-up actions in the regular backlog.
