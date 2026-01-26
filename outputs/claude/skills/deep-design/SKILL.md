---
name: deep-design
description: Apply structured product and interaction design thinking (Double Diamond) to shape solutions before implementation
user-invocable: true
---
# Deep Design Workflow

This workflow instructs Cascade to use modern design-thinking patterns to move from problem to solution in a disciplined way.

## 1. Discover: Understand Problem and Context

- Clarify business goals and success metrics.
- Identify primary users and their tasks.
- Review existing product behavior, analytics, and support insights.
- Use `search_web` where needed to explore comparable products and patterns.

## 2. Define: Frame the Right Problem

- Synthesize findings into:
  - Problem statements and user needs.
  - Constraints and non-goals.
- Map user journeys and key moments that matter.
- Prioritize which part of the journey to address first.

## 3. Develop: Explore Solution Space

- Generate multiple solution ideas, not just one.
- Use variations that trade off complexity vs value.
- Sketch information architecture and interaction flows at a coarse level.
- Consider cross-platform implications (web, mobile, responsive breakpoints) if relevant.

## 4. Deliver: Converge and Specify

- Choose a direction based on value, feasibility, and risk.
- Elaborate the chosen solution:
  - Screen/flow narratives, states, and edge cases.
  - Component hierarchy and layout for implementation.
- Capture constraints and open questions explicitly.

## 5. Prepare for Implementation

- Translate design decisions into artifacts developers can use:
  - Annotated mockups, component specs, acceptance criteria, UX success measures.
- Highlight dependencies and sequencing (what can be built first, what can be stubbed).
- Ensure that key UX flows are clearly documented and testable.

## 6. Plan for Validation and Iteration

- Define how success will be measured after release:
  - UX metrics, behavioral analytics, qualitative feedback.
- Propose small experiments or A/B tests where appropriate.
- Capture a short design rationale so future changes can understand trade-offs made today.
