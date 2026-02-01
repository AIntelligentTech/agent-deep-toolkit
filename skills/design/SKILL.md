---
name: design
description: Apply structured product and interaction design thinking (Double Diamond) to shape solutions before implementation
command: /design
synonyms: ["/designing", "/designed", "/designs", "/shaping"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Design Workflow

This workflow instructs Cascade to use modern design-thinking patterns to move from problem to solution in a disciplined way.

<scope_constraints>
**Operational Boundaries:**
- Scope: Product and interaction design using Double Diamond methodology
- Modes: User research, problem definition, solution exploration, specification
- Defaults: Prioritize user research; generate multiple solutions before choosing one; document rationale
- Not in scope: Visual design or brand guidelines; implementation (defer to /code skill)
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Business goals and success metrics
- User/stakeholder access for research and validation
- Analytics data and existing product behavior
- Understanding of technical constraints and feasibility
- Team alignment on process and decision criteria
</context>

<instructions>

## Inputs
- Business goals and context
- User problems or opportunities
- Constraints and success criteria
- Available resources and timeline
- Technical and platform considerations

## Steps

### Step 1: Discover: Understand Problem and Context

- Clarify business goals and success metrics.
- Identify primary users and their tasks.
- Review existing product behavior, analytics, and support insights.
- Use `search_web` where needed to explore comparable products and patterns.

### Step 2: Define: Frame the Right Problem

- Synthesize findings into:
  - Problem statements and user needs.
  - Constraints and non-goals.
- Map user journeys and key moments that matter.
- Prioritize which part of the journey to address first.

### Step 3: Develop: Explore Solution Space

- Generate multiple solution ideas, not just one.
- Use variations that trade off complexity vs value.
- Sketch information architecture and interaction flows at a coarse level.
- Consider cross-platform implications (web, mobile, responsive breakpoints) if relevant.

### Step 4: Deliver: Converge and Specify

- Choose a direction based on value, feasibility, and risk.
- Elaborate the chosen solution:
  - Screen/flow narratives, states, and edge cases.
  - Component hierarchy and layout for implementation.
- Capture constraints and open questions explicitly.

### Step 5: Prepare for Implementation

- Translate design decisions into artifacts developers can use:
  - Annotated mockups, component specs, acceptance criteria, UX success measures.
- Highlight dependencies and sequencing (what can be built first, what can be stubbed).
- Ensure that key UX flows are clearly documented and testable.

### Step 6: Plan for Validation and Iteration

- Define how success will be measured after release:
  - UX metrics, behavioral analytics, qualitative feedback.
- Propose small experiments or A/B tests where appropriate.
- Capture a short design rationale so future changes can understand trade-offs made today.

## Error Handling

- **Insufficient user research**: Pause design; conduct focused interviews or surveys; define minimum viable research scope
- **Conflicting stakeholder priorities**: Surface trade-offs explicitly; create weighted criteria; present multiple options with trade-offs
- **Technical feasibility unclear**: Spike technical approach early; raise constraints to design team; iterate design if needed
- **Over-scoped solution**: Break into phases; deliver MVP first; plan Phase 2 with additional complexity

</instructions>

<output_format>
**Deliverables:**
- Research summary (user needs, business goals, competitive landscape)
- Problem statement and user journey map
- 3+ solution concepts with sketches/wireframes
- Selected solution with annotated mockups
- Component specifications and interaction flows
- Acceptance criteria and success metrics
- Design rationale and trade-off documentation
- Implementation handoff guide with dependencies and sequencing
- Validation and iteration plan post-launch
</output_format>
