---
name: index
description: Navigator for all workflows - understand when to use each skill and how they relate
command: /index
aliases: ["/help", "/workflows", "/skills"]
activation-mode: contextual
user-invocable: true
disable-model-invocation: true
---

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
