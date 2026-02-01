---
name: benchmark
description: Performance benchmarking, comparison, and regression tracking
command: /benchmark
aliases: ["/perf-test", "/measure"]
synonyms: ["/benchmarking", "/benchmarked", "/benchmarks", "/measuring", "/measured", "/measures"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: measure
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Benchmark Workflow

This workflow instructs Cascade to create meaningful benchmarks that provide actionable performance insights.

<scope_constraints>
- Focuses on microbenchmarking and performance measurement
- Covers latency, throughput, memory, CPU, and resource usage
- Applies to hot paths, critical user flows, and known bottlenecks
- Includes regression detection and baseline comparison
- Works with profiling and load testing tools
- Not a replacement for production monitoring (use observability tools for runtime data)
</scope_constraints>

<context>
**Dependencies:**
- Understanding of performance metrics (latency, throughput, percentiles)
- Knowledge of benchmarking tools for target language/platform
- Familiarity with statistical concepts (mean, median, variance, outliers)
- Access to performance profiling tools if needed
- Stable test environment with consistent conditions

**Prerequisites:**
- Clear performance goals or baseline expectations
- Identified hot paths or critical workflows to benchmark
- Representative test data and realistic workloads
- Access to code or system being measured
</context>

<instructions>

## Inputs

- Metric to measure (latency, throughput, memory, CPU, startup time, bundle size)
- Benchmark goal (establish baseline, compare implementations, detect regressions, validate optimizations)
- Target code or system
- Representative workloads or test data
- Expected performance characteristics or SLO targets
- Existing baselines or historical data (if available)

## Steps

### Step 1: Define Benchmarking Goals

- Clarify what you're measuring:
  - Latency, throughput, memory, CPU.
  - Startup time, build time, bundle size.
- Define the purpose:
  - Establish baseline.
  - Compare implementations.
  - Detect regressions.
  - Validate optimizations.

### Step 2: Identify What to Benchmark

- Focus on meaningful targets:
  - Hot paths (frequently executed code).
  - Critical user flows.
  - Known bottlenecks.
- Prioritize by impact:
  - What affects users most?
  - What affects costs most?

### Step 3: Design Benchmark Suite

- Create representative workloads:
  - Realistic input data.
  - Typical usage patterns.
  - Edge cases (large inputs, empty states).
- Ensure reproducibility:
  - Fixed inputs, seeded randomness.
  - Consistent environment.
  - Warm-up periods.

### Step 4: Set Up Benchmarking Infrastructure

- Choose appropriate tools:
  - Microbenchmarking (hyperfine, criterion, benchmark.js).
  - Load testing (k6, locust, wrk).
  - Profiling (perf, pprof, flamegraphs).
- Configure environment:
  - Dedicated hardware or consistent cloud instances.
  - Disable thermal throttling, turbo boost variance.
  - Isolated from other workloads.

### Step 5: Run Benchmarks Properly

- Execute with statistical rigor:
  - Multiple iterations.
  - Discard outliers.
  - Report mean, median, percentiles.
- Control for variability:
  - Run at consistent times.
  - Monitor system state.
  - Account for garbage collection.

### Step 6: Analyze and Compare Results

- Compare against baselines:
  - Previous versions.
  - Alternative implementations.
  - Industry standards.
- Look for patterns:
  - Scaling behavior.
  - Memory/CPU trade-offs.
  - Variance and outliers.

### Step 7: Detect and Prevent Regressions

- Automate benchmark runs in CI:
  - Run on PR or scheduled.
  - Compare to main branch.
- Set thresholds:
  - Fail builds on significant regressions.
  - Alert on concerning trends.
- Track over time:
  - Historical data and trends.
  - Dashboard visualizations.

### Step 8: Document and Report

- Record benchmark methodology.
- Report results clearly:
  - What was measured, how.
  - Key findings and recommendations.
- Update as system evolves.

## Error Handling

**Common benchmarking pitfalls:**
- Insufficient iterations leading to unreliable results
- Measuring on noisy or non-representative systems
- Not accounting for garbage collection or warm-up
- Comparing incomparable systems or versions
- Setting regression thresholds too tight or too loose

**Mitigation strategies:**
- Run multiple iterations (at least 30 for statistical significance)
- Use dedicated hardware or consistent cloud instances
- Include warm-up runs and discard initial outliers
- Control for system state during benchmarks
- Set meaningful thresholds based on actual impact (e.g., 5% regression, not 0.1%)
- Document all methodology for reproducibility

</instructions>

<output_format>

The output of this skill is a **comprehensive benchmark report** with data and analysis:

1. **Benchmark Specification** — Goals, methodology, workloads, and environment
2. **Baseline Results** — Mean, median, percentiles (p50, p95, p99) for key metrics
3. **Historical Comparison** — Results vs. previous versions or baselines
4. **Comparative Analysis** — Results across multiple implementations or optimizations
5. **Regression Detection** — Pass/fail on defined thresholds with trending
6. **Resource Usage** — Memory, CPU, I/O characteristics
7. **Actionable Insights** — Key findings and optimization opportunities
8. **Next Steps** — Recommended spikes or further measurement

Deliverables typically include:
- Benchmark suite with representative workloads
- Results in tabular and graphical formats (dashboards preferred)
- Historical database for trending
- CI/CD integration for automated regression detection
- Detailed methodology document for reproducibility
- Profiling data (flamegraphs, allocation profiles) if applicable

</output_format>
