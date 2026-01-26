---
description: Propose, refine, and prioritize follow-up work based on current tasks, progress, and roadmap
agent: build
subtask: true
---

# Deep Followup Workflow

This workflow instructs Cascade to look at the current task, its context, and the broader roadmap to propose valuable, well-reasoned follow-up work.

## 1. Understand the Current Work and Roadmap Context

- Clarify the focal point:
  - Which task, feature, incident, or project are we following up on?
- Use `/deep-explore` and repository context to understand:
  - What has been implemented so far.
  - Open TODOs, FIXMEs, and partial implementations.
- Use available roadmap artifacts (specs, goals, tickets) and, where needed, `/deep-search` to understand strategic direction.

## 2. Analyze Outcomes and Gaps

- From `/deep-investigate` and `/deep-retrospective`:
  - What went well and unlocked new possibilities?
  - What remains rough, brittle, or under-addressed?
- Map gaps across dimensions:
  - UX and product, architecture and code, data and analytics, infra and reliability, process and team.

## 3. Generate Follow-Up Ideas

- Use `/deep-ideas` thinking focused specifically on follow-ups:
  - Small improvements directly adjacent to recent work.
  - Mid-sized enhancements or refactors to solidify the foundation.
  - Strategic next steps that build on the current outcome.
- Include:
  - Technical follow-ups (refactors, tests, observability, infra).
  - Product/UX follow-ups (journey completion, edge cases, documentation).

## 4. Evaluate, Group, and Prioritize

- Apply `/deep-consider` and `/deep-decision`:
  - Define evaluation criteria (value, urgency, risk, effort, learning).
  - Group follow-ups into themes or epics where helpful.
- Produce a ranked list of follow-up items:
  - Explicitly label quick wins vs larger initiatives.
  - Note dependencies and sequencing between follow-ups.

## 5. Translate into Concrete Next Steps

- For top-priority follow-ups:
  - Suggest how to encode them as tasks, tickets, or roadmap items.
  - Link them to appropriate workflows for execution:
    - `/deep-code`, `/deep-refactor`, `/deep-test`, `/deep-ux`, `/deep-observability`, etc.
- Provide a brief narrative summary:
  - Why these follow-ups matter.
  - What success would look like after they are completed.
