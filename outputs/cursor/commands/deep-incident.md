# Deep Incident Workflow

This workflow instructs Cascade to handle production incidents methodically: triage, stabilize, communicate, and learn.

## 1. Detect, Classify, and Declare

- Confirm that an incident is occurring using alerts, reports, or anomaly signals.
- Classify severity and impact:
  - Affected users, functionality, data, and regulatory exposure.
- Appoint an **incident commander** and establish communication channels.

## 2. Stabilize and Limit Impact

- Prioritize user and data safety over root-cause hunting.
- Use safe, reversible actions where possible:
  - Rollbacks, feature flags, traffic shaping, rate limiting, failover.
- Document actions and timestamps as you go for later analysis.

## 3. Investigate in Real Time

- Use logs, metrics, traces, and dashboards to narrow down failure domains.
- Form quick hypotheses and test them with minimal-risk experiments.
- Keep notes on what is ruled out to avoid duplication of effort.

## 4. Communicate Clearly

- Provide regular internal updates:
  - Current understanding, mitigations in progress, and next checkpoints.
- When appropriate, communicate externally:
  - Status pages, customer messages, and regulatory notifications.
- Be transparent but careful with speculation; focus on facts.

## 5. Resolve and Verify Recovery

- Implement the chosen mitigation or fix.
- Verify recovery:
  - Key metrics, logs, and user flows back within normal bounds.
- Decide when to formally close the incident and hand off to follow-up.

## 6. Transition to Retrospective and Systemic Fixes

- Schedule a follow-up using the Deep Retrospective workflow (`/deep-retrospective`).
- Ensure action items are captured and prioritized:
  - Code fixes, infra changes, observability upgrades, process improvements.
- Update runbooks, playbooks, and training based on what was learned.

