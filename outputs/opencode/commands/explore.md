---
description: Deeply explore and build understanding of a codebase, concept, technology,
  or system through structural analysis, execution tracing, and multi-source research
agent: auto
model: auto
subtask: false
allowed-tools:
- '*'
---

Context: $ARGUMENTS

# Explore Workflow

This workflow instructs Cascade to go beyond surface-level reading and build a deep, structural, and execution-flow understanding of any target—whether a codebase, concept, technology, or system.

## 1. Frame the Exploration Mission

- Restate what you are exploring in one precise sentence:
  - A codebase, module, or feature area.
  - A technology, framework, or library.
  - A concept, pattern, or domain.
  - A system, architecture, or integration.
- Define the depth required:
  - Quick orientation vs. deep mastery.
  - Specific questions that must be answered.

## 2. High-Level Structural Analysis

- Start by mapping the territory:
  - For codebases: list the root directory and key subdirectories to understand the project layout.
  - For concepts: identify the core principles, terminology, and relationships.
  - For technologies: find official docs, version info, and ecosystem context.
- Identify the type (monorepo, framework, pattern) and key configuration/entry points.

## 3. Component & Module Discovery

- Use `code_search` (Fast Context) to map out major components and modules.
- Identify where business logic, data access, UI components, and utilities reside.
- Look for architectural patterns (MVC, Clean Architecture, Hexagonal, etc.).
- For concepts: identify sub-topics, related concepts, and dependencies.

## 4. Execution Path Tracing

- Identify entry points (e.g., `main.ts`, `index.js`, API route handlers, CLI commands).
- Follow the execution flow from entry points down to core logic.
- Use `grep_search` to trace function calls and data passing.
- Understand how data flows through the system (inputs -> processing -> storage/outputs).

## 5. Deep Dive into Key Areas

- Don't just read top-level files; examine nested components and utilities.
- Understand the relationships between files (imports, exports, dependencies).
- Look for cross-cutting concerns (logging, error handling, auth).
- For technologies: explore the most commonly used APIs and patterns.

## 6. Multi-Source Research

- Use `/search` to find:
  - Official documentation and guides.
  - Community patterns and best practices.
  - Known issues, limitations, and workarounds.
- Cross-reference multiple sources to validate understanding.

## 7. Synthesis & Mental Model

- Synthesize the gathered information into a coherent mental model of the system.
- Explain *why* the code/concept is structured this way, not just *what* it is.
- Identify potential bottlenecks, complexity hotspots, or areas for improvement.
- Document the mental model for future reference.

## 8. Connect to Next Steps

- Based on understanding, identify:
  - Areas that need `/refactor` or `/simplify`.
  - Patterns to apply via `/code`.
  - Tests to add via `/test`.
  - Documentation gaps for `/document`.