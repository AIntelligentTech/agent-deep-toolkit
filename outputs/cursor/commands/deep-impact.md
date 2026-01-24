# Deep Impact Workflow

This workflow instructs Cascade to perform a structured impact assessment for a proposed change, before implementation or propagation. It synthesizes architecture, code, UX, ops, and governance considerations.

## 1. Clarify the Proposed Change and Context

- Restate the change in concrete terms:
  - What is being changed (API, data model, component, service, infra, process)?
  - Is this a new addition, a modification, or a removal?
- Capture scope and intent:
  - Why is this change being made (goal, pain point, opportunity)?
  - What is the desired outcome and time horizon?
- Use `/deep-spec` if the change is large or ambiguous and needs clearer specification.

## 2. Map the Impact Surface

- Apply `/deep-architect` to understand where this change sits in the architecture:
  - Which bounded contexts, services, modules, and external systems are involved?
  - What interfaces, contracts, or shared schemas might be affected?
- Use `/deep-explore` to locate and trace:
  - Entry points, call chains, and critical code paths touched by the change.
  - Shared utilities, feature flags, or configuration that influence behavior.
- Identify stakeholders and consumers:
  - Upstream and downstream systems, user types, teams, and workflows depending on this behavior.

## 3. Analyze Technical Impact Dimensions

- **Correctness and Behavior**
  - What existing behaviors must be preserved vs intentionally changed?
  - Which edge cases and failure modes are at risk? (Apply `/deep-think`.)
- **Performance and Scalability**
  - Use `/deep-optimize` thinking:
    - How might this affect latency, throughput, memory, or resource usage?
    - Are there new hot paths, larger payloads, or more expensive queries?
- **Code Quality and Design**
  - From `/deep-code` and `/deep-refactor` lenses:
    - Does this change simplify or complicate responsibilities, cohesion, and coupling?
    - Are new abstractions needed to avoid ad hoc special cases?

## 4. Analyze UX, Product, and Data Impact

- **UX and Product**
  - With `/deep-ux` in mind:
    - Does this change alter flows, states, or microcopy for users?
    - Are there new failure states, loading patterns, or accessibility concerns?
- **Data and Schema**
  - Apply `/deep-data`:
    - Any schema changes, new fields, or modified semantics?
    - Impact on historical data, migrations, and backward compatibility?
- **Analytics and Observability**
  - With `/deep-observability`:
    - Do existing metrics and logs still make sense?
    - Do we need new signals to detect regressions specific to this change?

## 5. Assess Security, Compliance, and Governance Impact

- Use `/deep-threat-model`:
  - Does the change alter trust boundaries, exposed surfaces, or data sensitivity?
  - Could it introduce new STRIDE risks (Spoofing, Tampering, etc.)?
- Apply `/deep-ethics` and `/deep-regulation` where relevant:
  - Any changes to how data is collected, stored, or processed that impact privacy or regulatory obligations?
  - Any AI-specific risks (bias, misuse, lack of transparency) introduced or amplified?

## 6. Evaluate Cost, Complexity, and Risk

- From `/deep-consider` and `/deep-decision`:
  - **Cost:** implementation time, infra/runtime cost, maintenance overhead.
  - **Complexity:** cognitive load for future maintainers, conceptual burden added.
  - **Risk:** likelihood and severity of regressions, blast radius, reversibility.
- Consider alternative options (or doing nothing) using `/deep-alternative` once available.

## 7. Synthesize Findings and Recommend a Path

- Summarize impact across dimensions:
  - Technical (correctness, performance, design), UX/product, data, security/compliance, cost.
- Propose options:
  - Proceed as proposed, proceed with modifications, run experiment first, or defer.
- Use `/deep-decision` to select a recommendation and define:
  - Guardrails (metrics, thresholds, feature flags).
  - Preconditions and explicit "stop/rollback" conditions.

## 8. Prepare for Safe Propagation

- If the change is approved in principle, prepare inputs for `/deep-propagate`:
  - List of code modules, services, configs, and infra components to update.
  - Affected tests, docs, and observability assets.
  - Rollout strategy (flags, canary, staged deployment).
- Ensure that `/deep-test` has a clear mandate:
  - Which tests to add or strengthen to cover the areas of highest impact.
