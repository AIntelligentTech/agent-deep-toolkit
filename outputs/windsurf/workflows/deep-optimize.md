---
description: Analyze and improve performance and scalability using a measurement-driven methodology
auto_execution_mode: 3
tags:
  - architecture
  - testing
  - documentation
  - performance
---
# Deep Optimize Workflow

This workflow instructs Cascade to optimize performance and scalability using evidence, not guesswork.

## 1. Define Performance Goals and Constraints

- Clarify target SLOs or expectations:
  - Latency, throughput, error rates, resource utilization, cost ceilings.
- Identify critical user journeys and hot paths to focus on first.
- Note constraints:
  - Hardware limits, third-party quotas, architectural immutables.

## 2. Measure Baseline

- Use appropriate tools to capture current behavior:
  - Profilers, flamegraphs, tracing, query plans, synthetic load tests.
- Measure under realistic scenarios:
  - Representative data volumes and traffic patterns.
- Record baseline metrics so improvements and regressions can be compared.

## 3. Identify Bottlenecks and Root Causes

- Analyze measurements to find:
  - Hot functions, slow queries, lock contention, chatty network calls.
- Apply an 80/20 lens:
  - Focus first on the few hotspots responsible for most of the slowness.
- Look for systemic patterns:
  - Inefficient data access patterns, unnecessary work, over‑synchronization.

## 4. Explore Optimization Strategies

- Consider layers of optimization, roughly in this order:
  - Algorithm and data structure improvements (time/space complexity).
  - Data access improvements (indexes, batching, denormalization where appropriate).
  - Architectural changes (caching, async processing, parallelism, offloading to background work).
  - Infrastructure tuning (connection pools, thread pools, container limits).
- Evaluate trade‑offs explicitly:
  - Complexity vs gain, impact on correctness, operational risk.

## 5. Implement and Validate Changes

- Apply optimizations in small, testable increments.
- After each change:
  - Re‑run the relevant benchmarks or load tests.
  - Compare new metrics against the baseline and goals.
- Ensure functional behavior and correctness remain intact via tests.

## 6. Guard Against Regressions

- Where feasible, add:
  - Automated performance checks, budgets, or alerts for key endpoints and jobs.
  - Dashboards tracking latency, throughput, and resource utilization over time.
- Document optimization decisions and their rationale so future changes respect the same constraints.
