---
name: infra
description: Design and operate resilient, secure, and automatable infrastructure
command: /infra
aliases: ["/infrastructure", "/devops", "/platform"]
synonyms: ["/provisioning", "/provisioned", "/scaling", "/containerising", "/containerizing"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---

# Infrastructure Workflow

This workflow instructs Cascade to help design and operate robust infrastructure using modern cloud-native and infrastructure-as-code practices.

## 1. Clarify Workloads, SLOs, and Constraints

- Understand what needs to run:
  - Application types, traffic patterns, data requirements.
- Define service level objectives:
  - Availability, latency, throughput targets.
- Identify constraints:
  - Budget, compliance, team skills, existing commitments.

## 2. Design Environments and Topology

- Plan environment strategy:
  - Development, staging, production, and any special-purpose environments.
- Design network topology:
  - VPCs, subnets, security groups, load balancers.
- Consider multi-region/multi-cloud as warranted by availability requirements.

## 3. Embrace Infrastructure as Code

- Use declarative IaC tools:
  - Terraform, Pulumi, CloudFormation, or similar.
- Organize code for maintainability:
  - Modules, environments, clear variable management.
- Version control all infrastructure code.
- Implement CI/CD for infrastructure changes.

## 4. Plan for Reliability and Resilience

- Design for failure:
  - Redundancy, health checks, auto-scaling.
- Implement disaster recovery:
  - Backups, restore testing, runbooks.
- Plan capacity:
  - Right-size resources, plan for growth.

## 5. Address Security and Compliance

- Apply least privilege:
  - IAM policies, service accounts, network segmentation.
- Encrypt data:
  - In transit and at rest.
- Implement audit logging.
- Address compliance requirements:
  - Certifications, data residency, retention.

## 6. Operational Excellence

- Implement comprehensive monitoring and alerting.
- Create runbooks for common operations.
- Automate routine maintenance.
- Practice incident response.

## 7. Continuous Improvement

- Review and optimize costs regularly.
- Stay current with platform capabilities.
- Gather feedback from development teams.
- Evolve architecture as requirements change.
