---
name: document
description: Discover, create, and maintain high-quality technical documentation aligned with modern docs-as-code practices
command: /document
aliases: ["/docs", "/write-docs", "/docstring"]
synonyms: ["/documenting", "/documented", "/documents", "/documentation"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Document Workflow

This workflow combines documentation discovery (mapping external docs) with documentation creation (writing internal docs), producing documentation that is clear, useful, and maintainable.

<scope_constraints>
**Operational Boundaries:**
- Scope: Technical documentation discovery and creation
- Modes: External documentation mapping, internal documentation writing, docs-as-code practices
- Defaults: Prefer modular, discoverable docs; link docs to code; keep docs current with code
- Not in scope: Brand/marketing content; user-facing feature documentation (user guides)
</scope_constraints>

<context>
**Dependencies and Prerequisites:**
- Access to dependency manifests (package.json, etc.) for discovery phase
- Code repository for grounding claims in reality
- Understanding of audience (developers, SREs, stakeholders)
- Clear purpose for documentation (onboarding, reference, decision record, etc.)
- Time/resources for writing and maintaining docs
</context>

<instructions>

## Inputs
- Documentation mission and purpose
- Target audience and their needs
- Dependency manifests (for discovery phase)
- Code and architecture context
- Existing documentation to reference or extend

## Steps

## Part A: Documentation Discovery

### Step 1: Frame the Documentation Mission

- Restate why you need docs and how deep you need to go:
  - Quick orientation, architecture work, migration, or debugging.
- Define how many top-priority tools to fully map (typically 3–7).

### Step 2: Discover Tools and Versions

- Crawl dependency definitions:
  - `package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, etc.
- Extract a Tool Inventory:
  - Name, version constraint, resolved version, role in the system.

### 3. Locate Canonical Sources

- Identify official docs domains and GitHub repos.
- Check for `llms.txt` / `llms-full.txt` for LLM-friendly navigation.
- Use progressive disclosure—don't ingest everything at once.

### Step 4: Build a Docs Map

- For each tool: core identity, primary docs, version details, known gaps.
- Store as a reusable Docs Brief.

## Part B: Documentation Creation

### Step 5: Clarify Purpose, Audience, and Lifespan

- Identify the primary purpose:
  - Onboarding, reference, decision record, how-to, conceptual overview, or incident/postmortem.
- Identify audiences and their needs:
  - New contributors, core maintainers, stakeholders, SREs, auditors, end users.
- Estimate lifespan and update frequency to choose appropriate depth and format.

### Step 6: Choose the Right Document Type and Structure

- Select a doc type aligned with purpose:
  - README/overview, design doc, ADR (Architecture Decision Record), RFC, API reference, runbook, troubleshooting guide.
- Use known patterns:
  - For ADRs: Context, Decision, Alternatives, Rationale, Consequences.
  - For design docs: Problem, Goals/Non-goals, Context, Proposed Design, Alternatives, Risks, Rollout, Monitoring.
- Sketch a clear outline before drafting to ensure flow.

### Step 7: Gather Inputs and Ground in Reality

- Collect relevant artifacts:
  - Code, diagrams, tickets, discussions, metrics, existing docs.
- Use `code_search` and `grep_search` to anchor statements in actual behavior and structure.
- When needed, use `search_web` for current best practices in documenting the specific technology or pattern.

### Step 8: Draft for Clarity, Then Detail

- Start with a concise summary:
  - What this is, who it's for, and what readers will get from it.
- Write short, active sentences and concrete examples.
- Prefer diagrams and tables where they convey structure more clearly than prose.
- Call out assumptions, constraints, and edge cases explicitly.

### Step 9: Connect Docs to Architecture and Code

- Link to relevant modules, services, ADRs, tickets, and dashboards.
- Where appropriate, describe the system using a C4-inspired structure (Context, Containers, Components) in text or diagrams.
- Ensure that documented flows match real call paths and data flows observed in code and telemetry.

### Step 10: Review for Accuracy, Gaps, and Consumption

- Self-review:
  - Check for ambiguity, missing pre-requisites, and undocumented edge cases.
  - Verify all technical claims against code or authoritative sources.
- Consider readers' workflows:
  - Is this doc discoverable from the relevant code, repo root, or command?
  - Does it answer the questions they are most likely to have?

### Step 11: Plan for Maintenance and Evolution

- State how and when the document should be updated (triggers such as releases, major refactors, or dependency upgrades).
- Where possible, keep documentation close to code (docs-as-code) and reference it from tests or CI checks.
- Encourage lightweight ADRs or changelogs to record future significant decisions that affect this doc.

## Error Handling

- **Documentation discovery outdated**: Check last update dates; prioritize most current sources; note discrepancies between versions
- **Code and docs diverge**: Establish trigger-based review (on major releases); automate doc validation in CI where possible
- **Audience unclear**: Create docs for multiple personas (new contributor, operator, architect); use sections to segment content
- **Documentation too large/complex**: Break into multiple docs; use progressive disclosure; link related docs together

</instructions>

<output_format>
**Deliverables for Discovery Phase:**
- Tool inventory with versions and roles
- Docs map with canonical source locations
- Summary of each tool's key concepts and APIs

**Deliverables for Creation Phase:**
- Completed documentation matching the chosen type (README, ADR, design doc, runbook, etc.)
- Clear outline and table of contents
- Code references and linked examples
- Diagrams or architecture visuals (where applicable)
- Audience-specific navigation and prerequisites
- Maintenance plan with update triggers
</output_format>
