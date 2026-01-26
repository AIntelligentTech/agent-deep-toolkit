---
description: Systematically enumerate and characterize items within a target area (entities, code, patterns, concepts, systems) to produce a rich, actionable inventory with contextual metadata
auto_execution_mode: 3
tags:
  - architecture
  - design
  - testing
  - refactoring
  - documentation
  - performance
---
# Deep Inventory Workflow

This workflow instructs Cascade to **deeply inventory** a target:

- Entities (e.g. users, domains, services, queues, data sources)
- Code artifacts (modules, components, endpoints, jobs, scripts)
- Patterns and concepts (design patterns, domain concepts, use cases)
- Infrastructure pieces (environments, databases, external systems)

The goal is to produce a **rich, structured list** of items with helpful context, so that follow-on workflows (like `/deep-architect`, `/deep-audit`, `/deep-data`, or `/deep-document`) start from a clear, shared catalog rather than scattered notes.

---

## 1. Frame the Inventory Mission

- **1.1 Name the inventory clearly**
  - Restate what you are inventorying in one precise sentence.
  - Examples:
    - "API endpoints in the public HTTP surface of Service X."
    - "Domain events flowing through our message bus."
    - "React components in the onboarding funnel."
    - "External systems and third-party integrations for this product."
- **1.2 Define the item type and granularity**
  - Are items:
    - Individual functions / components / files?
    - Interfaces / APIs / domains / bounded contexts?
    - Resources (tables, topics, queues, buckets)?
  - Decide what counts as **one row** in the inventory to avoid mixing levels.
- **1.3 Clarify purpose and consumers**
  - Why is this inventory needed now (architecture, refactor, migration, audit, cost control, risk analysis)?
  - Who will use it (you, future you, other engineers, product, ops)?

---

## 2. Discover Sources and Boundaries

- **2.1 Identify authoritative sources**
  - Code: repositories, directories, modules, configuration files.
  - Infrastructure: IaC (Terraform, Helm, CloudFormation), deployment manifests, CI/CD configs.
  - Domain: specs, ADRs, docs, diagrams, spreadsheets, existing lists.
- **2.2 Use structural tools to map the territory**
  - For code/system targets, call `/deep-explore` to understand where relevant items live structurally.
  - Use `code_search` and `grep_search` to locate likely definitions and registrations (e.g. route registries, job schedulers, model definitions).
- **2.3 Define inclusion/exclusion rules**
  - In scope: which projects, directories, environments, or domains.
  - Out of scope: legacy areas, experimental branches, or generated code (unless explicitly relevant).

---

## 3. Design the Inventory Schema (Columns/Fields)

- **3.1 Choose core fields for each item**
  - Typical baseline fields:
    - Identifier / name
    - Type / category
    - Location (file path, URL, namespace, environment)
    - Brief description / role
- **3.2 Add contextual fields based on purpose**
  - For architecture and design (with `/deep-architect` in mind):
    - Bounded context / subsystem
    - Upstream / downstream dependencies
    - Interfaces or contracts it participates in
  - For operations and reliability:
    - Owner / team
    - Environment(s) where it runs
    - Criticality / impact level
    - Observability hooks (logs, metrics, traces)
  - For risk, compliance, and lifecycle:
    - Status (active, deprecated, experimental, planned)
    - Risk level or sensitivity (e.g. PII, financial data)
    - Known issues / TODOs
- **3.3 Decide on representation**
  - Prefer a **tabular representation** (Markdown table or structured list) with columns matching the above fields.
  - Keep fields lean enough to be maintainable but rich enough to be useful.

---

## 4. Enumerate Candidate Items

- **4.1 Generate an initial raw list**
  - For code:
    - Use `code_search` and `grep_search` for patterns (e.g. route registries, controller decorators, job schedulers, model definitions).
    - Traverse key directories identified in `/deep-explore`.
  - For infrastructure:
    - Parse IaC, deployment manifests, and config files for resources (services, queues, topics, buckets, clusters).
  - For concepts/domains:
    - Mine specs, ADRs, design docs, and domain glossaries for named entities and concepts.
