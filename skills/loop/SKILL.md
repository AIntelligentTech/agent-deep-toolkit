---
name: loop
description: Execute work autonomously in a persistent loop until clearly-defined completion criteria are met, creating tools and capabilities as needed
command: /loop
aliases: ["/ralph-loop", "/autonomous", "/self-directed"]
synonyms: ["/looping", "/looped", "/loops"]
activation-mode: auto
user-invocable: true
disable-model-invocation: false
---

# Loop - Ralph Wiggum Autonomous Pattern

Execute work autonomously in a persistent loop until clearly-defined completion criteria are met. The agent operates independently, creating tools and capabilities as needed, with prompt-based self-assessment after each iteration.

## When to Use

- **Clear end state**: You know exactly what "done" looks like
- **Unpredictable path**: The approach may need to evolve as you learn
- **Tool creation needed**: May need to build utilities or scripts along the way
- **Self-directed execution**: Want the agent to work until truly complete
- **Iterative refinement**: Each cycle improves toward the goal

## When NOT to Use

- **Exploratory work**: Open-ended research without clear completion
- **Time-sensitive tasks**: Need results by specific deadline
- **Human decision points**: Require approval or input at key stages
- **Simple linear tasks**: One-shot execution is sufficient
- **High-risk operations**: Need manual oversight at each step

## The Ralph Wiggum Pattern

Named after the character who persists until truly done, this pattern enables autonomous execution with:

- **Clear exit criteria** defined upfront
- **Prompt-based re-assessment** after each iteration (no hard hooks)
- **Tool creation autonomy** to build what's needed
- **Self-adaptive strategy** that pivots based on learning
- **Safety mechanisms** to prevent runaway execution

## Core Loop Workflow

### 1. Define the Loop Contract

**Before starting the loop**, establish crystal-clear completion criteria:

```
✅ Measurable completion criteria
✅ Observable success indicators
✅ Maximum iteration limit (default: 50)
✅ Checkpoint frequency (every 25% progress)
✅ Rollback plan if things go wrong
```

**Example completion criteria:**
- "All tests pass with 100% coverage"
- "API returns valid responses for all 15 test cases"
- "Website renders correctly on 5 browsers"
- "Database migration completes with zero errors"

**Anti-patterns (too vague):**
- ❌ "Make it work"
- ❌ "Fix the bugs"
- ❌ "Improve performance"
- ❌ "Clean up the code"

### 2. Prepare Execution Environment

Set up clean state and observability:

```bash
# Create checkpoint directory
mkdir -p .loop-checkpoints/$(date +%Y%m%d-%H%M%S)

# Initialize iteration tracker
echo "0" > .loop-iteration
echo "RUNNING" > .loop-status

# Set up logging
exec > >(tee -a .loop-log.txt)
exec 2>&1
```

**Safety mechanisms:**
- Clean working directory (no uncommitted changes)
- Backup of current state
- Progress log file
- Iteration counter
- Status file for monitoring

### 3. Execute First Iteration

Make the initial attempt toward the goal:

1. **Assess current state** - What's the starting point?
2. **Choose approach** - What's the most promising strategy?
3. **Execute changes** - Implement the approach
4. **Test immediately** - Verify what changed
5. **Document results** - What worked? What didn't?

**Key principle**: Prefer small, testable changes over large rewrites.

### 4. Assess and Iterate

**After each iteration, use prompt-based self-assessment:**

```
📊 Iteration Assessment Template
─────────────────────────────────────────────
**Iteration:** [N]
**Status:** [PROGRESS | BLOCKED | COMPLETE]

**What was attempted:**
- [Action taken]

**What changed:**
- [Measurable change]

**Tests/Validation:**
- [What was verified]
- [Results: PASS/FAIL]

**Completion criteria check:**
- [ ] Criterion 1: [status]
- [ ] Criterion 2: [status]
- [ ] Criterion 3: [status]

**Next action:**
- [If not complete: what to try next]
- [If blocked: what's preventing progress]
- [If complete: verification steps]

**Iteration count:** [N/50]
─────────────────────────────────────────────
```

