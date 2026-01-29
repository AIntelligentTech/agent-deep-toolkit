---
name: test
description: Design, implement, and evolve high-value automated tests for robust software
command: /test
aliases: ["/verify", "/validate", "/check"]
synonyms: ["/verify", "/validate", "/check", "/testing", "/tested", "/tests", "/verifying", "/verified", "/validating", "/validated", "/checking", "/checked"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Test Workflow

This workflow instructs Cascade to approach testing as a first-class design activity, not an afterthought.

## 1. Clarify Behavior and Risk

- Restate what must be true for the system to be considered correct.
- Identify high-risk areas:
  - Complex logic, critical business flows, security-sensitive paths, and integrations.
- Decide on acceptable risk and where exhaustive testing is impractical.

## 2. Choose Test Strategy and Levels

- Define the mix of tests appropriate for the context:
  - Unit, integration, contract, end-to-end, property-based, and exploratory tests.
- Align with a testing pyramid mindset:
  - Many fast, focused tests; fewer slow, broad tests.
- Consider codebase and tooling constraints when selecting frameworks and libraries.

## 3. Design Test Cases Systematically

- Use test design techniques such as:
  - Equivalence partitioning, boundary value analysis, and state transition testing.
- Enumerate scenarios:
  - Happy paths, edge cases, error conditions, concurrency and timing issues.
- **Visual Regression**: For UI-heavy features, design tests that capture and compare visual states to detect unintended styling changes.
- For APIs and services, design contract tests that capture expectations between components.

## 4. Implement Readable, Maintainable Tests

- Structure tests clearly:
  - Arrange-Act-Assert or Given-When-Then patterns, meaningful names, and minimal duplication.
- Use appropriate test doubles:
  - Mocks, stubs, fakes, and spies, without over-mocking.
- Keep fixtures and setup simple and explicit; avoid magic globals.

## 5. Integrate Tests into CI/CD

- Ensure tests run reliably in automated pipelines:
  - Fast feedback for unit tests; scheduled or gated runs for heavier suites.
- Detect and address flaky tests:
  - Quarantine while investigating, then fix or remove.
- **Mutation Testing**: Periodically use mutation testing (introducing small bugs into code) to verify that your tests actually fail when they should.
- Use coverage as a **signal**, not an absolute target.

## 6. Evolve the Test Suite with the System

- Periodically review the test suite for:
  - Redundancy, brittleness, gaps, and misalignment with current risk.
- Refactor tests alongside production code using the `/refactor` workflow for guidance.
- Remove or rewrite low-value tests that hinder change without providing confidence.

## 7. Document Testing Strategy and Responsibilities

- Capture the testing strategy for the project:
  - What is covered where, and which tools are used.
- Clarify ownership:
  - Who maintains which test suites and environments.
- Link tests and strategy to specs, ADRs, and CI/CD configuration for traceability.
