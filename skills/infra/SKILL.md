---
name: infra
description: Design and operate resilient, secure, and automatable infrastructure
command: /infra
aliases: ["/infrastructure", "/devops", "/platform"]
synonyms: ["/provisioning", "/provisioned", "/scaling", "/containerising", "/containerizing"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: operations
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill covers infrastructure design, deployment, and operations using cloud-native and infrastructure-as-code practices. It focuses on architecture decisions, IaC implementations, and operational procedures. It does not cover application-level code but addresses how applications are deployed and operated.
</scope_constraints>

<context>
This workflow instructs the agent to help design and operate robust infrastructure using modern cloud-native and infrastructure-as-code practices. It emphasizes resilience, security, automation, and cost optimization.
</context>

<instructions>

## Inputs

- Application architecture and requirements
- Workload characteristics and traffic patterns
- SLO targets (availability, latency, throughput)
- Budget, compliance, and team constraints
- Existing infrastructure context

## Step 1: Clarify Workloads, SLOs, and Constraints

- Understand what needs to run:
  - Application types, traffic patterns, data requirements.
- Define service level objectives:
  - Availability, latency, throughput targets.
- Identify constraints:
  - Budget, compliance, team skills, existing commitments.

## Step 2: Design Environments and Topology

- Plan environment strategy:
  - Development, staging, production, and any special-purpose environments.
- Design network topology:
  - VPCs, subnets, security groups, load balancers.
- Consider multi-region/multi-cloud as warranted by availability requirements.

## Step 3: Embrace Infrastructure as Code

- Use declarative IaC tools:
  - Terraform, Pulumi, CloudFormation, or similar.
- Organize code for maintainability:
  - Modules, environments, clear variable management.
- Version control all infrastructure code.
- Implement CI/CD for infrastructure changes.

## Step 4: Plan for Reliability and Resilience

- Design for failure:
  - Redundancy, health checks, auto-scaling.
- Implement disaster recovery:
  - Backups, restore testing, runbooks.
- Plan capacity:
  - Right-size resources, plan for growth.

## Step 5: Address Security and Compliance

- Apply least privilege:
  - IAM policies, service accounts, network segmentation.
- Encrypt data:
  - In transit and at rest.
- Implement audit logging.
- Address compliance requirements:
  - Certifications, data residency, retention.

## Step 6: Operational Excellence

- Implement comprehensive monitoring and alerting.
- Create runbooks for common operations.
- Automate routine maintenance.
- Practice incident response.

## Step 7: Continuous Improvement

- Review and optimize costs regularly.
- Stay current with platform capabilities.
- Gather feedback from development teams.
- Evolve architecture as requirements change.

## Error Handling

- **Missing SLO specification**: Recommend default targets based on workload type
- **Unclear workload requirements**: Request detailed application specifications
- **Compliance uncertainty**: Flag for compliance officer review before implementation
- **Cost overruns**: Recommend cost optimization or right-sizing strategies
- **Deployment failures**: Provide rollback procedures and diagnostic steps

</instructions>

<output_format>
- **Architecture diagram**: Visual representation of infrastructure topology
- **IaC modules**: Organized Terraform/Pulumi modules for deployment
- **Environment strategy**: Dev/staging/prod setup with promotion procedures
- **SLO specification**: Target availability, latency, throughput metrics
- **Security design**: IAM policies, network segmentation, encryption strategy
- **Disaster recovery plan**: Backup strategy, RTO/RPO targets, restore procedures
- **Monitoring and alerting**: Dashboards, alert thresholds, runbook links
- **Cost optimization**: Resource sizing, scaling policies, cost projections
</output_format>
