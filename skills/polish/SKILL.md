---
name: polish
description: Refine products and interfaces to a world-class level of craft and cohesion
command: /polish
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Polish Workflow

This workflow instructs Cascade to apply craft, attention to detail, and systematic refinement to elevate a product or interface to world-class quality.

## 1. Clarify What "Polish" Means Here

- Define the scope:
  - A single component, a feature surface, a full page, or the entire product.
- Clarify the polish goals:
  - Visual consistency, interaction smoothness, clarity of messaging, performance feel, brand alignment, accessibility edge cases.
- Note constraints:
  - Timeline, design system boundaries, platform limitations.

## 2. Diagnose Rough Edges and Jank

- Walk through the experience systematically:
  - Inspect each element for alignment, spacing, sizing, color consistency, and animation smoothness.
- Note glitches and inconsistencies:
  - Visual jank, abrupt transitions, orphaned pixels, hover/focus issues, off-brand copy.
- Capture friction in flows:
  - Confusing states, unclear actions, ambiguous feedback.

## 3. Polish Layout, Spacing, and Visual Hierarchy

- Apply a consistent grid and spacing scale derived from `/tokens`.
- Ensure visual hierarchy clearly guides attention:
  - Primary actions stand out; secondary and tertiary elements recede.
- Refine alignment:
  - Text baselines, icon/button centers, card edges.

## 4. Refine States, Transitions, and Feedback

- Review component states:
  - Default, hover, focus, active, disabled, loading, empty, error.
- Ensure smooth, purposeful transitions:
  - Micro-animations reinforce meaning, not distract.
- Verify feedback clarity:
  - Users always know what happened and what to do next.

## 5. Polish Microcopy and Labels

- Review every piece of text:
  - Buttons, labels, placeholders, errors, empty states, tooltips.
- Apply consistent voice and terminology.
- Eliminate jargon, ambiguity, and redundancy.

## 6. Address Behavioral, Performance, and Responsiveness Issues

- Ensure snappy interactions:
  - No visible lag between user action and feedback.
- Test across devices, breakpoints, and input modes.
- Verify touch targets, scroll behavior, and resize behavior.

## 7. Ensure Cohesion with Design System and Brand

- Cross-check all elements against design tokens and guidelines.
- Ensure brand expression is consistent and intentional.
- Flag deviations for intentional exceptions or fixes.

## 8. Validate with Users and Stakeholders

- If possible, observe real users interacting with the polished surface.
- Collect feedback on feel, clarity, and delight.
- Iterate based on observations.

## 9. Capture and Institutionalize Polish Patterns

- Document successful polish patterns for reuse.
- Update component libraries where improvements should propagate.
- Add polish-related checks to review checklists.
