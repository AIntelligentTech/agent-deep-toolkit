---
name: review
description: Structured code review with security, performance, and maintainability lenses
command: /review
aliases: ["/code-review", "/cr"]
synonyms: ["/reviewing", "/reviewed", "/reviews", "/critique"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: code-quality
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Review Workflow

This workflow instructs Cascade to perform thorough, constructive code reviews that improve code quality and share knowledge.

<scope_constraints>
Review scope: Pull requests, code changes, architecture fit, and implementation quality. Not applicable to design reviews, product decisions, or business logic.
</scope_constraints>

<context>
Code review is a foundational practice for quality, knowledge sharing, and risk mitigation. This workflow combines structured assessment across multiple dimensions: correctness, security, performance, maintainability, and consistency.
</context>

<instructions>

## Inputs

- Pull request or code change with description
- Linked issues/tickets (if available)
- Project standards and architecture documentation
- Security requirements and compliance constraints

### Step 1: Understand the Context

- Review the PR/change description:
  - What problem is being solved?
  - What approach was taken?
- Check linked issues/tickets for requirements.
- Understand the scope:
  - Is this a focused change or broad refactor?

### Step 2: High-Level Assessment

- Does the change make sense overall?
  - Does the approach fit the problem?
  - Are there simpler alternatives?
- Check scope:
  - Is the change appropriately sized?
  - Are unrelated changes mixed in?
- Review architecture fit:
  - Does this align with system design?

### Step 3: Correctness Review

- Does the code work?
  - Verify logic handles all cases.
  - Check edge cases and error handling.
- Review tests:
  - Are tests adequate and meaningful?
  - Do tests actually test the new code?
- Look for bugs:
  - Off-by-one errors, null handling, race conditions.

### Step 4: Security Review

- Apply `/threat` principles:
  - Input validation.
  - Authentication/authorization checks.
  - Data exposure risks.
- Check for common vulnerabilities:
  - Injection, XSS, CSRF, etc.
- Review secrets and sensitive data handling.

### Step 5: Performance Review

- Identify potential hotspots:
  - Loops, database queries, API calls.
- Check for:
  - N+1 queries, unnecessary work.
  - Memory leaks, resource cleanup.
  - Scalability concerns.

### Step 6: Maintainability Review

- Code clarity:
  - Is the code readable and self-documenting?
  - Are names clear and consistent?
- Structure:
  - Appropriate abstraction level?
  - Single responsibility?
- Documentation:
  - Are complex parts explained?
  - Are public APIs documented?

### Step 7: Consistency Review

- Style and conventions:
  - Does it match project standards?
  - Are lints passing?
- Patterns:
  - Does it use established patterns?
  - Any unnecessary novelty?

### Step 8: Provide Constructive Feedback

- Be specific and actionable:
  - Point to exact lines.
  - Suggest concrete improvements.
- Distinguish:
  - 🔴 Blockers (must fix).
  - 🟡 Suggestions (should consider).
  - 🟢 Nitpicks (optional).
- Explain the "why" behind feedback.
- Acknowledge good work.

### Step 9: Follow Up

- Verify fixes address feedback.
- Approve when satisfied.
- Don't block on minor issues.

## Error Handling

- If PR is unclear, ask for clarification before proceeding.
- If tests are missing, flag as blocker and suggest test strategy.
- If security issues are found, treat as high-priority blockers.
- If scope is too broad, request a split into smaller PRs.

</instructions>

<output_format>
Provide structured feedback organized by review dimension (Correctness, Security, Performance, Maintainability, Consistency). Use severity indicators (🔴 Blocker, 🟡 Suggestion, 🟢 Nitpick) and provide specific, actionable recommendations with line references.
</output_format>
