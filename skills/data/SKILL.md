---
name: data
description: Design trustworthy data models, quality controls, and governance for analytics and AI
command: /data
aliases: []
synonyms: ["/modelling", "/modeling", "/modeled", "/modelled"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: design
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Data Workflow

This workflow instructs Cascade to help teams build data systems that are trustworthy, well-modeled, and governed appropriately.

<scope_constraints>
- Focuses on data modeling, quality, and governance for analytics and AI
- Applies to data warehouses, data lakes, and operational data systems
- Covers schema design, quality controls, and data lineage
- Includes data classification and access management
- Works with structured and semi-structured data
- Not a replacement for detailed database administration or infrastructure setup
</scope_constraints>

<context>
**Dependencies:**
- Understanding of data modeling approaches (relational, dimensional, event-based)
- Knowledge of data quality dimensions and assessment
- Familiarity with data governance and data catalog concepts
- Understanding of data classification and sensitivity levels
- Knowledge of relevant regulations (GDPR, data residency, etc.)

**Prerequisites:**
- Clear data use cases and consumer groups
- Understanding of data sources and volumes
- Defined quality expectations and SLOs
- Identified regulatory or compliance requirements
- Access to existing systems and documentation
</context>

<instructions>

## Inputs

- Data use cases (analytics, ML training, operational decisions, reporting)
- Consumer groups (analysts, data scientists, product teams, systems)
- Data sources (databases, APIs, logs, files, third-party)
- Expected data volumes, freshness, and growth rates
- Quality requirements (accuracy, completeness, consistency, timeliness)
- Data sensitivity and classification levels
- Applicable regulations and retention policies

## Steps

### Step 1: Clarify Data Use Cases and Consumers

- Identify how the data will be used:
  - Analytics dashboards, ML model training, operational decisions, regulatory reporting.
- Understand the consumers:
  - Data scientists, analysts, product teams, downstream systems.
- Define quality expectations:
  - Freshness, accuracy, completeness, consistency.

### Step 2: Map Data Sources and Lineage

- Inventory data sources:
  - Operational databases, event streams, third-party APIs, files.
- Trace data lineage:
  - How does data flow from source to consumption?
- Identify transformations and potential quality risks at each step.

### Step 3: Design Data Models

- Choose appropriate modeling approaches:
  - Normalized for operations, denormalized for analytics.
  - Dimensional modeling (star/snowflake) for warehouses.
  - Event-based models for streaming.
- Define entities, relationships, and key semantics clearly.
- Use consistent naming conventions.

### Step 4: Define Data Contracts

- Specify expectations between producers and consumers:
  - Schema, types, nullability, valid values.
  - Freshness and availability guarantees.
- Version contracts and plan for evolution.
- Use schema registries or contract testing where appropriate.

### Step 5: Implement Data Quality Checks

- Define quality dimensions to monitor:
  - Completeness, uniqueness, validity, consistency, timeliness.
- Implement checks at ingestion and transformation stages.
- Set up alerting for quality violations.
- Plan for remediation workflows.

### Step 6: Address Privacy, Security, and Governance

- Classify data sensitivity:
  - PII, financial, health, confidential business data.
- Apply appropriate controls:
  - Encryption, access controls, masking, retention policies.
- Document data ownership and stewardship.
- Ensure compliance with relevant regulations.

### Step 7: Document Semantics and Usage

- Create a data catalog or dictionary:
  - Field definitions, business meaning, valid values.
- Document known limitations and caveats.
- Provide usage examples for common queries.

### Step 8: Plan for Evolution

- Design for schema evolution without breaking consumers.
- Plan migration strategies for major changes.
- Monitor usage patterns to inform future development.

## Error Handling

**Common data modeling pitfalls:**
- Over-normalizing operational data (should be denormalized for analytics)
- Under-specifying quality expectations leading to data trust issues
- Ignoring data lineage and making it hard to trace data origin/transformations
- Failing to classify data sensitivity leading to access control gaps
- Not planning for schema evolution, breaking downstream consumers
- Overlooking data retention and compliance requirements

**Mitigation strategies:**
- Choose modeling approach appropriate for use case (normalized for operations, denormalized for analytics)
- Define explicit quality SLOs and implement automated checks
- Document data lineage and maintain data catalog
- Classify all data and enforce access controls accordingly
- Use versioning and contract-based evolution strategies
- Document retention policies and implement automated cleanup

</instructions>

<output_format>

The output of this skill is a **comprehensive data design specification** with governance:

1. **Use Case & Consumer Analysis** — Data consumers, use cases, and quality expectations
2. **Data Lineage Map** — Source systems, transformations, and consumption points
3. **Data Models** — Schema design for operational and analytical uses
4. **Data Contracts** — Schema definitions, types, nullability, valid values, versioning
5. **Quality Controls** — Completeness, uniqueness, validity, consistency checks and alerting
6. **Privacy & Security Design** — Data classification, access controls, encryption, masking
7. **Data Governance** — Ownership, stewardship, and policies
8. **Data Dictionary** — Field definitions, business meaning, examples, limitations
9. **Evolution Strategy** — Plan for schema changes, migration procedures
10. **Implementation Roadmap** — Phased rollout and success criteria

Deliverables typically include:
- Data modeling document with ERD or equivalent
- Schema definitions (SQL DDL or equivalent format)
- Data quality checks and alerting configuration
- Data governance and access control policies
- Data dictionary or catalog
- Data lineage diagram
- Migration guide for schema changes
- Optional: Automated data quality dashboard

</output_format>
