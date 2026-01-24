---
description: Extract and systematize design tokens from existing interfaces into a reliable design system foundation
auto_execution_mode: 3
---

# Deep Design Token Workflow

This workflow instructs Cascade to reverse-engineer and codify a UI’s visual language as robust design tokens, ready for use in design tools and frontend code.

## 1. Clarify Scope, Targets, and Goals

- Define what you are extracting tokens from:
  - Single component, page, flow, product surface, or full design system.
- Clarify the goal of tokenization:
  - Consistency across products, theming/dark mode, cross-platform reuse, or migration from ad-hoc styles.
- Note constraints:
  - Platforms in scope (web, iOS, Android, desktop), existing design tools, and frontend stacks.

## 2. Inventory the Existing Visual Language

- Using design files and/or frontend inspection tools, systematically capture:
  - **Color**: background, foreground, accent, border, states (hover, focus, active, disabled), semantic roles (success, warning, error, info).
  - **Typography**: font families, sizes, weights, line heights, letter spacing, text transforms.
  - **Spacing and sizing**: margins, paddings, gaps, layout grid, container widths.
  - **Radii, borders, and shadows**: corner radii families, border widths/styles, elevation patterns.
  - **Motion and timing**: durations, easing curves, common animation patterns.
- Look for implicit scales (e.g., 4/8/12px spacing, typographic steps) rather than one-off values.

## 3. Derive Primitive Token Scales

- Normalize raw values into **primitive tokens**:
  - E.g., `color.blue.50/100/500`, `space.0/1/2/3`, `radius.sm/md/lg`, `shadow.xs/sm/md/lg`, `duration.fast/normal/slow`.
- Ensure scales are coherent and minimal:
  - Prefer a small set of well-chosen steps over many near-duplicates.
- Capture these primitives in a tool-agnostic format (e.g., JSON/YAML) to support multiple platforms.

## 4. Define Semantic Tokens and Modes

- Map primitives to **semantic tokens** that express UI meaning:
  - E.g., `color.bg.surface`, `color.text.muted`, `color.border.focus`, `color.action.primary`, `color.feedback.success.bg`.
- Consider multiple modes (light/dark, brand variants, high-contrast):
  - Keep semantic names stable while swapping underlying primitive values per mode.
- Use naming that aligns with how designers and engineers describe the UI, not implementation details.

## 5. Validate Tokens by Rebuilding Key Surfaces

- Choose representative components and screens:
  - Primary buttons, inputs, alerts, cards, navigation, and at least one complex page.
- Attempt to rebuild them **only using tokens**:
  - Adjust primitives or semantic mappings where the reconstruction diverges noticeably from the intended design.
- Capture gaps revealed during this exercise:
  - Missing tokens, ambiguous names, or overly broad semantics.

## 6. Plan Frontend Implementation and Tooling

- Decide how tokens will be represented in code:
  - CSS variables, theme objects, Style Dictionary pipelines, platform-specific exports (iOS, Android), or a combination.
- Align file structure and naming across:
  - Design tool libraries, token source of truth, and frontend consumption.
- Consider build and distribution strategy:
  - Versioning, package boundaries, and how teams adopt token updates.

## 7. Integrate with Components, UX, and Tests

- Ensure components use tokens rather than hard-coded values:
  - Map semantic tokens to component props, variants, and states.
- Coordinate with `/workflow-deep-ux` and `/workflow-deep-polish`:
  - Use tokens to implement visual hierarchy, states, and brand expression.
- Incorporate tokens into `/workflow-deep-test` strategy where relevant:
  - Visual regression tests, snapshot tests, or contract tests for theming.

## 8. Govern Token Evolution

- Define contribution and review processes for token changes:
  - Who can add/modify tokens, how proposals are evaluated, and how breaking changes are managed.
- Monitor usage and drift:
  - Identify unused tokens and hard-coded values that should be migrated.
- Keep documentation current:
  - Token catalogs, usage guidelines, and examples for designers and engineers.

