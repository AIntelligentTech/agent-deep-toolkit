---
name: followup
description: Propose, refine, and prioritize follow-up work based on current tasks, progress, and roadmap
command: /followup
aliases: ["/next", "/nextsteps"]
synonyms: ["/following-up", "/followed-up", "/next-steps"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Followup Workflow

This workflow instructs Cascade to systematically identify and prioritize follow-up work, ensuring momentum continues after completing tasks.

<scope_constraints>
**Operational Boundaries:**
- Scope: Identifying, evaluating, and prioritizing follow-up work
- Modes: Gap analysis, idea generation, prioritization, task creation
- Defaults: Prioritize critical issues first; group related work; plan in phases
- Not in scope: Executing follow-up work (defer to specific skills like /code, /deploy, etc.)
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Understanding of completed work and what was delivered
- Knowledge of roadmap and strategic priorities
- Visibility into team capacity and commitments
- Access to feedback and issue tracking systems
- Understanding of technical debt and system health
</context>

<instructions>

## Inputs
- Completed work or current progress
- Remaining requirements or gaps
- Discovered issues and feedback
- Roadmap and strategic priorities
- Team capacity and constraints

## Steps

### Step 1: Understand Current Context

- Review what was just completed:
  - Feature, fix, refactor, investigation, or other work.
- Note any loose ends:
  - Deferred decisions, technical debt items, documented TODOs.
- Check related tickets and documentation.

### Step 2: Analyze Outcomes and Gaps

- Assess the completeness of the work:
  - Does it fully meet requirements?
  - Are there edge cases not covered?
  - What's the test coverage?
- Identify discovered issues:
  - Bugs found, performance concerns, usability issues.
- Note feedback received.

### Step 3: Generate Follow-Up Ideas

- Categories to consider:
  - **Immediate**: Critical fixes or missing pieces.
  - **Enhancement**: Improvements to what was built.
  - **Related**: Adjacent features or refactors.
  - **Technical**: Debt, observability, documentation.
  - **Learning**: Skills or knowledge gaps to address.
- Include ideas from team discussions and user feedback.

### Step 4: Evaluate and Prioritize

- For each follow-up item, assess:
  - Value: Impact on users, business, or technical health.
  - Effort: Complexity and time required.
  - Urgency: Time-sensitivity.
  - Dependencies: What must happen first.
- Group related items.
- Use simple prioritization frameworks (MoSCoW, ICE, etc.).

### Step 5: Translate to Concrete Next Steps

- Convert top priorities to actionable items:
  - Tickets, tasks, or backlog items.
  - Clear descriptions and acceptance criteria.
- Assign ownership where possible.
- Set timelines or milestones.

### Step 6: Communicate and Track

- Share follow-up plan with stakeholders.
- Ensure items are tracked in the team's system.
- Schedule check-ins to review progress.

## Error Handling

- **Too many follow-up items**: Ruthlessly prioritize; consider what can be deferred; escalate capacity constraints
- **Conflicting priorities**: Surface explicitly; use decision-making framework (refer to /decide skill); align with roadmap
- **Unclear ownership**: Assign explicitly; confirm with owner; escalate if no one takes ownership
- **Moving target**: Document current state; schedule regular review checkpoints; adjust priorities as needed

</instructions>

<output_format>
**Deliverables:**
- Summary of completed work and current state
- Gap analysis identifying unfulfilled requirements
- List of discovered issues and improvement opportunities
- Follow-up ideas grouped by category
- Prioritized list with rationale
- Concrete next steps with owners and timelines
- Communication plan for sharing with stakeholders
- Tracking mechanism in team system (tickets, backlog, etc.)
</output_format>
