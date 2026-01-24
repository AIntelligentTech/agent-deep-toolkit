# Agent Deep Toolkit

A portable, cross-agent meta-cognitive toolkit for development workflows.

This directory is designed to become the **root of a standalone repo** that packages the full `deep-*` workflow suite for:

- **Windsurf** – `.windsurf/workflows`-style deep workflows.
- **Claude Code** – SKILL-based slash commands using the Agent Skills standard.
- **Cursor** – `.cursor/commands`-style slash commands.

The goal is to keep procedures conceptually identical across agents while keeping their implementations **independent** so you can install Windsurf, Claude Code, or Cursor tooling separately.

## Repository layout

```text
agent-deep-toolkit/
  README.md          # This file (agent-agnostic overview)
  LICENSE            # MIT license for the toolkit
  .gitignore         # Ignore rules for this repo
  install.sh         # Unified installer for Windsurf, Claude Code, and Cursor

  templates/
    windsurf/
      workflow-template.md  # Single Windsurf workflow template (metadata + injected deep-* content)
    claude-code/
      skill-template.md     # Single Claude skill template (metadata + injected deep-* content)
    cursor/
      command-template.md   # Single Cursor command template (plain markdown)

  tools/
    deep-tools.json       # Single-source-of-truth registry: metadata + content for all deep-* tools

  outputs/
    windsurf/
      workflows/     # Generated Windsurf workflows used by the installer
    claude/
      skills/        # Generated Claude Code skills used by the installer
    cursor/
      commands/      # Generated Cursor commands used by the installer
```

Each skill directory is structured according to the **Agent Skills** standard:

- `SKILL.md` – YAML frontmatter (`name`, `description`, and policy fields) + concise instructions.
- `references/` – Detailed workflow guides (ported from the Windsurf deep-* workflows).

## Installing Windsurf workflows

From the `agent-deep-toolkit/` directory:

```bash
# Install Windsurf workflows into the current project (.windsurf/workflows)
./install.sh --agent windsurf --level project

# Install into global Windsurf workflows (~/.windsurf/workflows)
./install.sh --agent windsurf --level user

# Install into Codeium/Windsurf Next global workflows
# (supports both ~/.codeium/windsurf-next/global_workflows and
#            ~/.codium/windsurf-next/global_workflows)
./install.sh --agent windsurf-next --level user
```

These commands copy the generated `outputs/windsurf/workflows/deep-*.md` files into the appropriate Windsurf workflow locations. They do **not** install any Claude Code content.

## Installing Claude Code skills

From the `agent-deep-toolkit/` directory:

```bash
# Install Claude Code skills into the current project (.claude/skills)
./install.sh --agent claude --level project

# Install Claude Code skills into your user-level skills (~/.claude/skills)
./install.sh --agent claude --level user

# Install both Windsurf and Claude Code tooling at the user level
./install.sh --agent all --level user
```

These commands copy the **entire generated skill directories** from `outputs/claude/skills/` into the chosen `.claude/skills` location. Each tool becomes its own slash command (e.g. `/deep-architect`, `/deep-debug`, `/deep-refactor`), matching Windsurf workflows 1:1.

## Per-agent independence

- **Windsurf** installation only touches Windsurf workflow locations and only depends on files under `templates/windsurf/` and `outputs/windsurf/`.
- **Claude Code** installation only touches `.claude/skills` locations and only depends on files under `templates/claude-code/` and `outputs/claude/`.
- **Cursor** installation only touches `.cursor/commands` locations and only depends on files under `templates/cursor/` and `outputs/cursor/`.

You can:

- Install **only Windsurf** workflows on a machine that doesn't use Claude Code or Cursor.
- Install **only Claude Code** skills into `.claude/skills` without having any Windsurf or Cursor configuration.
- Install **only Cursor** commands into `.cursor/commands` without having any Windsurf or Claude Code configuration.

## Requirements

- A POSIX-like environment (macOS or Linux) with a recent version of `bash` available via `/usr/bin/env bash`.
- Access to your home directory for user-level installs.
- Optionally, a project directory where you want to keep `.windsurf/workflows`, `.claude/skills`, and/or `.cursor/commands` under version control.

## What the installer and uninstaller do

The `install.sh` script is intentionally simple and conservative. For the options you choose, it will:

- **Windsurf**
  - Copy `windsurf/workflows/deep-*.md` into the target `.windsurf/workflows` directory.
  - Write a `.agent-deep-toolkit-version` file into that directory recording the toolkit version that was installed.
