# Incident Workflow

This workflow combines incident response with blameless retrospectives, covering the full cycle from detection through learning and systemic improvement.

## Part A: Incident Response

### 1. Detect, Classify, and Declare

- Recognize incident indicators:
  - Alerts, user reports, anomalous metrics.
- Classify severity and impact:
  - Users affected, business criticality, duration.
- Formally declare an incident when warranted:
  - Assign an incident commander, open communication channels.

### 2. Stabilize and Limit Impact

- Focus on mitigation before root cause:
  - Rollback, feature flag, scale, redirect traffic.
- Limit blast radius:
  - Isolate affected components.
- Keep the system operational even if degraded.

### 3. Investigate in Real-Time

- Gather signals:
  - Logs, metrics, traces, recent deployments.
- Form and test hypotheses quickly.
- Document findings as you go.

### 4. Communicate Clearly

- Keep stakeholders informed:
  - Status updates at regular intervals.
  - Be honest about what's known and unknown.
- Use incident communication templates.

### 5. Resolve and Verify Recovery

- Apply fixes or workarounds.
- Verify recovery through monitoring and testing.
- Confirm with affected parties.
- Close the incident formally.

## Part B: Retrospective

### 6. Frame the Retrospective

- Define what the retrospective covers:
  - Specific incident, release, sprint, or project.
- Clarify objectives:
  - Understanding root causes, improving processes.
- **Psychological Safety**: Explicitly establish a safe environment where everyone feels comfortable sharing mistakes and truths without fear.
- Emphasize a **blameless** approach focused on systems, not individuals.

### 7. Reconstruct the Timeline

- Collect key events:
  - When issues were introduced, detected, escalated, mitigated, and resolved.
- Use logs, tickets, chats, and deployment history.
- Note where information was missing or delayed.

### 8. Analyze Impact

- Describe impacts across dimensions:
  - Users and customers.
  - Business metrics and reputation.
  - **Metrics**: Include reliability metrics like **MTTR** (Mean Time to Repair) and **TTO** (Time to Outage/Detection).
  - Technical health (incurred debt, instability).
  - Team well-being (stress, burnout).

### 9. Identify Root Causes

- Apply 5 Whys to get beyond surface symptoms.
- Use a fishbone lens (People, Process, Platform, Code, Data).
- Distinguish between proximate causes and deeper systemic issues.

### 10. Capture What Worked and What Didn't

- List practices that helped:
  - Effective communication, quick detection, robust tooling.
- List things that hindered:
  - Slow detection, unclear roles, brittle systems.
- Highlight surprises or invalidated assumptions.

### 11. Define Actionable Improvements

- Propose concrete actions across:
  - Code/architecture improvements.
  - Tooling and observability enhancements.
  - Process and collaboration changes.
- Assign priority and ownership.
- Track follow-up actions in the regular backlog.