**Decision logic:**
- **All criteria met** → Proceed to completion verification
- **Progress made** → Continue with next iteration
- **Blocked** → Attempt autonomous unblocking (see section 5)
- **No progress for 3 iterations** → Escalate or pivot strategy
- **Iteration limit reached** → Document state and exit

### 5. Handle Errors and Blockers

**When encountering errors or blockers, attempt autonomous resolution:**

**Tool creation autonomy:**
```bash
# Example: Create validation script
cat > validate.sh <<'EOF'
#!/bin/bash
# Auto-generated validation script
set -e
npm test
npm run lint
npm run type-check
echo "✅ All checks passed"
EOF
chmod +x validate.sh
```

**Common blocker patterns:**

| Blocker | Autonomous Resolution |
|---------|----------------------|
| Missing dependency | Install package, update manifest |
| Configuration error | Generate valid config from template |
| Test failure | Analyze failure, create minimal fix |
| API error | Add retry logic, improve error handling |
| Permission issue | Adjust permissions, create proper structure |

**Escalation triggers:**
- Same error for 3 consecutive iterations
- Blocker requires external resource (credentials, API access)
- Fundamental architectural incompatibility
- Resource limits (memory, disk, quota)

### 6. Track Progress

**Monitor iteration counter and prevent infinite loops:**

```bash
# Increment iteration counter
ITERATION=$(cat .loop-iteration)
ITERATION=$((ITERATION + 1))
echo "$ITERATION" > .loop-iteration

# Check limits
if [ "$ITERATION" -ge 50 ]; then
    echo "⚠️ Max iterations reached. Exiting loop."
    echo "LIMIT_REACHED" > .loop-status
    exit 1
fi

# Checkpoint at 25% intervals
if [ $((ITERATION % 12)) -eq 0 ]; then
    # Create checkpoint
    cp -r . ".loop-checkpoints/checkpoint-$ITERATION/"
    echo "📍 Checkpoint $ITERATION created"
fi
```

**Progress indicators:**
- Iteration count (N/50)
- Completion percentage (estimated)
- Time elapsed since start
- Tests passing vs failing
- Blockers encountered and resolved

### 7. Verify Completion Criteria

**When all criteria appear met, perform rigorous verification:**

**Verification checklist:**
```
✅ All automated tests pass
✅ Manual verification confirms expected behavior
✅ No regressions in existing functionality
✅ Documentation updated if needed
✅ Code committed with clear message
✅ Artifacts available for review
```

**False completion check:**
- Did you test edge cases?
- Did you verify on clean environment?
- Did you check for side effects?
- Did you document what changed?

**Exit only when verification confirms true completion.**

### 8. Completion Summary

**Document the journey and artifacts:**

```
🏁 Loop Completion Summary
─────────────────────────────────────────────
**Goal:** [Original objective]
**Status:** [COMPLETE | LIMIT_REACHED | BLOCKED]

**Statistics:**
- Iterations: [N/50]
- Duration: [time]
- Tools created: [count]
- Strategy pivots: [count]

**What was accomplished:**
- [Key achievement 1]
- [Key achievement 2]
- [Key achievement 3]

**Key learnings:**
- [Pattern 1]
- [Pattern 2]
- [Pattern 3]

**Artifacts:**
- [File/script 1]
- [File/script 2]
- [Test results]

**Verification results:**
- [Criterion 1]: ✅ PASS
- [Criterion 2]: ✅ PASS
- [Criterion 3]: ✅ PASS

**Next steps:**
- [Recommendation 1]
- [Recommendation 2]
─────────────────────────────────────────────
```

### 9. Safety and Guardrails

**Built-in safety mechanisms:**

**Resource limits:**
- Max iterations: 50 (hard limit)
- Max time: 2 hours (suggested)
- Max file size: 10MB per file
- Max total changes: 100 files

**Checkpoints:**
- Automatic every 12 iterations
- Manual checkpoint before risky operations
- Full state snapshot for rollback

**Rollback capability:**
```bash
# If things go wrong, rollback to checkpoint
CHECKPOINT=$(ls -t .loop-checkpoints/ | head -1)
cp -r ".loop-checkpoints/$CHECKPOINT/." .
echo "↩️ Rolled back to $CHECKPOINT"
```

