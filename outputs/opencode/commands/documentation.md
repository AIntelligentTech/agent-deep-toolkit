---
description: Discover, create, and maintain high-quality technical documentation aligned
  with modern docs-as-code practices
agent: auto
model: auto
subtask: false
allowed-tools:
- '*'
---

Context: $ARGUMENTS

# Document Workflow

This workflow combines documentation discovery (mapping external docs) with documentation creation (writing internal docs), producing documentation that is clear, useful, and maintainable.

## Part A: Documentation Discovery

### 1. Frame the Documentation Mission

- Restate why you need docs and how deep you need to go:
  - Quick orientation, architecture work, migration, or debugging.
- Define how many top-priority tools to fully map (typically 3–7).

### 2. Discover Tools and Versions

- Crawl dependency definitions:
  - `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, etc.
- Extract a Tool Inventory:
  - Name, version constraint, resolved version, role in the system.

### 3. Locate Canonical Sources

- Identify official docs domains and GitHub repos.
- Check for `llms.txt` / `llms-full.txt` for LLM-friendly navigation.
- Use progressive disclosure—don't ingest everything at once.

### 4. Build a Docs Map

- For each tool: core identity, primary docs, version details, known gaps.
- Store as a reusable Docs Brief.

## Part B: Documentation Creation

### 5. Clarify Purpose, Audience, and Lifespan

- Identify the primary purpose:
  - Onboarding, reference, decision record, how-to, conceptual overview, or incident/postmortem.
- Identify audiences and their needs:
  - New contributors, core maintainers, stakeholders, SREs, auditors, end users.
- Estimate lifespan and update frequency to choose appropriate depth and format.

### 6. Choose the Right Document Type and Structure

- Select a doc type aligned with purpose:
  - README/overview, design doc, ADR (Architecture Decision Record), RFC, API reference, runbook, troubleshooting guide.
- Use known patterns:
  - For ADRs: Context, Decision, Alternatives, Rationale, Consequences.
  - For design docs: Problem, Goals/Non-goals, Context, Proposed Design, Alternatives, Risks, Rollout, Monitoring.
- Sketch a clear outline before drafting to ensure flow.

### 7. Gather Inputs and Ground in Reality

- Collect relevant artifacts:
  - Code, diagrams, tickets, discussions, metrics, existing docs.
- Use `code_search` and `grep_search` to anchor statements in actual behavior and structure.
- When needed, use `search_web` for current best practices in documenting the specific technology or pattern.

### 8. Draft for Clarity, Then Detail

- Start with a concise summary:
  - What this is, who it's for, and what readers will get from it.
- Write short, active sentences and concrete examples.
- Prefer diagrams and tables where they convey structure more clearly than prose.
- Call out assumptions, constraints, and edge cases explicitly.

### 9. Connect Docs to Architecture and Code

- Link to relevant modules, services, ADRs, tickets, and dashboards.
- Where appropriate, describe the system using a C4-inspired structure (Context, Containers, Components) in text or diagrams.
- Ensure that documented flows match real call paths and data flows observed in code and telemetry.

### 10. Review for Accuracy, Gaps, and Consumption

- Self-review:
  - Check for ambiguity, missing pre-requisites, and undocumented edge cases.
  - Verify all technical claims against code or authoritative sources.
- Consider readers' workflows:
  - Is this doc discoverable from the relevant code, repo root, or command?
  - Does it answer the questions they are most likely to have?

### 11. Plan for Maintenance and Evolution

- State how and when the document should be updated (triggers such as releases, major refactors, or dependency upgrades).
- Where possible, keep documentation close to code (docs-as-code) and reference it from tests or CI checks.
- Encourage lightweight ADRs or changelogs to record future significant decisions that affect this doc.