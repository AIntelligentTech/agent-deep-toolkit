---
name: bash
description: Design and implement robust Bash/Linux CLI automations, workflows, and terminal orchestration
command: /bash
aliases: ["/shell", "/cli", "/terminal"]
synonyms: ["/shell", "/scripting", "/scripted", "/scripts", "/terminal", "/cli", "/command-line", "/orchestration"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: code
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Bash Workflow

This workflow instructs Cascade to design and implement robust, maintainable Bash/Linux CLI automations and workflows, including advanced terminal orchestration with tools like tmux and Neovim.

<scope_constraints>
- Focuses on Bash and POSIX shell scripting
- Covers CLI design, task automation, and terminal orchestration
- Applies to system administration, DevOps, and build automation
- Assumes Unix/Linux environments (some content applicable to macOS)
- Supports Windows via WSL, Git Bash, or MSYS2
- Not a replacement for full application development (escalate large scripts to Python/Go)
</scope_constraints>

<context>
**Dependencies:**
- Bash/POSIX shell knowledge (variables, arrays, control flow)
- Understanding of Unix tools (grep, sed, awk, jq, etc.)
- Familiarity with terminal concepts and process management
- Knowledge of error handling and exit codes
- Optional: tmux, Neovim, and modern CLI tools (fzf, ripgrep, etc.)

**Prerequisites:**
- Clear description of automation or workflow needed
- Target shell and OS requirements
- Constraints on available tools and dependencies
- Performance and reliability expectations
</context>

<instructions>

## Inputs

- Description of automation or workflow to implement
- Target shells (bash, zsh, sh) and OS (Linux, macOS, POSIX)
- Required binaries and tools
- Input sources (arguments, files, APIs, stdin)
- Expected output format
- Error handling and logging requirements
- Performance or reliability constraints

## Steps

### Step 1: Clarify the Task and Constraints

- Restate what the user wants to automate or orchestrate:
  - One-liner, script, interactive workflow, background service, or multi-pane terminal setup.
- Identify constraints:
  - Target shells (bash, zsh, sh compatibility), OS requirements, required binaries, permissions, portability.
- Define success criteria:
  - What does "done" look like?

### Step 2: Discover Existing Ecosystem

- Review the project or system for:
  - Existing scripts, aliases, and functions.
  - Makefile or Taskfile targets.
  - Dotfile configurations (`.bashrc`, `.zshrc`, etc.).
- Understand dependencies:
  - Required tools and their versions (e.g., `jq`, `ripgrep`, `fzf`, `tmux`).
- Search for canonical patterns:
  - Refer to established CLI patterns and modern Unix philosophy.

### Step 3: Design the CLI Workflow

- Break down the automation into steps:
  - Inputs, processing, outputs, error handling, and cleanup.
- Consider:
  - Idempotency: Can this be run safely multiple times?
  - Interruptibility: What happens if the user presses Ctrl+C?
  - Logging: How will progress and errors be reported?
- Choose the right tool for the job:
  - Shell scripts for orchestration and glue.
  - Dedicated tools for parsing (jq, yq, awk) and searching (rg, fd).

### Step 4: Advanced Terminal Orchestration (When Needed)

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

### Step 5: Implement with Defensive Coding

- Use strict mode where appropriate:
  ```bash
  set -euo pipefail
  ```
- Validate inputs early and fail fast.
- Quote variables properly.
- Use meaningful exit codes.
- Handle signals gracefully (trap).
- Prefer portable constructs unless targeting a specific shell.

### Step 6: Verification and Testing

- Test the happy path and common failure modes.
- Verify behavior in the target environment.
- Check for:
  - Correct output and exit codes.
  - Proper cleanup on success and failure.
  - No unintended side effects.

### Step 7: Documentation and Discoverability

- Add usage help (`--help` or inline comments).
- Document prerequisites and installation.
- Link scripts from READMEs or task runners.
- Consider adding shell completion for complex CLIs.

### Step 8: When to Escalate to Other Tools

- If the script exceeds ~200 lines or needs complex data structures:
  - Consider Python, Go, or a dedicated CLI framework.
- For cross-platform needs:
  - Consider tools that work on Windows/macOS/Linux.
- For frequent reuse:
  - Package as a proper CLI tool with versioning.

## Error Handling

**Common Bash pitfalls:**
- Unquoted variables causing word splitting and globbing
- Missing error handling leading to silent failures
- Poor exit code management
- Inadequate logging or output for debugging
- Non-portable bash constructs

**Mitigation strategies:**
- Always quote variables: `"$var"`, `"${array[@]}"`
- Use `set -euo pipefail` for fail-fast behavior
- Trap signals and errors explicitly
- Log important steps to stderr
- Test scripts on target shells and OS versions
- Use shellcheck for static analysis

</instructions>

<output_format>

The output of this skill is **well-documented, maintainable Bash code** that includes:

1. **CLI Script or Orchestration** — Main implementation file(s) with clear structure
2. **Usage Documentation** — Help text, examples, prerequisites
3. **Error Handling** — Error messages, logging, recovery procedures
4. **Tests** — Test cases covering happy path and failure modes
5. **Installation Guide** — Steps to integrate into project (linking, PATH setup, etc.)
6. **Performance Notes** — Benchmark results or optimization considerations
7. **Maintenance Guide** — Known issues, edge cases, future improvements

Deliverables typically include:
- Executable bash script(s) with strict mode and signal handling
- Comprehensive inline comments and usage help (`--help`)
- Test script or test cases (using bats or bash test framework)
- README with prerequisites, installation, and examples
- Optional: Makefile or task runner integration
- Optional: tmux/Neovim configuration for orchestrated workflows

</output_format>
