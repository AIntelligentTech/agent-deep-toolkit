---
name: observe
description: Design and evolve robust observability for applications, data, and AI systems
command: /observe
aliases: ["/observability", "/monitor", "/metrics"]
synonyms: ["/observability", "/monitoring", "/monitored", "/monitors", "/metrics", "/telemetry", "/logging", "/tracing"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Observe Workflow

<scope_constraints>
This workflow instructs Cascade to help design and evolve observability that enables fast debugging, reliable operations, and continuous improvement. Covers metrics, logs, and traces across applications, data pipelines, and AI systems.
</scope_constraints>

<context>
Observability answers critical operational questions: Is the system healthy? Why is it slow or broken? What's the user experience? Three pillars—metrics, logs, traces—form the foundation. Effective observability requires intentional design, appropriate instrumentation, and governance to manage cost and noise.
</context>

<instructions>

## Inputs

- Current observability landscape: What's already in place (tools, dashboards, alerts)?
- Key questions: What must observability answer (health, performance, user experience)?
- System scope: Applications, data systems, infrastructure, or AI components?
- Stakeholders: Who consumes observability (SREs, developers, product, business)?
- Constraints: Budget, retention requirements, tool choices, SLO targets

## Step 1: Clarify Observability Goals

- Define what questions observability should answer:
  - Is the system healthy?
  - Why is it slow/broken?
  - What's the user experience?
- Align with SLOs and business metrics.
- Identify who consumes observability data:
  - SREs, developers, product, business.

### Step 2: Inventory Current Signals

- Audit existing observability:
  - What metrics, logs, and traces exist?
  - What gaps prevent answering key questions?
- Assess tool landscape:
  - What's in place (Prometheus, Grafana, Datadog, etc.)?
  - Are they well-utilized?

### Step 3: Design the Three Pillars

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

### Step 4: Implement Instrumentation

- Add instrumentation to code:
  - Custom metrics, structured logging, span creation.
- Use auto-instrumentation where available.
- Ensure minimal performance overhead.

### Step 5: Design Dashboards and Alerts

- Create dashboards for different audiences:
  - Executive overview, service health, debugging.
- Set up alerts that are actionable:
  - Alert on symptoms, not just causes.
  - Reduce noise; every alert should require action.
- Document escalation paths.

### Step 6: Govern Noise, Cost, and Privacy

- Monitor observability costs.
- Tune sampling and retention.
- Ensure PII is not logged inappropriately.
- Review and prune unused dashboards and alerts.

### Step 7: Review and Evolve

- Conduct regular observability reviews.
- Update instrumentation as systems change.
- Learn from incidents to improve coverage.

## Error Handling

- **Missing signals:** Identify specific gaps, add instrumentation, test collection in staging
- **Alert fatigue:** Review alert rules, reduce noise by alerting on symptoms not causes, retune thresholds
- **Cost overruns:** Adjust sampling rates, retention policies, or reduce cardinality in metrics
- **Privacy violations:** Mask PII from logs, audit sensitive fields, implement field-level redaction

</instructions>

<output_format>

Provide a complete observability design as the output:

1. **Observability Goals**: Key questions observability must answer
2. **Three Pillars Design**: Metrics strategy (SLIs, RED or USE), logs strategy (structure, levels), traces strategy (sampling, propagation)
3. **Instrumentation Plan**: What to instrument, where, and how
4. **Dashboard and Alert Design**: Who sees what, alert rules with thresholds
5. **Governance Plan**: Cost management, PII protection, review cadence

</output_format>
