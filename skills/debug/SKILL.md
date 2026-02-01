---
name: debug
description: Perform deep, systematic debugging to find true root causes and design robust, well-tested fixes
command: /debug
aliases: ["/fix", "/troubleshoot", "/diagnose"]
synonyms: ["/debugging", "/debugged", "/debugs", "/fixing", "/fixed", "/fixes", "/troubleshooting", "/troubleshoot", "/troubleshot", "/diagnosing", "/diagnosed"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Debug Workflow

This workflow instructs Cascade to debug like an experienced tester and engineer combined: methodical reproduction, deep code understanding, hypothesis-driven experiments, and prevention-focused fixes.

<scope_constraints>
**Operational Boundaries:**
- Scope: Systematic debugging of failures, regressions, and anomalies
- Modes: Reproduction, code tracing, hypothesis testing, root cause analysis
- Defaults: Prioritize depth over speed; focus on prevention not just fixes
- Not in scope: Feature implementation, architectural redesign without debugging context
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Access to error messages, logs, stack traces, and reproduction steps
- Code repository and version history (git)
- Test suite and ability to run tests locally
- Debugging tools appropriate to the tech stack (debugger, REPL, logging)
- Familiarity with the codebase structure and architecture
</context>

<instructions>

## Inputs
- Problem statement (user-reported issue or error)
- Environment details (versions, configs, browser/OS)
- Error messages, stack traces, or reproduction steps
- Recent changes or context

## Steps

### Step 1: Clarify, Triage, and Reproduce

- Restate the problem in precise, observable terms:
  - Expected vs actual behavior.
  - Error messages, stack traces, logs, and user-visible symptoms.
- Capture environment details:
  - Versions (app, dependencies, platform, browser/OS).
  - Config flags, feature toggles, data conditions.
- **Rubber Ducking**: Explain the problem aloud (or in chat) to another "entity" or the user. Often, the act of precise explanation reveals the flaw.
- Establish a reliable reproduction path:
  - Document exact steps.
  - Strive to minimize the repro to the smallest scenario that still fails.
- **Git Bisect**: Use `git bisect` to identify exactly which commit introduced the regression, if the history is available.
- Assess impact and urgency (severity, affected users, business risk) to guide depth vs speed.

### Step 2: Map and Trace the Code Path in Detail

- Start from the **entrypoint** used in your repro:
  - HTTP route, RPC handler, CLI command, queue consumer, cron job, etc.
  - Locate the corresponding handler/controller using `code_search` and `grep_search`.
- Use stack traces and logs to identify the **observed call stack** at the failure point:
  - Note the top few frames (entry) and the bottom frames (where the failure surfaced).
  - Distinguish framework/runtime plumbing from your own application code.
- Build a **mental call graph** for the failing path:
  - From the entry handler, follow function calls forward into services, repositories, and utilities.
  - Note branches, loops, callbacks, and asynchronous boundaries (promises, background tasks, events).
  - Record this as a short textual outline so it can be updated as you learn more.
- Use targeted instrumentation to **dynamically trace** execution when helpful:
  - Temporary logs at function entry/exit with key parameters and identifiers.
  - Correlation IDs to follow a single request across services.

### Step 3: Form Hypotheses (Tester's Mindset)

- List plausible classes of defects given the symptoms:
  - Data/contract mismatches, null/undefined handling, off-by-one, race conditions, caching inconsistencies, time-zone or locale issues, precision/rounding, permission checks, performance timeouts, etc.
- Use a quick **CSD Matrix**:
  - What do we know for sure about the failure?
  - What are working assumptions?
  - What remains unclear?
- Prioritize hypotheses based on alignment with evidence and historical defect patterns in this codebase.

### Step 4: Improve Observability and Testability

- Apply testability heuristics:
  - Can the failing area be exercised through a smaller, more focused unit or integration test?
  - Is the behavior observable via logs/metrics/traces at the right granularity?
- Add or refine instrumentation (temporarily if needed):
  - Structured logs with key inputs, branches, and outputs.
  - Metrics or counters around suspected hotspots.
- Create or adjust automated tests to:
  - Reproduce the failure in a controlled environment (ideally as a failing test).
  - Cover nearby edge cases that might share the same root cause.

### Step 5: Run Targeted Experiments and Use the Web Wisely

- Use the debugger, REPL, or print-style debugging selectively to inspect state.
- Vary inputs, environment variables, and feature flags to see how the behavior changes.
- Use `search_web` when:
  - Error messages mention framework/runtime internals.
  - Behavior is tied to specific versions of libraries or platforms.
- Verify that online solutions:
  - Match the actual versions and stack in use.
  - Are current, or intentionally apply older approaches only when working with legacy code.

### Step 6: Converge on Root Cause (Not Just the Symptom)

- Once a candidate fix emerges, apply **5 Whys** to ensure you have gone deep enough:
  - Why did this specific error occur?
  - Why did the system allow this state or input?
  - Why was it not caught by tests or monitoring?
- Optionally use a mini **Fishbone** lens (People, Process, Platform, Code, Data) to see if broader factors contributed.
- Check for similar vulnerable areas (e.g., same pattern used elsewhere) to avoid "one-off" patches.

### Step 7: Design a Safe, Sustainable Fix

- Favor the smallest change that fully addresses the root cause and fits the architecture.
- Consider:
  - Performance implications (e.g., added checks vs hot paths).
  - Security implications (e.g., new validation, error messaging).
  - User experience (e.g., clearer error handling, graceful degradation).
- Strengthen automated tests:
  - Turn repro into a regression test.
  - Add tests for adjacent edge cases to guard against similar issues.
- Where appropriate, add assertions or invariants at boundaries to prevent reintroduction.

### Step 8: Validate, Monitor, and Learn

- Re-run the original repro and a broader smoke/regression check around the affected area.
- If applicable, validate in staging or with feature flags/canary releases before full rollout.
- After deployment, monitor logs/metrics for:
  - Recurrence of the error.
  - New anomalies introduced by the fix.
- Capture a brief "bug narrative":
  - Root cause.
  - How it was found and fixed.
  - What changed in tests/monitoring/process to prevent similar bugs in future.

## Error Handling

- **Cannot reproduce**: Gather more context (logs, timing, environment); try to narrow scope or ask user for detailed repro steps
- **Fix introduces new issues**: Revert, re-analyze root cause, and design alternative fix
- **Root cause unclear after hypothesis testing**: Consider deferring (if low impact) or escalating to team/domain expert
- **Performance concerns**: Measure impact before and after; optimize if needed, or revert and try different approach

</instructions>

<output_format>
**Deliverables:**
- Confirmed root cause with supporting evidence (code references, logs, test cases)
- Detailed fix with code changes and test coverage
- "Bug narrative" documenting discovery process and prevention measures
- Monitoring plan for post-deployment validation
</output_format>
