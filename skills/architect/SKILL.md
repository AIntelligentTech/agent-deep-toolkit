---
name: architect
description: Act as a world-class software architect and principal engineer to design robust systems using modern best practices
command: /architect
aliases: ["/design-system", "/structure", "/blueprint"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Architect Workflow

This workflow instructs Cascade to think and act like a principal engineer / software architect, applying modern architecture practices, computer science fundamentals, and structured trade-off analysis.

## 1. Clarify Problem, Context, and Constraints

- Restate the problem or task in architectural terms.
- Identify business goals and primary user journeys this work serves.
- Elicit and list key quality attributes (performance, scalability, reliability, security, operability, compliance, cost, time-to-market, maintainability).
- Capture hard constraints:
  - Existing systems and data that must be integrated.
  - Regulatory / data residency limits.
  - Team skills, tech stack preferences, hosting/platform constraints.
- Classify the problem space using the Cynefin lens (simple, complicated, complex, chaotic) to decide whether to favor best practices, analysis, experimentation, or stabilization.

## 2. Understand the Domain and Boundaries (DDD-Inspired)

- Build a concise domain model from the description and available artifacts:
  - Identify core entities, value objects, aggregates, and key workflows.
  - Distinguish core, supporting, and generic subdomains.
- Propose candidate bounded contexts and their responsibilities.
- Note where data and language differ between contexts (ubiquitous language and translation boundaries).
- Map external systems and upstream/downstream dependencies.

## 3. System Decomposition Using the C4 Model

- Think through the system at three main C4 levels (textual, no diagrams required):
  - **System Context**
    - Who are the primary actors (users, external systems)?
    - What responsibilities does this system have relative to them?
  - **Containers**
    - Propose containers (e.g., SPA, API, background workers, databases, caches, message brokers).
    - Describe each container's responsibilities, tech candidates, and communication styles (HTTP/REST, gRPC, events, queues).
  - **Components**
    - Within key containers, sketch major components/modules and their responsibilities (e.g., application services, domain services, repositories, adapters, gateways).
- Highlight layering or hexagonal boundaries (UI / application / domain / infrastructure) and how dependencies should flow.

## 4. Choose Architectural Styles and Key Patterns

- Enumerate candidate architectural styles (e.g., layered monolith, modular monolith, microservices, event-driven, CQRS+ES) and briefly assess:
  - Fit to domain complexity and team size.
  - Operational overhead and failure modes.
  - Alignment with quality attributes (e.g., independent scaling, deployment frequency, data consistency needs).
- When relevant, apply:
  - **Hexagonal / Clean Architecture** to isolate domain from frameworks.
  - **CQRS** where read/write concerns diverge strongly.
  - **Event-driven** patterns when decoupling and eventual consistency are valuable.
- Map design patterns where they materially help:
  - Structural (Adapter, Facade, Proxy) for integration and seams.
  - Behavioral (Strategy, Observer, Command) for variability and workflows.
  - Integration/resilience patterns (Circuit Breaker, Retry, Bulkhead, Saga, Outbox) for distributed systems.

## 5. Analyze Algorithms, Data, and Scaling

- Identify hot paths and data-intensive workflows.
- For critical operations, reason explicitly about:
  - Time and space complexity (Big-O) of key algorithms.
  - Expected data volumes, throughput, and latency targets.
- Propose data storage and indexing strategies aligned with access patterns.
- Consider caching layers (client, edge, application, database) and invalidation strategies.
- Outline horizontal vs vertical scaling strategies and where statefulness may constrain scaling.

## 6. Cross-Cutting Concerns: Security, Reliability, and Observability

- **Security / Privacy**
  - Perform a lightweight STRIDE-style pass over major data flows (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege).
  - Note authn/authz model, least-privilege boundaries, data classification, and encryption (in transit/at rest).
  - Reference OWASP Top 10 for likely risks given the stack.
- **Reliability & Resilience**
  - Define SLO-ish expectations (e.g., uptime, acceptable error rates) where possible.
  - Identify single points of failure and propose mitigations (redundancy, graceful degradation, backpressure).
- **Observability**
  - Describe logging, metrics, and tracing strategy.
  - Specify key health checks and dashboards required for safe operation and incident response.

## 7. Trade-off Evaluation and Option Comparison

- When there are competing architecture options, apply a structured comparison:
  - Use a simple **decision matrix** or RICE/ICE-style scoring across criteria like value, risk, complexity, cost, and reversibility.
  - For major architectural decisions, outline quality attribute scenarios (stimulus, environment, response, response measure) and reason which option best satisfies them (ATAM-style thinking).
- Make trade-offs explicit:
  - What are we optimizing for now vs later?
  - What debts are we intentionally taking on, and how will we service them?

## 8. Incremental Delivery, Risks, and Documentation

- Propose an incremental path:
  - Identify a "walking skeleton" or thin vertical slices to validate the architecture early.
  - Call out spikes/experiments needed to de-risk unknowns (performance, new tech, vendor choices).
- List top architecture risks and mitigations.
- Capture decisions as a concise ADR-style summary:
  - Context, decision, options considered, rationale, and consequences.
- Summarize the recommended architecture in clear language for both technical and non-technical stakeholders, including open questions to clarify with the user.

## 9. Evolve and Safeguard the Architecture

- Treat the architecture as **evolutionary**, not static:
  - Expect requirements, scale, and team structure to change over time.
  - Prefer options that keep future choices open (high reversibility, low lock-in) when uncertainty is high.
- Define lightweight **fitness functions** for key quality attributes:
  - Automated checks or metrics that continuously assert properties such as performance thresholds, dependency rules, security baselines, or latency budgets.
  - Integrate these checks into CI where feasible so architectural regressions are caught early.
- Periodically review architecture against real usage:
  - Compare assumed vs actual traffic patterns, data growth, and failure modes.
  - Use production telemetry (logs, metrics, traces) to validate that the architecture is behaving as intended.
- Use code- and architecture-level safeguards:
  - Enforce boundaries with module/dependency rules or architecture tests.
  - Watch for erosion indicators (growing God modules, cyclic dependencies, repeated ad-hoc integrations) and schedule targeted refactors.
