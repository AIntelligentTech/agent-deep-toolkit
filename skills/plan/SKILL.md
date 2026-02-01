---
name: plan
description: Create structured implementation plans with phases, dependencies, milestones, and risk mitigation
command: /plan
aliases: ["/roadmap", "/schedule"]
synonyms: ["/planning", "/planned", "/plans", "/strategy"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Plan Workflow

<scope_constraints>
This workflow instructs Cascade to create comprehensive, actionable implementation plans that guide complex work from start to completion. Covers goal clarification, phasing, dependency mapping, estimation, resource allocation, milestone definition, and risk management.
</scope_constraints>

<context>
Good plans reduce uncertainty, align stakeholders, and enable tracking. Plans should be detailed enough to guide work but flexible enough to accommodate learning. They balance optimism with contingency and expose dependencies early.
</context>

<instructions>

## Inputs

- Objective: What needs to be accomplished?
- Current state: Where are we starting from?
- Constraints: Timeline, budget, resources, dependencies
- Success criteria: What does "done" look like?
- Stakeholders: Who is affected and needs alignment?

## Step 1: Clarify Goals and Success Criteria

- Restate the objective clearly:
  - What are we trying to achieve?
  - What does "done" look like?
- Define success criteria:
  - Measurable outcomes.
  - Quality expectations.
- Identify constraints:
  - Timeline, budget, resources, dependencies.

### Step 2: Break Down into Phases

- Divide work into logical phases:
  - Each phase has a clear deliverable.
  - Phases build on each other sensibly.
- Consider:
  - Foundation/setup phase.
  - Core implementation phases.
  - Integration and testing phase.
  - Polish and documentation phase.
  - Rollout phase.

### Step 3: Identify Dependencies and Sequencing

- Map dependencies between tasks:
  - What must happen before what?
  - What can happen in parallel?
- Identify the critical path:
  - Tasks that directly impact timeline.
- Note external dependencies:
  - Other teams, third parties, approvals.

### Step 4: Estimate Effort and Duration

- For each task, estimate:
  - Effort (person-hours or story points).
  - Duration (calendar time accounting for constraints).
- Apply estimation techniques:
  - Analogous estimation (based on similar past work).
  - Three-point estimation (optimistic, likely, pessimistic).
- Build in buffer for uncertainty.

### Step 5: Assign Resources and Ownership

- Identify who will do what:
  - Skills required for each task.
  - Availability and constraints.
- Assign clear ownership:
  - One person accountable per task.
- Consider parallel workstreams.

### Step 6: Define Milestones and Checkpoints

- Set key milestones:
  - Meaningful achievements, not just dates.
- Define review checkpoints:
  - When to assess progress and adjust.
- Identify go/no-go decision points.

### Step 7: Identify Risks and Mitigations

- List potential risks:
  - Technical, resource, dependency, timeline risks.
- For each risk:
  - Likelihood and impact.
  - Mitigation strategy.
  - Contingency plan.
- Identify early warning signs.

### Step 8: Create the Plan Artifact

- Document the plan in appropriate format:
  - Gantt chart, task list, timeline view.
- Include:
  - Overview and goals.
  - Phase breakdown with tasks.
  - Timeline and milestones.
  - Resource assignments.
  - Risk register.
  - Assumptions and dependencies.

### Step 9: Communicate and Track

- Share the plan with stakeholders.
- Set up tracking:
  - Task management system.
  - Progress reporting cadence.
- Plan for updates:
  - How and when will the plan be revised?

## Error Handling

- **Plan is too vague:** Add more detail to phases and tasks, break down larger items
- **Estimates are consistently wrong:** Adjust estimation technique, calibrate against actual results
- **Dependencies discovered late:** Add dependency mapping earlier, ask "what must happen first?"
- **Critical path is unclear:** Use CPM analysis, identify tasks that impact timeline directly
- **Resources unavailable as planned:** Identify slack time, parallelize work, adjust timeline

</instructions>

<output_format>

Provide a complete implementation plan as the output:

1. **Goal Summary**: Objective, success criteria, constraints
2. **Phase Breakdown**: 3-5 phases with deliverables and sequence
3. **Detailed Task List**: Tasks per phase with effort estimates and dependencies
4. **Timeline**: Gantt chart or timeline view with milestones
5. **Resource Plan**: Who does what, skill requirements, availability
6. **Risk Register**: Identified risks, likelihood, impact, mitigations
7. **Assumptions and Dependencies**: External factors, decision points

</output_format>
