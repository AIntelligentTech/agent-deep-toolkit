---
name: deep-think
description: Perform deep reasoning and analysis on a subject, considering patterns, edge cases, and multiple perspectives
command: /deep-think
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Deep Think Workflow

This workflow instructs Cascade to pause and reason deeply before acting, ensuring solutions are robust, well-considered, and comprehensive.

## 1. First-Principles Decomposition

- Break the problem down into its fundamental truths and constraints.
- Question assumptions. Is the standard approach the best one here?
- Identify the core "job to be done" for the code or feature.

## 2. Multi-Perspective Analysis

- Analyze the problem from different angles:
  - **Architectural**: How does this fit into the larger system? Is it coupled?
  - **Security**: What are the attack vectors? (OWASP Top 10 2025)
  - **Performance**: Time/Space complexity, I/O bottlenecks.
  - **Maintainability**: Readability, extensibility, testing.
  - **User Experience**: How does this affect the end user?

## 3. Pattern & Anti-Pattern Recognition

- Identify applicable design patterns (Factory, Observer, Strategy, etc.).
- Watch out for anti-patterns (God objects, tight coupling, premature optimization).
- Consider "best practices" but evaluate if they apply to *this specific context*.

## 4. Edge Case & Failure Mode Analysis

- The "Happy Path" is not enough.
- What happens if inputs are null/empty/malformed?
- What if the network fails? What if the database is down?
- What are the concurrency implications?

## 5. Logical Synthesis

- Combine the analysis into a cohesive plan.
- Weigh trade-offs explicitly (e.g., "This approach is faster but uses more memory").
- Produce a solution that is not just "working code" but "well-engineered software".
