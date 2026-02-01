---
name: explore
description: Deeply explore and build understanding of a codebase, concept, technology, or system through structural analysis, execution tracing, and multi-source research
command: /explore
aliases: ["/understand", "/learn", "/discover"]
synonyms: ["/exploring", "/explored", "/explores", "/understand", "/understanding", "/learn", "/discovery"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Explore Workflow

This workflow instructs Cascade to go beyond surface-level reading and build a deep, structural, and execution-flow understanding of any target—whether a codebase, concept, technology, or system.

<scope_constraints>
**Operational Boundaries:**
- Scope: Deep analysis of systems, codebases, technologies, and concepts
- Modes: Structural analysis, execution tracing, research synthesis
- Defaults: Map structure first; then trace execution; synthesize into mental model
- Not in scope: Making changes; solving problems (defer to /code or /debug); implementing findings
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Access to the target code, documentation, or resources
- Time for detailed analysis (not a quick lookup)
- Tools appropriate to the target (grep, code search, debugger, etc.)
- Clear understanding of what depth is needed
</context>

<instructions>

## Inputs
- Target to explore (codebase, concept, technology, system)
- Depth requirement (quick orientation vs. deep mastery)
- Specific questions to answer
- Known entry points or starting areas

## Steps

### Step 1: Frame the Exploration Mission

- Restate what you are exploring in one precise sentence:
  - A codebase, module, or feature area.
  - A technology, framework, or library.
  - A concept, pattern, or domain.
  - A system, architecture, or integration.
- Define the depth required:
  - Quick orientation vs. deep mastery.
  - Specific questions that must be answered.

### Step 2: High-Level Structural Analysis

- Start by mapping the territory:
  - For codebases: list the root directory and key subdirectories to understand the project layout.
  - For concepts: identify the core principles, terminology, and relationships.
  - For technologies: find official docs, version info, and ecosystem context.
- Identify the type (monorepo, framework, pattern) and key configuration/entry points.

### Step 3: Component & Module Discovery

- Use `code_search` (Fast Context) to map out major components and modules.
- Identify where business logic, data access, UI components, and utilities reside.
- Look for architectural patterns (MVC, Clean Architecture, Hexagonal, etc.).
- For concepts: identify sub-topics, related concepts, and dependencies.

### Step 4: Execution Path Tracing

- Identify entry points (e.g., `main.ts`, `index.js`, API route handlers, CLI commands).
- Follow the execution flow from entry points down to core logic.
- Use `grep_search` to trace function calls and data passing.
- Understand how data flows through the system (inputs -> processing -> storage/outputs).

### Step 5: Deep Dive into Key Areas

- Don't just read top-level files; examine nested components and utilities.
- Understand the relationships between files (imports, exports, dependencies).
- Look for cross-cutting concerns (logging, error handling, auth).
- For technologies: explore the most commonly used APIs and patterns.

### Step 6: Multi-Source Research

- Use `/search` to find:
  - Official documentation and guides.
  - Community patterns and best practices.
  - Known issues, limitations, and workarounds.
- Cross-reference multiple sources to validate understanding.

### Step 7: Synthesis & Mental Model

- Synthesize the gathered information into a coherent mental model of the system.
- Explain *why* the code/concept is structured this way, not just *what* it is.
- Identify potential bottlenecks, complexity hotspots, or areas for improvement.
- Document the mental model for future reference.

### Step 8: Connect to Next Steps

- Based on understanding, identify:
  - Areas that need `/refactor` or `/simplify`.
  - Patterns to apply via `/code`.
  - Tests to add via `/test`.
  - Documentation gaps for `/document`.

## Error Handling

- **Codebase too large to fully explore**: Focus on relevant subsystems first; create a map of modules; identify core paths vs. peripheral features
- **Insufficient documentation**: Use code as documentation; trace execution; look for tests and examples; build mental model from code structure
- **Conflicting information between sources**: Verify against code directly; check recency of documentation; note discrepancies explicitly
- **Complexity overwhelming**: Break into smaller chunks; focus on one concern at a time; build up understanding incrementally

</instructions>

<output_format>
**Deliverables:**
- Project/system structure map and key directories
- List of major components and modules
- Entry points and execution flow diagrams (textual or visual)
- Data flow model (how information moves through the system)
- Mental model summary explaining core concepts
- Key architectural patterns and design decisions identified
- Identified bottlenecks or complexity hotspots
- Questions answered and remaining unknowns
- Next steps recommendations (refactor, test, document, etc.)
</output_format>
