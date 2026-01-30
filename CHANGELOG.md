# Changelog

## [3.0.0] - 2026-01-30

### 🎉 Major Release - CACE Build System Integration

This release integrates the Cross-Agent Compatibility Engine (CACE) as the build system, enabling dual-output strategy for Windsurf to preserve Claude skill behavior.

### ✨ New Features

#### CACE Build System
- **Replaced Python-based build** with CACE CLI integration
- **Local CACE dependency** at `/home/tony/business/tools/cross-agent-compatibility-engine`
- **Automatic version detection** and fallback mechanisms
- **Comprehensive health validation** for all converted outputs

#### Dual-Output Strategy for Windsurf
Claude skills can be both auto-invoked AND manually invoked via `/command`. Windsurf enforces a bifurcated model:
- **Skills**: Auto-invoked, NO `/command` access
- **Workflows**: Manual `/command`, NO auto-invocation

**Solution:** Generate BOTH artifacts:
```
.windsurf/workflows/<skill>.md   # Manual /command invocation
.windsurf/skills/<skill>/SKILL.md  # Auto-invocation parity
```

#### Updated Output Structure
| Agent | Output Format | Path |
|-------|--------------|------|
| Claude | Skills | `.claude/skills/<name>/SKILL.md` |
| Windsurf | Workflows + Skills | `.windsurf/workflows/<name>.md` + `.windsurf/skills/<name>/SKILL.md` |
| Cursor | Commands | `.cursor/commands/<name>/` |
| OpenCode | Commands | `.opencode/<name>/` |

### 🔧 Changes

#### bin/cace-convert
- New build script using local CACE
- Automatic dual-output strategy for Windsurf
- Variant generation for aliases/synonyms
- Health validation post-conversion

#### install.sh
- Updated directory paths for new output structure
- Added `copy_windsurf_skills()` for dual-output installation
- Supports both workflows and skills for Windsurf

#### docs/CACE_MIGRATION_ARCHITECTURE.md
- Complete architecture documentation for CACE integration
- Dual-output strategy documentation
- Agent compatibility matrix

### 📊 Statistics

- **Skills:** 46 canonical skills
- **Agents:** 4 supported (Claude, Windsurf, Cursor, OpenCode)
- **Health:** 100% across all agents
- **Variants:** Auto-generated aliases/synonyms per agent

### ⚠️ Breaking Changes

- **Output structure changed:** All agents now use nested directory structure (e.g., `.claude/skills/<name>/SKILL.md` instead of `.claude/skills/<name>.md`)
- **Windsurf now produces dual outputs:** Both workflows and skills are installed

---

## [2.0.0] - 2025-05-15

### Added
- **Variant Generation System**: Skills now support a `synonyms` tag in frontmatter.
- **Improved Build Pipeline**: New Python-based generator produces multiple entry points for Windsurf, Cursor, and OpenCode, and populates `aliases` for Claude Code.
- **Synonyms for Key Tools**:
  - `/think` -> `/thought`, `/thinking`, `/thinks`
  - `/decide` -> `/decision`, `/choice`, `/choose`, `/pick`, `/select`
  - `/debug` -> `/fix`, `/troubleshoot`, `/solve`, `/repair`, `/patch`
  - ... and many more.

### Changed
- **Cleaner Naming Convention**: Removed `deep-` prefix from all source directories and skill names (e.g., `deep-think` becomes `think`).
- **Enhanced Content Frameworks**:
  - `/think`: Integrated Second-Order and Inversion thinking.
  - `/decide`: Formally distinguishes Type 1 (Irreversible) and Type 2 (Reversible) decisions.
  - `/search`: Multi-source keyword expansion.
  - `/refactor`: Added Characterization Tests and Rewrite vs Refactor analysis.
  - `/architect`: Added Sustainability/Green IT lens and Fitness Functions.
- **Updated Installer**: `install.sh` now handles non-prefixed files and all generated variants automatically.

### Fixed
- Fixed broken build dependency on missing `cace` tool by implementing internal Python-based conversion.

All notable changes to this project will be documented in this file.

The format is loosely based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/).

## [2.0.0] - 2026-01-29

### ⚠️ Breaking Changes

- **Removed `deep-` prefix from all skills**: All commands are now invoked without
  the `deep-` prefix (e.g., `/think` instead of `/deep-think`, `/debug` instead of
  `/deep-debug`).
- **Skill consolidation**: 10 skill pairs have been merged to reduce overlap:
  - `deep-consider` + `deep-decide` → `/decide`
  - `deep-docs` + `deep-document` → `/document`
  - `deep-search` + `deep-research` → `/search`
  - `deep-explore` + `deep-understand` → `/explore`
  - `deep-relentless` + `deep-iterate` → `/iterate`
  - `deep-prune` + `deep-refactor` → `/refactor`
  - `deep-incident` + `deep-retrospective` → `/incident`
  - `deep-ethics` + `deep-regulation` → `/compliance`
  - `deep-alternative` + `deep-ideas` → `/brainstorm`
- **Removed legacy skill directories**: All `deep-*` directories have been removed
  from `skills/`.

### Added

- **10 new skills** to fill conceptual gaps:
  - `/plan` - Implementation planning with phases, dependencies, milestones
  - `/migrate` - Safe data/schema/API migrations with rollback strategies
  - `/review` - Structured code review workflow
  - `/deploy` - Deployment strategy and rollout patterns
  - `/estimate` - Effort estimation and complexity analysis
  - `/onboard` - Developer onboarding materials
  - `/api` - API design, contracts, versioning, documentation
  - `/dependency` - Dependency management and security
  - `/benchmark` - Performance benchmarking and regression tracking
  - `/simplify` - Complexity reduction beyond basic refactoring
- **Alias support**: Each skill now supports multiple aliases for natural language
  triggering:
  - `/think` → `/reason`, `/analyze`, `/ponder`
  - `/code` → `/implement`, `/build`, `/develop`
  - `/debug` → `/fix`, `/troubleshoot`, `/diagnose`
  - `/test` → `/verify`, `/validate`, `/check`
  - `/architect` → `/design-system`, `/structure`, `/blueprint`
  - `/optimize` → `/perf`, `/performance`, `/speedup`
  - `/search` → `/find`, `/lookup`, `/locate`, `/research`
  - `/document` → `/docs`, `/write-docs`, `/docstring`
  - `/investigate` → `/dig`, `/probe`, `/examine`
  - `/explore` → `/understand`, `/learn`, `/discover`
  - And many more...
- **Updated `/index` skill**: Now serves as a comprehensive navigator showing all
  45 skills organized by category with common workflow combinations.

### Changed

- **Skill count**: Now 45 skills (was 44), despite consolidation, due to new
  additions.
- **Skill organization**: Skills reorganized into 7 clear categories:
  - Core Reasoning (5)
  - Architecture & Design (9)
  - Implementation (10)
  - Operations (9)
  - Governance (2)
  - Change Management (5)
  - Meta (5)
- **README.md**: Completely rewritten to document the new skill naming, aliases,
  and organization.

### Migration Guide

To migrate from v0.x to v2.0:

1. Update all command references from `/deep-*` to the new names:
   - `/deep-think` → `/think`
   - `/deep-code` → `/code`
   - etc.
2. For consolidated skills, use the new combined skill:
   - `/deep-consider` or `/deep-decide` → `/decide`
   - `/deep-search` or `/deep-research` → `/search`
   - etc.
3. Re-run the installer to update your workflow/skill files:
   ```bash
   ./install.sh --agent all --level user --force
   ```

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
