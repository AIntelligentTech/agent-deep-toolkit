---
name: data
description: Design trustworthy data models, quality controls, and governance for
  analytics and AI
activation: auto
---

# Data Workflow

This workflow instructs Cascade to help teams build data systems that are trustworthy, well-modeled, and governed appropriately.

## 1. Clarify Data Use Cases and Consumers

- Identify how the data will be used:
  - Analytics dashboards, ML model training, operational decisions, regulatory reporting.
- Understand the consumers:
  - Data scientists, analysts, product teams, downstream systems.
- Define quality expectations:
  - Freshness, accuracy, completeness, consistency.

## 2. Map Data Sources and Lineage

- Inventory data sources:
  - Operational databases, event streams, third-party APIs, files.
- Trace data lineage:
  - How does data flow from source to consumption?
- Identify transformations and potential quality risks at each step.

## 3. Design Data Models

- Choose appropriate modeling approaches:
  - Normalized for operations, denormalized for analytics.
  - Dimensional modeling (star/snowflake) for warehouses.
  - Event-based models for streaming.
- Define entities, relationships, and key semantics clearly.
- Use consistent naming conventions.

## 4. Define Data Contracts

- Specify expectations between producers and consumers:
  - Schema, types, nullability, valid values.
  - Freshness and availability guarantees.
- Version contracts and plan for evolution.
- Use schema registries or contract testing where appropriate.

## 5. Implement Data Quality Checks

- Define quality dimensions to monitor:
  - Completeness, uniqueness, validity, consistency, timeliness.
- Implement checks at ingestion and transformation stages.
- Set up alerting for quality violations.
- Plan for remediation workflows.

## 6. Address Privacy, Security, and Governance

- Classify data sensitivity:
  - PII, financial, health, confidential business data.
- Apply appropriate controls:
  - Encryption, access controls, masking, retention policies.
- Document data ownership and stewardship.
- Ensure compliance with relevant regulations.

## 7. Document Semantics and Usage

- Create a data catalog or dictionary:
  - Field definitions, business meaning, valid values.
- Document known limitations and caveats.
- Provide usage examples for common queries.

## 8. Plan for Evolution

- Design for schema evolution without breaking consumers.
- Plan migration strategies for major changes.
- Monitor usage patterns to inform future development.