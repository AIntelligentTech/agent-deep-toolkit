---
description: Design and evolve robust observability for applications, data, and AI
  systems
auto_execution_mode: 2
---

# Observe Workflow

This workflow instructs Cascade to help design and evolve observability that enables fast debugging, reliable operations, and continuous improvement.

## 1. Clarify Observability Goals

- Define what questions observability should answer:
  - Is the system healthy?
  - Why is it slow/broken?
  - What's the user experience?
- Align with SLOs and business metrics.
- Identify who consumes observability data:
  - SREs, developers, product, business.

## 2. Inventory Current Signals

- Audit existing observability:
  - What metrics, logs, and traces exist?
  - What gaps prevent answering key questions?
- Assess tool landscape:
  - What's in place (Prometheus, Grafana, Datadog, etc.)?
  - Are they well-utilized?

## 3. Design the Three Pillars

### Metrics
- Define SLIs (Service Level Indicators):
  - Latency, error rate, throughput, saturation.
- Use RED (Rate, Errors, Duration) for services.
- Use USE (Utilization, Saturation, Errors) for resources.
- Establish baselines and set meaningful thresholds.

### Logs
- Structure logs consistently:
  - JSON format, correlation IDs, consistent fields.
- Define log levels appropriately.
- Ensure logs are searchable and retained appropriately.

### Traces
- Implement distributed tracing for request flows.
- Propagate context across service boundaries.
- Sample appropriately to manage cost.

## 4. Implement Instrumentation

- Add instrumentation to code:
  - Custom metrics, structured logging, span creation.
- Use auto-instrumentation where available.
- Ensure minimal performance overhead.

## 5. Design Dashboards and Alerts

- Create dashboards for different audiences:
  - Executive overview, service health, debugging.
- Set up alerts that are actionable:
  - Alert on symptoms, not just causes.
  - Reduce noise; every alert should require action.
- Document escalation paths.

## 6. Govern Noise, Cost, and Privacy

- Monitor observability costs.
- Tune sampling and retention.
- Ensure PII is not logged inappropriately.
- Review and prune unused dashboards and alerts.

## 7. Review and Evolve

- Conduct regular observability reviews.
- Update instrumentation as systems change.
- Learn from incidents to improve coverage.