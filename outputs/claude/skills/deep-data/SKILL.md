---
name: deep-data
description: Design trustworthy data models, quality controls, and governance for analytics and AI
disable-model-invocation: true
user-invocable: true
---

# Deep Data Workflow

This workflow instructs Cascade to treat data as a product: modeled clearly, validated continuously, and governed responsibly.

## 1. Clarify Data Use Cases and Stakeholders

- Identify decisions, models, and reports that depend on the data.
- List stakeholders:
  - Producers, consumers, data owners, and downstream teams.
- Classify data domains (e.g., customer, product, billing, events).

## 2. Map Sources, Lineage, and Ownership

- Inventory upstream systems and pipelines that feed the data.
- Establish clear ownership for each key dataset or table.
- Sketch high-level lineage from raw inputs to curated outputs.

## 3. Design Data Models and Contracts

- Choose modeling approaches appropriate to the stack (e.g., star schema, data vault, event models).
- Define schemas, primary keys, relationships, and naming conventions.
- Specify **data contracts** between producers and consumers:
  - Schemas, SLAs for freshness, and expectations around nulls and defaults.

## 4. Define Data Quality Checks and Monitoring

- Identify quality dimensions that matter:
  - Freshness, completeness, uniqueness, validity, consistency, and accuracy.
- Implement automated checks where possible:
  - Threshold-based alerts, anomaly detection, schema change monitoring.
- Integrate checks into pipelines and CI/CD for data ("data tests").

## 5. Address Privacy, Security, and Governance

- Classify data sensitivity (e.g., public, internal, personal, special categories).
- Align access controls, encryption, and retention with classification.
- Ensure compliance with relevant regulations and policies by using `/workflow-deep-regulation` and `/workflow-deep-ethics` where appropriate.

## 6. Document Semantics and Usage

- Write clear documentation for datasets:
  - Definitions of fields, units, caveats, and known issues.
- Link data docs to dashboards, models, and application code that use them.
- Encourage feedback loops when consumers find inconsistencies or gaps.

## 7. Evolve Data Models Safely

- Manage schema changes with deprecation plans and migration paths.
- Use feature flags, dual-write/read strategies, or views to smooth transitions.
- Periodically review data models and quality metrics to ensure they still fit evolving product and AI needs.

