# Agent Deep Toolkit

A portable, cross-agent meta-cognitive toolkit for development workflows.

This directory is designed to become the **root of a standalone repo** that
packages the full workflow suite for:

- **Windsurf** – `.windsurf/workflows`-style deep workflows.
- **Claude Code** – SKILL-based slash commands using the Agent Skills standard.
- **Cursor** – `.cursor/commands`-style slash commands.
- **OpenCode** – `.opencode/commands`-style commands with native OpenCode
  frontmatter.

The goal is to keep procedures conceptually identical across agents while
keeping their implementations **independent** so you can install Windsurf,
Claude Code, or Cursor tooling separately.

## Quick Start (5 Minutes)

### 1️⃣ Install

```bash
# Clone repository
git clone https://github.com/AIntelligentTech/agent-deep-toolkit.git
cd agent-deep-toolkit

# Interactive wizard (recommended for first-time users)
./install.sh --wizard

# Or direct install for all detected agents
./install.sh --agent all --level user
```

### 2️⃣ Choose Your Agent

The installer automatically detects:
- **Claude Code** → Skills installed to `~/.claude/skills/`
- **Windsurf Cascade** → Workflows installed to `~/.windsurf/workflows/`
- **Cursor** → Commands installed to `~/.cursor/commands/`
- **OpenCode** → Commands installed to `~/.opencode/commands/`

### 3️⃣ Try Your First Skill

**Claude Code:** Type in chat
```bash
/think "How should I architect a real-time notification system?"
```

**Windsurf:** Type in chat (auto-suggests contextually)
```bash
/architect
```

**Cursor:** Command Palette (`Cmd+K` or `Ctrl+K`)
```text
think <Enter>
```

**OpenCode:** Type in chat
```bash
/think "notification system design"
```

### 4️⃣ Explore 50 Skills

- Type `/index` (Claude/OpenCode) or `/help` to see all skills
- Read [EXAMPLES.md](EXAMPLES.md) for practical recipes
- Review [ARCHITECTURE.md](ARCHITECTURE.md) to understand the system

## How It Works

```
┌──────────────────────────────────────────┐
│   Single CACE Source (skills/*.md)       │  ← One skill definition
│   Frontmatter + XML-tagged instructions  │
└──────────────┬───────────────────────────┘
               │
               ▼
       ┌───────────────┐
       │ Build Pipeline │  ← Convert to agent formats
       └───────┬────────┘
               │
    ┌──────────┼──────────┬──────────┐
    ▼          ▼          ▼          ▼
 Windsurf   Claude     Cursor    OpenCode   ← Agent-specific outputs
 Workflows  Skills     Commands  Commands
```

**Key Benefits:**
- **Portable:** One skill, four agent formats
- **Deep Work:** Strategic thinking, not just code completion
- **Battle-Tested:** 50 skills refined over real-world projects
- **Open Source:** MIT licensed, community-driven

## Workflow Suite (v2.0)

The toolkit provides **48 specialized workflows** organized into 7 categories:

### 🧠 Core Reasoning (5)

| Command        | Aliases                                    | Purpose                                    |
| -------------- | ------------------------------------------ | ------------------------------------------ |
| `/think`       | `/reason`, `/analyze`, `/ponder`           | Deep multi-perspective analysis            |
| `/decide`      | `/consider`, `/choose`, `/weigh`           | Structured decision-making with frameworks |
| `/search`      | `/find`, `/lookup`, `/locate`, `/research` | Local + web search combined                |
| `/investigate` | `/dig`, `/probe`, `/examine`               | Root-cause analysis and hypothesis testing |
| `/explore`     | `/understand`, `/learn`, `/discover`       | Build mental models of code/concepts       |

### 🏗️ Architecture & Design (9)

