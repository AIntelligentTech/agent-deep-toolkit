---
name: test
description: Design, implement, and evolve high-value automated tests for robust software
command: /test
aliases: ["/verify", "/validate", "/check"]
synonyms: ["/verify", "/validate", "/check", "/testing", "/tested", "/tests", "/verifying", "/verified", "/validating", "/validated", "/checking", "/checked"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: quality-assurance
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Test Workflow

This workflow instructs Cascade to approach testing as a first-class design activity, not an afterthought.

<scope_constraints>
Test scope: Automated tests (unit, integration, contract, end-to-end, property-based), test strategy, test design, and CI/CD integration. Excludes manual testing, exploratory testing reports, and performance profiling.
</scope_constraints>

<context>
Testing is fundamentally about reducing risk and building confidence in correctness. This workflow treats testing as a design activity that shapes code structure and reveals hidden assumptions, not merely a verification step at the end of development.
</context>

<instructions>

## Inputs

- Feature, system, or behavior to test
- Risk assessment (areas of high concern, business impact)
- Tech stack and testing frameworks available
- Existing test coverage (if any)
- Performance and resource constraints

### Step 1: Clarify Behavior and Risk

- Restate what must be true for the system to be considered correct.
- Identify high-risk areas:
  - Complex logic, critical business flows, security-sensitive paths, and integrations.
- Decide on acceptable risk and where exhaustive testing is impractical.

### Step 2: Choose Test Strategy and Levels

- Define the mix of tests appropriate for the context:
  - Unit, integration, contract, end-to-end, property-based, and exploratory tests.
- Align with a testing pyramid mindset:
  - Many fast, focused tests; fewer slow, broad tests.
- Consider codebase and tooling constraints when selecting frameworks and libraries.

### Step 3: Design Test Cases Systematically

- Use test design techniques such as:
  - Equivalence partitioning, boundary value analysis, and state transition testing.
- Enumerate scenarios:
  - Happy paths, edge cases, error conditions, concurrency and timing issues.
- **Visual Regression**: For UI-heavy features, design tests that capture and compare visual states to detect unintended styling changes.
- For APIs and services, design contract tests that capture expectations between components.

### Step 4: Implement Readable, Maintainable Tests

- Structure tests clearly:
  - Arrange-Act-Assert or Given-When-Then patterns, meaningful names, and minimal duplication.
- Use appropriate test doubles:
  - Mocks, stubs, fakes, and spies, without over-mocking.
- Keep fixtures and setup simple and explicit; avoid magic globals.

### Step 5: Integrate Tests into CI/CD

- Ensure tests run reliably in automated pipelines:
  - Fast feedback for unit tests; scheduled or gated runs for heavier suites.
- Detect and address flaky tests:
  - Quarantine while investigating, then fix or remove.
- **Mutation Testing**: Periodically use mutation testing (introducing small bugs into code) to verify that your tests actually fail when they should.
- Use coverage as a **signal**, not an absolute target.

### Step 6: Evolve the Test Suite with the System

- Periodically review the test suite for:
  - Redundancy, brittleness, gaps, and misalignment with current risk.
- Refactor tests alongside production code using the `/refactor` workflow for guidance.
- Remove or rewrite low-value tests that hinder change without providing confidence.

### Step 7: Document Testing Strategy and Responsibilities

- Capture the testing strategy for the project:
  - What is covered where, and which tools are used.
- Clarify ownership:
  - Who maintains which test suites and environments.
- Link tests and strategy to specs, ADRs, and CI/CD configuration for traceability.

## Error Handling

- If tests are flaky, investigate and quarantine before committing.
- If coverage is low, assess whether gaps represent real risk or over-testing.
- If test setup is complex, simplify fixtures or consider integration test layer instead.
- If CI/CD pipeline fails, prioritize fixing tests over disabling them.

</instructions>

<output_format>
Provide test strategy, test case design document, implementation code with clear naming and structure, and integration notes for CI/CD. Include risk assessment, coverage goals, and long-term maintenance plan.
</output_format>
