---
name: optimize
description: Analyze and improve performance and scalability using a measurement-driven methodology
command: /optimize
aliases: ["/perf", "/performance", "/speedup"]
synonyms: ["/optimizing", "/optimized", "/optimizes", "/performance", "/speedup", "/optimise", "/optimising", "/optimised", "/optimises"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Optimize Workflow

<scope_constraints>
This workflow instructs Cascade to apply rigorous, measurement-driven performance engineering. Focuses on latency, throughput, resource efficiency, and scalability for systems where performance matters.
</scope_constraints>

<context>
Performance optimization requires measurement before and after every change. Common pitfalls: optimizing the wrong thing, introducing complexity for marginal gains, and regression during deployment. This workflow emphasizes measurement discipline and incremental validation.
</context>

<instructions>

## Inputs

- Performance goals: What metric matters (latency, throughput, resource efficiency)?
- Current state: Baseline measurements with realistic workload
- Constraints: Acceptable complexity, timeline, risk tolerance
- Success criteria: Concrete targets (p50, p95, p99 latency or throughput goals)

## Step 1: Define Performance Goals and Context

- Clarify what "performance" means for this system:
  - Latency (p50, p95, p99), throughput, resource efficiency, cold-start time, or other metrics.
- Identify where bottlenecks are suspected and where they matter most (user-facing, background, cost-driven).
- Set concrete targets:
  - SLOs, benchmarks, or relative improvement goals.

### Step 2: Measure Baseline Performance

- Capture current state with realistic workloads:
  - Load tests, benchmarks, traces, flame graphs, system metrics.
- Use appropriate instrumentation:
  - Wall clock time, CPU/memory sampling, I/O and network metrics.
- Document environment details so measurements are reproducible.

### Step 3: Identify Bottlenecks and Root Causes

- Analyze traces and profiles to locate hot paths and resource sinks.
- Apply Amdahl's Law thinking:
  - A small percentage of code often dominates performance.
- Distinguish between algorithmic inefficiency, I/O waits, contention/locking, memory/cache issues, and external dependencies.

### Step 4: Explore Optimization Strategies

- Generate multiple candidate optimizations:
  - Algorithmic improvements (better BigO).
  - Caching and memoization.
  - Batching and request collapsing.
  - Parallelization and concurrency tuning.
  - Data structure and memory layout changes.
  - Offloading to specialized hardware or services.
- Evaluate trade-offs:
  - Complexity vs gain, maintainability, correctness risk.

### Step 5: Implement and Validate Changes

- Make changes incrementally and measure after each.
- Compare new measurements against baseline.
- Ensure correctness:
  - No regression in behavior; run tests.
- Watch for second-order effects:
  - Memory usage, tail latency, dependency load.

### Step 6: Guard Against Regression

- Add benchmarks or performance tests to CI.
- Set up alerting on key performance metrics.
- Document performance characteristics and known limits.

## Error Handling

- **Baseline measurement fails:** Use simpler, more isolated benchmarks; verify test environment
- **Optimization regresses other metrics:** Revert change, analyze trade-offs, try different approach
- **Cannot reproduce performance issue:** Vary workload, environment, and timing; add detailed logging
- **Optimization introduces correctness bug:** Revert immediately, write test for bug, fix both issues separately

</instructions>

<output_format>

Provide a performance optimization analysis and plan as the output:

1. **Baseline Measurement**: Current performance with methodology and environment
2. **Bottleneck Analysis**: Identified hot paths with Amdahl's Law analysis
3. **Optimization Strategies**: 3+ approaches with pros/cons and estimated impact
4. **Implementation Plan**: Incremental steps with measurements after each
5. **Regression Prevention**: Benchmarks and monitoring to guard against performance degradation

</output_format>
