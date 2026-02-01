---
name: compare
description: Perform structured comparison and differential analysis between options, architectures, libraries, or code implementations
command: /compare
aliases: ["/diff", "/tradeoff", "/contrast"]
synonyms: ["/comparison", "/comparing", "/compared", "/compares", "/differential", "/trade-off", "/tradeoffs", "/contrasting"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: analyze
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Compare Workflow

This workflow instructs Cascade to perform rigorous side-by-side analysis, highlighting differences and trade-offs between multiple options or states.

<scope_constraints>
- Focuses on structured, side-by-side analysis of alternatives
- Applies to code, architectures, libraries, implementations, or versions
- Highlights differences, trade-offs, and relative strengths
- Provides decision support through multi-dimensional evaluation
- Not a replacement for final decision-making (use `/decide` for formal decisions)
</scope_constraints>

<context>
**Dependencies:**
- Understanding of what is being compared (code, architectures, libraries, etc.)
- Knowledge of relevant evaluation dimensions
- Access to documentation, source code, or specifications
- Understanding of trade-off analysis and comparison frameworks

**Prerequisites:**
- Clearly defined alternatives to compare
- Identified comparison dimensions or criteria
- Goal or decision to be informed by the comparison
- Access to all materials needed for analysis
</context>

<instructions>

## Inputs

- Multiple options/versions/implementations to compare
- Comparison goal (decision support, migration planning, debugging, etc.)
- Comparison dimensions or criteria (performance, cost, complexity, maintainability, etc.)
- Constraints or context for the comparison
- Any existing differences or change logs
- Relevant documentation or specifications

## Steps

### Step 1: Define the Comparison Scope

- Identify exactly which artifacts, options, or versions are being compared.
- State the goal: decision support, migration planning, or debugging.
- Define the comparison dimensions (e.g., performance, cost, complexity, maintainability).

### Step 2: Structural & Differential Analysis (The "Diff")

- For code/files:
  - Identify what has changed, what is new, and what has been removed.
  - Explain the *intent* behind the differences, not just the text changes.
- For architectures/libraries:
  - Map core functionalities side-by-side.
  - Identify unique features and shared capabilities.
  - Note differences in implementation patterns or paradigms.

### Step 3: Explicit Trade-off Mapping

- Use a structured format (e.g., Pros/Cons, Advantage/Disadvantage) for each option.
- Highlight the **Zero-Sum** aspects:
  - If we gain X (e.g., speed), what are we losing (e.g., memory, simplicity)?
- Identify the "ideal" use case for each option.

### Step 4: Multi-Dimensional Evaluation

- Create a comparison matrix across key criteria:
  - **Runtime**: Performance, scalability, resource usage.
  - **Development**: Ease of use, learning curve, tooling, ecosystem.
  - **Business**: Cost, licensing, vendor lock-in, time-to-market.
- Assign relative ratings (High/Medium/Low or 1-5) to normalize the comparison.

### Step 5: Synthesis and Recommendations

- Summarize the fundamental differences.
- Call out "deal-breakers" or critical risks associated with specific options.
- Provide a recommendation based on the user's specific constraints (link to `/decide` for formal decision-making).

## Error Handling

**Common comparison pitfalls:**
- Comparing incomparable things (different versions, contexts, or scales)
- Biased selection of evaluation criteria
- Over-weighting single dimensions without considering holistic trade-offs
- Ignoring context-specific constraints
- Conflating correlation with causation

**Mitigation strategies:**
- Define comparison scope and dimensionality clearly upfront
- Use balanced set of criteria that represent different concerns
- Make weighting explicit and context-aware
- Document which factors were out of scope
- Call out assumptions and limitations in the analysis

</instructions>

<output_format>

The output of this skill is a **comprehensive comparison report** with analysis and insights:

1. **Comparison Scope** — What is being compared, why, and what was excluded
2. **Structural Differences** — Side-by-side analysis of key differences
3. **Trade-off Matrix** — Pros/cons or advantages/disadvantages for each option
4. **Multi-Dimensional Evaluation** — Scoring across key criteria with justification
5. **Risk Assessment** — Deal-breakers, critical concerns, and mitigation options
6. **Use Case Mapping** — Which option is best suited for which scenario
7. **Synthesis** — Summary of fundamental differences and key insights
8. **Recommendations** — Suggested choice based on stated constraints and goals
9. **Open Questions** — Uncertainties or areas requiring further investigation

Deliverables typically include:
- Comparison summary document (2-5 pages)
- Side-by-side comparison table or matrix
- Trade-off analysis with pros/cons for each option
- Evaluation scoring sheet with weighted criteria
- Risk assessment and decision checklist
- Optional: Detailed technical analysis or deep dives on specific dimensions

</output_format>
