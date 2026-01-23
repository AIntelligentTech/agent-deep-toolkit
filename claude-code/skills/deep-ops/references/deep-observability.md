---
description: Design and evolve robust observability for applications, data, and AI systems
auto_execution_mode: 3
---

# Deep Observability Workflow

This workflow instructs Cascade to create and refine observability so teams can understand, debug, and improve systems quickly.

## 1. Clarify Goals and Critical Flows

- Identify key user journeys and business capabilities that must be observable.
- For each, define what “healthy” looks like:
  - Latency, error rates, throughput, resource usage, data quality, and cost.
- Note SLOs or reliability targets where they exist.

## 2. Inventory Current Signals and Gaps

- List existing logs, metrics, and traces for the targeted areas.
- Map them to the **four golden signals** (latency, traffic, errors, saturation) and, for data, to observability pillars (freshness, volume, schema, quality, lineage).
- Identify blind spots, noisy signals, and missing correlations.

## 3. Design Metrics, Logs, and Traces

- Define a small, meaningful set of **service-level indicators (SLIs)** aligned to SLOs.
- Standardize logging patterns:
  - Structured logs with correlation IDs, key context fields, and severity levels.
- Decide where to add tracing:
  - Critical request paths, cross-service calls, data pipelines, and LLM/agent workflows.

## 4. Implement Instrumentation Patterns

- Integrate observability libraries and middleware at appropriate layers.
- Instrument at logical boundaries:
  - API handlers, message consumers, background jobs, pipeline stages.
- For LLM/AI systems, capture:
  - Model/provider, latency, token usage/cost, failure categories, and user feedback.

## 5. Design Dashboards and Alerts

- Create dashboards that:
  - Follow flows end-to-end rather than listing raw metrics.
  - Highlight SLOs, error spikes, and unusual patterns.
- Define alerting rules:
  - Thresholds, aggregation windows, and on-call rotations.
- Avoid alert fatigue:
  - Prioritize high-severity, actionable alerts with clear runbooks.

## 6. Govern Noise, Cost, and Privacy

- Periodically review high-volume logs and metrics:
  - Remove or sample low-value signals.
- Ensure observability data respects privacy and compliance constraints:
  - Avoid sensitive data in logs; use redaction and access controls.
- Monitor observability tooling costs and optimize storage and retention policies.

## 7. Review and Evolve Observability

- After major incidents or launches, revisit observability:
  - What signals helped? What was missing?
- Incorporate lessons into updated instrumentation, dashboards, and runbooks.
- Keep a lightweight observability roadmap aligned with product and infrastructure evolution.
