---
name: inventory
description: Systematically enumerate and characterize items within a target area to produce a rich, actionable inventory
command: /inventory
aliases: ["/catalog", "/enumerate"]
synonyms: ["/inventorying", "/inventoried", "/cataloguing", "/cataloging", "/catalogued", "/enumerating", "/enumerated"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: analysis
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill focuses on systematic enumeration and characterization of items within defined boundaries. It discovers, catalogs, and enriches inventory with metadata. It does not modify or act on the items discovered—that's for downstream skills like refactor or migrate.
</scope_constraints>

<context>
This workflow instructs the agent to systematically enumerate and characterize items within a target area—whether entities, code structures, patterns, concepts, or systems—to produce a rich, actionable inventory with contextual metadata.
</context>

<instructions>

## Inputs

- Target area for enumeration (codebase, data store, business entities, patterns)
- Inventory purpose (gap analysis, migration planning, refactoring, audit)
- Scope boundaries (what's in/out of scope)
- Existing catalogs or sources of truth

## Step 1: Frame the Inventory Mission

- Restate what you are inventorying:
  - A type of entity, a category of files, a pattern or abstraction, or a conceptual domain.
- Define the purpose:
  - Gap analysis, migration planning, documentation, refactoring targets, security review.
- Identify boundaries:
  - What's in scope and what's explicitly excluded.

## Step 2: Discover Sources of Truth

- Identify where items of this type are defined or manifest:
  - Code files, config files, database schemas, documentation, external systems.
- Prioritize sources:
  - Start with authoritative, well-structured sources.
- Note sources that are incomplete or may have stale information.

## Step 3: Design the Inventory Schema

- Define what attributes to capture for each item:
  - Identity (name, ID, location).
  - Classification (type, category, tags).
  - Metadata (owner, created date, last modified, version).
  - Context (dependencies, relationships, usage patterns).
  - Quality signals (test coverage, documentation quality, known issues).

## Step 4: Enumerate Items Systematically

- Use code search, file listing, and pattern matching to discover items.
- Cross-reference multiple sources to ensure completeness.
- Track progress:
  - What's been inventoried, what's pending.
- Handle duplicates and aliases appropriately.

## Step 5: Enrich with Context and Metadata

- For each item, gather the defined attributes.
- Use automated analysis where possible.
- Fill gaps with manual investigation.
- Flag items with incomplete or uncertain data.

## Step 6: Analyze for Gaps and Patterns

- Look for:
  - Missing items that should exist.
  - Inconsistent naming or organization.
  - Unused or orphaned items.
  - Patterns that suggest refactoring opportunities.
- Summarize key findings.

## Step 7: Produce the Inventory Artifact

- Format output appropriately:
  - Structured data (JSON, YAML, CSV) for tooling.
  - Human-readable tables or lists for review.
- Include summary statistics.
- Document methodology and limitations.

## Step 8: Connect to Downstream Workflows

- Use inventory to inform:
  - `/refactor` for cleanup targets.
  - `/migrate` for migration planning.
  - `/document` for documentation updates.
  - `/audit` for compliance review.

## Error Handling

- **Incomplete enumeration**: Document what's missing and why (source unavailable, excluded)
- **Conflicting data sources**: Note discrepancies and flag for manual review
- **Ambiguous classification**: Flag items that don't fit schema cleanly
- **Orphaned items**: Highlight unused or unmaintained items for review

</instructions>

<output_format>
- **Inventory summary**: Count, scope, and key statistics
- **Catalog table**: Structured list with all defined attributes
- **Gap analysis**: Missing items, inconsistencies, orphaned entries
- **Pattern findings**: Trends suggesting refactoring or consolidation
- **Quality summary**: Test coverage, documentation, maintenance status
- **Methodology notes**: Sources used, limitations, completeness assessment
- **Recommendations**: Suggested actions for downstream workflows
</output_format>

# Inventory Workflow

This workflow instructs the agent to systematically enumerate and characterize items within a target area—whether entities, code structures, patterns, concepts, or systems—to produce a rich, actionable inventory with contextual metadata.
