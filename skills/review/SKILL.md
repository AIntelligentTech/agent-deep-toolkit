---
name: review
description: Structured code review with security, performance, and maintainability lenses
command: /review
aliases: ["/code-review", "/cr"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Review Workflow

This workflow instructs Cascade to perform thorough, constructive code reviews that improve code quality and share knowledge.

## 1. Understand the Context

- Review the PR/change description:
  - What problem is being solved?
  - What approach was taken?
- Check linked issues/tickets for requirements.
- Understand the scope:
  - Is this a focused change or broad refactor?

## 2. High-Level Assessment

- Does the change make sense overall?
  - Does the approach fit the problem?
  - Are there simpler alternatives?
- Check scope:
  - Is the change appropriately sized?
  - Are unrelated changes mixed in?
- Review architecture fit:
  - Does this align with system design?

## 3. Correctness Review

- Does the code work?
  - Verify logic handles all cases.
  - Check edge cases and error handling.
- Review tests:
  - Are tests adequate and meaningful?
  - Do tests actually test the new code?
- Look for bugs:
  - Off-by-one errors, null handling, race conditions.

## 4. Security Review

- Apply `/threat` principles:
  - Input validation.
  - Authentication/authorization checks.
  - Data exposure risks.
- Check for common vulnerabilities:
  - Injection, XSS, CSRF, etc.
- Review secrets and sensitive data handling.

## 5. Performance Review

- Identify potential hotspots:
  - Loops, database queries, API calls.
- Check for:
  - N+1 queries, unnecessary work.
  - Memory leaks, resource cleanup.
  - Scalability concerns.

## 6. Maintainability Review

- Code clarity:
  - Is the code readable and self-documenting?
  - Are names clear and consistent?
- Structure:
  - Appropriate abstraction level?
  - Single responsibility?
- Documentation:
  - Are complex parts explained?
  - Are public APIs documented?

## 7. Consistency Review

- Style and conventions:
  - Does it match project standards?
  - Are lints passing?
- Patterns:
  - Does it use established patterns?
  - Any unnecessary novelty?

## 8. Provide Constructive Feedback

- Be specific and actionable:
  - Point to exact lines.
  - Suggest concrete improvements.
- Distinguish:
  - 🔴 Blockers (must fix).
  - 🟡 Suggestions (should consider).
  - 🟢 Nitpicks (optional).
- Explain the "why" behind feedback.
- Acknowledge good work.

## 9. Follow Up

- Verify fixes address feedback.
- Approve when satisfied.
- Don't block on minor issues.
