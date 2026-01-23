# Changelog

All notable changes to this project will be documented in this file.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.2.0] - 2026-01-23

### Added

- Expanded `README.md` with requirements, installer behavior, safety characteristics, versioning/upgrade guidance, and uninstall instructions.
- New contributor documentation: `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and `SECURITY.md`.
- `CHANGELOG.md` to record user-visible changes going forward.
- A `--dry-run` flag to `install.sh` so users can see what would be installed without changing their filesystem.
- Logging of key installer parameters (agent, level, project directory, force, dry-run) at startup.
- A safety check that refuses project-level installs when `--project-dir /` is specified, to avoid accidental writes at the filesystem root.

### Changed

- Bumped toolkit version from `0.1.0` to `0.2.0` in `VERSION`.

## [0.1.0]

- Initial release of the Agent Deep Toolkit structure:
  - Windsurf deep-* workflows under `windsurf/workflows/`.
  - Claude Code skills and references under `claude-code/skills/`.
  - Unified `install.sh` for Windsurf and Claude Code without `--dry-run`.
