---
description: Systematically enumerate and characterize items within a target area
  to produce a rich, actionable inventory
agent: auto
model: auto
subtask: false
allowed-tools:
- '*'
---

Context: $ARGUMENTS

# Inventory Workflow

This workflow instructs Cascade to systematically enumerate and characterize items within a target area—whether entities, code structures, patterns, concepts, or systems—to produce a rich, actionable inventory with contextual metadata.

## 1. Frame the Inventory Mission

- Restate what you are inventorying:
  - A type of entity, a category of files, a pattern or abstraction, or a conceptual domain.
- Define the purpose:
  - Gap analysis, migration planning, documentation, refactoring targets, security review.
- Identify boundaries:
  - What's in scope and what's explicitly excluded.

## 2. Discover Sources of Truth

- Identify where items of this type are defined or manifest:
  - Code files, config files, database schemas, documentation, external systems.
- Prioritize sources:
  - Start with authoritative, well-structured sources.
- Note sources that are incomplete or may have stale information.

## 3. Design the Inventory Schema

- Define what attributes to capture for each item:
  - Identity (name, ID, location).
  - Classification (type, category, tags).
  - Metadata (owner, created date, last modified, version).
  - Context (dependencies, relationships, usage patterns).
  - Quality signals (test coverage, documentation quality, known issues).

## 4. Enumerate Items Systematically

- Use code search, file listing, and pattern matching to discover items.
- Cross-reference multiple sources to ensure completeness.
- Track progress:
  - What's been inventoried, what's pending.
- Handle duplicates and aliases appropriately.

## 5. Enrich with Context and Metadata

- For each item, gather the defined attributes.
- Use automated analysis where possible.
- Fill gaps with manual investigation.
- Flag items with incomplete or uncertain data.

## 6. Analyze for Gaps and Patterns

- Look for:
  - Missing items that should exist.
  - Inconsistent naming or organization.
  - Unused or orphaned items.
  - Patterns that suggest refactoring opportunities.
- Summarize key findings.

## 7. Produce the Inventory Artifact

- Format output appropriately:
  - Structured data (JSON, YAML, CSV) for tooling.
  - Human-readable tables or lists for review.
- Include summary statistics.
- Document methodology and limitations.

## 8. Connect to Downstream Workflows

- Use inventory to inform:
  - `/refactor` for cleanup targets.
  - `/migrate` for migration planning.
  - `/document` for documentation updates.
  - `/audit` for compliance review.