# Deep Document Workflow

This workflow instructs Cascade to write documentation that is clear, useful, and maintainable, not just descriptive prose.

## 1. Clarify Purpose, Audience, and Lifespan

- Identify the primary purpose:
  - Onboarding, reference, decision record, how-to, conceptual overview, or incident/postmortem.
- Identify audiences and their needs:
  - New contributors, core maintainers, stakeholders, SREs, auditors, end users.
- Estimate lifespan and update frequency to choose appropriate depth and format.

## 2. Choose the Right Document Type and Structure

- Select a doc type aligned with purpose:
  - README/overview, design doc, ADR (Architecture Decision Record), RFC, API reference, runbook, troubleshooting guide.
- Use known patterns:
  - For ADRs: Context, Decision, Alternatives, Rationale, Consequences.
  - For design docs: Problem, Goals/Non-goals, Context, Proposed Design, Alternatives, Risks, Rollout, Monitoring.
- Sketch a clear outline before drafting to ensure flow.

## 3. Gather Inputs and Ground in Reality

- Collect relevant artifacts:
  - Code, diagrams, tickets, discussions, metrics, existing docs.
- Use `code_search` and `grep_search` to anchor statements in actual behavior and structure.
- When needed, use `search_web` for current best practices in documenting the specific technology or pattern.

## 4. Draft for Clarity, Then Detail

- Start with a concise summary:
  - What this is, who it’s for, and what readers will get from it.
- Write short, active sentences and concrete examples.
- Prefer diagrams and tables where they convey structure more clearly than prose.
- Call out assumptions, constraints, and edge cases explicitly.

## 5. Connect Docs to Architecture and Code

- Link to relevant modules, services, ADRs, tickets, and dashboards.
- Where appropriate, describe the system using a C4-inspired structure (Context, Containers, Components) in text or diagrams.
- Ensure that documented flows match real call paths and data flows observed in code and telemetry.

## 6. Review for Accuracy, Gaps, and Consumption

- Self-review:
  - Check for ambiguity, missing pre-requisites, and undocumented edge cases.
  - Verify all technical claims against code or authoritative sources.
- Consider readers’ workflows:
  - Is this doc discoverable from the relevant code, repo root, or command?
  - Does it answer the questions they are most likely to have?

## 7. Plan for Maintenance and Evolution

- State how and when the document should be updated (triggers such as releases, major refactors, or dependency upgrades).
- Where possible, keep documentation close to code (docs-as-code) and reference it from tests or CI checks.
- Encourage lightweight ADRs or changelogs to record future significant decisions that affect this doc.

