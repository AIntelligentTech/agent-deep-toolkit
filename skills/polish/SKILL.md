---
name: polish
description: Refine products and interfaces to a world-class level of craft and cohesion
command: /polish
aliases: ["/refine", "/enrich", "/touch-up", "/finesse", "/fine-tune"]
synonyms: ["/polishing", "/polished", "/polishes", "/refining", "/refined", "/refines", "/refine", "/enriching", "/enriched", "/finesse", "/fine-tuning", "/fine-tuned"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Polish Workflow

<scope_constraints>
This workflow instructs Cascade to apply craft, attention to detail, and systematic refinement to elevate a product or interface to world-class quality. Covers visual design, interaction, copy, performance feel, and brand alignment.
</scope_constraints>

<context>
Polish is the difference between "working" and "delightful." It requires systematic walking through experiences, identifying rough edges, and refining with intention. Polish is never an afterthought—it's built in from the beginning through consistent tokens, clear patterns, and thoughtful feedback.
</context>

<instructions>

## Inputs

- Scope: What's being polished (component, feature, page, entire product)?
- Design system: Available tokens, components, and guidelines
- Target experience: What should the polished result feel like?
- Constraints: Timeline, design system boundaries, platform limitations

## Step 1: Clarify What "Polish" Means Here

- Define the scope:
  - A single component, a feature surface, a full page, or the entire product.
- Clarify the polish goals:
  - Visual consistency, interaction smoothness, clarity of messaging, performance feel, brand alignment, accessibility edge cases.
- Note constraints:
  - Timeline, design system boundaries, platform limitations.

### Step 2: Diagnose Rough Edges and Jank

- Walk through the experience systematically:
  - Inspect each element for alignment, spacing, sizing, color consistency, and animation smoothness.
- Note glitches and inconsistencies:
  - Visual jank, abrupt transitions, orphaned pixels, hover/focus issues, off-brand copy.
- Capture friction in flows:
  - Confusing states, unclear actions, ambiguous feedback.

### Step 3: Polish Layout, Spacing, and Visual Hierarchy

- Apply a consistent grid and spacing scale derived from `/tokens`.
- Ensure visual hierarchy clearly guides attention:
  - Primary actions stand out; secondary and tertiary elements recede.
- Refine alignment:
  - Text baselines, icon/button centers, card edges.

### Step 4: Refine States, Transitions, and Feedback

- Review component states:
  - Default, hover, focus, active, disabled, loading, empty, error.
- Ensure smooth, purposeful transitions:
  - Micro-animations reinforce meaning, not distract.
- Verify feedback clarity:
  - Users always know what happened and what to do next.

### Step 5: Polish Microcopy and Labels

- Review every piece of text:
  - Buttons, labels, placeholders, errors, empty states, tooltips.
- Apply consistent voice and terminology.
- Eliminate jargon, ambiguity, and redundancy.

### Step 6: Address Behavioral, Performance, and Responsiveness Issues

- Ensure snappy interactions:
  - No visible lag between user action and feedback.
- Test across devices, breakpoints, and input modes.
- Verify touch targets, scroll behavior, and resize behavior.

### Step 7: Ensure Cohesion with Design System and Brand

- Cross-check all elements against design tokens and guidelines.
- Ensure brand expression is consistent and intentional.
- Flag deviations for intentional exceptions or fixes.

### Step 8: Validate with Users and Stakeholders

- If possible, observe real users interacting with the polished surface.
- Collect feedback on feel, clarity, and delight.
- Iterate based on observations.

### Step 9: Capture and Institutionalize Polish Patterns

- Document successful polish patterns for reuse.
- Update component libraries where improvements should propagate.
- Add polish-related checks to review checklists.

## Error Handling

- **Design system tokens unavailable:** Document assumptions, establish conventions, use consistent ratios
- **Performance jank:** Profile animations, identify bottlenecks, optimize rendering or simplify transitions
- **Copy is unclear:** Simplify language, test with users, align with established voice
- **Accessibility issues detected:** Ensure adequate contrast, focus states, label clarity, and keyboard navigation

</instructions>

<output_format>

Provide a complete polish report and deliverables as the output:

1. **Polish Diagnosis**: Identified rough edges, inconsistencies, and friction points
2. **Refinement Plan**: Priorities for visual, interaction, copy, and performance improvements
3. **Updated Design**: Refined layouts, states, copy, and interactions
4. **Polish Patterns**: Reusable patterns for consistency across surface
5. **Validation Results**: User feedback, accessibility verification, cross-browser testing

</output_format>
