# Architecture

> **TL;DR:** Agent Deep Toolkit uses a **single-source CACE format** that converts to agent-specific implementations (Windsurf workflows, Claude skills, Cursor commands, OpenCode commands). One skill definition → four agent formats.

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    CACE Source Format                        │
│              skills/*/SKILL.md (50 skills)                   │
│                                                              │
│  Frontmatter: name, description, aliases, activation mode    │
│  Body: XML-tagged instructions (scope, context, steps)      │
└──────────────────┬───────────────────────────────────────────┘
                   │
                   ▼
         ┌─────────────────────┐
         │   Build Pipeline    │
         │ bin/build-all-agents│
         │   (Python script)   │
         └──────────┬───────────┘
                    │
        ┌───────────┼───────────┬───────────┐
        │           │           │           │
        ▼           ▼           ▼           ▼
   Windsurf      Claude      Cursor     OpenCode
   Adapter       Adapter     Adapter    Adapter
        │           │           │           │
        ▼           ▼           ▼           ▼
  .windsurf/    .claude/    .cursor/   .opencode/
  workflows/    skills/     commands/  commands/
                            rules/
        │           │           │           │
        └───────────┴───────────┴───────────┘
                    │
                    ▼
            ┌──────────────┐
            │  install.sh  │
            │   (Wizard)   │
            └──────┬───────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  User's Agent Setup   │
        │ (selected agent only) │
        └───────────────────────┘
```

## Design Philosophy

### 1. Single Source of Truth
- **One canonical skill definition** in `skills/*/SKILL.md`
- Agent adapters transform to platform-specific formats
- No manual duplication across agents

### 2. Agent-Agnostic Core
- Skills describe **what** and **why**, not platform mechanics
- Activation modes map to agent capabilities
- Frontmatter provides metadata, body provides instructions

### 3. Graceful Degradation
- If an agent doesn't support a feature (e.g., auto-execution), adapter chooses best alternative
- Core skill logic remains intact

## Core Components

### 1. CACE Source Format

**Location:** `skills/*/SKILL.md`

**Structure:**
```markdown
---
name: think
description: Deep reasoning and analysis
command: /think
aliases: ["/reason", "/analyze", "/ponder"]
synonyms: ["/thinking", "/reasoning", "/analysis"]
activation-mode: auto
user-invocable: true
disable-model-invocation: false
category: problem-solving
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Think Workflow

<scope_constraints>
What this skill covers and its boundaries.
</scope_constraints>

<context>
Why this skill exists and when to use it.
</context>

<instructions>
Step-by-step guidance for the agent.
</instructions>

<error_handling>
What to do when things go wrong.
</error_handling>
```

#### Frontmatter Fields

| Field | Type | Required | Purpose |
|-------|------|----------|---------|
| `name` | string | ✅ | Canonical skill identifier (lowercase, no spaces) |
| `description` | string | ✅ | One-line summary for UI/docs |
| `command` | string | ✅ | Primary slash command (e.g., `/think`) |
| `aliases` | array | ❌ | Alternative commands that trigger this skill |
| `synonyms` | array | ❌ | Additional variants (merged with aliases in Claude) |
| `activation-mode` | enum | ✅ | `auto`, `contextual`, or `manual` |
| `user-invocable` | boolean | ❌ | Default `true` - can users call this directly? |
| `disable-model-invocation` | boolean | ❌ | Default `false` - suppress model call (for control flow) |
| `category` | string | ❌ | Grouping for documentation |
| `model` | string | ❌ | Model preference (`inherit` uses agent default) |
| `created` | date | ❌ | Initial creation date |
| `updated` | date | ❌ | Last modification date |

#### Activation Modes

- **`auto`**: Skill is always available, agent can proactively use it
- **`contextual`**: Triggered by patterns (file types, keywords)
- **`manual`**: Only invoked explicitly by user command

#### XML Body Tags

- **`<scope_constraints>`**: What the skill covers and boundaries
- **`<context>`**: Why this skill exists, problem it solves
- **`<instructions>`**: Step-by-step agent guidance
- **`<error_handling>`**: Fallback strategies and error cases

### 2. Build Pipeline

**Script:** `bin/build-all-agents` (Python 3)

**Process:**
1. Scan `skills/` for all `SKILL.md` files
2. Parse YAML frontmatter and body
3. For each skill, call all 4 agent adapters
4. Write transformed outputs to `outputs/*/`
5. Handle variants (aliases + synonyms)

**Key Functions:**
- `parse_skill(path)`: Extract frontmatter + body
- `build_windsurf(name, fm, body, dest)`: Generate Windsurf workflow/skill
- `build_cursor(name, fm, body, dest)`: Generate Cursor command/rule
- `build_opencode(name, fm, body, dest)`: Generate OpenCode command
- `build_claude(name, fm, body, dest)`: Generate Claude skill

**Output Structure:**
```
outputs/
├── windsurf/
│   ├── workflows/*.md      # Direct workflows for chat
│   └── skills/*/SKILL.md   # Skill definitions
├── claude/
│   └── skills/*/SKILL.md   # Agent Skills Standard
├── cursor/
│   ├── commands/*.md       # Command library (body only)
│   └── rules/*.mdc         # Contextual rules (with frontmatter)
└── opencode/
    └── commands/*.md       # Commands with agent/model metadata
```

### 3. Agent Adapters

#### Windsurf Adapter

**Format:** `.windsurf/workflows/*.md` and `.windsurf/skills/*/SKILL.md`

**Transformation:**
- Frontmatter → `auto_execution_mode` (0=manual, 1=contextual, 2=auto)
- Body → Preserved with XML tags
- Variants → Separate files for each alias/synonym

**Example:**
```markdown
---
description: Deep reasoning and analysis
auto_execution_mode: 2
---

