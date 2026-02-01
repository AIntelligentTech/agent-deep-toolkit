---
name: estimate
description: Effort estimation, complexity analysis, and time/resource planning
command: /estimate
aliases: ["/scope", "/sizing"]
synonyms: ["/estimating", "/estimated", "/estimates", "/estimation", "/scoping", "/scoped", "/sizing"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Estimate Workflow

This workflow instructs Cascade to provide thoughtful, realistic estimates that account for uncertainty and complexity.

<scope_constraints>
**Operational Boundaries:**
- Scope: Effort, duration, resource, and complexity estimation
- Modes: Decomposition, three-point estimation, analogous estimation, risk assessment
- Defaults: Always provide ranges with assumption documentation; account for hidden work; apply buffers based on uncertainty
- Not in scope: Commitment to specific dates (estimation is input to planning); changing scope mid-estimate
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Clear work definition and requirements
- Historical data from similar past work (analogous estimation)
- Understanding of team velocity and typical hidden work percentages
- Identified technical unknowns and risks
- Available resources and constraints
</context>

<instructions>

## Inputs
- Work to be estimated (feature, task, project)
- Type of estimate needed (effort, duration, resources)
- Purpose for estimate (planning, commitment, budgeting)
- Known constraints and risks
- Historical baseline data (if available)

## Steps

### Step 1: Clarify What's Being Estimated

- Define the work:
  - Specific feature, project, or task.
- Identify what estimate is needed:
  - Effort (person-hours, story points).
  - Duration (calendar time).
  - Resources (people, infrastructure, budget).
- Understand the purpose:
  - Planning, prioritization, commitment, budgeting.

### Step 2: Break Down the Work

- Decompose into estimable units:
  - Features → tasks → subtasks.
- Aim for tasks small enough to estimate confidently:
  - Generally 1-3 days or less.
- Identify all activities:
  - Design, implementation, testing, documentation.
  - Reviews, meetings, coordination.

### Step 3: Assess Complexity Factors

For each component, consider:

- **Technical complexity**:
  - Known vs novel technology.
  - Algorithmic difficulty.
  - Integration touchpoints.
- **Uncertainty**:
  - Requirements clarity.
  - Technical unknowns.
  - External dependencies.
- **Risk factors**:
  - Performance requirements.
  - Security considerations.
  - Regulatory constraints.

### Step 4: Apply Estimation Techniques

#### Analogous Estimation
- Compare to similar past work.
- Adjust for differences.

#### Three-Point Estimation
- Best case (everything goes right).
- Likely case (realistic expectations).
- Worst case (significant problems).
- Expected = (Best + 4×Likely + Worst) / 6

#### T-Shirt Sizing
- Relative sizing for quick comparisons.
- XS, S, M, L, XL.

#### Planning Poker
- Team-based estimation for consensus.

### Step 5: Account for Hidden Work

Add time for:
- Meetings and communication (15-20%).
- Code reviews and rework.
- Testing and bug fixes.
- Documentation.
- Deployment and monitoring setup.
- Learning curves.

### Step 6: Add Appropriate Buffer

- Low uncertainty: 10-20% buffer.
- Medium uncertainty: 30-50% buffer.
- High uncertainty: 50-100% buffer or spike first.

### Step 7: Present the Estimate

- Provide a range, not a single number:
  - "Most likely 3-5 days, could extend to 8 days if X."
- State assumptions explicitly.
- Identify risks that could affect the estimate.
- Note dependencies.

### Step 8: Track and Improve

- Compare estimates to actuals.
- Analyze variances:
  - What was underestimated?
  - What was unexpected?
- Improve estimation over time.

## Error Handling

- **Scope creep during estimation**: Document out-of-scope items; clarify boundaries before estimating; offer separate estimate for additions
- **High uncertainty**: Create spike estimate for research phase; escalate decision on whether to proceed with full estimate
- **Stakeholder pressure for specific date**: Communicate estimate range and assumptions; offer options (reduce scope, extend timeline, add resources)
- **Historical data unavailable**: Use team's best judgment with three-point estimation; capture estimate quality for future reference

</instructions>

<output_format>
**Deliverables:**
- Work breakdown structure with tasks and subtasks
- Complexity assessment for each major component
- Estimation using selected technique(s)
- Hidden work and buffer calculations
- Estimate range with best, likely, and worst cases
- Explicit assumptions and dependencies
- Risk factors that could affect the estimate
- Improvement recommendations for future estimation
</output_format>
