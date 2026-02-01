---
name: followup
description: Propose, refine, and prioritize follow-up work based on current tasks, progress, and roadmap
command: /followup
aliases: ["/next", "/nextsteps"]
synonyms: ["/following-up", "/followed-up", "/next-steps"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Followup Workflow

This workflow instructs Cascade to systematically identify and prioritize follow-up work, ensuring momentum continues after completing tasks.

## 1. Understand Current Context

- Review what was just completed:
  - Feature, fix, refactor, investigation, or other work.
- Note any loose ends:
  - Deferred decisions, technical debt items, documented TODOs.
- Check related tickets and documentation.

## 2. Analyze Outcomes and Gaps

- Assess the completeness of the work:
  - Does it fully meet requirements?
  - Are there edge cases not covered?
  - What's the test coverage?
- Identify discovered issues:
  - Bugs found, performance concerns, usability issues.
- Note feedback received.

## 3. Generate Follow-Up Ideas

- Categories to consider:
  - **Immediate**: Critical fixes or missing pieces.
  - **Enhancement**: Improvements to what was built.
  - **Related**: Adjacent features or refactors.
  - **Technical**: Debt, observability, documentation.
  - **Learning**: Skills or knowledge gaps to address.
- Include ideas from team discussions and user feedback.

## 4. Evaluate and Prioritize

- For each follow-up item, assess:
  - Value: Impact on users, business, or technical health.
  - Effort: Complexity and time required.
  - Urgency: Time-sensitivity.
  - Dependencies: What must happen first.
- Group related items.
- Use simple prioritization frameworks (MoSCoW, ICE, etc.).

## 5. Translate to Concrete Next Steps

- Convert top priorities to actionable items:
  - Tickets, tasks, or backlog items.
  - Clear descriptions and acceptance criteria.
- Assign ownership where possible.
- Set timelines or milestones.

## 6. Communicate and Track

- Share follow-up plan with stakeholders.
- Ensure items are tracked in the team's system.
- Schedule check-ins to review progress.
