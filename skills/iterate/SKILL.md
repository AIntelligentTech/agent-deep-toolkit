---
name: iterate
description: Break complex tasks into independently verifiable, committable iterations that build progressively toward goals
command: /iterate
aliases: ["/cycle", "/increment", "/chunk", "/breakdown"]
synonyms: ["/iterating", "/iterated", "/iterations", "/incrementing", "/incremented", "/chunking", "/chunked"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: execution
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill focuses on breaking complex work into independently verifiable iterations with clear verification at each step. It guides implementation and testing but requires user confirmation between iterations for progression decisions.
</scope_constraints>

<context>
This workflow breaks complex tasks into independently verifiable, committable iterations that build progressively toward clearly-defined goals. Each iteration is a complete, testable unit of progress with its own verification strategy.
</context>

<instructions>

## Inputs

- Complex task or goal to be decomposed
- Success criteria for the overall goal
- Verification preferences (programmatic, visual, manual)
- Constraints (time, dependencies, resource limits)

## Scope

- **Complex multi-step tasks**: Can be broken into smaller pieces
- **Uncertain path**: Don't know exact approach upfront
- **Need verification at each step**: Want to confirm correctness before proceeding
- **Git-friendly workflow**: Want atomic, reviewable commits
- **Learning as you go**: Each iteration informs the next
- **Risk management**: Want to catch issues early

# Iterate - Verified Incremental Development

Break complex tasks into independently verifiable, committable iterations that build progressively toward clearly-defined goals. Each iteration is a complete, testable unit of progress.

## When to Use

- **Complex multi-step tasks**: Can be broken into smaller pieces
- **Uncertain path**: Don't know exact approach upfront
- **Need verification at each step**: Want to confirm correctness before proceeding
- **Git-friendly workflow**: Want atomic, reviewable commits
- **Learning as you go**: Each iteration informs the next
- **Risk management**: Want to catch issues early

## When NOT to Use

- **Simple one-shot tasks**: Single file change with clear approach
- **Fully autonomous work**: Use `/loop` for self-directed execution until done
- **Already clear sequence**: Use `/plan` for predetermined steps
- **Exploration**: Use `/explore` for open-ended investigation
- **High effort needed**: Prefix with `/relentless` for deeper work

## Error Handling

- **Iteration too large**: Split into smaller chunks with intermediate verification points
- **Verification failure**: Fix issues in current iteration before proceeding
- **Dependency discovered**: Reorder iterations to handle prerequisites first
- **Scope creep**: Defer non-essential changes to later iterations
- **Approach not working**: Pivot strategy and adjust remaining iterations

</instructions>

<output_format>
- **Iteration decomposition**: Numbered list of independent chunks with success criteria
- **Verification strategy**: For each iteration, how it will be verified
- **Iteration sequence**: Ordered by dependencies and risk
- **Execution checklist**: Per-iteration implementation guidelines
- **Verification results**: Pass/fail status for each iteration
- **Commits**: One per iteration with clear commit messages
- **Learnings**: Patterns, anti-patterns, impediments discovered
- **Completion summary**: All iterations done with verification evidence
</output_format>

## Core Iteration Workflow

### 1. Decompose the Goal

**Break the complex task into independently valuable, testable chunks:**

```
🎯 Goal Decomposition
─────────────────────────────────────────────
**Overall Goal:** [High-level objective]

**Iterations (chunked):**
1. [Iteration 1] - Independently valuable/testable
   - Success criteria: [How to verify]
   - Dependencies: [None or specific iterations]

2. [Iteration 2] - Builds on previous
   - Success criteria: [How to verify]
   - Dependencies: [Iteration 1]

3. [Iteration 3] - Next increment
   - Success criteria: [How to verify]
   - Dependencies: [Iteration 2]

**Completion criteria:**
- All iterations done + verified
- [Additional success metrics]
─────────────────────────────────────────────
```

**Good iteration boundaries:**
- ✅ Independently testable (can verify in isolation)
- ✅ Committable (makes sense as single commit)
- ✅ Valuable (provides some benefit even if later iterations don't happen)
- ✅ Reversible (can be backed out if needed)
- ✅ Small (completable in reasonable time)

**Bad iteration boundaries:**
- ❌ Half a feature (not testable alone)
- ❌ Multiple unrelated changes (should be separate)
- ❌ Too large (takes hours, hard to verify)
- ❌ Tightly coupled (can't test without other parts)

### 2. Classify Verification Strategies

**For each iteration, determine how to verify correctness:**

**Verification strategy matrix:**

| Strategy | When to Use | Tools/Approach | Cost |
|----------|-------------|----------------|------|
| **Programmatic** | Logic, APIs, data processing | Unit tests, integration tests | Low (automated) |
| **Visual** | UI, layouts, rendering | Screenshots, browser tools, visual regression | Medium (semi-automated) |
| **Manual** | UX flows, edge cases, feel | Human testing, exploratory | High (human time) |
| **Contract** | API compatibility | OpenAPI validation, Pact | Low (automated) |
| **Performance** | Speed, efficiency | Benchmarks, profiling | Medium (automated but slow) |
| **Security** | Auth, injection, XSS | Static analysis, pen testing | High (specialized tools) |

**Example verification plan:**

```
Iteration 1: Add user authentication API
→ Verification: Programmatic (unit tests for JWT validation)
→ Tools: Jest, Supertest
→ Time: 5 minutes

Iteration 2: Add login UI form
→ Verification: Visual (screenshot comparison) + Manual (test form submission)
→ Tools: Playwright visual comparison + browser
→ Time: 10 minutes

Iteration 3: Integrate auth with existing features
→ Verification: Programmatic (integration tests) + Manual (smoke test critical paths)
→ Tools: Jest integration suite + manual checklist
→ Time: 15 minutes
```

### 3. Plan Iteration Sequence

**Order iterations by dependencies and risk:**

**Sequencing considerations:**

| Factor | Strategy |
|--------|----------|
| **Dependencies** | Do prerequisite iterations first (can't test login UI without auth API) |
| **Risk** | Front-load high-risk iterations (validate assumptions early) |
| **Learning** | Start with uncertain parts (learn before committing to approach) |
| **Value** | Prioritize high-value iterations if time-constrained |
| **Testing** | Easier-to-test iterations first (build confidence) |

**Iteration sequence template:**

```
🚦 Iteration Sequence
─────────────────────────────────────────────
Phase 1: Foundation (Iterations 1-2)
- High-risk, foundational work
- Validates core assumptions
- Dependencies: None

Phase 2: Core Features (Iterations 3-5)
- Main functionality
- Dependencies: Phase 1 complete

Phase 3: Integration (Iterations 6-7)
- Connect pieces together
- Dependencies: Phase 2 complete

Phase 4: Polish (Iterations 8-9)
- Edge cases, error handling
- Dependencies: Phase 3 verified
─────────────────────────────────────────────
```

### 4. Execute Each Iteration

**Implement with quality discipline:**

**Execution checklist per iteration:**

```
✅ Implementation Checklist
─────────────────────────────────────────────
[ ] Read relevant code/docs before changing
[ ] Make minimal changes needed for this iteration
[ ] Follow existing code style and patterns
[ ] Add error handling for failure modes
[ ] Write clear variable/function names
[ ] Add comments only where logic is non-obvious
[ ] Avoid scope creep (resist "while I'm here..." changes)
[ ] Keep changes focused on iteration goal
─────────────────────────────────────────────
```

**Quality practices:**
- **Read first**: Understand existing code before modifying
- **Minimal changes**: Don't refactor unrelated code
- **Follow patterns**: Match existing style and architecture
- **Error handling**: Handle expected failures gracefully
- **Avoid scope creep**: Save "nice to have" for later iterations

### 5. Verify Immediately

**Apply the verification strategy for this iteration:**

**Programmatic verification:**

```bash
# Run tests for changed code
npm test -- path/to/changed-file.test.js

# Run integration tests
npm run test:integration

# Check types
npm run type-check

# Lint changes
npm run lint -- path/to/changed-file.js
```

**Visual verification:**

```bash
# Take screenshot before changes
playwright screenshot baseline.png

# Make changes...

# Take screenshot after changes
playwright screenshot current.png

# Compare visually or with tool
pixelmatch baseline.png current.png diff.png
```

**Manual verification:**

```
Manual Test Checklist
─────────────────────────────────────────────
[ ] Happy path works (expected behavior)
[ ] Error path works (graceful failures)
[ ] Edge case 1: [specific case]
[ ] Edge case 2: [specific case]
[ ] No regressions in related features
[ ] Console has no errors
─────────────────────────────────────────────
```

**Verification pass criteria:**
- All automated tests pass
- Visual comparison shows expected changes only
- Manual checklist complete with no issues
- No regressions detected

**If verification fails:**
- Fix the issue in this iteration
- Don't proceed to next iteration until current one verifies
- Re-verify after fixes

### 6. Commit at Boundaries

**Create atomic, standalone commits for each iteration:**

**Commit message template:**

```bash
git add [files changed in this iteration]

git commit -m "$(cat <<'EOF'
<type>(<scope>): <iteration summary>

<detailed description of what this iteration accomplishes>

- Change 1
- Change 2
- Change 3

Verification: <how it was verified>
- Tests: <which tests pass>
- Manual: <what was manually verified>

Part of: <overall goal>
Iteration: <N of M>

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

**Commit types:**
- `feat`: New feature iteration
- `fix`: Bug fix iteration
- `refactor`: Code improvement iteration
- `test`: Add tests iteration
- `docs`: Documentation iteration
- `perf`: Performance improvement iteration

**Example commit:**

```
feat(auth): add JWT validation middleware

Implements JWT token validation for API routes.
Supports both HS256 and RS256 algorithms.

- Add jwt validation middleware
- Add token expiry checking
- Add signature verification
- Add tests for valid and invalid tokens

Verification:
- Tests: 8 new tests pass (valid token, expired token, invalid signature)
- Manual: Verified with Postman using test tokens

Part of: User authentication system
Iteration: 1 of 4
```

**Good commit qualities:**
- **Atomic**: Single logical change
- **Standalone**: Makes sense without other commits
- **Reversible**: Can be reverted cleanly
- **Testable**: Has verification evidence
- **Reviewable**: Clear what changed and why

### 7. Document Learning

**Capture patterns and impediments discovered:**

**Learning capture template:**

```
📚 Iteration Learnings
─────────────────────────────────────────────
**Iteration:** [N]
**Date:** [YYYY-MM-DD]

**Patterns discovered:**
- [Reusable pattern 1]
  - Context: [When it applies]
  - Implementation: [How to do it]

- [Reusable pattern 2]
  - Context: [When it applies]
  - Implementation: [How to do it]

**Impediments encountered:**
- [Blocker 1]
  - Impact: [What it prevented]
  - Resolution: [How it was resolved]

- [Blocker 2]
  - Impact: [What it prevented]
  - Resolution: [How it was resolved]

**Surprises:**
- [Unexpected finding 1]
- [Unexpected finding 2]

**Adjustments to remaining iterations:**
- [Change to iteration 3 based on learning]
- [Change to iteration 4 based on learning]
─────────────────────────────────────────────
```

**Types of learnings:**

| Type | Example |
|------|---------|
| **Pattern** | "API error responses should include request ID for debugging" |
| **Anti-pattern** | "Don't use async/await inside forEach (use for...of instead)" |
| **Gotcha** | "Library X doesn't support feature Y in version Z" |
| **Optimization** | "Caching API responses reduces load time by 80%" |
| **Assumption** | "Assumed X but actually Y (adjust future iterations)" |

### 8. Adapt the Plan

**Update remaining iterations based on what was learned:**

**Adaptation triggers:**

| Trigger | Action |
|---------|--------|
| **Easier than expected** | Combine iterations, finish faster |
| **Harder than expected** | Split iteration into smaller chunks |
| **New dependency discovered** | Reorder iterations (do dependency first) |
| **Approach not working** | Pivot strategy for remaining iterations |
| **Scope creep identified** | Defer nice-to-haves to later iterations |
| **Blocker encountered** | Add iteration to resolve blocker |

**Plan adaptation example:**

```
Original Plan:
1. Add auth API ✅ (done)
2. Add login UI
3. Integrate with existing features
4. Add password reset

Adapted Plan (after iteration 1):
1. Add auth API ✅ (done, learned: need CORS config)
2. Add CORS configuration (NEW - discovered dependency)
3. Add login UI (was #2)
4. Integrate with existing features (was #3)
5. Add password reset (was #4)
```

### 9. Summarize Progress

**After completing all iterations, document final state:**

```
🏁 Iteration Summary
─────────────────────────────────────────────
**Goal:** [Original objective]
**Status:** [COMPLETE | PARTIAL | BLOCKED]

**Completed iterations:** [N of M]
- Iteration 1: [Summary] ✅
- Iteration 2: [Summary] ✅
- Iteration 3: [Summary] ✅

**Verification results:**
- Programmatic: [N tests pass]
- Visual: [N screenshots verified]
- Manual: [N checklist items complete]

**Commits made:**
- [commit hash 1]: [commit message]
- [commit hash 2]: [commit message]
- [commit hash 3]: [commit message]

**Learnings captured:** [N patterns, N impediments]

**Remaining work (if any):**
- [Future iteration 1]
- [Future iteration 2]

**Recommendations:**
- [Next step 1]
- [Next step 2]
─────────────────────────────────────────────
```

## Examples

### Example 1: Add Search Feature

**Goal:** Add search functionality to blog

**Iterations:**
1. Add search API endpoint (programmatic verification: unit tests)
2. Add search UI input field (visual verification: screenshot)
3. Connect UI to API (manual verification: test search)
4. Add search highlighting (visual verification: highlight appears)
5. Add empty state messaging (visual verification: message appears)

**Verification strategies:**
- Iteration 1: Jest tests for search logic
- Iteration 2: Visual snapshot testing
- Iteration 3: Manual testing with various queries
- Iteration 4-5: Visual + manual verification

**Commits:** 5 commits (one per iteration)

### Example 2: Refactor Legacy Code

**Goal:** Refactor authentication module for testability

**Iterations:**
1. Extract validation logic to pure functions (programmatic: unit tests)
2. Extract API calls to separate module (programmatic: integration tests)
3. Replace global state with dependency injection (programmatic: refactor tests)
4. Add error handling (programmatic: error case tests)

**Verification strategies:**
- All programmatic (unit and integration tests)
- Each iteration maintains 100% passing tests
- No manual verification needed (pure logic)

**Commits:** 4 commits (one per iteration)

### Example 3: Fix Multi-Step Bug

**Goal:** Fix checkout flow bug

**Iterations:**
1. Reproduce bug with failing test (programmatic: test fails as expected)
2. Fix validation logic (programmatic: test now passes)
3. Add edge case handling (programmatic: additional tests)
4. Verify no regressions (manual: smoke test entire checkout flow)

**Verification strategies:**
- Iterations 1-3: Programmatic (test-driven)
- Iteration 4: Manual verification of full flow

**Commits:** 4 commits (one per iteration)

## Integration with Other Skills

**Before `/iterate`:**
```
/plan → High-level roadmap of phases
/architect → System design for complex features
```

**During `/iterate`:**
```
/test → Run verification at each iteration
/commit → Create atomic commits at boundaries
```

**After `/iterate`:**
```
/review → Review all commits made
/document → Document patterns discovered
```

**Combine with `/relentless` for high-stakes work:**
```
/relentless /iterate [complex task]
```
- Test 10+ edge cases per iteration
- Multiple verification methods (programmatic + visual + manual)
- Deeper analysis of learnings

**Combine with `/loop` for autonomous completion:**
```
/loop /iterate [task with clear end state]
```
- Loop continues until all iterations verified
- Self-directed progression through iterations

## Anti-Patterns

❌ **Iterations too large**
- Taking hours to complete one iteration
- Can't verify in isolation
- Too much to commit atomically

✅ **Right-sized iterations**
- 15-45 minutes each
- Independently testable
- Clean commit boundary

❌ **Skipping verification**
- Assuming it works without testing
- Moving to next iteration with failing tests
- "I'll test it all at the end"

✅ **Verify immediately**
- Test after each iteration
- Fix issues before proceeding
- Build confidence incrementally

❌ **Not adapting plan**
- Following original plan rigidly despite learnings
- Ignoring discovered dependencies
- Missing opportunities to combine/split iterations

✅ **Adaptive planning**
- Adjust based on learnings
- Reorder when dependencies discovered
- Split when iterations too large

❌ **Scope creep mid-iteration**
- "While I'm here, let me also..."
- Adding unrelated changes
- Iterations become unfocused

✅ **Focused iterations**
- One logical change per iteration
- Defer nice-to-haves to later
- Keep commits clean

## Tips

✅ **Plan iterations before starting** (but adapt as you learn)
✅ **Classify verification strategy per iteration** (programmatic, visual, manual)
✅ **Verify immediately after each iteration** (don't accumulate unverified work)
✅ **Commit at iteration boundaries** (atomic, standalone commits)
✅ **Document learnings** (patterns, anti-patterns, gotchas)
✅ **Adapt plan based on learnings** (reorder, split, combine)
✅ **Keep iterations small** (15-45 minutes each)
✅ **Each iteration should be independently valuable** (provides some benefit alone)

---

**Remember**: Iterations are about breaking complexity into verifiable, committable chunks. Each iteration is independently testable and provides incremental progress toward the goal.
