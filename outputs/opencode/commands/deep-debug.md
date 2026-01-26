---
description: Perform deep, systematic debugging to find true root causes and design robust, well-tested fixes
agent: build
subtask: true
---

# Deep Debug Workflow

This workflow instructs Cascade to debug like an experienced tester and engineer combined: methodical reproduction, deep code understanding, hypothesis-driven experiments, and prevention-focused fixes.

## 1. Clarify, Triage, and Reproduce

- Restate the problem in precise, observable terms:
  - Expected vs actual behavior.
  - Error messages, stack traces, logs, and user-visible symptoms.
- Capture environment details:
  - Versions (app, dependencies, platform, browser/OS).
  - Config flags, feature toggles, data conditions.
- Establish a reliable reproduction path:
  - Document exact steps.
  - Strive to minimize the repro to the smallest scenario that still fails.
- Assess impact and urgency (severity, affected users, business risk) to guide depth vs speed.

## 2. Map and Trace the Code Path in Detail

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
  - If available, enable distributed tracing or framework-level request tracing around the failing scenario.
- Identify and annotate **integration and state boundaries** along the path:
  - Network calls (APIs, message queues, external services).
  - Database queries, caches, file systems, and other side effects.
  - Feature flags and configuration reads that may change behaviour.
- Relate this traced path back to the broader architecture:
  - Which bounded context and C4 container/component does it live in?
  - Are there other code paths that share components or data with this one (potential collateral impact)?

## 3. Form Hypotheses (Tester’s Mindset)

- List plausible classes of defects given the symptoms:
  - Data/contract mismatches, null/undefined handling, off-by-one, race conditions, caching inconsistencies, time-zone or locale issues, precision/rounding, permission checks, performance timeouts, etc.
- Use a quick **CSD Matrix**:
  - What do we know for sure about the failure?
  - What are working assumptions?
  - What remains unclear?
- Prioritize hypotheses based on alignment with evidence and historical defect patterns in this codebase.

## 4. Improve Observability and Testability

- Apply testability heuristics:
  - Can the failing area be exercised through a smaller, more focused unit or integration test?
  - Is the behavior observable via logs/metrics/traces at the right granularity?
- Add or refine instrumentation (temporarily if needed):
  - Structured logs with key inputs, branches, and outputs.
  - Metrics or counters around suspected hotspots.
- Create or adjust automated tests to:
  - Reproduce the failure in a controlled environment (ideally as a failing test).
  - Cover nearby edge cases that might share the same root cause.

## 5. Run Targeted Experiments and Use the Web Wisely

- Use the debugger, REPL, or print-style debugging selectively to inspect state.
- Vary inputs, environment variables, and feature flags to see how the behavior changes.
- Use `search_web` when:
  - Error messages mention framework/runtime internals.
  - Behavior is tied to specific versions of libraries or platforms.
- Verify that online solutions:
  - Match the actual versions and stack in use.
  - Are current (2024–2026), or intentionally apply older approaches only when working with legacy code.

## 6. Converge on Root Cause (Not Just the Symptom)

- Once a candidate fix emerges, apply **5 Whys** to ensure you have gone deep enough:
  - Why did this specific error occur?
  - Why did the system allow this state or input?
  - Why was it not caught by tests or monitoring?
- Optionally use a mini **Fishbone** lens (People, Process, Platform, Code, Data) to see if broader factors contributed.
- Check for similar vulnerable areas (e.g., same pattern used elsewhere) to avoid “one-off” patches.

## 7. Design a Safe, Sustainable Fix

- Favor the smallest change that fully addresses the root cause and fits the architecture.
- Consider:
  - Performance implications (e.g., added checks vs hot paths).
  - Security implications (e.g., new validation, error messaging).
  - User experience (e.g., clearer error handling, graceful degradation).
- Strengthen automated tests:
  - Turn repro into a regression test.
  - Add tests for adjacent edge cases to guard against similar issues.
- Where appropriate, add assertions or invariants at boundaries to prevent reintroduction.

## 8. Validate, Monitor, and Learn

- Re-run the original repro and a broader smoke/regression check around the affected area.
- If applicable, validate in staging or with feature flags/canary releases before full rollout.
- After deployment, monitor logs/metrics for:
  - Recurrence of the error.
  - New anomalies introduced by the fix.
- Capture a brief “bug narrative”:
  - Root cause.
  - How it was found and fixed.
  - What changed in tests/monitoring/process to prevent similar bugs in future.

