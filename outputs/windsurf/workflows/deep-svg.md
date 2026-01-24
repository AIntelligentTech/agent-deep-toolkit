---
description: Generate, validate, and refine high-quality SVGs using modern AI models
auto_execution_mode: 3
---

# Deep SVG Workflow

This workflow instructs Cascade to use AI models to produce reliable, high-quality SVGs (icons, diagrams, illustrations) from textual descriptions, then validate, optimize, and integrate them into a frontend/design-system context.

## 1. Clarify SVG Intent and Constraints

- Restate the request in precise SVG terms:
  - Type: icon, logo, diagram, chart, illustration, UI element, or background.
  - Style: flat, outline, duotone, skeuomorphic, isometric, etc.
  - Geometry: aspect ratio, approximate dimensions, orientation, symmetry requirements.
- Capture constraints and integration context:
  - Target platforms (web, mobile, print), theming (light/dark), and brand guidelines.
  - Accessibility needs (e.g., meaningful shapes vs purely decorative).
- Decide the appropriate **fidelity level**:
  - Simple icon vs complex scene influences model choice and prompting style.

## 2. Choose Generation Approach and Models

- Prefer **code-capable language models** (LLMs) when:
  - You need precise control over paths, groups, and attributes.
  - The output is an icon, logo, or simple diagram with clear structure.
- Consider **image-to-vector tools or dedicated SVG generators** when:
  - The request is for complex illustrations, gradients, or painterly styles.
  - Structural exactness is less important than visual richness.
- When working in an environment with multiple models available:
  - Use a code/structure-strong model for initial SVG markup.
  - Optionally pass the result through specialized SVG tools for optimization and cleanup.
- If model capabilities are uncertain, use `/deep-search` to:
  - Check current best-in-class models for code/SVG generation.
  - Identify limitations (e.g., tendency to embed HTML, missing viewBox, extraneous metadata).

## 3. Design a Precise Prompt for SVG Generation

- Always instruct the model to output **only** a single `<svg>` element:
  - No markdown fences, no surrounding HTML, and no commentary.
- Specify structural requirements:
  - Include `xmlns`, `viewBox`, and (if needed) `role`/`aria-hidden` attributes.
  - Use grouped elements (`<g>`) for logical parts when helpful.
- Constrain styling and dependencies:
  - Prefer inline attributes or well-scoped `<style>` blocks, not external resources.
  - Avoid `<script>`, `<foreignObject>`, external fonts, and remote image links.
- Tie SVG to your design system and tokens where relevant:
  - Reference semantic colors and sizes (e.g., "use currentColor" or token-based values) rather than hard-coded brand values when appropriate.
- Describe the desired geometry and composition:
  - Key shapes, relative proportions, alignment, and visual hierarchy.
  - Any symmetry, grids, or alignment rules to respect.
- For complex scenes, consider a **two-step prompt**:
  - First, ask the model to outline the structure (groups, shapes, layering) in plain language.
  - Then request the final SVG based on that structural plan.

## 4. Generate and Sanity-Check the SVG

- Inspect the raw SVG text:
  - Confirm there is exactly one `<svg>` root element.
  - Check for required attributes (`viewBox`, `xmlns`) and absence of scripts or remote references.
- Validate the SVG syntax using appropriate tools (or by loading into a viewer):
  - Ensure it renders without errors or obvious distortions.
  - Check that shapes appear at reasonable scale and position within the viewBox.
- If the model mixed in non-SVG content:
  - Strip markdown, HTML, or commentary.
  - If structure is still unclear or broken, regenerate with a stricter prompt.

## 5. Optimize, Normalize, and Secure the SVG

- Normalize attributes and structure:
  - Remove redundant groups, transforms, and unused definitions where safe.
  - Prefer consistent units and coordinate systems.
- Run the SVG through an optimizer (e.g., SVGO or an equivalent pipeline):
  - Reduce file size and remove editor-specific metadata.
  - Preserve readability for hand editing where that matters.
- Enforce security and safety constraints:
  - Strip any `<script>`, event handlers (e.g., `onclick`), and remote references.
  - Avoid embedding sensitive data or tracking mechanisms.

## 6. Iterate with Structured Refinement

- Compare the SVG against the original description and UX/brand goals:
  - Shape accuracy, style consistency, and visual hierarchy.
- Use the AI model for **targeted edits** rather than full regeneration when possible:
  - Ask it to adjust specific attributes (colors, strokes, positions) or add/remove elements.
  - Provide the current SVG and a focused change request.
- For non-trivial adjustments, consider a hybrid approach:
  - Manual edits for fine control, with the AI assisting in explaining or simplifying path data.
- Repeat generation/refinement cycles until the SVG meets the defined quality bar.

## 7. Integrate SVGs with Design Tokens, Components, and Tests

- Align the SVG with your token system using `/deep-design-token`:
  - Replace hard-coded values with semantic or primitive tokens where appropriate.
- Wrap SVGs in components consistent with your frontend architecture:
  - Icon components with props for size, color (e.g., `currentColor`), and accessibility labels.
  - Diagram or illustration components that maintain aspect ratio and responsiveness.
- Incorporate into `/deep-test` strategy where relevant:
  - Visual regression tests for critical icons/illustrations.
  - Snapshot or contract tests ensuring no introduction of scripts or forbidden attributes.

## 8. Capture Patterns and Model-Specific Learnings

- Document effective prompt patterns for different SVG types (icons, diagrams, complex scenes).
- Note model-specific behaviors:
  - Strengths, typical failure modes, and any recurring formatting quirks.
- Periodically revisit model and tool choices using `/deep-search`:
  - As new models and SVG tooling emerge, update this workflow and prompts to leverage them.
