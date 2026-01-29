---
name: deploy
description: Deployment strategy, rollout planning, canary, and blue-green patterns
command: /deploy
aliases:
- /release
- /rollout
activation-mode: auto
user-invocable: true
disable-model-invocation: true
allowed-tools:
- '*'
---

# Deploy Workflow

This workflow instructs Cascade to plan and guide safe, reliable deployments using modern release engineering practices.

## 1. Assess Deployment Readiness

- Verify pre-deployment checklist:
  - All tests passing.
  - Code reviewed and approved.
  - Documentation updated.
  - Rollback plan in place.
- Check environment readiness:
  - Infrastructure in place.
  - Configuration correct.
  - Secrets and credentials available.

## 2. Choose Deployment Strategy

Select the appropriate strategy based on risk and requirements:

### Blue-Green Deployment
- Run two identical environments.
- Switch traffic after verification.
- Instant rollback capability.
- **Use when**: Need zero-downtime with quick rollback.

### Canary Deployment
- Deploy to small percentage of traffic.
- Gradually increase if healthy.
- **Use when**: Want to limit blast radius of issues.

### Rolling Deployment
- Update instances incrementally.
- Graceful transfer of traffic.
- **Use when**: Resource-efficient gradual rollout.

### Feature Flags
- Deploy code but control activation.
- Enable for subset of users.
- **Use when**: Decoupling deploy from release.

## 3. Define Rollout Plan

- Specify rollout stages:
  - Percentage of traffic or users per stage.
  - Duration at each stage.
  - Criteria to advance.
- Define monitoring checkpoints:
  - Key metrics to watch.
  - Thresholds for concern.
- Set communication plan:
  - Who to notify at each stage.

## 4. Prepare Rollback Plan

- Define rollback triggers:
  - Error rate thresholds.
  - Latency degradation.
  - Business metric impacts.
- Document rollback procedure:
  - Step-by-step instructions.
  - Expected duration.
  - Verification steps.
- Test rollback before deploying.

## 5. Execute Deployment

- Follow the rollout plan:
  - Deploy to first stage.
  - Monitor and verify.
  - Advance or rollback.
- Communicate status:
  - Keep stakeholders informed.
  - Announce completion or issues.

## 6. Post-Deployment Verification

- Verify deployment success:
  - Functional tests passing.
  - Performance within bounds.
  - No error spikes.
- Monitor for delayed issues:
  - Watch for hours/days after.
  - Check business metrics.

## 7. Document and Learn

- Record deployment details:
  - What was deployed, when.
  - Any issues encountered.
- Capture lessons:
  - What went well.
  - What to improve.
- Update runbooks as needed.