[Original body preserved]
```

#### Claude Code Adapter

**Format:** `~/.claude/skills/*/SKILL.md`

**Transformation:**
- Merges `synonyms` into `aliases` array
- Adds `allowed-tools: ["*"]` by default
- Preserves all frontmatter fields
- Body unchanged

**Example:**
```markdown
---
name: think
description: Deep reasoning and analysis
command: /think
aliases: ["/reason", "/analyze", "/ponder", "/thinking", "/reasoning"]
activation-mode: auto
user-invocable: true
disable-model-invocation: false
allowed-tools: ["*"]
---

[Original body preserved]
```

#### Cursor Adapter

**Format:** `.cursor/commands/*.md` (commands) and `.cursor/rules/*.mdc` (rules)

**Transformation:**
- **Commands:** Body only (no frontmatter) - Cursor executes commands as templates
- **Rules:** Frontmatter with `description`, `globs`, `alwaysApply`
- Activation mapping: `auto` → `alwaysApply: true`

**Command Example (commands/think.md):**
```markdown
[Body only - Cursor doesn't use frontmatter for commands]
```

**Rule Example (rules/think.mdc):**
```markdown
---
description: Deep reasoning and analysis
globs: ["**/*"]
alwaysApply: true
---

[Original body]
```

#### OpenCode Adapter

**Format:** `.opencode/commands/*.md`

**Transformation:**
- Adds `agent`, `model`, `subtask`, `allowed-tools` metadata
- Injects `$ARGUMENTS` placeholder if not present
- Variants as separate files

**Example:**
```markdown
---
description: Deep reasoning and analysis
agent: auto
model: auto
subtask: false
allowed-tools: ["*"]
---

Context: $ARGUMENTS

[Original body]
```

### 4. Installation System

**Script:** `install.sh` (Bash)

**Modes:**
- **Wizard:** Interactive TUI with fzf multi-select
- **CLI:** Direct `--agent <name> --level <user|system|repository>` flags

**Flow:**
1. **Prerequisite Check:** Node.js >=18.0.0, CACE CLI >=2.5.5 (optional)
2. **Agent Detection:** Scan for Claude, Windsurf, Cursor, OpenCode
3. **Build:** Run `bin/build-all-agents` to generate outputs
4. **Install:** Copy from `outputs/` to agent-specific locations
5. **Verify:** Health checks for installed files

**Installation Targets:**

| Agent | User Level | System Level | Repository Level |
|-------|------------|--------------|------------------|
| Claude | `~/.claude/skills/` | N/A | `.claude/skills/` |
| Windsurf | `~/.windsurf/workflows/` | N/A | `.windsurf/workflows/` |
| Cursor | `~/.cursor/commands/` | N/A | `.cursor/commands/` |
| OpenCode | `~/.opencode/commands/` | N/A | `.opencode/commands/` |

**Features:**
- `--force`: Overwrite existing installations
- `--dry-run`: Preview without writing files
- `--uninstall`: Remove installed skills
- `--detect-only`: Show detected agents without installing

### 5. Release System

**Script:** `release.sh`

**Process:**
1. Parse current version from `VERSION` file
2. Bump version (major/minor/patch) via CLI arg
3. Update:
   - `VERSION`
   - `INSTALLATION.yaml` (package.version)
   - `CHANGELOG.md` (generate from git log)
4. Git commit with version tag
5. Push to GitHub

**Usage:**
```bash
bash release.sh bump patch   # 3.6.0 → 3.6.1
bash release.sh bump minor   # 3.6.0 → 3.7.0
bash release.sh bump major   # 3.6.0 → 4.0.0
```

## Skill Categories

Agent Deep Toolkit organizes 50 skills into 7 semantic categories:

1. **🧠 Core Reasoning (5):** `think`, `decide`, `search`, `investigate`, `explore`
2. **🏗️ Architecture & Design (9):** `architect`, `design`, `ux`, `spec`, `document`, etc.
3. **💻 Implementation (11):** `code`, `debug`, `refactor`, `test`, `optimize`, `polish`, etc.
4. **⚙️ Operations (9):** `bash`, `git`, `data`, `infra`, `observe`, `incident`, etc.
5. **📋 Governance (2):** `compliance`, `threat`
6. **🔄 Change Management (6):** `integrate`, `impact`, `propagate`, `brainstorm`, `followup`, `experiment`
7. **🔧 Meta (7):** `loop`, `iterate`, `relentless`, `index`, `audit`, `plan`, `estimate`

## Extension Points

### Adding a New Skill

1. **Create source:** `skills/yourskill/SKILL.md` with proper frontmatter
2. **Build:** Run `./bin/build-all-agents`
3. **Test:** Install in at least 2 agents and verify behavior
4. **Tests:** Add conversion tests to `tests/test-cace-conversion.sh`
5. **Docs:** Update README.md skill table with your new skill

### Creating a New Agent Adapter

To support a new AI agent platform:

1. Add adapter function in `bin/build-all-agents`:
   ```python
   def build_newagent(name, fm, body, dest_dir):
       # Transform frontmatter to new format
       # Write to dest_dir / "commands" / f"{name}.md"
       pass
   ```

2. Add output directory creation in `main()`:
   ```python
   agent_paths['newagent'] = OUTPUTS_DIR / "newagent"
   (agent_paths['newagent'] / "commands").mkdir()
   ```

3. Update `install.sh` to detect and install to new agent

4. Document format in this ARCHITECTURE.md

### Custom Activation Patterns

To add context-aware triggers:

1. In CACE source, use `activation-mode: contextual`
2. In agent adapters, map to platform-specific triggers:
   - **Windsurf:** `auto_execution_mode: 1`
   - **Cursor:** `globs: ["src/**/*.ts"]`
   - **OpenCode:** `agent: context-aware`

