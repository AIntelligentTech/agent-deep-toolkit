---
name: relentless
description: Multiply effort and depth; iterate until the goal is truly done
command: /relentless
aliases: ["/try-hard", "/dont-stop", "/ultrathink"]
synonyms: ["/relentlessly", "/trying-hard", "/ultrathinking", "/deep-effort"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Relentless Mode - Effort and Depth Multiplier

Apply maximum effort and depth to any task. Use when thoroughness, correctness, and completeness matter more than speed.

## What Relentless Mode Does

**Effort multiplier:** Increases time investment 2-3x per phase

**Depth multiplier:** Goes deeper at every step with specific amplification patterns

**Works with any skill:** Prefix any skill with `/relentless` to amplify it

## Core Amplification Patterns

### 1. Search Depth (3-5x more sources)

**Standard approach:**
- Check 1-2 obvious sources
- Stop when you find something that works

**Relentless approach:**
- Check 3-5 sources minimum
- Try alternative keywords and phrasings
- Search official docs, GitHub issues, Stack Overflow, blog posts
- Compare multiple explanations before accepting
- Verify information is current (not outdated)

**Example:**
```
Task: Find out how to configure X

Standard: Google "configure X" → read first result
Relentless:
- Search official docs for "X configuration"
- Search GitHub issues for "X config"
- Search Stack Overflow with 3 keyword variations
- Check changelog for recent changes
- Compare 5 different approaches before selecting
```

### 2. Approaches (Evaluate 3+ alternatives)

**Standard approach:**
- Think of one obvious solution
- Implement it

**Relentless approach:**
- Generate 3+ alternative approaches
- Evaluate pros/cons of each
- Consider edge cases for each approach
- Prototype most promising 2 approaches
- Select based on evidence, not intuition

**Example:**
```
Task: Add caching to API

Standard: Add Redis cache

Relentless:
- Approach 1: Redis (persistent, external)
  - Pros: Scalable, shared across instances
  - Cons: Extra dependency, network latency

- Approach 2: In-memory LRU cache (fast, simple)
  - Pros: No network overhead, simple
  - Cons: Not shared, lost on restart

- Approach 3: File-based cache (persistent, no deps)
  - Pros: No external service needed
  - Cons: Slower, harder to invalidate

→ Evaluate: For single-instance API with <1000 requests/min,
  Approach 2 is simplest. Prototype and verify before committing.
```

### 3. Edge Cases (Test 10+ corner cases)

**Standard approach:**
- Test happy path
- Test 1-2 obvious edge cases

**Relentless approach:**
- Test 10+ edge cases minimum
- Boundary conditions (0, 1, max, max+1, negative)
- Error conditions (null, undefined, empty, malformed)
- Concurrent access scenarios
- Resource exhaustion scenarios
- Compatibility scenarios (old browsers, different OSes)

**Example:**
```
Task: Add input validation

Standard: Test empty string, valid string

Relentless:
1. Empty string
2. Whitespace only
3. Maximum length
4. Maximum length + 1
5. Special characters (<, >, &, ', ")
6. Unicode characters (emoji, RTL, CJK)
7. SQL injection patterns
8. XSS injection patterns
9. Null/undefined
10. Very long string (10MB)
11. Concurrent validation calls
12. Validation during network outage
```

### 4. Verification (Multiple validation methods)

**Standard approach:**
- Run tests OR manual check
- Single verification method

**Relentless approach:**
- Programmatic verification (automated tests)
- Visual verification (screenshots, visual diff)
- Manual verification (human testing)
- Integration verification (works with other systems)
- Performance verification (benchmarks, profiling)
- Security verification (static analysis, pen testing)

**Example:**
```
Task: Verify authentication works

Standard: Login with test account → see dashboard

Relentless:
- Programmatic: 15 unit tests (valid token, expired, invalid, etc.)
- Visual: Screenshot comparison (login form, dashboard)
- Manual: Test with real browser on 3 different devices
- Integration: Verify auth works with API, database, cache
- Performance: Benchmark login time (< 500ms)
- Security: Run OWASP ZAP scan for vulnerabilities
```

### 5. Time Investment (2-3x longer per phase)

**Standard approach:**
- Spend 5 minutes researching
- Spend 15 minutes implementing
- Spend 5 minutes testing

**Relentless approach:**
- Spend 15 minutes researching (3x)
- Spend 30-45 minutes implementing (2-3x)
- Spend 15 minutes testing (3x)

**Why longer:**
- More sources consulted
- More approaches evaluated
- More edge cases tested
- More verification methods applied
- More documentation written

### 6. Thinking Depth (Apply `/think` frameworks)

**Standard approach:**
- Intuitive decision making
- Quick reasoning

**Relentless approach:**
- Apply explicit thinking frameworks from `/think`
- First principles reasoning
- Pros/cons analysis
- Pre-mortem (assume failure, work backwards)
- Second-order thinking (what happens after the obvious effect?)
- Devil's advocate (challenge assumptions)

**Example:**
```
Task: Decide on database for new service

Standard: Use PostgreSQL (we use it elsewhere)

Relentless:
- First principles: What are actual requirements?
  - Need: ACID, relations, full-text search
  - Don't need: Multi-model, distributed, high write throughput

- Pros/cons of 3 options: Postgres, MySQL, SQLite

- Pre-mortem: Assume project fails in 6 months. Why?
  - Database too slow → Benchmark before deciding
  - Schema migrations painful → Check migration tooling
  - Hard to scale → Validate scaling approach

- Second-order: If we choose Postgres, what comes next?
  - Need connection pooling
  - Need backup strategy
  - Need monitoring setup

→ Decision: Postgres, but with upfront investment in
  benchmarking, migration tooling, and monitoring
```

## Operating Principles

**Keep going** until the user's request is fully satisfied and verified.

**Explore more options** before committing to an approach.
- Generate 3+ alternatives
- Evaluate pros/cons
- Prototype when uncertain

**Go deeper on edge cases** (failure modes, weird inputs, compatibility).
- Test 10+ corner cases
- Boundary conditions
- Error conditions
- Concurrent access
- Resource exhaustion

**Try multiple approaches before selecting** (when there are plausible alternatives).
- Implement 2 approaches if uncertain which is better
- Measure and compare
- Select based on evidence

**Increase validation rigor** (more checks/tests, tighter sanity checks).
- Multiple verification methods (programmatic + visual + manual)
- Test on multiple environments
- Verify backwards compatibility

**Document more thoroughly** (what changed, why, how it was verified).
- Explain reasoning for approach chosen
- Document alternatives considered
- Record verification results
- Capture learnings for future

**Avoid premature stopping**: don't end while uncertainty remains.
- If unsure → investigate further
- If verification incomplete → complete it
- If edge cases untested → test them

## How to Apply Relentless Mode

**Prefix any skill with `/relentless`:**

```
/relentless /code [implementation task]
/relentless /debug [complex bug]
/relentless /review [critical PR]
/relentless /research [important decision]
/relentless /integrate [high-risk integration]
/relentless /iterate [complex multi-step task]
```

**Follow the base skill workflow, but with amplification:**

1. **Clarify** the end goal and acceptance criteria (spend 2-3x longer)
2. **Plan** the approach (evaluate 3+ alternatives)
3. **Execute** with high-quality discipline (test 10+ edge cases)
4. **Validate** with multiple verification methods (programmatic + visual + manual)
5. **Document** thoroughly (reasoning, alternatives, verification)
6. **Repeat** until truly complete (no uncertainty remains)

## When to Use

**High-stakes work:**
- Production-critical systems
- Security-sensitive features
- Data integrity operations
- Financial transactions
- Legal/compliance code

**High-risk integrations:**
- Breaking API changes
- Database migrations
- Third-party integrations
- Version upgrades with breaking changes

**Complex debugging:**
- Intermittent bugs
- Race conditions
- Memory leaks
- Performance degradation

**Important decisions:**
- Architecture choices
- Technology selection
- API design
- Data model design

**Learning new domains:**
- Unfamiliar technology
- New framework
- Different paradigm
- Unfamiliar codebase

## When NOT to Use

**Exploratory work:**
- Open-ended research
- Brainstorming
- Proof-of-concept
- Rapid prototyping

**Time-sensitive tasks:**
- Hotfixes needed NOW
- Deadline in < 1 hour
- Emergency production issues (fix first, relentless later)

**Trivial changes:**
- One-line fixes
- Typo corrections
- Comment updates
- Simple refactoring

**Low-stakes work:**
- Internal tooling for personal use
- Temporary debugging scripts
- Experimental features
- Non-production code

**Already thorough:**
- Code that already has comprehensive tests
- Well-documented decisions
- Proven approaches
- Battle-tested patterns

## Examples

### Example 1: Relentless Code Review

**Standard review:**
- Read diff
- Check for obvious bugs
- Comment on style issues

**Relentless review:**
- Read diff + related code context
- Check for 10+ edge cases
- Verify tests cover edge cases
- Check for security vulnerabilities (SQL injection, XSS, etc.)
- Verify backwards compatibility
- Check performance implications
- Suggest 3 alternative approaches for complex logic
- Verify documentation is accurate
- Check for potential race conditions

**Time:** Standard 10 min → Relentless 30 min

### Example 2: Relentless Debugging

**Standard debugging:**
- Reproduce bug
- Add console.log
- Find issue
- Fix

**Relentless debugging:**
- Reproduce bug with minimal test case
- Reproduce on 3 different environments
- Add comprehensive logging (not just console.log)
- Investigate 3+ potential root causes
- Trace execution flow through debugger
- Check for similar bugs in related code
- Write failing test before fixing
- Verify fix doesn't break other cases
- Add regression tests for this bug
- Document root cause and fix

**Time:** Standard 20 min → Relentless 60 min

### Example 3: Relentless Integration

**Standard integration:**
- Add new API endpoint
- Test happy path
- Deploy

**Relentless integration:**
- Add new API endpoint
- Test 15 edge cases (invalid input, auth failures, network errors, etc.)
- Test backwards compatibility with old clients
- Test concurrent requests
- Benchmark performance (p50, p95, p99)
- Add monitoring and alerts
- Test rollback procedure
- Document API contract
- Create migration guide for consumers
- Gradual rollout (10% → 50% → 100%)

**Time:** Standard 1 hour → Relentless 3 hours

## Integration with Other Skills

**Amplifies any skill:**

| Base Skill | Relentless Version |
|------------|-------------------|
| `/code` | 3+ approaches, 10+ edge cases, multiple verifications |
| `/debug` | Deep root cause analysis, test all hypotheses, comprehensive fix |
| `/review` | Security audit, performance check, backwards compat |
| `/research` | 5+ sources, compare alternatives, verify currency |
| `/integrate` | Multiple rollout strategies, 10+ failure scenarios |
| `/iterate` | Deeper verification per iteration, more thorough docs |
| `/test` | 10+ edge cases, visual + manual + programmatic |

**Works with `/loop` for autonomous + thorough:**
```
/relentless /loop [complex autonomous task]
```
- Loop continues until done + thoroughly verified
- Each iteration applies relentless patterns

## Anti-Patterns

❌ **Relentless on trivial tasks**
- Overkill for typo fixes
- Wastes time on low-stakes work

✅ **Reserve for high-stakes**
- Production-critical
- Security-sensitive
- High-risk integrations

❌ **Relentless when time-constrained**
- Hotfix needed in 10 minutes
- Relentless will take 2-3x longer

✅ **Use standard mode for urgency**
- Fix fast, relentless later (technical debt)

❌ **Relentless without focus**
- Spending effort on irrelevant edge cases
- Over-engineering solutions

✅ **Relentless with discipline**
- Focus on relevant edge cases
- Choose appropriate depth per task

## Quantified Multipliers Summary

| Dimension | Standard | Relentless | Multiplier |
|-----------|----------|------------|-----------|
| **Sources searched** | 1-2 | 3-5 | 3-5x |
| **Approaches evaluated** | 1 | 3+ | 3x |
| **Edge cases tested** | 2-3 | 10+ | 3-5x |
| **Verification methods** | 1 | 3+ (programmatic + visual + manual) | 3x |
| **Time per phase** | Baseline | 2-3x baseline | 2-3x |
| **Thinking frameworks** | Intuitive | Explicit (first principles, pre-mortem, etc.) | Deep |

## Tips

✅ **Use for high-stakes work** (production-critical, security-sensitive)
✅ **Evaluate 3+ approaches** before selecting
✅ **Test 10+ edge cases** (boundaries, errors, concurrency)
✅ **Apply multiple verification methods** (programmatic + visual + manual)
✅ **Invest 2-3x time per phase** (research, implement, test)
✅ **Apply explicit thinking frameworks** from `/think`
✅ **Document thoroughly** (reasoning, alternatives, verification)
✅ **Don't use for trivial tasks** (overkill on typo fixes)
✅ **Don't use when time-constrained** (hotfixes, urgent work)

---

**Remember**: Relentless mode is about multiplying effort and depth. It's not about working harder—it's about being more thorough, testing more cases, evaluating more options, and verifying more rigorously. Use it when correctness matters more than speed.
