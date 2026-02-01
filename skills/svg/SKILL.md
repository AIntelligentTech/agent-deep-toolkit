---
name: svg
description: Generate, validate, and refine high-quality SVGs using modern AI models
command: /svg
aliases: []
synonyms: ["/svgs", "/vector", "/vectors"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: design
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# SVG Workflow

This workflow instructs Cascade to generate, validate, and refine high-quality SVGs using AI, ready for frontend or design-system integration.

<scope_constraints>
SVG scope: Icons, illustrations, diagrams, logos, and vector graphics for web and design systems. Assumes valid SVG output and integration with design tokens and component systems.
</scope_constraints>

<context>
SVGs are scalable, accessible vector graphics that form the backbone of modern design systems. This workflow combines AI generation with rigorous validation and optimization to produce production-ready assets that integrate seamlessly with design tokens and accessibility requirements.
</context>

<instructions>

## Inputs

- Specification of what SVG should represent (icon, illustration, diagram, etc.)
- Style requirements (palette, size, flat/gradient/outlined)
- Target usage context (inline, background, sprite sheet, component)
- Design system or brand guidelines (if applicable)
- Integration requirements (token references, accessibility needs)

### Step 1: Clarify SVG Requirements

- Define what the SVG needs to represent:
  - Icon, illustration, diagram, logo, or decorative element.
- Specify constraints:
  - Size requirements, color palette, style (flat, gradient, outlined, filled).
  - Target usage (inline, background, sprite sheet, component).
- Note integration context:
  - Design system, brand guidelines, accessibility requirements.

### Step 2: Generate Initial SVG

- Use AI image generation or SVG-specific tools to create initial versions.
- Generate multiple variations to explore options.
- Consider:
  - Clarity at different sizes.
  - Consistency with existing visual language.
  - Semantic meaning and recognizability.

### Step 3: Validate SVG Quality

- Check technical quality:
  - Valid SVG markup.
  - Optimized paths and minimal file size.
  - No unnecessary groups or transforms.
- Verify visual quality:
  - Crisp rendering at target sizes.
  - Appropriate stroke widths and spacing.
  - Color accuracy.

### Step 4: Optimize for Production

- Run through SVG optimization:
  - Remove metadata, comments, and unused definitions.
  - Simplify paths where possible.
  - Convert to appropriate coordinate system.
- Ensure accessibility:
  - Add appropriate `title` and `desc` elements.
  - Consider `aria-label` for interactive contexts.

### Step 5: Integrate with Design System

- Apply design tokens:
  - Replace hard-coded colors with CSS custom properties or token references.
  - Use consistent sizing units.
- Create component wrapper if needed:
  - Props for size, color, and accessibility.
  - Support for dark mode and theming.

### Step 6: Document and Catalog

- Add the SVG to the icon/illustration catalog.
- Document usage guidelines:
  - When to use, size recommendations, color variations.
- Link to related components that use this SVG.

## Error Handling

- If AI generation produces invalid SVG, request regeneration with corrected specifications.
- If SVG doesn't render crisply at target sizes, adjust paths or simplify design.
- If accessibility elements are missing, add descriptive title and desc elements.
- If integration with design tokens fails, validate token references and naming.

</instructions>

<output_format>
Provide optimized SVG code with accessibility metadata, integration notes for design system, and usage documentation. Include before/after visual comparison and performance metrics (file size, rendering quality at different scales).
</output_format>
