---
name: think
description: Perform deep reasoning and analysis on a subject, considering patterns, edge cases, and multiple perspectives
command: /think
aliases: ["/reason", "/analyze", "/ponder"]
synonyms: ["/thought", "/thinking", "/thinks", "/reasoning", "/pondering", "/pondered", "/analysis", "/analysing", "/analysed", "/analyse"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: problem-solving
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Think Workflow

This workflow instructs Cascade to pause and reason deeply before acting, ensuring solutions are robust, well-considered, and comprehensive.

<scope_constraints>
Thinking scope: Problem decomposition, multi-perspective analysis, design pattern recognition, edge case analysis, and synthesis of solutions. Best used before committing to major decisions or implementations.
</scope_constraints>

<context>
Deep thinking before action prevents costly mistakes, exposes hidden assumptions, and produces more robust solutions. This workflow applies first-principles reasoning, systems thinking, and rigorous analysis to arrive at well-engineered outcomes.
</context>

<instructions>

## Inputs

- Problem statement or challenge
- Constraints and context
- Stakeholders and success criteria
- Related existing systems or decisions
- Technical constraints and resources

### Step 1: First-Principles Decomposition

- Break the problem down into its fundamental truths and constraints.
- Question assumptions. Is the standard approach the best one here?
- Identify the core "job to be done" for the code or feature.
- **Second-Order Thinking**: Ask "And then what?" for every proposed solution to understand downstream consequences.
- **Inversion Thinking**: Ask "What would make this fail?" to identify hidden risks and failure modes before they happen.

### Step 2: Multi-Perspective Analysis

- Analyze the problem from different angles:
  - **Architectural**: How does this fit into the larger system? Is it coupled?
  - **Security**: What are the attack vectors? (OWASP Top 10 2025)
  - **Performance**: Time/Space complexity, I/O bottlenecks.
  - **Maintainability**: Readability, extensibility, testing.
  - **User Experience**: How does this affect the end user?

### Step 3: Pattern & Anti-Pattern Recognition

- Identify applicable design patterns (Factory, Observer, Strategy, etc.).
- Watch out for anti-patterns (God objects, tight coupling, premature optimization).
- Consider "best practices" but evaluate if they apply to *this specific context*.

### Step 4: Edge Case & Failure Mode Analysis

- The "Happy Path" is not enough.
- What happens if inputs are null/empty/malformed?
- What if the network fails? What if the database is down?
- What are the concurrency implications?

### Step 5: Logical Synthesis

- Combine the analysis into a cohesive plan.
- Weigh trade-offs explicitly (e.g., "This approach is faster but uses more memory").
- Produce a solution that is not just "working code" but "well-engineered software".

## Error Handling

- If assumptions are untested, flag for validation before proceeding.
- If perspectives conflict, document both viewpoints and explain chosen direction.
- If edge cases reveal fundamental issues, escalate for redesign rather than patching.
- If synthesis requires more information, identify what's needed and adjust scope.

</instructions>

<output_format>
Provide comprehensive analysis organized by perspective (architectural, security, performance, maintainability, UX), identify patterns and anti-patterns, enumerate edge cases and failure modes, and synthesize a well-reasoned solution with explicit trade-offs and justification.
</output_format>
