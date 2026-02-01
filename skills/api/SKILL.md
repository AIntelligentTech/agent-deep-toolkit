---
name: api
description: API design, contracts, versioning, and documentation
command: /api
aliases: ["/api-design", "/endpoint"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: design
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# API Workflow

This workflow instructs Cascade to design and document APIs that are intuitive, consistent, and well-documented.

<scope_constraints>
- Focuses on RESTful API design best practices
- Covers design, contracts, versioning, and documentation
- Applies to internal, external, and public API contexts
- Not a replacement for complete API governance frameworks
- Assumes HTTP/REST as primary transport (extensible to gRPC, GraphQL)
</scope_constraints>

<context>
**Dependencies:**
- Understanding of HTTP methods and status codes
- Familiarity with request/response payload design
- Knowledge of authentication and authorization concepts
- Experience with API documentation tools (OpenAPI/Swagger recommended)

**Prerequisites:**
- Clear API requirements and use case definition
- Identification of target consumers
- Alignment on quality attributes (performance, security, scalability)
</context>

<instructions>

## Inputs

- API purpose and target consumers (internal, external, public)
- Use cases and user journeys
- Existing APIs or systems that must be integrated
- Performance, security, and compatibility requirements
- Constraints (team skills, technology stack, deployment model)

## Steps

### Step 1: Understand API Requirements

- Clarify the purpose:
  - What capability is being exposed?
  - Who are the consumers (internal, external, public)?
- Define use cases:
  - Primary workflows.
  - Edge cases and error scenarios.
- Identify constraints:
  - Performance requirements.
  - Security and authentication needs.
  - Compatibility with existing APIs.

### Step 2: Design Resource Model

- Identify resources:
  - Core entities and their relationships.
  - Resource naming (nouns, plural).
- Define operations:
  - CRUD operations needed.
  - Non-CRUD actions (use verbs sparingly).
- Consider resource hierarchy:
  - Nested vs flat resources.
  - URL structure.

### Step 3: Design Request/Response Contracts

- Define request formats:
  - Parameters (path, query, body).
  - Required vs optional fields.
  - Validation rules.
- Define response formats:
  - Success responses with consistent structure.
  - Error responses with clear messages.
  - Pagination for collections.
- Choose content types:
  - JSON, with consistent casing.

### Step 4: Plan for Versioning

- Choose versioning strategy:
  - URL path (/v1/...).
  - Header-based.
  - Query parameter.
- Define compatibility rules:
  - What constitutes breaking vs non-breaking.
- Plan deprecation process:
  - Notice period.
  - Migration guidance.

### Step 5: Design for Security

- Choose authentication method:
  - API keys, OAuth, JWT.
- Define authorization rules:
  - Resource-level permissions.
  - Rate limiting.
- Protect sensitive data:
  - Encryption, masking.

### Step 6: Design Error Handling

- Define error response format:
  - Error code, message, details.
  - Correlation ID for debugging.
- Use appropriate HTTP status codes.
- Provide actionable error messages.

### Step 7: Create API Documentation

- Document each endpoint:
  - Description and purpose.
  - Request format with examples.
  - Response format with examples.
  - Error cases.
- Use OpenAPI/Swagger for machine-readable docs.
- Include authentication instructions.

### Step 8: Implement Contract Testing

- Write contract tests:
  - Verify API meets its documented contract.
  - Test from consumer perspective.
- Automate in CI/CD.
- Consider consumer-driven contracts for microservices.

### Step 9: Design for Evolvability

- Build in extensibility:
  - Allow additional fields.
  - Avoid overly specific designs.
- Monitor usage:
  - Which endpoints are used.
  - Performance characteristics.
- Plan for future needs.

## Error Handling

**Common API design pitfalls:**
- Inconsistent error response formats across endpoints
- Missing or unclear error messages and codes
- Unclear versioning strategy causing consumer confusion
- Over-specification leading to rigid, hard-to-evolve APIs
- Inadequate documentation or out-of-date examples

**Mitigation strategies:**
- Establish a consistent error response schema before implementation
- Version early; plan deprecation as part of initial design
- Include examples and non-examples in documentation
- Review API design with consumers (internal teams or partners)
- Test API evolution scenarios during design phase

</instructions>

<output_format>

The output of this skill is a **comprehensive API design document** that includes:

1. **Resource Model** — Core entities, relationships, and URL structure
2. **Request/Response Contracts** — Payload schemas with examples for key operations
3. **Versioning Strategy** — Approach and deprecation plan
4. **Security Design** — Authentication, authorization, and data protection approach
5. **Error Handling Specification** — Error codes, response format, and examples
6. **API Documentation** — Endpoint reference (OpenAPI/Swagger format recommended)
7. **Contract Tests** — Test cases covering key scenarios and edge cases
8. **Evolution Plan** — Extensibility strategy and monitoring approach
9. **Design Rationale** — Trade-offs and decisions made during design

Deliverables typically include:
- Textual design document or wiki pages
- OpenAPI/Swagger specification (machine-readable)
- Sample client code or SDKs
- Contract test suite
- Implementation checklist

</output_format>