| Command      | Aliases                                      | Purpose                                         |
| ------------ | -------------------------------------------- | ----------------------------------------------- |
| `/architect` | `/design-system`, `/structure`, `/blueprint` | System architecture design (C4, DDD)            |
| `/design`    | -                                            | Product and interaction design (Double Diamond) |
| `/ux`        | -                                            | UX evaluation and improvement                   |
| `/spec`      | -                                            | Write specifications and ADRs                   |
| `/document`  | `/docs`, `/write-docs`, `/docstring`         | Documentation discovery and creation            |
| `/tokens`    | `/design-tokens`                             | Extract and systematize design tokens           |
| `/svg`       | -                                            | Generate and validate SVGs                      |
| `/onboard`   | `/onboarding`, `/getting-started`            | Developer onboarding materials                  |
| `/api`       | `/api-design`, `/endpoint`                   | API design, contracts, versioning               |

### 💻 Implementation (11)

| Command       | Aliases                                | Purpose                                          |
| ------------- | -------------------------------------- | ------------------------------------------------ |
| `/code`       | `/implement`, `/build`, `/develop`     | High-quality code implementation                 |
| `/debug`      | `/fix`, `/troubleshoot`, `/diagnose`   | Systematic debugging                             |
| `/refactor`   | `/restructure`, `/reorganize`          | Safe refactoring and design improvement          |
| `/prune`      | `/purge`, `/cleanup`, `/sweep`         | Aggressive dead code and legacy removal          |
| `/test`       | `/verify`, `/validate`, `/check`       | Test strategy and implementation                 |
| `/optimize`   | `/perf`, `/performance`, `/speedup`    | Performance improvement                          |
| `/polish`     | -                                      | Final refinement to world-class quality          |
| `/review`     | `/code-review`, `/cr`                  | Structured code review                           |
| `/dependency` | `/deps`, `/dependencies`               | Dependency management and security               |
| `/benchmark`  | `/perf-test`, `/measure`               | Performance benchmarking                         |
| `/simplify`   | `/reduce-complexity`, `/declutter`     | Complexity reduction                             |

### ⚙️ Operations (9)

| Command      | Aliases                                    | Purpose                          |
| ------------ | ------------------------------------------ | -------------------------------- |
| `/bash`      | `/shell`, `/cli`, `/terminal`              | CLI automation and scripting     |
| `/git`       | `/github`, `/vcs`                          | Git workflows and best practices |
| `/data`      | -                                          | Data modeling and governance     |
| `/infra`     | `/infrastructure`, `/devops`, `/platform`  | Infrastructure design            |
| `/observe`   | `/observability`, `/monitor`, `/metrics`   | Logs, metrics, traces            |
| `/incident`  | `/retrospective`, `/postmortem`, `/outage` | Incident response + retros       |
| `/inventory` | `/catalog`, `/enumerate`                   | Systematic enumeration           |
| `/migrate`   | `/migration`, `/upgrade`                   | Safe data/schema migrations      |
| `/deploy`    | `/release`, `/rollout`                     | Deployment strategy              |

### 📋 Governance (2)

| Command       | Aliases                            | Purpose                       |
| ------------- | ---------------------------------- | ----------------------------- |
| `/compliance` | `/ethics`, `/regulation`, `/legal` | Ethics + regulatory alignment |
| `/threat`     | `/threat-model`, `/security`       | Security threat modeling      |

### 🔄 Change Management (6)

| Command       | Aliases                              | Purpose                         |
| ------------- | ------------------------------------ | ------------------------------- |
| `/integrate`  | `/integration`, `/integrate-plan`    | Holistic integration planning   |
| `/impact`     | -                                    | Change impact analysis          |
| `/propagate`  | -                                    | Safe change rollout             |
| `/brainstorm` | `/ideas`, `/alternatives`, `/ideate` | Idea generation and evaluation  |
| `/followup`   | `/next`, `/nextsteps`                | Next steps planning             |
| `/experiment` | `/test-hypothesis`, `/ab-test`       | Experiment design and execution |

### 🔧 Meta (7)

