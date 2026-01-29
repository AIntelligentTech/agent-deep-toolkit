---
description: Generate, validate, and refine high-quality SVGs using modern AI models
auto_execution_mode: 2
---

# SVG Workflow

This workflow instructs Cascade to generate, validate, and refine high-quality SVGs using AI, ready for frontend or design-system integration.

## 1. Clarify SVG Requirements

- Define what the SVG needs to represent:
  - Icon, illustration, diagram, logo, or decorative element.
- Specify constraints:
  - Size requirements, color palette, style (flat, gradient, outlined, filled).
  - Target usage (inline, background, sprite sheet, component).
- Note integration context:
  - Design system, brand guidelines, accessibility requirements.

## 2. Generate Initial SVG

- Use AI image generation or SVG-specific tools to create initial versions.
- Generate multiple variations to explore options.
- Consider:
  - Clarity at different sizes.
  - Consistency with existing visual language.
  - Semantic meaning and recognizability.

## 3. Validate SVG Quality

- Check technical quality:
  - Valid SVG markup.
  - Optimized paths and minimal file size.
  - No unnecessary groups or transforms.
- Verify visual quality:
  - Crisp rendering at target sizes.
  - Appropriate stroke widths and spacing.
  - Color accuracy.

## 4. Optimize for Production

- Run through SVG optimization:
  - Remove metadata, comments, and unused definitions.
  - Simplify paths where possible.
  - Convert to appropriate coordinate system.
- Ensure accessibility:
  - Add appropriate `title` and `desc` elements.
  - Consider `aria-label` for interactive contexts.

## 5. Integrate with Design System

- Apply design tokens:
  - Replace hard-coded colors with CSS custom properties or token references.
  - Use consistent sizing units.
- Create component wrapper if needed:
  - Props for size, color, and accessibility.
  - Support for dark mode and theming.

## 6. Document and Catalog

- Add the SVG to the icon/illustration catalog.
- Document usage guidelines:
  - When to use, size recommendations, color variations.
- Link to related components that use this SVG.