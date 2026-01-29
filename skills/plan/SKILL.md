---
name: plan
description: Create structured implementation plans with phases, dependencies, milestones, and risk mitigation
command: /plan
aliases: ["/roadmap", "/schedule"]
synonyms: ["/planning", "/planned", "/plans", "/strategy"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Plan Workflow

This workflow instructs Cascade to create comprehensive, actionable implementation plans that guide complex work from start to completion.

## 1. Clarify Goals and Success Criteria

- Restate the objective clearly:
  - What are we trying to achieve?
  - What does "done" look like?
- Define success criteria:
  - Measurable outcomes.
  - Quality expectations.
- Identify constraints:
  - Timeline, budget, resources, dependencies.

## 2. Break Down into Phases

- Divide work into logical phases:
  - Each phase has a clear deliverable.
  - Phases build on each other sensibly.
- Consider:
  - Foundation/setup phase.
  - Core implementation phases.
  - Integration and testing phase.
  - Polish and documentation phase.
  - Rollout phase.

## 3. Identify Dependencies and Sequencing

- Map dependencies between tasks:
  - What must happen before what?
  - What can happen in parallel?
- Identify the critical path:
  - Tasks that directly impact timeline.
- Note external dependencies:
  - Other teams, third parties, approvals.

## 4. Estimate Effort and Duration

- For each task, estimate:
  - Effort (person-hours or story points).
  - Duration (calendar time accounting for constraints).
- Apply estimation techniques:
  - Analogous estimation (based on similar past work).
  - Three-point estimation (optimistic, likely, pessimistic).
- Build in buffer for uncertainty.

## 5. Assign Resources and Ownership

- Identify who will do what:
  - Skills required for each task.
  - Availability and constraints.
- Assign clear ownership:
  - One person accountable per task.
- Consider parallel workstreams.

## 6. Define Milestones and Checkpoints

- Set key milestones:
  - Meaningful achievements, not just dates.
- Define review checkpoints:
  - When to assess progress and adjust.
- Identify go/no-go decision points.

## 7. Identify Risks and Mitigations

- List potential risks:
  - Technical, resource, dependency, timeline risks.
- For each risk:
  - Likelihood and impact.
  - Mitigation strategy.
  - Contingency plan.
- Identify early warning signs.

## 8. Create the Plan Artifact

- Document the plan in appropriate format:
  - Gantt chart, task list, timeline view.
- Include:
  - Overview and goals.
  - Phase breakdown with tasks.
  - Timeline and milestones.
  - Resource assignments.
  - Risk register.
  - Assumptions and dependencies.

## 9. Communicate and Track

- Share the plan with stakeholders.
- Set up tracking:
  - Task management system.
  - Progress reporting cadence.
- Plan for updates:
  - How and when will the plan be revised?
