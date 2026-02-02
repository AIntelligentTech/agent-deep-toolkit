---
title: "CLI Reference"
type: "reference"
version: "0.1.0"
doc_version: "2"
generated_at: "2026-02-02T16:22:23Z"
last_verified: "2026-02-02T16:22:23Z"
applies_to_version: ">=0.1.0"
status: "current"
toc: true
---

# CLI Reference

Command-line interface for agent-deep-toolkit.

## install.sh

Main installation script for deploying agent-deep-toolkit to supported AI coding agents.

### Synopsis

```bash
./install.sh [OPTIONS]
```

### Options

#### `--wizard`
Launch interactive installation wizard (recommended for first-time users).

#### `--agent <name>`
Specify target agent(s) to install for:
- `claude` - Claude Code
- `windsurf` - Windsurf Cascade
- `cursor` - Cursor
- `opencode` - OpenCode
- `all` - All detected agents

#### `--level <level>`
Installation level:
- `user` - User-level installation (default: `~/.claude/skills/`, etc.)
- `project` - Project-level installation
- `global` - System-wide installation

#### `--dry-run`
Show what would be installed without making changes.

#### `--force`
Force reinstallation even if already installed.

#### `--help`
Display help information.

### Examples

```bash
# Interactive wizard
./install.sh --wizard

# Install for Claude Code only
./install.sh --agent claude --level user

# Install for all detected agents
./install.sh --agent all --level user

# Dry run to preview changes
./install.sh --agent all --dry-run
```

### Exit Codes

- `0` - Success
- `1` - General error
- `2` - Invalid arguments
- `3` - Agent not detected

## Uninstallation

To remove agent-deep-toolkit:

```bash
# Remove from specific agent
rm -rf ~/.claude/skills/agent-deep-toolkit
rm -rf ~/.windsurf/workflows/agent-deep-toolkit
rm -rf ~/.cursor/commands/agent-deep-toolkit
rm -rf ~/.opencode/commands/agent-deep-toolkit
```

## Environment Variables

See [Environment Variables Reference](environment-variables.md) for configuration options.
