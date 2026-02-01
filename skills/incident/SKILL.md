---
name: incident
description: Respond to incidents and run blameless retrospectives that lead to real improvements
command: /incident
aliases: ["/retrospective", "/postmortem", "/outage"]
synonyms: ["/retro", "/postmortem", "/outage", "/incident-report", "/retrospective"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: operations
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill covers the full incident lifecycle from detection through resolution and post-incident learning. It includes active response coordination and retrospective analysis but assumes incident management infrastructure (communication channels, etc.) already exists.
</scope_constraints>

<context>
This workflow combines incident response with blameless retrospectives, covering the full cycle from detection through learning and systemic improvement. The approach emphasizes rapid stabilization, clear communication, and systematic learning to prevent recurrence.
</context>

<instructions>

## Inputs

- Incident indicators (alerts, user reports, metrics anomalies)
- Current system state and recent changes
- Stakeholder list and communication channels
- Historical incident data (for retrospectives)

## Part A: Incident Response

### Step 1: Detect, Classify, and Declare

- Recognize incident indicators:
  - Alerts, user reports, anomalous metrics.
- Classify severity and impact:
  - Users affected, business criticality, duration.
- Formally declare an incident when warranted:
  - Assign an incident commander, open communication channels.

### Step 2: Stabilize and Limit Impact

- Focus on mitigation before root cause:
  - Rollback, feature flag, scale, redirect traffic.
- Limit blast radius:
  - Isolate affected components.
- Keep the system operational even if degraded.

### Step 3: Investigate in Real-Time

- Gather signals:
  - Logs, metrics, traces, recent deployments.
- Form and test hypotheses quickly.
- Document findings as you go.

### Step 4: Communicate Clearly

- Keep stakeholders informed:
  - Status updates at regular intervals.
  - Be honest about what's known and unknown.
- Use incident communication templates.

### Step 5: Resolve and Verify Recovery

- Apply fixes or workarounds.
- Verify recovery through monitoring and testing.
- Confirm with affected parties.
- Close the incident formally.

## Part B: Retrospective

### Step 6: Frame the Retrospective

- Define what the retrospective covers:
  - Specific incident, release, sprint, or project.
- Clarify objectives:
  - Understanding root causes, improving processes.
- **Psychological Safety**: Explicitly establish a safe environment where everyone feels comfortable sharing mistakes and truths without fear.
- Emphasize a **blameless** approach focused on systems, not individuals.

### Step 7: Reconstruct the Timeline

- Collect key events:
  - When issues were introduced, detected, escalated, mitigated, and resolved.
- Use logs, tickets, chats, and deployment history.
- Note where information was missing or delayed.

### Step 8: Analyze Impact

- Describe impacts across dimensions:
  - Users and customers.
  - Business metrics and reputation.
  - **Metrics**: Include reliability metrics like **MTTR** (Mean Time to Repair) and **TTO** (Time to Outage/Detection).
  - Technical health (incurred debt, instability).
  - Team well-being (stress, burnout).

### Step 9: Identify Root Causes

- Apply 5 Whys to get beyond surface symptoms.
- Use a fishbone lens (People, Process, Platform, Code, Data).
- Distinguish between proximate causes and deeper systemic issues.

### Step 10: Capture What Worked and What Didn't

- List practices that helped:
  - Effective communication, quick detection, robust tooling.
- List things that hindered:
  - Slow detection, unclear roles, brittle systems.
- Highlight surprises or invalidated assumptions.

### Step 11: Define Actionable Improvements

- Propose concrete actions across:
  - Code/architecture improvements.
  - Tooling and observability enhancements.
  - Process and collaboration changes.
- Assign priority and ownership.
- Track follow-up actions in the regular backlog.

## Error Handling

- **Missing incident context**: Request historical data and recent changes
- **Unclear root cause**: Recommend additional investigation or expert consultation
- **Stakeholder disagreement**: Document divergent perspectives in retrospective
- **Follow-up actions not assigned**: Escalate until owners are identified

</instructions>

<output_format>
- **Incident summary**: Brief description of what happened and impact
- **Timeline**: Chronological sequence of detection, escalation, mitigation, resolution
- **Impact metrics**: MTTR, TTO, users affected, business impact
- **Root cause analysis**: Primary and contributing causes using fishbone method
- **What worked/didn't work**: Effective practices and impediments
- **Action items**: Prioritized improvements with assigned owners
- **Follow-up tracking**: Links to backlog items for closure verification
</output_format>
