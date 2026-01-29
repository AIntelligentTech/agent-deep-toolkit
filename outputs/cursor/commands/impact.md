# Impact Workflow

This workflow instructs Cascade to perform a rigorous impact analysis before making or shipping changes, ensuring all downstream effects are understood.

## 1. Clarify the Change

- Restate what is changing:
  - Feature, refactor, migration, configuration, dependency update, policy change.
- Define the intended outcome and success criteria.
- Note the scope boundaries:
  - What is deliberately in and out of scope.

## 2. Map the Impact Surface

- Identify all areas potentially affected:
  - Code modules and services.
  - APIs and contracts.
  - Data schemas and stores.
  - Configuration and infrastructure.
  - Documentation and training materials.
  - External integrations.

## 3. Analyze Technical Impact

- **Code**: What files/modules change? What depends on them?
- **Performance**: Any effect on latency, throughput, resource usage?
- **Reliability**: Does this introduce new failure modes?
- **Security**: Any change to attack surface or trust boundaries?
- **Data**: Schema migrations, compatibility, backfill needs?

## 4. Analyze UX and Product Impact

- **User experience**: Does this change user flows or behaviors?
- **Accessibility**: Any impact on assistive technology users?
- **Documentation**: What user-facing docs need updating?
- **Feature flags**: Should this be gated for progressive rollout?

## 5. Analyze Data and Compliance Impact

- **Privacy**: Does this change what data is collected or how it's used?
- **Regulatory**: Any compliance implications (GDPR, etc.)?
- **Audit**: Are there audit log or reporting changes?

## 6. Evaluate Cost, Complexity, and Risk

- **Complexity**: How difficult is the change to implement and validate?
- **Cost**: Infrastructure costs, engineering time, opportunity cost?
- **Reversibility**: How easy is it to roll back?
- **Risk**: What could go wrong? What's the blast radius?

## 7. Synthesize Impact Assessment

- Summarize key impacts in a structured format.
- Highlight the highest-risk areas.
- Propose mitigation strategies.
- Recommend go/no-go based on analysis.

## 8. Prepare for Safe Propagation

- Define rollout strategy:
  - Phased, canary, feature-flagged?
- Set up monitoring for impact areas.
- Create rollback plan.
- Communicate changes to affected stakeholders.