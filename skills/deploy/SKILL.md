---
name: deploy
description: Deployment strategy, rollout planning, canary, and blue-green patterns
command: /deploy
aliases: ["/release", "/rollout"]
synonyms: ["/deploying", "/deployed", "/deploys", "/releasing", "/released", "/releases", "/rolling-out"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Deploy Workflow

This workflow instructs Cascade to plan and guide safe, reliable deployments using modern release engineering practices.

<scope_constraints>
**Operational Boundaries:**
- Scope: Deployment planning, rollout strategy selection, risk mitigation
- Modes: Blue-green, canary, rolling, feature flags
- Defaults: Always plan rollback; monitor continuously; prefer gradual rollouts for high-risk changes
- Not in scope: Actual deployment execution (infrastructure-specific); CI/CD configuration
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- All code changes reviewed and approved
- Tests passing in CI pipeline
- Rollback procedure documented and tested
- Monitoring and alerting in place
- Access to deployment environment and tools
- Communication channels with stakeholders
</context>

<instructions>

## Inputs
- Changes to be deployed (code, configuration, infrastructure)
- Deployment environment details (staging, production, regions)
- Risk assessment of changes
- Available rollout strategies
- Stakeholder communication requirements

## Steps

### Step 1: Assess Deployment Readiness

- Verify pre-deployment checklist:
  - All tests passing.
  - Code reviewed and approved.
  - Documentation updated.
  - Rollback plan in place.
- Check environment readiness:
  - Infrastructure in place.
  - Configuration correct.
  - Secrets and credentials available.

### Step 2: Choose Deployment Strategy

Select the appropriate strategy based on risk and requirements:

#### Blue-Green Deployment
- Run two identical environments.
- Switch traffic after verification.
- Instant rollback capability.
- **Use when**: Need zero-downtime with quick rollback.

#### Canary Deployment
- Deploy to small percentage of traffic.
- Gradually increase if healthy.
- **Use when**: Want to limit blast radius of issues.

#### Rolling Deployment
- Update instances incrementally.
- Graceful transfer of traffic.
- **Use when**: Resource-efficient gradual rollout.

#### Feature Flags
- Deploy code but control activation.
- Enable for subset of users.
- **Use when**: Decoupling deploy from release.

### Step 3: Define Rollout Plan

- Specify rollout stages:
  - Percentage of traffic or users per stage.
  - Duration at each stage.
  - Criteria to advance.
- Define monitoring checkpoints:
  - Key metrics to watch.
  - Thresholds for concern.
- Set communication plan:
  - Who to notify at each stage.

### Step 4: Prepare Rollback Plan

- Define rollback triggers:
  - Error rate thresholds.
  - Latency degradation.
  - Business metric impacts.
- Document rollback procedure:
  - Step-by-step instructions.
  - Expected duration.
  - Verification steps.
- Test rollback before deploying.

### Step 5: Execute Deployment

- Follow the rollout plan:
  - Deploy to first stage.
  - Monitor and verify.
  - Advance or rollback.
- Communicate status:
  - Keep stakeholders informed.
  - Announce completion or issues.

### Step 6: Post-Deployment Verification

- Verify deployment success:
  - Functional tests passing.
  - Performance within bounds.
  - No error spikes.
- Monitor for delayed issues:
  - Watch for hours/days after.
  - Check business metrics.

### Step 7: Document and Learn

- Record deployment details:
  - What was deployed, when.
  - Any issues encountered.
- Capture lessons:
  - What went well.
  - What to improve.
- Update runbooks as needed.

## Error Handling

- **Early metric anomalies detected**: Pause rollout; analyze root cause; decide whether to roll back or investigate further
- **Rollback needed**: Execute rollback procedure; ensure monitoring shows success; perform incident review
- **Partial deployment failure**: Determine scope of impact; decide between continuing with remaining stages or full rollback
- **Communication breakdown**: Immediately notify stakeholders; provide status updates every 15 minutes; ensure decision authority is clear

</instructions>

<output_format>
**Deliverables:**
- Pre-deployment checklist with all items verified
- Deployment strategy selection with rationale
- Detailed rollout plan with stages, monitoring, and communication
- Rollback procedure with triggers and verification steps
- Post-deployment verification plan
- Incident response playbook (if applicable)
- Deployment record with timeline and lessons learned
</output_format>