- **4.2 Normalize and deduplicate**
  - Unify naming (e.g. consistent service identifiers or resource names).
  - Collapse aliases or synonyms into one canonical item where appropriate.
- **4.3 Classify into categories**
  - Group by type (e.g. API endpoint, background job, data store, external provider).
  - Optionally assign tags (e.g. `auth`, `billing`, `analytics`, `critical-path`).

---

## 5. Enrich Each Item with Context

- **5.1 Fill in schema fields systematically**
  - For each item, populate the agreed fields:
    - Name, type, location.
    - Short description of its responsibility.
    - Relationships (who calls it / what it calls).
- **5.2 Use code and docs to enrich**
  - For code items:
    - Note primary file(s) and key functions.
    - Mention tests or lack thereof.
    - Link to call sites or entrypoints where feasible.
  - For infra items:
    - Capture region, size, scaling policies, key config flags.
  - For domain concepts:
    - Describe domain role, invariants, and example scenarios.
- **5.3 Add status, risk, and importance**
  - Status: active / deprecated / experimental / planned.
  - Importance: critical / high / medium / low.
  - Known issues or TODOs that affect usage (e.g. "scheduled for migration", "known flaky endpoint").

---

## 6. Analyze Coverage, Gaps, and Patterns

- **6.1 Check inventory completeness relative to scope**
  - Compare expected counts (e.g. known services, modules, or flows) with what was found.
  - Note suspicious gaps (e.g. no inventory entries for a known feature area).
- **6.2 Identify clusters and hotspots**
  - Areas with many high-criticality items.
  - Items with many dependencies (potential architectural hot spots).
  - Surfaces exposed to external parties (public APIs, external systems).
- **6.3 Prepare views for different consumers**
  - For architects: slices by bounded context, dependency graph hints, and critical paths.
  - For ops: slices by environment, criticality, and observability coverage.
  - For compliance: slices by data sensitivity and external integrations.

---

## 7. Produce the Inventory Artifact

- **7.1 Choose file location and naming**
  - Place the inventory where it naturally belongs in the vault or repo, for example:
    - Architecture/component inventories near product specs (e.g. `40-product/...`).
    - Code/infrastructure inventories under `50-engineering/` or `infra/` directories.
  - Name it descriptively (e.g. `INVENTORY-APIS-SERVICE-X.md`, `INVENTORY-DOMAINS-CORE-SYSTEM.md`).
- **7.2 Structure the document**
  - Include:
    - Mission and scope description.
    - The inventory table/list (possibly grouped by category).
    - Summary observations (gaps, hotspots, risks).
    - Links to relevant workflows and docs (`deep-architect`, `deep-data`, `deep-audit`, etc.).
- **7.3 Make it easy to maintain**
  - Prefer simple formats (Markdown tables, bullet lists) over exotic tooling.
  - Note how and when it should be updated (e.g. during major releases, audits, or refactors).

---

## 8. Connect Inventory to Architecture and Change Workflows

- **8.1 Feed into `/deep-architect` and related workflows**
  - Use the inventory as a concrete input when:
    - Designing or evolving architecture for the inventoried area.
    - Choosing bounded contexts and responsibilities.
    - Planning resilience, observability, and failure domains.
- **8.2 Support audits, migrations, and refactors**
  - For `/deep-audit` and `/deep-refactor`:
    - Use the inventory to scope work and avoid missing items.
  - For `/deep-propagate` and migrations:
    - Use the inventory to enumerate all touchpoints for a given change.
- **8.3 Surface follow-up questions and work**
  - List items that clearly need deeper understanding (`/deep-understand`), investigation (`/deep-investigate`), or optimization (`/deep-optimize`).
  - Tag high-risk or unclear items as candidates for future workflows.