## Testing Strategy

### 1. Wizard Tests
**Script:** `tests/test-wizard.sh`

Tests interactive installation flow:
- Agent detection
- User input simulation
- Dry-run mode verification
- Uninstall cleanup

### 2. CACE Conversion Tests
**Script:** `tests/test-cace-conversion.sh`

Validates build pipeline:
- All 50 skills parse correctly
- Frontmatter fields preserved
- Body structure intact
- Variants generated for aliases/synonyms

### 3. Manual Agent Validation
1. Install to each agent
2. Invoke `/think` (or equivalent)
3. Verify agent executes skill instructions
4. Check variant commands work (`/reason`, `/analyze`)

## Dependencies

### Runtime
- **Node.js >=18.0.0** (for agent compatibility, not this toolkit directly)
- **Bash** (install.sh, release.sh)
- **Python 3.7+** (build pipeline)

### Development
- **CACE CLI >=2.5.5** (optional, for advanced skill authoring)
- **yq** (YAML parsing in install.sh)
- **fzf** (optional, for wizard mode)

### Optional
- **bun** (package manager mentioned in INSTALLATION.yaml, but not required)

## Performance Characteristics

- **Build Time:** ~2 seconds for 50 skills (Python script)
- **Install Time:** ~5-10 seconds (depends on agent)
- **Disk Usage:** ~2MB per agent (50 skills × ~40KB each)

## Security Considerations

1. **No remote execution:** All skills run locally via agent
2. **User permission model:** Agents inherit user's shell permissions
3. **Code review:** All skills are human-readable markdown
4. **No telemetry:** Toolkit does not phone home

## Future Enhancements

1. **Agent capability negotiation:** Skills declare required features, adapters gracefully degrade
2. **Skill composition:** High-level skills invoke lower-level ones
3. **Parametric skills:** Accept arguments via frontmatter schema
4. **Skill marketplace:** Community-contributed skills with verification

## References

- [Agent Skills Standard](https://github.com/anthropics/agent-skills-standard) (Claude Code)
- [CACE Specification](https://github.com/AIntelligentTech/cross-agent-compatibility-engine)
- [Windsurf Workflows Documentation](https://docs.codeium.com/windsurf/workflows)
- [Cursor Commands Reference](https://docs.cursor.com/commands)

---

**Questions?** Open an issue or read [CONTRIBUTING.md](CONTRIBUTING.md) for how to get involved.
