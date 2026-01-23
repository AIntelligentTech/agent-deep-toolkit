# Agent Deep Toolkit

A portable, cross-agent meta-cognitive toolkit for development workflows.

This directory is designed to become the **root of a standalone repo** that packages the full `deep-*` workflow suite for:

- **Windsurf** – `.windsurf/workflows`-style deep workflows.
- **Claude Code** – SKILL-based slash commands using the Agent Skills standard.

The goal is to keep procedures conceptually identical across agents while keeping their implementations **independent** so you can install Windsurf or Claude Code tooling separately.

## Repository layout

```text
agent-deep-toolkit/
  README.md          # This file (agent-agnostic overview)
  LICENSE            # MIT license for the toolkit
  .gitignore         # Ignore rules for this repo
  install.sh         # Unified installer for Windsurf and Claude Code

  windsurf/
    workflows/       # Canonical deep-* Windsurf workflows

  claude-code/
    skills/          # Ready-to-install Claude Code skills (one directory per skill)
      deep-meta/
        SKILL.md
        references/  # Deep meta-cognitive procedures (think, explore, search, etc.)
      deep-engineering/
        SKILL.md
        references/  # Code, debug, test, refactor, optimize, prune, etc.
      deep-ops/
        SKILL.md
        references/  # Audit, observability, incident, infra, threat-model, etc.
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

These commands copy `windsurf/workflows/deep-*.md` into the appropriate Windsurf workflow locations. They do **not** install any Claude Code content.

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

These commands copy the **entire skill directories** from `claude-code/skills/` into the chosen `.claude/skills` location. Each skill then shows up as a slash command, e.g. `/deep-meta`, `/deep-engineering`, `/deep-ops` (names come from SKILL.md frontmatter).

## Per-agent independence

- **Windsurf** installation only touches Windsurf workflow locations and only depends on files under `windsurf/`.
- **Claude Code** installation only touches `.claude/skills` locations and only depends on files under `claude-code/`.

You can:

- Install **only Windsurf** workflows on a machine that doesn't use Claude Code.
- Install **only Claude Code** skills into `.claude/skills` without having any Windsurf configuration.

## Requirements

- A POSIX-like environment (macOS or Linux) with a recent version of `bash` available via `/usr/bin/env bash`.
- Access to your home directory for user-level installs.
- Optionally, a project directory where you want to keep `.windsurf/workflows` and/or `.claude/skills` under version control.

## What the installer does

The `install.sh` script is intentionally simple and conservative. For the options you choose, it will:

- **Windsurf**
  - Copy `windsurf/workflows/deep-*.md` into the target `.windsurf/workflows` directory.
  - Write a `.agent-deep-toolkit-version` file into that directory recording the toolkit version that was installed.
- **Claude Code**
  - Copy each skill directory (for example `deep-meta`, `deep-engineering`, `deep-ops`) from `claude-code/skills/` into the target `.claude/skills` directory.
  - Write a `.agent-deep-toolkit-version` file into that directory.

The installer:

- Does **not** contact the network.
- Does **not** execute arbitrary user code.
- Only creates directories and copies Markdown files within the locations you explicitly target.

If you want to see what would happen without modifying your filesystem, you can add `--dry-run` to any command. For example:

```bash
./install.sh --agent all --level user --dry-run
```

## Versioning and upgrades

Agent Deep Toolkit follows [Semantic Versioning](https://semver.org/). The canonical version is stored in the top-level `VERSION` file (for example `0.2.0`).

Each destination directory that the installer manages also receives a `.agent-deep-toolkit-version` file. Re-running the installer:

- Is **idempotent** by default: if that version file already exists and `--force` is not set, the installer logs an informational message and skips overwriting.
- Can be forced with `--force` (or `--overwrite`) to replace existing toolkit files for the selected targets.

To upgrade an existing installation to a newer toolkit version:

1. Update your local `agent-deep-toolkit` checkout to the desired version (for example by checking out the `v0.2.0` tag once it exists).
2. Re-run the same `install.sh` command(s) you used originally (for example `--agent windsurf --level user` or `--agent all --level project`).

The version markers in your workflow/skills directories will be updated to reflect the new toolkit version.

## Uninstalling

The toolkit does not currently ship an automated uninstaller. To remove installed workflows and skills, delete the files and version markers from the relevant locations:

- **Windsurf (project-level)**
  - Remove `deep-*.md` workflows and `.agent-deep-toolkit-version` from `<project>/.windsurf/workflows/`.
- **Windsurf (user-level / Windsurf Next)**
  - Remove the same `deep-*.md` files and version markers from some or all of:
    - `~/.windsurf/workflows/`
    - `~/.codeium/windsurf-next/global_workflows/`
    - `~/.codium/windsurf-next/global_workflows/`
- **Claude Code (project-level)**
  - Remove the `deep-meta`, `deep-engineering`, and `deep-ops` directories and `.agent-deep-toolkit-version` from `<project>/.claude/skills/`.
- **Claude Code (user-level)**
  - Remove the same skill directories and version marker from `~/.claude/skills/`.

After those files are removed, Windsurf and Claude Code will stop exposing the corresponding deep-* workflows and skills.

## Contributing and support

If you would like to propose changes to workflows, skills, or the installer itself, please see:

- `CONTRIBUTING.md` for contribution guidelines and review expectations.
- `CODE_OF_CONDUCT.md` for community standards.
- `SECURITY.md` for how to report potential security or privacy issues in the toolkit.

## License

MIT. See `LICENSE` for details.
