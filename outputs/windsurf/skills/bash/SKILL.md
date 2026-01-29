---
name: bash
description: Design and implement robust Bash/Linux CLI automations, workflows, and
  terminal orchestration
activation: auto
---

# Bash Workflow

This workflow instructs Cascade to design and implement robust, maintainable Bash/Linux CLI automations and workflows, including advanced terminal orchestration with tools like tmux and Neovim.

## 1. Clarify the Task and Constraints

- Restate what the user wants to automate or orchestrate:
  - One-liner, script, interactive workflow, background service, or multi-pane terminal setup.
- Identify constraints:
  - Target shells (bash, zsh, sh compatibility), OS requirements, required binaries, permissions, portability.
- Define success criteria:
  - What does "done" look like?

## 2. Discover Existing Ecosystem

- Review the project or system for:
  - Existing scripts, aliases, and functions.
  - Makefile or Taskfile targets.
  - Dotfile configurations (`.bashrc`, `.zshrc`, etc.).
- Understand dependencies:
  - Required tools and their versions (e.g., `jq`, `ripgrep`, `fzf`, `tmux`).
- Search for canonical patterns:
  - Refer to established CLI patterns and modern Unix philosophy.

## 3. Design the CLI Workflow

- Break down the automation into steps:
  - Inputs, processing, outputs, error handling, and cleanup.
- Consider:
  - Idempotency: Can this be run safely multiple times?
  - Interruptibility: What happens if the user presses Ctrl+C?
  - Logging: How will progress and errors be reported?
- Choose the right tool for the job:
  - Shell scripts for orchestration and glue.
  - Dedicated tools for parsing (jq, yq, awk) and searching (rg, fd).

## 4. Advanced Terminal Orchestration (When Needed)

For complex workflows involving multiple terminal contexts:

### Tmux Patterns
- Session and window management for persistent workflows.
- Pane layouts for simultaneous monitoring and interaction.
- Key bindings and hooks for automation.

### Neovim Integration
- Terminal buffers for embedded shell interaction.
- Lua scripting for custom workflows.
- Floating windows for transient commands.

### Orchestration Principles
- Keep orchestration logic separate from business logic.
- Use configuration files for flexibility.
- Design for both interactive and headless execution.

## 5. Implement with Defensive Coding

- Use strict mode where appropriate:
  ```bash
  set -euo pipefail
  ```
- Validate inputs early and fail fast.
- Quote variables properly.
- Use meaningful exit codes.
- Handle signals gracefully (trap).
- Prefer portable constructs unless targeting a specific shell.

## 6. Verification and Testing

- Test the happy path and common failure modes.
- Verify behavior in the target environment.
- Check for:
  - Correct output and exit codes.
  - Proper cleanup on success and failure.
  - No unintended side effects.

## 7. Documentation and Discoverability

- Add usage help (`--help` or inline comments).
- Document prerequisites and installation.
- Link scripts from READMEs or task runners.
- Consider adding shell completion for complex CLIs.

## 8. When to Escalate to Other Tools

- If the script exceeds ~200 lines or needs complex data structures:
  - Consider Python, Go, or a dedicated CLI framework.
- For cross-platform needs:
  - Consider tools that work on Windows/macOS/Linux.
- For frequent reuse:
  - Package as a proper CLI tool with versioning.