| Command       | Aliases                                       | Purpose                                        |
| ------------- | --------------------------------------------- | ---------------------------------------------- |
| `/loop`       | `/ralph-loop`, `/autonomous`, `/self-directed`| Autonomous execution until completion          |
| `/iterate`    | `/cycle`, `/increment`, `/chunk`              | Break tasks into verifiable iterations         |
| `/relentless` | `/try-hard`, `/dont-stop`, `/ultrathink`      | Multiply effort and depth for high-stakes work |
| `/index`      | `/help`, `/workflows`, `/skills`              | Navigator for all workflows                    |
| `/audit`      | -                                             | Comprehensive system review                    |
| `/plan`       | `/roadmap`, `/schedule`                       | Implementation planning                        |
| `/estimate`   | `/scope`, `/sizing`                           | Effort estimation                              |

## Repository layout

```text
agent-deep-toolkit/
  README.md          # This file (agent-agnostic overview)
  LICENSE            # MIT license for the toolkit
  .gitignore         # Ignore rules for this repo
  install.sh         # Unified installer for Windsurf, Claude Code, Cursor, and OpenCode

  skills/            # Canonical skill definitions (source of truth)
    think/SKILL.md
    decide/SKILL.md
    search/SKILL.md
    ... (45 total skills)

  templates/
    windsurf/
      workflow-template.md      # Single Windsurf workflow template
    claude-code/
      skill-template.md         # Single Claude skill template
    cursor/
      command-template.md       # Single Cursor command template
    open-code/
      command-template.md       # Single OpenCode command template

  outputs/
    windsurf/workflows/         # Generated Windsurf workflows
    claude/skills/              # Generated Claude Code skills
    cursor/commands/            # Generated Cursor commands
    opencode/commands/          # Generated OpenCode commands
```

Each skill directory is structured according to the **Agent Skills** standard:

- `SKILL.md` – YAML frontmatter (`name`, `description`, `command`, `aliases`,
  and policy fields) + concise instructions.

## Installing

### Interactive Wizard (Recommended)

For first-time users, use the interactive wizard:

```bash
./install.sh --wizard
```

The wizard will guide you through:

- Prerequisite validation (Node.js, fzf)
- Multi-select agent selection
- Installation level choice (user or project)
- Preview of what will be installed
- Safe dry-run mode by default

### Command-Line Installation

For automation or CLI-only environments:

```bash
# Install for all agents at user level
./install.sh --agent all --level user

# Install specific agent (windsurf, claude, cursor, opencode)
./install.sh --agent claude --level project

# Force overwrite existing installation
./install.sh --agent all --level user --force

# Dry-run preview (no filesystem changes)
./install.sh --agent all --level user --dry-run
```

## Command naming

All tools use **canonical command names** without the legacy `deep-` prefix:

- `/think` instead of `/deep-think`
- `/debug` instead of `/deep-debug`
- etc.

Commands also support **aliases** that trigger the same workflow:

- `/fix` triggers `/debug`
- `/perf` triggers `/optimize`
- `/docs` triggers `/document`

## Per-agent independence

- **Windsurf** installation only touches Windsurf workflow locations.
- **Claude Code** installation only touches `.claude/skills` locations.
- **Cursor** installation only touches `.cursor/commands` locations.
- **OpenCode** installation only touches `.opencode/commands` locations.

You can install for just one agent without affecting others.

## Requirements

- A POSIX-like environment (macOS or Linux) with `bash` available.
- Access to your home directory for user-level installs.
- Optionally, a project directory for project-level installs.

## Versioning

Agent Deep Toolkit follows [Semantic Versioning](https://semver.org/). The
canonical version is stored in the top-level `VERSION` file.

## Uninstalling

```bash
# Uninstall everything
./install.sh --agent all --level user --uninstall --yes

# Detect existing installations
./install.sh --agent all --level user --detect-only
```

## Contributing and support

See:

- `CONTRIBUTING.md` for contribution guidelines.
- `CODE_OF_CONDUCT.md` for community standards.
- `SECURITY.md` for reporting security issues.

## License

MIT. See `LICENSE` for details.