- **Claude Code**
  - Copy each skill directory (one per deep-* tool, e.g. `deep-architect`, `deep-debug`, `deep-refactor`) from `outputs/claude/skills/` into the target `.claude/skills` directory.
  - Write a `.agent-deep-toolkit-version` file into that directory.
- **Cursor**
  - Copy `cursor/commands/deep-*.md` into the target `.cursor/commands` directory.
  - Write a `.agent-deep-toolkit-version` file into that directory recording the toolkit version that was installed.

For uninstall and detection, the same script exposes additional flags:

- `--uninstall`
  - Remove Agent Deep Toolkit workflows/skills and their `.agent-deep-toolkit-version` markers for the selected `--agent` and `--level`.
- `--clean-up`
  - Currently behaves the same as `--uninstall`, and is reserved for more aggressive cleanup behavior in a future release.
- `--detect-only`
  - Detect and report existing installations for the selected `--agent` and `--level` without modifying the filesystem.
- `--yes` / `--non-interactive`
  - Skip confirmation prompts during uninstall, which is useful for scripted or non-interactive environments.

The installer and uninstaller:

- Does **not** contact the network.
- Does **not** execute arbitrary user code.
- Only creates directories and copies Markdown files within the locations you explicitly target.

If you want to see what would happen without modifying your filesystem, you can add `--dry-run` to any install, uninstall, or detect-only command. For example:

```bash
./install.sh --agent all --level user --dry-run
```

## Installing Cursor commands

From the `agent-deep-toolkit/` directory:

```bash
# Install Cursor commands into the current project (.cursor/commands)
./install.sh --agent cursor --level project

# Install Cursor commands into your user-level commands (~/.cursor/commands)
./install.sh --agent cursor --level user
```

These commands copy the generated `outputs/cursor/commands/deep-*.md` files into the appropriate Cursor commands locations. Once installed, type `/` in Cursor's AI chat to access all deep-* commands (e.g. `/deep-architect`, `/deep-debug`, `/deep-refactor`).

## Using Agent Deep Toolkit with Cursor

Cursor commands follow the official locations from the Cursor docs:

- **Project commands**: stored in the `.cursor/commands` directory of your project.
- **Global commands**: stored in the `~/.cursor/commands` directory in your home directory.
- **Team commands**: created by team admins in the Cursor dashboard and automatically available to all team members (this toolkit does **not** manage team commands directly).

Cursor supports two ways to use the deep-* toolkit:

### Option 1: Native Cursor commands (recommended)

Install with `--agent cursor` to get native slash commands:

```bash
./install.sh --agent cursor --level user
```

This installs plain markdown files to `~/.cursor/commands/` (for global use) and `.cursor/commands/` when you install at the project level, which Cursor automatically discovers. Type `/` in chat to see all available commands.

### Option 2: Via Claude Code skills

If you use Cursor together with the Claude Code extension, installing with `--agent claude` makes the deep-* skills available via `.claude/skills`. Cursor will surface these through its Claude integration.

### Command semantics by agent

All deep tools use the same **canonical command name** across agents: `/deep-<tool-id>` (for example `/deep-architect`, `/deep-debug`, `/deep-refactor`). There are no `/workflow-deep-*` commands; older `workflow-` prefixes have been removed in favour of this unified naming.

- **In Cursor**:
  - Each chat message can apply at most one `/deep-*` command.
  - Any text you type *after* the command name (for example `/deep-architect Design a new event pipeline`) is treated as that command’s parameters.
  - The deep-* command bodies may reference other `/deep-*` commands, but Cursor does **not** automatically chain or nest commands. This composability is **conceptual**: it is up to you (and the model) to run follow-up commands in separate turns when helpful.

- **In Windsurf and Claude Code**:
  - The agent sees the **entire prompt** and can respond to multiple `/deep-*` cues in a single message.
  - There is no special notion of “trailing parameters”; all text in the message is treated as context.
  - You can freely mix several deep-* workflows in one prompt (for example `/deep-architect` + `/deep-test`), and the agent will select and combine them as appropriate.

This means Cursor’s stricter `/command <args>` model is **only a limitation for Cursor’s native commands**. The same deep-* content remains fully flexible in Windsurf and Claude Code.

## Deep tools model and generated outputs (for maintainers)

The canonical sources for the toolkit now live in:

- `tools/deep-tools.json` – single-source-of-truth registry for all deep-* tools, including:
  - Windsurf metadata (description + auto-execution mode).
  - Optional Claude metadata (name, description, policy flags) – defaults are derived from Windsurf metadata if not specified.
  - Full workflow body content (shared by all agents).

Agent-specific templates are defined once per agent:

