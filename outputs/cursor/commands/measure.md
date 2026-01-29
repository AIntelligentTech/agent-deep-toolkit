# Benchmark Workflow

This workflow instructs Cascade to create meaningful benchmarks that provide actionable performance insights.

## 1. Define Benchmarking Goals

- Clarify what you're measuring:
  - Latency, throughput, memory, CPU.
  - Startup time, build time, bundle size.
- Define the purpose:
  - Establish baseline.
  - Compare implementations.
  - Detect regressions.
  - Validate optimizations.

## 2. Identify What to Benchmark

- Focus on meaningful targets:
  - Hot paths (frequently executed code).
  - Critical user flows.
  - Known bottlenecks.
- Prioritize by impact:
  - What affects users most?
  - What affects costs most?

## 3. Design Benchmark Suite

- Create representative workloads:
  - Realistic input data.
  - Typical usage patterns.
  - Edge cases (large inputs, empty states).
- Ensure reproducibility:
  - Fixed inputs, seeded randomness.
  - Consistent environment.
  - Warm-up periods.

## 4. Set Up Benchmarking Infrastructure

- Choose appropriate tools:
  - Microbenchmarking (hyperfine, criterion, benchmark.js).
  - Load testing (k6, locust, wrk).
  - Profiling (perf, pprof, flamegraphs).
- Configure environment:
  - Dedicated hardware or consistent cloud instances.
  - Disable thermal throttling, turbo boost variance.
  - Isolated from other workloads.

## 5. Run Benchmarks Properly

- Execute with statistical rigor:
  - Multiple iterations.
  - Discard outliers.
  - Report mean, median, percentiles.
- Control for variability:
  - Run at consistent times.
  - Monitor system state.
  - Account for garbage collection.

## 6. Analyze and Compare Results

- Compare against baselines:
  - Previous versions.
  - Alternative implementations.
  - Industry standards.
- Look for patterns:
  - Scaling behavior.
  - Memory/CPU trade-offs.
  - Variance and outliers.

## 7. Detect and Prevent Regressions

- Automate benchmark runs in CI:
  - Run on PR or scheduled.
  - Compare to main branch.
- Set thresholds:
  - Fail builds on significant regressions.
  - Alert on concerning trends.
- Track over time:
  - Historical data and trends.
  - Dashboard visualizations.

## 8. Document and Report

- Record benchmark methodology.
- Report results clearly:
  - What was measured, how.
  - Key findings and recommendations.
- Update as system evolves.