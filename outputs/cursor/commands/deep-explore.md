# Deep Explore

## Objective

Deeply explore the codebase for comprehensive understanding of structure, components, and execution paths

## Requirements

# Deep Explore Workflow

This workflow instructs Cascade to go beyond surface-level reading and build a deep, structural, and execution-flow understanding of the codebase.

## 1. High-Level Structural Analysis

- Start by listing the root directory and key subdirectories to understand the project layout.
- Use `list_dir` or `run commands` with `tree` (if available and constrained) to visualize the hierarchy.
- Identify the project type (monorepo, polyrepo, framework used) and key configuration files (package.json, tsconfig.json, etc.).

## 2. Component & Module Discovery

- Use `search the codebase` (Fast Context) to map out major components and modules.
- Identify where business logic, data access, UI components, and utilities reside.
- Look for architectural patterns (MVC, Clean Architecture, Hexagonal, etc.).

## 3. Execution Path Tracing

- Identify entry points (e.g., `main.ts`, `index.js`, API route handlers, CLI commands).
- Follow the execution flow from entry points down to core logic.
- Use `search for patterns` to trace function calls and data passing.
- Understand how data flows through the system (inputs -> processing -> storage/outputs).

## 4. Deep Dive into Key Areas

- Don't just read top-level files; examine nested components and utilities.
- Understand the relationships between files (imports, exports, dependencies).
- Look for cross-cutting concerns (logging, error handling, auth).

## 5. Synthesis & Reasoning

- Synthesize the gathered information into a coherent mental model of the system.
- Explain *why* the code is structured this way, not just *what* it is.
- Identify potential bottlenecks, complexity hotspots, or areas for refactoring.