- `templates/windsurf/workflow-template.md` – Windsurf workflow frontmatter + body placeholder.
- `templates/claude-code/skill-template.md` – Claude SKILL frontmatter + body placeholder.
- `templates/cursor/command-template.md` – Cursor command (plain markdown body).

From these, a small helper script, `bin/generate-deep-tools`, regenerates the **generated outputs** under `outputs/`:

- `outputs/windsurf/workflows/` – generated Windsurf workflows used by the installer.
- `outputs/claude/skills/` – generated Claude Code skills (one per tool, 1:1 with Windsurf) used by the installer.
- `outputs/cursor/commands/` – generated Cursor commands (one per tool, 1:1 with Windsurf) used by the installer.

Maintainers edit `tools/deep-tools.json` and rerun `bin/generate-deep-tools` when changing workflows; end-users only need `install.sh`.

For exploratory work, there are two complementary workflows:

- `deep-search` – focuses on **local/project search** (code, configs, tests, history).
- `deep-research` – focuses on **web/multi-source research** (docs, repos, specs, blogs).

## Versioning and upgrades

Agent Deep Toolkit follows [Semantic Versioning](https://semver.org/). The canonical version is stored in the top-level `VERSION` file (for example `0.3.1`).

Each destination directory that the installer manages also receives a `.agent-deep-toolkit-version` file. Re-running the installer:

- Is **idempotent** by default: if that version file already exists and `--force` is not set, the installer logs an informational message and skips overwriting.
- Can be forced with `--force` (or `--overwrite`) to replace existing toolkit files for the selected targets.

To upgrade an existing installation to a newer toolkit version:

1. Update your local `agent-deep-toolkit` checkout to the desired version (for example by checking out the `v0.3.1` tag once it exists).
2. Re-run the same `install.sh` command(s) you used originally (for example `--agent windsurf --level user` or `--agent all --level project`).

The version markers in your workflow/skills directories will be updated to reflect the new toolkit version.

## Uninstalling

The recommended way to remove Agent Deep Toolkit artifacts is to use the built-in uninstaller in `install.sh`.

From the `agent-deep-toolkit/` directory:

```bash
# Uninstall everything for all agents at the user level
./install.sh --agent all --level user --uninstall --yes

# Uninstall Windsurf workflows from a specific project
./install.sh --agent windsurf --level project --project-dir /path/to/project --uninstall

# Detect existing installations without changing the filesystem
./install.sh --agent all --level user --detect-only
```

Notes:

- `--uninstall` removes only the workflows/skills and `.agent-deep-toolkit-version` files that the toolkit manages for the selected `--agent` and `--level`.
- `--detect-only` reports what would be uninstalled for the selected scope but never deletes anything.
- `--dry-run` can be combined with `--uninstall` to preview deletions without actually removing files.
- `--clean-up` is currently equivalent to `--uninstall` and is reserved for stricter cleanup behavior in a future release.
- `--yes` / `--non-interactive` can be combined with uninstall flags to skip confirmation prompts, which is useful in CI or scripted environments.

### Manual uninstall (fallback)

If you prefer to remove files manually, or if you need to clean up legacy installations, you can still delete the files and version markers directly from the relevant locations:

- **Windsurf (project-level)**
  - Remove `deep-*.md` workflows and `.agent-deep-toolkit-version` from `<project>/.windsurf/workflows/`.
- **Windsurf (user-level / Windsurf Next)**
  - Remove the same `deep-*.md` files and version markers from some or all of:
    - `~/.windsurf/workflows/`
    - `~/.codeium/windsurf-next/global_workflows/`
    - `~/.codium/windsurf-next/global_workflows/`
- **Claude Code (project-level)**
  - Remove all `deep-*` skill directories and `.agent-deep-toolkit-version` from `<project>/.claude/skills/`.
- **Cursor (project-level)**
  - Remove `deep-*.md` commands and `.agent-deep-toolkit-version` from `<project>/.cursor/commands/`.
- **Cursor (user-level)**
  - Remove `deep-*.md` commands and `.agent-deep-toolkit-version` from `~/.cursor/commands/`.
- **Claude Code (user-level)**
  - Remove all `deep-*` skill directories and version marker from `~/.claude/skills/`.

After those files are removed (whether by the uninstaller or manually), Windsurf, Claude Code, and Cursor will stop exposing the corresponding deep-* workflows, skills, and commands.

## Contributing and support

If you would like to propose changes to workflows, skills, or the installer itself, please see:

- `CONTRIBUTING.md` for contribution guidelines and review expectations.
- `CODE_OF_CONDUCT.md` for community standards.
- `SECURITY.md` for how to report potential security or privacy issues in the toolkit.

## License

MIT. See `LICENSE` for details.
