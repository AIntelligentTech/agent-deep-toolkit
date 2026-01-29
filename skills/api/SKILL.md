---
name: api
description: API design, contracts, versioning, and documentation
command: /api
aliases: ["/api-design", "/endpoint"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# API Workflow

This workflow instructs Cascade to design and document APIs that are intuitive, consistent, and well-documented.

## 1. Understand API Requirements

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

## 2. Design Resource Model

- Identify resources:
  - Core entities and their relationships.
  - Resource naming (nouns, plural).
- Define operations:
  - CRUD operations needed.
  - Non-CRUD actions (use verbs sparingly).
- Consider resource hierarchy:
  - Nested vs flat resources.
  - URL structure.

## 3. Design Request/Response Contracts

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

## 4. Plan for Versioning

- Choose versioning strategy:
  - URL path (/v1/...).
  - Header-based.
  - Query parameter.
- Define compatibility rules:
  - What constitutes breaking vs non-breaking.
- Plan deprecation process:
  - Notice period.
  - Migration guidance.

## 5. Design for Security

- Choose authentication method:
  - API keys, OAuth, JWT.
- Define authorization rules:
  - Resource-level permissions.
  - Rate limiting.
- Protect sensitive data:
  - Encryption, masking.

## 6. Design Error Handling

- Define error response format:
  - Error code, message, details.
  - Correlation ID for debugging.
- Use appropriate HTTP status codes.
- Provide actionable error messages.

## 7. Create API Documentation

- Document each endpoint:
  - Description and purpose.
  - Request format with examples.
  - Response format with examples.
  - Error cases.
- Use OpenAPI/Swagger for machine-readable docs.
- Include authentication instructions.

## 8. Implement Contract Testing

- Write contract tests:
  - Verify API meets its documented contract.
  - Test from consumer perspective.
- Automate in CI/CD.
- Consider consumer-driven contracts for microservices.

## 9. Design for Evolvability

- Build in extensibility:
  - Allow additional fields.
  - Avoid overly specific designs.
- Monitor usage:
  - Which endpoints are used.
  - Performance characteristics.
- Plan for future needs.
