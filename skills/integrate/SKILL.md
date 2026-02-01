---
name: integrate
description: Plan clean, holistic integration of changes with systematic analysis of impact surfaces, edge cases, and compatibility requirements
command: /integrate
aliases: ["/integration", "/integrate-plan", "/fit"]
synonyms: ["/integrating", "/integrated", "/integrates", "/seamless", "/harmonize", "/compatibility", "/fit-check", "/harmonise", "/harmonising", "/harmonised"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Integrate - Holistic Integration Planning

Plan how new changes fit cleanly into existing systems with systematic analysis of impact surfaces, compatibility requirements, edge cases, and rollout sequencing.

## When to Use

- **Fitting changes into existing systems**: New feature needs to work with current architecture
- **Multi-component updates**: Changes touch multiple services or layers
- **Version compatibility concerns**: Need to maintain backward compatibility
- **Data migration required**: Schema or API changes affect existing data
- **Cross-team coordination**: Integration spans multiple ownership boundaries
- **High-risk integrations**: Breaking changes or critical path modifications

## When NOT to Use

- **Greenfield development**: Building from scratch with no existing system
- **Trivial additions**: Single-file change with no dependencies
- **Isolated experiments**: Proof-of-concept that won't integrate yet
- **Pure refactoring**: Internal changes with identical external behavior
- **Already in `/propagate`**: Use `/integrate` BEFORE `/propagate`, not during

## Position in Workflow Chain

```
/architect (system design)
    ↓
/decide (choice + rationale)
    ↓
/integrate (NEW - integration planning) ← YOU ARE HERE
    ↓
/impact (downstream assessment)
    ↓
/propagate (execution + rollout)
```

**Key distinctions:**

| Skill | Focus | Output |
|-------|-------|--------|
| `/architect` | System design from requirements | Architecture diagrams, component specs |
| `/decide` | Choose between alternatives | Decision + rationale |
| **`/integrate`** | **How changes fit into existing system** | **Integration plan + sequencing** |
| `/impact` | What breaks downstream | Impact report + mitigation |
| `/propagate` | Safe rollout execution | Deployment steps + verification |

## Core Integration Workflow

### 1. Clarify Integration Scope

**Define exactly what's being integrated and what success looks like:**

```
📦 Integration Scope
─────────────────────────────────────────────
**What's being integrated:**
- Component: [name]
- Version: [version]
- Changes: [summary]

**Integration targets:**
- System A: [how it connects]
- System B: [how it connects]
- System C: [how it connects]

**Success criteria:**
- [ ] Criterion 1: [measurable]
- [ ] Criterion 2: [measurable]
- [ ] Criterion 3: [measurable]

**Constraints:**
- Backward compatibility: [requirements]
- Performance impact: [limits]
- Deployment window: [timing]
─────────────────────────────────────────────
```

**Key questions:**
- What are we integrating? (Component, feature, API, data model)
- Where is it going? (Which systems, services, layers)
- What can't break? (Critical dependencies, user-facing features)
- When does it need to work? (Deadline, rollout timing)

### 2. Map Integration Surface

**Identify all systems and touchpoints affected by the integration:**

**Integration surface analysis:**

```
🗺️ Integration Surface Map
─────────────────────────────────────────────
**Direct integrations** (systems that directly use the change):
- System: [name]
  - Integration type: [API | Data | Event | Library]
  - Current version: [version]
  - Coupling level: [Tight | Moderate | Loose]

**Indirect integrations** (systems affected transitively):
- System: [name]
  - Dependency path: [how connected]
  - Risk level: [High | Medium | Low]

**External integrations** (third-party or external dependencies):
- Service: [name]
  - Integration point: [API endpoint, webhook, etc]
  - SLA requirements: [uptime, latency]

**Data integrations** (shared databases, caches, files):
- Data store: [name]
  - Schema changes: [yes/no]
  - Migration required: [yes/no]
─────────────────────────────────────────────
```

**Discovery techniques:**
- Grep for imports/requires of changed modules
- Check API endpoint usage in logs
- Review database foreign keys and indexes
- Analyze event subscribers/publishers
- Search for environment variable references

### 3. Identify Compatibility Requirements

**Analyze version compatibility, breaking changes, and migration needs:**

**Compatibility matrix:**

| Requirement | Current | Target | Breaking? | Mitigation |
|-------------|---------|--------|-----------|------------|
| API version | v1.2 | v2.0 | YES | Dual-version support during transition |
| Schema | v3 | v4 | YES | Database migration with rollback plan |
| Node version | 16.x | 18.x | NO | Update engines field in package.json |
| Library X | 2.1 | 3.0 | YES | Adapter layer for old consumers |

**Backward compatibility strategies:**

| Pattern | When to Use | Implementation |
|---------|-------------|----------------|
| **Dual versioning** | API changes | Support both v1 and v2 endpoints during transition |
| **Feature flags** | Gradual rollout | Toggle new behavior on/off per user/environment |
| **Adapter pattern** | Library upgrades | Wrapper that translates old interface to new |
| **Database migration** | Schema changes | Versioned migrations with up/down scripts |
| **Deprecation period** | Removing features | Mark deprecated, warn users, remove after N months |

**Version constraint analysis:**
```bash
# Check current version constraints
grep "packageName" package.json
grep "packageName" */package.json

# Check for breaking changes in upgrade
npm info packageName@newVersion --json | jq '.version, .deprecated'
```

### 4. Analyze Integration Points

**Map dependencies, data flow, and timing requirements:**

**Integration point analysis:**

```
🔗 Integration Points
─────────────────────────────────────────────
**Point 1: [Name]**
- Type: [API | Event | Data | Import]
- Direction: [Inbound | Outbound | Bidirectional]
- Protocol: [REST | GraphQL | Message Queue | Direct]
- Data format: [JSON | Protobuf | XML]
- Auth: [API key | OAuth | mTLS]
- Dependencies: [what must happen first]
- Error handling: [retry | fallback | fail fast]

**Point 2: [Name]**
- [... same structure]
─────────────────────────────────────────────
```

**Data flow diagram:**
```
[External API] → [API Gateway] → [Service A] → [Database]
                                      ↓
                                 [Event Bus]
                                      ↓
                                 [Service B] → [Cache]
```

**Timing and sequencing:**
- What must happen before X can start?
- What can run in parallel?
- What requires synchronous response?
- What can be async/eventual consistency?

### 5. Design Integration Sequencing

**Determine order of updates, parallelization, and rollback strategy:**

**Sequencing plan:**

```
🚦 Integration Sequence
─────────────────────────────────────────────
**Phase 1: Preparation** (Day 1)
- [ ] Deploy backward-compatible schema changes
- [ ] Enable feature flags (default: off)
- [ ] Deploy adapter layers

**Phase 2: Core Integration** (Day 2)
- [ ] Update Service A (new version with dual support)
- [ ] Update Service B (consumer of A)
- [ ] Verify integration tests pass

**Phase 3: Data Migration** (Day 3)
- [ ] Run migration script (with progress monitoring)
- [ ] Validate migrated data
- [ ] Create rollback snapshot

**Phase 4: Gradual Rollout** (Day 4-7)
- [ ] Enable feature flag for 10% of users
- [ ] Monitor metrics (error rate, latency)
- [ ] Increase to 50% if metrics green
- [ ] Full rollout if 50% stable for 24h

**Phase 5: Cleanup** (Day 8+)
- [ ] Remove old endpoints/code (after 30 days)
- [ ] Update documentation
- [ ] Archive rollback artifacts
─────────────────────────────────────────────
```

**Parallelization opportunities:**
- Services with no dependencies can update simultaneously
- Database migrations can run in separate windows
- Documentation and code changes can happen in parallel

**Rollback plan:**
- At what point is rollback still possible?
- What's the rollback procedure for each phase?
- What data needs to be preserved for rollback?

### 6. Evaluate Edge Cases

**Identify failure scenarios, partial states, and recovery paths:**

**Edge case analysis:**

```
⚠️ Edge Cases & Failure Scenarios
─────────────────────────────────────────────
**Edge Case 1: Partial migration failure**
- Scenario: Database migration completes 70% then crashes
- Impact: Data inconsistency between old and new schema
- Detection: Migration progress log shows incomplete
- Recovery: Rollback migration, fix issue, restart

**Edge Case 2: Dual-version API race condition**
- Scenario: Same user hits v1 and v2 endpoints simultaneously
- Impact: Conflicting writes to shared resource
- Detection: Conflict errors in logs
- Recovery: Last-write-wins with conflict resolution UI

**Edge Case 3: Feature flag state inconsistency**
- Scenario: Feature flag service unavailable
- Impact: Undefined behavior (new or old code path?)
- Detection: Feature flag client timeout
- Recovery: Default to safe state (old behavior)

**Edge Case 4: Dependency version mismatch**
- Scenario: Service A updated but Service B not yet
- Impact: Incompatible API calls
- Detection: HTTP 400/500 errors
- Recovery: Adapter layer handles version negotiation
─────────────────────────────────────────────
```

**Failure mode analysis:**

| Component | Failure Mode | Detection | Mitigation |
|-----------|--------------|-----------|------------|
| Database migration | Timeout | Progress log stalls | Batch into smaller chunks |
| API Gateway | 503 errors | Health check fails | Blue-green deployment |
| Event bus | Message loss | Consumer lag metric | Dead letter queue + replay |
| Cache invalidation | Stale data | Cache hit rate drop | TTL + manual invalidation |

### 7. Plan Validation Strategy

**Define testing approach, monitoring, and success metrics:**

**Validation plan:**

```
✅ Validation Strategy
─────────────────────────────────────────────
**Pre-integration testing:**
- [ ] Unit tests pass (new + existing)
- [ ] Integration tests cover new paths
- [ ] Contract tests verify API compatibility
- [ ] Load tests confirm performance impact < 10%

**During integration:**
- [ ] Smoke tests after each deployment
- [ ] Canary metrics green for 1 hour before proceeding
- [ ] Manual verification of critical paths
- [ ] Rollback drill (practice rollback procedure)

**Post-integration monitoring:**
- Error rate: < 0.1% increase
- Latency p99: < 20% increase
- Throughput: No degradation
- User complaints: Monitor for 48h

**Success criteria:**
- All tests pass
- Metrics within bounds for 7 days
- Zero critical incidents
- Zero rollbacks required
─────────────────────────────────────────────
```

**Testing levels:**

| Level | What | When | Tools |
|-------|------|------|-------|
| Unit | Individual components | Before commit | Jest, pytest |
| Integration | Component interactions | Pre-deployment | Supertest, Postman |
| Contract | API compatibility | Pre-deployment | Pact, OpenAPI validator |
| E2E | User workflows | Staging environment | Playwright, Cypress |
| Load | Performance under load | Pre-production | k6, Artillery |
| Chaos | Resilience to failures | Production (controlled) | Chaos Monkey |

### 8. Document Integration Patterns

**Capture reusable patterns and anti-patterns discovered:**

**Integration patterns library:**

```
📚 Integration Patterns
─────────────────────────────────────────────
**Pattern: Blue-Green Deployment**
- Use when: Zero-downtime required
- Implementation: Two environments, switch traffic atomically
- Rollback: Switch traffic back to old environment

**Pattern: Strangler Fig**
- Use when: Replacing legacy system incrementally
- Implementation: Route traffic to new system for specific paths
- Rollback: Route all traffic back to legacy

**Pattern: Database Expand-Contract**
- Use when: Schema changes with no downtime
- Implementation: Expand (add new columns), migrate data, contract (remove old)
- Rollback: Keep old columns during migration period

**Anti-pattern: Big Bang Integration**
- Problem: Update everything at once
- Consequence: High risk, hard to debug, no rollback
- Alternative: Phased rollout with feature flags
─────────────────────────────────────────────
```

**Lessons learned:**
- What worked well?
- What would you do differently?
- What surprised you?
- What should be automated next time?

## Examples

### Example 1: Upgrading Node.js Dependency

**Integration scope:** Upgrade `express` from v4 to v5

**Integration surface:**
- 12 routes use deprecated middleware
- 3 error handlers rely on old signatures
- 2 test files use outdated mocking

**Compatibility:**
- Breaking changes: Middleware signature, error handling
- Mitigation: Create adapter for old middleware pattern

**Sequencing:**
1. Add express v5 alongside v4 (both installed)
2. Migrate routes one at a time
3. Run tests after each route migration
4. Remove v4 after all routes migrated

**Edge cases:**
- Middleware called in wrong order → Add type checking
- Error handler doesn't catch async errors → Add async wrapper

### Example 2: Adding Authentication to API

**Integration scope:** Add JWT auth to existing REST API

**Integration surface:**
- 25 existing endpoints need auth
- 3 public endpoints stay open
- Mobile app and web app are consumers

**Compatibility:**
- Breaking change: All endpoints now require `Authorization` header
- Mitigation: 30-day dual-mode (allow both authed and unauthed)

**Sequencing:**
1. Deploy auth middleware (optional mode)
2. Update mobile app to send tokens
3. Update web app to send tokens
4. Switch auth middleware to required mode
5. Remove dual-mode code

**Edge cases:**
- Token refresh during long-running request → Add refresh endpoint
- Clock skew causes token validation errors → Allow 5-minute window
- User logs out on one device → Implement token revocation

### Example 3: Database Schema Migration

**Integration scope:** Add `user_preferences` table with foreign keys

**Integration surface:**
- Users table (foreign key source)
- 5 services read user data
- 2 services write user data

**Compatibility:**
- Schema change: Non-breaking (new table, no existing columns changed)
- Data migration: Populate from legacy `user_settings` JSON column

**Sequencing:**
1. Create `user_preferences` table (no data yet)
2. Deploy dual-write code (write to both JSON and table)
3. Run backfill migration (copy JSON → table)
4. Validate migration (compare JSON vs table for sample)
5. Deploy dual-read code (prefer table, fallback to JSON)
6. Monitor for 7 days
7. Remove JSON column (after 30 days)

**Edge cases:**
- Migration fails halfway → Resumable migration with progress tracking
- New preferences added during migration → Dual-write ensures consistency
- Read query hits unmigrated user → Fallback to JSON

## Integration with Other Skills

**Before `/integrate`:**
```
/architect → Design the system
/decide → Choose the approach
```

**After `/integrate`:**
```
/impact → Assess downstream effects
/propagate → Execute the rollout
```

**Combine with `/relentless` for critical integrations:**
```
/relentless /integrate [critical integration]
```
- Evaluate 3+ rollout strategies
- Test 10+ edge cases
- Verify with multiple validation methods

## Anti-Patterns

❌ **Big Bang integration** - Update everything at once
✅ **Phased rollout** - Incremental with rollback points

❌ **No rollback plan** - Hope it works
✅ **Tested rollback** - Practice rollback before deployment

❌ **Ignoring edge cases** - Focus only on happy path
✅ **Edge-case-first** - Design for failures

❌ **No monitoring** - Deploy and hope
✅ **Metrics-driven** - Monitor metrics, rollback if red

❌ **Breaking backward compat** - Old clients break immediately
✅ **Graceful deprecation** - Dual-version support during transition

## Tips

✅ **Map the integration surface before coding**
✅ **Design rollback strategy before deploying**
✅ **Test edge cases in staging first**
✅ **Use feature flags for gradual rollout**
✅ **Monitor metrics continuously during integration**
✅ **Document patterns for future integrations**
✅ **Prefer small, reversible changes over large irreversible ones**
✅ **Validate backward compatibility with contract tests**

---

**Remember**: Integration is about making changes fit cleanly into existing systems. Plan how to bridge the gap between current state and desired state without breaking what already works.
