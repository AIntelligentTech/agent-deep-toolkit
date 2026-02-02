---
title: "Quick Start Guide"
type: "guide"
version: "0.1.0"
doc_version: "2"
generated_at: "2026-02-02T16:22:23Z"
last_verified: "2026-02-02T16:22:23Z"
applies_to_version: ">=0.1.0"
status: "current"
toc: true
---

# Quick Start Guide

Get up and running with agent-deep-toolkit in 5 minutes.

## Prerequisites

- One or more supported AI coding agents installed:
  - Claude Code
  - Windsurf Cascade
  - Cursor
  - OpenCode
- Git installed for cloning the repository
- Bash shell (Linux, macOS, WSL)

## Installation Steps

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/AIntelligentTech/agent-deep-toolkit.git
cd agent-deep-toolkit
```

### 2️⃣ Run the Installer

**Interactive wizard (recommended for first-time users):**
```bash
./install.sh --wizard
```

**Direct install for all detected agents:**
```bash
./install.sh --agent all --level user
```

**Install for specific agent:**
```bash
./install.sh --agent claude --level user
./install.sh --agent windsurf --level user
./install.sh --agent cursor --level user
./install.sh --agent opencode --level user
```

### 3️⃣ Verify Installation

The installer will automatically detect which agents are installed and configure them accordingly:

- **Claude Code** → Skills in `~/.claude/skills/`
- **Windsurf** → Workflows in `~/.windsurf/workflows/`
- **Cursor** → Commands in `~/.cursor/commands/`
- **OpenCode** → Commands in `~/.opencode/commands/`

## Try Your First Skill

### Claude Code
```bash
/think "How should I architect a real-time notification system?"
```

### Windsurf
Workflows auto-suggest contextually as you work

### Cursor
Use slash commands in the chat interface

### OpenCode
Commands available via the command palette

## Next Steps

- [Configuration Guide](configuration.md) - Customize your installation
- [Full Installation Guide](installation.md) - Advanced installation options
- [Troubleshooting](troubleshooting.md) - Common issues and solutions
