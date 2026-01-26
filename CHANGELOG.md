# Changelog

All notable changes to this project will be documented in this file.

The format is loosely based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/).

## [0.4.0] - 2026-01-26

### Added

- **Intelligent Windsurf installation detection**: Installer now automatically
  detects Windsurf installations across multiple possible locations.
  - Stable channel detection checks: `~/.windsurf/workflows`,
    `~/.codeium/.windsurf/workflows`, `~/.codeium/windsurf/global_workflows`
  - Next channel detection checks: `~/.codeium/windsurf-next/global_workflows`
  - New detection functions: `detect_windsurf_stable_installation()`,
    `detect_all_windsurf_stable_installations()`,
    `detect_windsurf_next_installations()`,
    `detect_all_windsurf_installations()`
- Comprehensive documentation: `docs/WINDSURF-INSTALLATION-DETECTION.md`
  explains detection logic, priority order, and migration from v0.3.x

### Changed

- **`--agent windsurf` behavior**: Now installs to the first detected stable
  installation (prioritizes `~/.windsurf/workflows`) instead of always
  defaulting to `~/.windsurf/workflows`
- **`--agent windsurf-next` behavior**: Now detects and installs to all existing
  Next channel installations instead of blindly installing to hardcoded paths
- **`--agent all` behavior**: Now intelligently detects and installs to all
  existing Windsurf installations (both stable and next channels) instead of
  using hardcoded paths

### Fixed

- Installer now correctly prioritizes stable Windsurf installations over next
  channel installations
- Fixed issue where installer would always target windsurf-next paths regardless
  of which Windsurf variant was actually installed
- Removed incorrect `~/.codium/*` path references (typos for `~/.codeium/*`)

## [0.3.1] - 2026-01-24

### Added

- Restored previously missing deep tools to `tools/deep-tools.json` and
  generated outputs:
  - `deep-alternative`, `deep-bash`, `deep-docs`, `deep-followup`, `deep-ideas`,
    `deep-impact`, `deep-index`, `deep-inventory`, `deep-propagate`,
    `deep-relentless`, `deep-svg`, `deep-understand`.
- Generated corresponding Windsurf workflows, Claude Code skills, and Cursor
  commands for all restored tools.

### Changed

- Normalized all cross-references in deep-_ content to the canonical
  `/deep-_`naming (no more`/workflow-deep-\*` references).
- Documented Cursor's command semantics and the canonical naming scheme in
  `README.md`.

## [0.3.0] - 2026-01-24

### Added

- **Full Cursor support**: Native slash commands via `.cursor/commands/`
  directory.
  - New `--agent cursor` option in `install.sh` for project and user-level
    installations.
  - Cursor commands are plain markdown files (no frontmatter) that Cursor
    auto-discovers when you type `/` in chat.
  - Commands install to `.cursor/commands/` (project) or `~/.cursor/commands`
    (user).
- New `templates/cursor/command-template.md` template for generating Cursor
  commands.
- New `outputs/cursor/commands/` directory with generated Cursor commands (1:1
  with Windsurf workflows).
- Cursor included in `--agent all` for both install and uninstall operations.
- Generator now writes `outputs/version.txt` with the toolkit version, enabling
  easy verification of which version generated the current outputs.
- Integrated **Automated Iterative Development (AID)** methodology into
  `deep-iterate` and `deep-code` workflows:
  - AID process loop diagram (Plan → Execute → Validate → Commit → Adapt)
  - Task list pattern with status tracking (`[x]`, `[ ]`, `[>]`, `[!]`)
  - Phase decomposition methodology
  - Validation hierarchy (syntax → unit → integration → e2e)
  - Commit at phase boundaries discipline
  - Adaptation triggers and responses table
  - Code quality checklist and validation commands by artifact type.
- Intelligent uninstall support in `install.sh` with `--uninstall`,
  `--clean-up`, and `--detect-only` action flags.
- A non-interactive mode for uninstall via `--yes` / `--non-interactive`,
  suitable for scripted use.
- Detection and reporting of existing Agent Deep Toolkit installs across
  supported agents without modifying the filesystem when `--detect-only` is
  specified.
- README documentation for the automated uninstaller, detect-only mode, and how
  to use the toolkit with Cursor and Claude Code.
- A `deep-tools.json` registry plus `bin/generate-deep-tools` script and
  `outputs/` tree for generating Windsurf workflows, Claude skills, and Cursor
  commands from a single source of truth.
- A split between `deep-search` (local/project search) and `deep-research`
  (web/multi-source research) across Windsurf workflows and the `deep-meta`
  Claude skill.

### Changed

- Updated `bin/generate-deep-tools` to generate Cursor commands alongside
  Windsurf workflows and Claude skills.
- Updated `install.sh` with `copy_cursor_commands`, `install_cursor_to`, and
  `uninstall_cursor_from` functions.
- Updated README with comprehensive Cursor documentation including installation,
  usage, and per-agent independence.
- Architecture comment in the generator updated to reflect three-agent support.
- **Breaking**: Claude Code skills are now generated 1:1 with Windsurf
  workflows. Each deep-\* tool gets its own skill directory
  (`outputs/claude/skills/deep-architect/`, `deep-debug/`, etc.) instead of
  being grouped into three bundled skills (deep-meta, deep-engineering,
  deep-ops).
- Removed the grouped `skills` array from `tools/deep-tools.json`; the `tools`
  array is now the sole source of truth for both Windsurf workflows and Claude
  skills.
- Updated `bin/generate-deep-tools` to produce one Claude skill per tool,
  matching Windsurf 1:1.
- Updated `install.sh` uninstaller to dynamically find all `deep-*` skill
  directories instead of a hardcoded list.
- Claude skills now use the same workflow body content as Windsurf workflows,
  ensuring identical behavior across agents.
- Each Claude skill defaults to `disable-model-invocation: true` and
  `user-invocable: true` for safe, user-controlled invocation.
- Bumped toolkit version from `0.2.0` to `0.3.0` in `VERSION` and updated README
  version examples accordingly.

### Removed

- Removed the grouped Claude skills (`deep-meta`, `deep-engineering`,
  `deep-ops`) and their `references/` subdirectories.
- Removed the `skills` array from `tools/deep-tools.json`.

## [0.2.0] - 2026-01-23

### Added

- Expanded `README.md` with requirements, installer behavior, safety
  characteristics, versioning/upgrade guidance, and uninstall instructions.
- New contributor documentation: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and
  `SECURITY.md`.
- `CHANGELOG.md` to record user-visible changes going forward.
- A `--dry-run` flag to `install.sh` so users can see what would be installed
  without changing their filesystem.
- Logging of key installer parameters (agent, level, project directory, force,
  dry-run) at startup.
- A safety check that refuses project-level installs when `--project-dir /` is
  specified, to avoid accidental writes at the filesystem root.

### Changed

- Bumped toolkit version from `0.1.0` to `0.2.0` in `VERSION`.

## [0.1.0]

- Initial release of the Agent Deep Toolkit structure:
  - Windsurf deep-\* workflows under `windsurf/workflows/`.
  - Claude Code skills and references under `claude-code/skills/`.
  - Unified `install.sh` for Windsurf and Claude Code without `--dry-run`.
