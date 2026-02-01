---
name: onboard
description: Create onboarding materials for developers joining a codebase
command: /onboard
aliases: ["/onboarding", "/getting-started"]
synonyms: ["/onboarding", "/onboarded", "/getting-started"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: skill
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Onboard Workflow

<scope_constraints>
This workflow instructs Cascade to create or improve developer onboarding materials that get new contributors productive quickly. Covers environment setup, architecture understanding, key workflows, navigation, and cultural context.
</scope_constraints>

<context>
Good onboarding reduces time-to-productivity from weeks to days. It builds confidence, establishes patterns, and creates a shared vocabulary. Effective onboarding covers multiple learning styles and is continuously updated based on new contributor feedback.
</context>

<instructions>

## Inputs

- Target audience: Who is being onboarded (new hires, open source contributors, contractors)?
- Project scope: Codebase size, complexity, technology stack
- Current state: What onboarding materials exist?
- Pain points: What do new contributors struggle with?
- Context: Key milestones, learning progression, success criteria

## Step 1: Understand the Target Audience

- Identify who is being onboarded:
  - New team members.
  - Open source contributors.
  - Contractors or rotations.
- Assess their expected background:
  - Required skills and experience.
  - Familiarity with the domain.
- Note common gaps or challenges.

### Step 2: Map the Learning Journey

- Define learning progression:
  - Day 1: Environment setup, first build.
  - Week 1: Basic navigation, first contribution.
  - Month 1: Deeper understanding, independent work.
- Identify key milestones:
  - First successful build.
  - First passing test.
  - First PR merged.

### Step 3: Create Setup Guide

- Document environment setup:
  - Required tools and versions.
  - Installation steps.
  - Configuration instructions.
- Include troubleshooting:
  - Common issues and solutions.
  - Where to get help.
- Verify on a fresh machine.

### Step 4: Create Architecture Overview

- Explain the system at a high level:
  - Purpose and main use cases.
  - Key components and their roles.
  - How data flows through the system.
- Include architecture diagrams if helpful.
- Point to deeper documentation for details.

### Step 5: Document Key Workflows

- Explain how to do common tasks:
  - Running the application locally.
  - Running tests.
  - Making changes and submitting PRs.
  - Deploying (if applicable).
- Include examples and commands.

### Step 6: Create Codebase Navigation Guide

- Explain the directory structure:
  - What's where and why.
  - Key files to know about.
- Document naming conventions and patterns.
- Identify good "starting points" for exploration.

### Step 7: Provide Learning Resources

- Link to relevant documentation:
  - Internal docs, ADRs, specs.
  - External resources for technologies used.
- Suggest good first issues or tasks.
- Identify mentors or points of contact.

### Step 8: Include Cultural and Process Info

- Explain team practices:
  - Code review expectations.
  - Communication channels.
  - Meeting rhythms.
- Document decision-making processes.
- Share relevant history and context.

### Step 9: Test and Iterate

- Have someone new follow the guide.
- Gather feedback:
  - What was confusing?
  - What was missing?
- Keep the guide updated as things change.

## Error Handling

- **Setup fails on fresh machine:** Document error, provide solution, update guide
- **Contributor stuck early:** Review guide for gaps, pair with experienced contributor
- **Outdated documentation:** Version docs, create update schedule, assign ownership
- **Missing prerequisites:** Add to setup guide with version requirements

</instructions>

<output_format>

Provide complete onboarding materials as the output:

1. **Quick Start Guide**: 15-minute setup to first build
2. **Architecture Overview**: System purpose, key components, data flow
3. **Codebase Navigation**: Directory structure, naming conventions, starting points
4. **Key Workflows**: Run app, run tests, make changes, submit PR, deploy
5. **Learning Resources**: Links to docs, frameworks, good first issues
6. **Cultural Context**: Team practices, communication, decision-making
7. **Troubleshooting Guide**: Common issues and solutions

</output_format>
