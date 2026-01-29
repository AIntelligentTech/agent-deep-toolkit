---
name: ux
description: Perform a deep UX review using research insights, user journeys, and
  established usability heuristics
activation: auto
---

# UX Workflow

This workflow instructs Cascade to evaluate and improve user experience systematically, grounded in modern UX practice.

## 1. Understand Users, Tasks, and Contexts

- Identify key user segments and their primary goals.
- List critical tasks and scenarios this interface must support.
- **Cognitive Load Analysis**: Evaluate the mental effort required to complete tasks. Identify where the user is forced to hold too much information in memory or face unnecessary decision paralysis (Hick's Law).
- Note environmental factors:
  - Devices, assistive technologies, network conditions, time pressure.

## 2. Map Journeys and Flows

- Outline end-to-end user journeys for critical goals.
- For each step, identify:
  - User intent, system response, and potential friction points.
- Distinguish between journeys (high-level across touchpoints) and flows (detailed UI steps) and use both where helpful.

## 3. Heuristic Evaluation

- Evaluate the interface against recognized usability heuristics (e.g., Nielsen's 10):
  - Visibility of system status.
  - Match between system and real world.
  - User control and freedom.
  - Consistency and standards.
  - Error prevention and recovery.
  - Recognition rather than recall.
  - Flexibility and efficiency of use.
  - Aesthetic and minimalist design.
  - Help users recognize, diagnose, and recover from errors.
  - Help and documentation.
- Note concrete issues with severity and supporting examples.

## 4. Accessibility and Inclusive Design

- Check for basic accessibility practices:
  - Semantic HTML/roles, focus order, keyboard navigation, contrast, text sizing.
- **Screen Reader Simulation**: Mentally (or via tools) simulate the experience for a screen reader user. Are labels descriptive? Is the focus order logical? Are dynamic changes announced (ARIA live regions)?
- Consider diverse users:
  - Different abilities, cultural contexts, and levels of expertise.
- Where appropriate, reference relevant guidelines (e.g., WCAG) when evaluating issues.

## 5. Synthesize Issues and Opportunities

- Group findings by flow or UI area.
- Prioritize based on:
  - Impact on task success and satisfaction.
  - Frequency of occurrence.
  - Ease of remediation.
- Propose UX improvements that are concrete and implementation-aware.

## 6. Plan Validation

- Suggest ways to validate proposed UX changes:
  - Remote or in-person usability tests.
  - Prototype testing, A/B tests, or feature flags.
- Recommend instrumentation to capture UX signals in production (e.g., drop-off points, completion rates).

## 7. Detect and Avoid AI Slop in AI-Driven UX

- When AI-generated content or AI-powered features are present, explicitly evaluate them for **signal vs. noise**:
  - Check that AI output is relevant, concise, and clearly advances the user's task.
  - Watch for "AI slop" symptoms: generic or repetitive text, incoherent or low-fidelity visuals, unverifiable claims, or engagement-bait responses.
- Assess **trust, control, and transparency** around AI:
  - Ensure AI output is clearly labeled as such, with access to explanations, sources, or uncertainty cues where appropriate.
  - Provide user controls to opt out, refine, or correct AI suggestions instead of flooding the interface with unsolicited content.

## 8. Apply World-Class Visual and Interaction Design

- Ground visual and interaction decisions in established, high-quality design systems and guidelines (e.g., Apple Human Interface Guidelines, Material Design 3, Fluent 2, Carbon).
- Evaluate **layout and spacing** deliberately:
  - Use clear grids, alignment, and consistent spacing scales to create visual rhythm and hierarchy.
- Treat **typography** as a primary tool for hierarchy and clarity.
- Design **components and affordances** to match user intent.
- Use **motion and microinteractions** purposefully.

## 9. Use Whimsy and Delight Responsibly

- Start from **usability, reliability, and accessibility** as non-negotiable foundations. Only add whimsy once core flows are fast, clear, and robust.
- Treat whimsical elements as **microinteractions and moments**, not permanent decoration.
- Align whimsy with **brand voice, context, and emotional state**.
- Safeguard **clarity and focus**.
- Ensure **accessibility and control**.

## 10. Bridge UX to Frontend Implementation

- When proposing UX changes, think through how they will be realized in the frontend stack.
- Favor implementation patterns that keep UI concerns modular and testable.
- Consider responsiveness and platform specifics at implementation time.
- Anticipate performance characteristics of the implementation.