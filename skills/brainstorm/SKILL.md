---
name: brainstorm
description: Generate and evaluate innovative ideas, alternatives, and creative solutions grounded in context and constraints
command: /brainstorm
aliases: ["/ideas", "/alternatives", "/ideate"]
synonyms: ["/brainstorming", "/brainstormed", "/brainstorms", "/ideating", "/ideated", "/ideates"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: explore
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Brainstorm Workflow

This workflow combines divergent idea generation with structured evaluation, helping teams explore alternatives and prioritize the most promising directions.

<scope_constraints>
- Focuses on structured brainstorming with divergence and convergence phases
- Applies to feature ideation, problem-solving, process improvement, and strategic direction
- Combines idea generation with feasibility evaluation
- Includes prioritization and connection to execution workflows
- Not a replacement for detailed planning or decision-making (use `/decide` for formal decisions)
</scope_constraints>

<context>
**Dependencies:**
- Clear problem statement or challenge area
- Awareness of business context and constraints
- Knowledge of current solutions and industry practices
- Understanding of feasibility factors (budget, time, team skills)
- Access to relevant stakeholders or expertise

**Prerequisites:**
- Defined problem space and what success looks like
- Articulated constraints (time, budget, technology, regulatory)
- Knowledge of current state and pain points
- Understanding of what makes ideas valuable in this context
</context>

<instructions>

## Inputs

- Problem or challenge to brainstorm solutions for
- Current state and pain points
- Target outcomes or success criteria
- Constraints (time, budget, technology, team skills, regulatory)
- Stakeholder perspectives and priorities
- Existing solutions or competitive landscape

## Steps

### Step 1: Clarify the Problem Space

- Define what you're brainstorming for:
  - New feature, solution to a problem, process improvement, strategic direction.
- Articulate constraints:
  - Time, budget, technology, team skills, regulatory.
- Distinguish between negotiable and non-negotiable constraints.

### Step 2: Ground in Current Reality

- Understand the current state:
  - Existing solutions, pain points, user feedback.
- Research current trends:
  - Use `/search` to find relevant patterns, tools, and industry practices.
- Identify what's working and what's not.

### Step 3: Generate Ideas Broadly (Diverge)

- Aim for quantity over quality initially.
- Use multiple frames to stimulate ideas:
  - **Analogies**: How do other industries solve similar problems?
  - **Extremes**: What if we had unlimited resources? What if we had none?
  - **Inversion**: What would make this problem worse? Now, do the opposite.
  - **User perspectives**: What would different users want?
  - **Technology**: What new capabilities could we leverage?
- Include wild ideas—they often spark practical ones.
- Record all ideas without judgment.

### Step 4: Evaluate and Refine (Converge)

- Group similar ideas.
- Evaluate against criteria:
  - Value/impact, feasibility, alignment with goals.
  - Risk, reversibility, learning potential.
- Use `/decide` techniques for important decisions:
  - Decision matrix, cost-benefit, pre-mortem.
- Identify ideas worth exploring further.

### Step 5: Prioritize and Define Next Steps

- Rank top ideas by potential and feasibility.
- For the most promising:
  - Define what would need to be true for this to work.
  - Identify quick experiments or prototypes to validate.
  - Assign ownership and timeline.
- Capture rejected ideas with rationale (they may be useful later).

### Step 6: Connect to Execution

- Translate selected ideas into:
  - Specs (`/spec`) for detailed design.
  - Implementation plans (`/plan`) for execution.
  - Experiments (`/experiment`) for validation.
- Set up checkpoints to revisit and iterate.

## Error Handling

**Common brainstorming pitfalls:**
- Premature evaluation killing idea generation
- Over-focus on feasibility without exploring possibilities
- Groupthink or dominant voices suppressing diverse ideas
- Failing to ground ideas in actual constraints
- No clear path from brainstorm to execution

**Mitigation strategies:**
- Separate divergence (idea generation) from convergence (evaluation) phases
- Explicitly invite wild ideas and unconventional perspectives
- Ground all ideas in real constraints, not assumptions
- Use structured evaluation frameworks to make decisions transparent
- Assign owners and timelines for follow-up on selected ideas

</instructions>

<output_format>

The output of this skill is a **prioritized set of ideas with next steps** that includes:

1. **Problem Definition** — Challenge, context, constraints, and success criteria
2. **Current State Analysis** — Existing solutions, pain points, and opportunities
3. **Generated Ideas** — Diverse solutions across multiple frames or perspectives
4. **Evaluation Framework** — Criteria used to assess ideas (impact, feasibility, risk, etc.)
5. **Prioritized Shortlist** — Top 3-5 ideas ranked by potential and effort
6. **Detailed Exploration** — For top ideas: what needs to be true, experiments to validate
7. **Action Items** — Owner, timeline, and success criteria for each selected idea
8. **Rejected Ideas Log** — Ideas not selected with brief rationale (for future reference)

Deliverables typically include:
- Brainstorm summary document with all ideas listed
- Evaluation matrix (ideas vs. criteria)
- Top ideas with detailed exploration
- Roadmap connecting brainstorm to execution workflows
- Optional: Innovation pipeline or idea tracking system

</output_format>
