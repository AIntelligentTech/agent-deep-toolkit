# Optimize Workflow

This workflow instructs Cascade to apply rigorous, measurement-driven performance engineering.

## 1. Define Performance Goals and Context

- Clarify what "performance" means for this system:
  - Latency (p50, p95, p99), throughput, resource efficiency, cold-start time, or other metrics.
- Identify where bottlenecks are suspected and where they matter most (user-facing, background, cost-driven).
- Set concrete targets:
  - SLOs, benchmarks, or relative improvement goals.

## 2. Measure Baseline Performance

- Capture current state with realistic workloads:
  - Load tests, benchmarks, traces, flame graphs, system metrics.
- Use appropriate instrumentation:
  - Wall clock time, CPU/memory sampling, I/O and network metrics.
- Document environment details so measurements are reproducible.

## 3. Identify Bottlenecks and Root Causes

- Analyze traces and profiles to locate hot paths and resource sinks.
- Apply Amdahl's Law thinking:
  - A small percentage of code often dominates performance.
- Distinguish between algorithmic inefficiency, I/O waits, contention/locking, memory/cache issues, and external dependencies.

## 4. Explore Optimization Strategies

- Generate multiple candidate optimizations:
  - Algorithmic improvements (better BigO).
  - Caching and memoization.
  - Batching and request collapsing.
  - Parallelization and concurrency tuning.
  - Data structure and memory layout changes.
  - Offloading to specialized hardware or services.
- Evaluate trade-offs:
  - Complexity vs gain, maintainability, correctness risk.

## 5. Implement and Validate Changes

- Make changes incrementally and measure after each.
- Compare new measurements against baseline.
- Ensure correctness:
  - No regression in behavior; run tests.
- Watch for second-order effects:
  - Memory usage, tail latency, dependency load.

## 6. Guard Against Regression

- Add benchmarks or performance tests to CI.
- Set up alerting on key performance metrics.
- Document performance characteristics and known limits.