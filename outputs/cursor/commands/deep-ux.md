# Deep UX Workflow

This workflow instructs Cascade to evaluate and improve user experience systematically, grounded in modern UX practice.

## 1. Understand Users, Tasks, and Contexts

- Identify key user segments and their primary goals.
- List critical tasks and scenarios this interface must support.
- Note environmental factors:
  - Devices, assistive technologies, network conditions, time pressure.

## 2. Map Journeys and Flows

- Outline end-to-end user journeys for critical goals.
- For each step, identify:
  - User intent, system response, and potential friction points.
- Distinguish between journeys (high-level across touchpoints) and flows (detailed UI steps) and use both where helpful.

## 3. Heuristic Evaluation

- Evaluate the interface against recognized usability heuristics (e.g., Nielsen’s 10):
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
  - Check that AI output is relevant, concise, and clearly advances the user’s task.
  - Watch for "AI slop" symptoms: generic or repetitive text, incoherent or low-fidelity visuals, unverifiable claims, or engagement-bait responses.
- Assess **trust, control, and transparency** around AI:
  - Ensure AI output is clearly labeled as such, with access to explanations, sources, or uncertainty cues where appropriate.
  - Provide user controls to opt out, refine, or correct AI suggestions instead of flooding the interface with unsolicited content.
- Protect **content quality and hierarchy**:
  - Avoid auto-filling interfaces with AI-generated material that competes with or obscures user-authored and verified content.
  - Prefer focused, on-demand AI assistance over persistent, high-volume generation.
- If AI features do not materially improve UX in this context, recommend constraining, redesigning, or removing them rather than tolerating low-quality AI output.

## 8. Apply World-Class Visual and Interaction Design

- Ground visual and interaction decisions in established, high-quality design systems and guidelines (e.g., Apple Human Interface Guidelines, Material Design 3, Fluent 2, Carbon, and contemporary design-system practice), while adapting them to the specific product, brand, and context rather than copying them verbatim.
- Evaluate **layout and spacing** deliberately:
  - Use clear grids, alignment, and consistent spacing scales to create visual rhythm and hierarchy.
  - Ensure key actions and information follow natural scanning patterns and reading order for the target platform.
- Treat **typography** as a primary tool for hierarchy and clarity:
  - Choose sizes, weights, and line lengths that optimize legibility and emphasize what matters most.
  - Maintain sufficient contrast and typographic consistency across states and breakpoints.
- Design **components and affordances** to match user intent:
  - Prefer bespoke or tailored component compositions over generic, overused patterns when the product’s workflows or brand call for it.
  - Make interactive elements clearly interactive, with sensible hit areas and feedback.
- Use **motion and microinteractions** purposefully:
  - Apply subtle, meaningful motion to communicate state changes, reinforce spatial models, and reduce cognitive load.
  - Avoid gratuitous animations that distract from tasks or create motion sickness.
- When proposing designs, consider at least one alternative layout or component strategy and, using `/workflow-deep-consider` where helpful, justify why the chosen approach best fits the users, content, and brand instead of defaulting to commodity patterns.

## 9. Use Whimsy and Delight Responsibly

- Start from **usability, reliability, and accessibility** as non-negotiable foundations. Only add whimsy once core flows are fast, clear, and robust.
- Treat whimsical elements as **microinteractions and moments**, not permanent decoration:
  - Favor small, contextual animations, sound cues, or playful visuals that respond directly to user actions.
  - Ensure every delightful detail has a clear trigger, purpose, and feedback loop (per microinteraction best practices).
- Align whimsy with **brand voice, context, and emotional state**:
  - Use playful elements where exploration, creativity, or celebration is appropriate.
  - Avoid whimsy in high-stress, high-risk, or sensitive contexts (e.g., financial loss, medical data, incidents) where it can feel disrespectful.
- Safeguard **clarity and focus**:
  - Never let decorative whimsy compete with primary actions, content, or status indicators.
  - Test that delightful elements do not introduce motion sickness, distraction, or cognitive overload.
- Ensure **accessibility and control**:
  - Respect reduced-motion preferences and provide ways to tone down or disable non-essential animation.
  - Keep whimsical copy and visuals understandable for diverse audiences; avoid in-jokes that exclude or confuse.
- When recommending whimsical patterns, propose at least one **no-whimsy baseline** and one **delight-enhanced variant**, and use `/workflow-deep-consider` reasoning to decide whether the added delight is justified for this product, audience, and moment.

## 10. Bridge UX to Frontend Implementation

- When proposing UX changes, think through how they will be realized in the frontend stack:
  - Component and state architecture, routing, data fetching, and error boundaries.
  - Integration with design tokens, themes, and the design system’s component library.
- Favor implementation patterns that keep UI concerns modular and testable:
  - Clear separation between presentation and data/logic where appropriate.
  - Reusable components with well-defined props, slots, or composition patterns.
- Consider responsiveness and platform specifics at implementation time:
  - Breakpoints, input methods (mouse, touch, keyboard), and density/zoom settings.
  - Cross-browser and cross-device behaviors, including reduced-motion and high-contrast modes.
- Anticipate performance characteristics of the implementation:
  - Bundle size, code-splitting, lazy loading, and caching strategies.
  - Minimizing unnecessary re-renders and overdraw; efficient list and media handling.
- Ensure the UX plan is reflected in engineering quality practices:
  - Map critical flows and edge cases into `/workflow-deep-test` coverage.
  - Align error states, loading states, and empty states with actual API and data behavior.
- Where trade-offs between UX ideals and engineering constraints emerge, use `/workflow-deep-consider` to make them explicit and document the chosen compromise.


