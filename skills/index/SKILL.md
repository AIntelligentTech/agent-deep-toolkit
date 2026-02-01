---
name: index
description: Navigator for all workflows - understand when to use each skill and how they relate
command: /index
aliases: ["/help", "/workflows", "/skills"]
synonyms: ["/help", "/listing", "/navigating"]
activation-mode: contextual
user-invocable: true
disable-model-invocation: true
category: meta
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill provides navigation and discovery for all available workflows. It helps users understand the purpose of each skill, when to use it, and how skills combine. It does not execute work but rather directs users to appropriate skills.
</scope_constraints>

<context>
This skill serves as a navigator for all available workflows, helping you understand when to use each and how they connect. It provides a comprehensive index of capabilities organized by domain and use case.
</context>

<instructions>

## Inputs

- User question or stated objective
- Current context or problem to solve
- Prior workflows used (for sequencing recommendations)

## Step 1: Understand the User's Need

- What are they trying to accomplish?
- What domain is the work in (reasoning, architecture, implementation, operations)?
- Have they used related skills before?

## Step 2: Identify Relevant Skills

- Match the objective to appropriate skills
- Consider skill combinations and sequences
- Identify prerequisite or follow-up skills

## Step 3: Present Skill Options

- List relevant skills with brief descriptions
- Highlight when to use each (decision criteria)
- Show common workflow sequences

## Step 4: Guide Toward Appropriate Skills

- Explain why a particular skill is recommended
- Suggest skill combinations for complex work
- Provide examples of effective patterns

## Step 5: Support Skill Discovery

- Help users explore the skill catalog
- Suggest skills based on problem patterns
- Connect related domains and workflows

## Error Handling

- **Unclear objective**: Ask clarifying questions about the goal
- **Multiple applicable skills**: Explain differences and sequencing
- **Missing skill**: Identify gaps and suggest alternatives
- **Skill misunderstanding**: Clarify purpose and scope

</instructions>

<output_format>
- **Skill recommendations**: List of relevant skills with rationale
- **Skill descriptions**: Purpose and primary use case for each
- **Workflow sequences**: Recommended skill ordering for complex work
- **Decision criteria**: When to choose each skill
- **Examples**: Concrete scenarios showing skill application
</output_format>

# Workflow Index

This skill serves as a navigator for all available workflows, helping you understand when to use each and how they connect.

## Workflow Categories

### 🧠 Core Reasoning
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/think` | Deep multi-perspective analysis | Before complex decisions or implementations |
| `/decide` | Structured decision-making | Choosing between options with trade-offs |
| `/search` | Local + web search combined | Finding code, docs, or external information |
| `/investigate` | Root-cause analysis | Understanding why something happened |
| `/explore` | Build mental models | Learning a codebase, concept, or technology |

### 🏗️ Architecture & Design
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/architect` | System design | Major technical decisions, new systems |
| `/design` | Product/interaction design | User-facing features |
| `/ux` | UX evaluation | Reviewing and improving interfaces |
| `/spec` | Write specifications | Before implementation begins |
| `/document` | Create/find documentation | Any documentation needs |
| `/tokens` | Design system tokens | Building design systems |
| `/svg` | SVG generation | Creating vector graphics |

### 💻 Implementation
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/code` | Quality implementation | Writing production code |
| `/debug` | Find and fix issues | Something isn't working |
| `/refactor` | Improve code structure | Code needs restructuring |
| `/test` | Test strategy and implementation | Building test suites |
| `/optimize` | Performance improvement | Speed/efficiency matters |
| `/polish` | Final refinement | Making things world-class |

### ⚙️ Operations
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/bash` | CLI automation | Terminal scripting and automation |
| `/git` | Version control | Git workflows and best practices |
| `/data` | Data modeling | Database and data pipeline design |
| `/infra` | Infrastructure | Cloud, DevOps, platform work |
| `/observe` | Observability | Logs, metrics, traces |
| `/incident` | Incident response + retros | Outages and learning from them |
| `/inventory` | Catalog and enumerate | Systematic enumeration |

### 📋 Governance
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/compliance` | Ethics + regulation | Legal and ethical considerations |
| `/threat` | Security assessment | Threat modeling |

### 🔄 Change Management
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/impact` | Impact analysis | Before major changes |
| `/propagate` | Safe change rollout | Applying changes broadly |
| `/brainstorm` | Idea generation | Need creative solutions |
| `/followup` | Next steps planning | After completing work |
| `/experiment` | Run experiments | Validating hypotheses |

### 🔧 Meta
| Skill | Purpose | Use When |
|-------|---------|----------|
| `/iterate` | Iterative development | Sustained development work |
| `/relentless` | Maximum-effort iteration | High-stakes work where thoroughness matters more than speed |
| `/index` | This navigator | Finding the right workflow |
| `/audit` | Systematic review | Comprehensive codebase review |
| `/plan` | Implementation planning | Complex multi-phase work |
| `/estimate` | Effort estimation | Scoping work |

## Common Workflow Combinations

| Goal | Workflow Sequence |
|------|-------------------|
| New feature | `/design` → `/spec` → `/architect` → `/code` → `/test` |
| Debug an issue | `/search` → `/debug` → `/investigate` → `/code` |
| Code review | `/explore` → `/threat` → `/ux` → feedback |
| Performance fix | `/observe` → `/optimize` → `/test` → `/benchmark` |
| Refactoring | `/explore` → `/refactor` → `/test` → `/propagate` |
| Incident | `/incident` (response) → `/incident` (retro) → `/followup` |

## Synergy Guidance

- Use `/think` before any complex decision.
- Use `/search` to ground work in facts.
- Use `/decide` when trade-offs are significant.
- Use `/test` alongside any code work.
- Use `/document` to capture decisions.