**Circuit breakers:**
- Same error 3x → Escalate or pivot
- No progress 5x → Request human guidance
- Resource exhaustion → Stop gracefully
- External service failure → Retry with backoff

**Monitoring hooks (optional):**
```bash
# Optional: Send progress updates
if [ $((ITERATION % 5)) -eq 0 ]; then
    echo "📊 Progress: $ITERATION/50 iterations"
fi
```

## Examples

### Example 1: Fix All Failing Tests

**Goal:** Get test suite to 100% passing

**Completion criteria:**
- `npm test` exits with code 0
- All tests show "PASS" status
- Coverage remains above 80%

**Loop execution:**
1. Run tests → identify first failure
2. Fix failing test → re-run suite
3. If new failures appear → fix those
4. Repeat until all green
5. Verify coverage threshold met
6. Done

**Iterations:** Typically 5-15 depending on test count

### Example 2: Cross-Browser Compatibility

**Goal:** Website renders correctly on 5 browsers

**Completion criteria:**
- Screenshots match on Chrome, Firefox, Safari, Edge, Opera
- No console errors in any browser
- All interactive elements work

**Loop execution:**
1. Take screenshots on all browsers
2. Identify rendering differences
3. Fix CSS/JS for specific browser
4. Re-test all browsers
5. Repeat until all match
6. Done

**Tools created:**
- Screenshot automation script
- Visual diff comparison tool
- Browser compatibility test suite

### Example 3: API Integration Validation

**Goal:** API returns valid responses for all test cases

**Completion criteria:**
- All 15 test cases return HTTP 200
- Response schemas validate against spec
- No timeout or rate limit errors

**Loop execution:**
1. Run test case 1 → check response
2. Fix issues → move to test case 2
3. Handle edge cases discovered
4. Create retry logic for flaky endpoints
5. Verify all cases pass
6. Done

**Iterations:** 8-20 depending on API complexity

## Comparison with Other Skills

| Aspect | /loop | /iterate | /relentless |
|--------|-------|----------|-------------|
| **Autonomy** | Fully autonomous until done | Manual progression | Amplifies any skill |
| **Exit condition** | Self-determined by criteria | User decides when to stop | User decides |
| **Tool creation** | Yes, as needed | No | Depends on base skill |
| **Re-assessment** | Prompt-based after each iteration | Between iterations | Continuous throughout |
| **Iterations** | Until done (max 50) | User-controlled | N/A (effort multiplier) |

## Integration with Other Skills

**Prefix with `/relentless` for high-stakes loops:**
```
/relentless /loop [goal with completion criteria]
```
- Increases validation rigor
- Tests 10+ edge cases per iteration
- Multiple verification methods
- Longer analysis per iteration

**Combine with `/test` for verification:**
```
After each loop iteration:
1. Run /test to validate changes
2. Check completion criteria
3. Continue or exit based on results
```

**Use `/integrate` before looping on complex changes:**
```
1. /integrate [plan the approach]
2. /loop [execute until complete]
3. /propagate [roll out changes]
```

## Anti-Patterns

❌ **Vague completion criteria**
- "Make it better"
- "Fix the issues"
- "Improve quality"

❌ **No iteration limit**
- Risk of infinite loop
- Resource exhaustion
- Lost time

❌ **Ignoring blockers**
- Retrying same approach 10x
- Not pivoting when stuck
- Not escalating when needed

❌ **Skipping verification**
- Assuming it works
- Not testing edge cases
- No regression checking

❌ **No checkpoints**
- Can't rollback if things break
- Lose progress on failure
- No recovery path

## Tips

✅ **Write completion criteria like test assertions**
✅ **Create checkpoint before risky changes**
✅ **Pivot strategy after 3 failed attempts**
✅ **Build tools that persist beyond the loop**
✅ **Document what you learn in each iteration**
✅ **Verify thoroughly before declaring complete**
✅ **Keep iterations small and testable**
✅ **Monitor iteration count actively**

---

**Remember**: The loop continues until the job is truly done, not just "good enough". The Ralph Wiggum pattern means working autonomously with clear criteria, self-assessment, and safety guardrails.
