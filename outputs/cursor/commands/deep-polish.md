# Deep Polish Workflow

This workflow instructs Cascade to focus on the final 10–20% of refinement that separates “good enough” from truly excellent. It assumes core UX, architecture, and functionality are already in place (see `/workflow-deep-ux`, `/workflow-deep-code`, and `/workflow-deep-test`).

## 1. Clarify the Polish Goal and Quality Bar

- Restate what is being polished:
  - Screen(s), flow, component library, microcopy set, motion system, or overall product surface.
- Define the target quality bar:
  - Reference products or design systems that set the benchmark for this context.
- Make constraints explicit:
  - Timebox, scope, platform limitations, brand guidelines, and technical debt that cannot be addressed now.

## 2. Diagnose Current Rough Edges

- Perform a structured pass (building on `/workflow-deep-ux` where relevant):
  - Visual noise, misalignment, inconsistent spacing.
  - Awkward flows, missing or unclear states.
  - Jarring or absent motion, loading, and error handling.
  - Copy that is unclear, wordy, or off-tone.
- Capture issues in a concise list grouped by area (visual, interaction, copy, behavior, performance).
- Prioritize by impact vs effort to guide where polish time should go first.

## 3. Polish Layout, Spacing, and Visual Hierarchy

- Revisit grids and spacing scales:
  - Align elements to a consistent grid and rhythm.
  - Normalize spacing between related and unrelated elements.
- Sharpen hierarchy:
  - Ensure typography, color, and weight clearly indicate what is primary, secondary, and tertiary.
- Remove visual clutter:
  - Eliminate redundant lines, borders, and decoration that do not aid comprehension.

## 4. Refine States, Interactions, and Feedback

- Enumerate states for key components and flows:
  - Default, hover, focus, active/pressed, loading, success, empty, error, disabled.
- Ensure each state is visually distinct and accessible:
  - Adequate contrast, clear focus indicators, and consistent behavior patterns.
- Add or tune microinteractions where appropriate:
  - Subtle transitions, hover/press feedback, and progress indicators that clarify system status without distracting.

## 5. Polish Microcopy and Communication

- Review microcopy in context:
  - Labels, helper text, placeholders, validation messages, empty states, and confirmations.
- Optimize for clarity first, then tone:
  - Prefer concrete, action-oriented language over cleverness.
  - Align tone with brand and user context (especially for stressful flows).
- Ensure consistency:
  - Terminology, capitalization, and phrasing patterns across the product.

## 6. Behavioral, Performance, and Responsiveness Polish

- Check responsiveness:
  - Layout and interactions across breakpoints, orientations, and density settings.
- Address performance polish:
  - Perceived speed via skeletons, progressive loading, and responsive interactions.
  - Avoid jank in animations and scrolling.
- Verify error handling and recovery:
  - Clear, actionable error messages and recovery paths.

## 7. Ensure Cohesion with Systems and Brand

- Cross-check against design and component systems:
  - Variants, tokens, and patterns should be used consistently or intentionally diverge with rationale.
- Align with brand expression:
  - Color, imagery, motion, and tone should reinforce the same identity across surfaces.
- Eliminate one-off hacks where reasonable:
  - Move ad hoc styling or behavior into reusable patterns where it improves maintainability.

## 8. Validate Polish with Users and Team

- Where feasible, perform quick validation:
  - Heuristic review, design QA, or light user testing on the polished flows.
- Incorporate feedback selectively:
  - Focus on issues that undermine clarity, trust, or perceived quality.
- Coordinate with engineering and QA:
  - Ensure polish changes are testable, captured in `/workflow-deep-test` strategy, and do not introduce regressions.

## 9. Capture Patterns and Definition of Done

- Document newly established patterns and decisions:
  - Layout rules, spacing scales, state patterns, microcopy conventions, and motion guidelines.
- Update the team’s "definition of done" for relevant workstreams to include key polish checks.
- Note follow-up polish opportunities that exceed current constraints, so they are not lost.

