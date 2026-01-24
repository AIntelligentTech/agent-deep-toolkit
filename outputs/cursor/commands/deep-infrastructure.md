# Deep Infrastructure Workflow

This workflow instructs Cascade to think like an experienced SRE/DevOps/infra engineer.

## 1. Clarify Workloads, SLOs, and Constraints

- Describe the services and workloads to be supported:
  - Traffic patterns, data volumes, latency expectations, and dependencies.
- Identify or propose SLOs for availability, latency, and error rates.
- Capture constraints:
  - Budget, regions, compliance, team skills, and existing platforms.

## 2. Design Environments and Topology

- Define environment strategy:
  - Dev, test, staging, production, and any specialized environments.
- Sketch high-level topology:
  - Regions, availability zones, network segments, and trust boundaries.
- Consider multi-region, multi-cloud, or hybrid approaches where justified.

## 3. Embrace Infrastructure as Code and Automation

- Choose appropriate IaC tools (e.g., Terraform, CloudFormation, Pulumi) based on stack.
- Define patterns for:
  - Reusable modules, configuration management, and secrets handling.
- Integrate infra changes into CI/CD with review, validation, and automated testing.

## 4. Plan for Reliability, Scalability, and Resilience

- Select scaling strategies:
  - Horizontal vs vertical scaling, autoscaling policies, and capacity buffers.
- Design for failure:
  - Redundancy, graceful degradation, backpressure, and safe fallbacks.
- Align with `/workflow-deep-observability` to ensure infra health is visible.

## 5. Address Security and Compliance Baselines

- Apply security best practices:
  - Least privilege, network segmentation, patching, hardened images, and key rotation.
- Consider relevant standards and benchmarks (e.g., CIS benchmarks).
- Integrate security checks into pipelines where feasible.

## 6. Operational Excellence and Runbooks

- Define operational tasks and on-call responsibilities.
- Create and maintain runbooks for:
  - Common incidents, deployments, rollbacks, and maintenance.
- Use post-incident learnings (`/workflow-deep-incident`) to refine infra and operations.

## 7. Iterate with Measurements and Feedback

- Monitor infra-related costs, performance, and reliability trends.
- Plan incremental improvements rather than large, risky overhauls.
- Keep documentation and diagrams in sync with reality to avoid configuration drift.

