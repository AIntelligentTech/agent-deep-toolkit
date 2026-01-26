---
name: deep-bash
description: Design and implement robust Bash/Linux CLI automations and workflows (including tmux/nvim orchestration) with expert-level efficiency and safety.
command: /deep-bash
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---
# Deep Bash Workflow

This workflow instructs Cascade to think and act like an expert Bash/Linux/CLI engineer:

- Writes **robust, efficient** shell scripts and one-liners.
- Designs **automation workflows** using the wider Linux toolbox.
- Uses **tmux, neovim, and terminal multiplexers** to orchestrate panes/sessions.
- Treats scripts as **mini systems**: designed, tested, documented, and safe.

Use this when you want on-demand automations or scripts to reliably execute tasks or achieve goals in the most efficient, effective way.

---

## Input & Composition Semantics

- Assume this workflow may be invoked **together with other `/workflow-*` commands** in the same message.
- Treat the **entire user message** (including any other slash commands) as the problem description.
- Do **not** assume that input comes only from text immediately after `/deep-bash`.
- Ignore the literal `/workflow-*` tokens as natural language; instead, infer the user’s intent from the full message and conversation.

---

## 1. Clarify Task, Environment, and Safety

**Goal:** Understand what the automation must do, where it runs, and how safe it must be.

- **1.1 Restate the task as an automation goal**

  > “Automate **[TASK]** on **[HOST/ENV]**, so that **[OUTCOME]** happens with minimal manual work.”

  Classify:
  - One-off **command sequence**.
  - Reusable **script/tool**.
  - Long-running **service/daemon**.
  - **Interactive** CLI helper (prompting the user).
  - **tmux/nvim**-orchestrated workflow.

- **1.2 Capture constraints**

  - OS / distro, shell (`bash`, `zsh`, `fish`), package manager.
  - Privileges (normal user vs sudo/root).
  - Available tools (e.g. `tmux`, `nvim`, `systemd`, `cron`, `entr`, `inotifywait`, `fzf`, `ripgrep`).
  - Portability requirements (works only on your laptop vs generic Linux).

- **1.3 Safety and risk level**

  - Does it **delete/modify data**, restart services, touch prod?
  - Should we add:
    - `--dry-run` mode and confirmation prompts.
    - Safety checks (backup, guard rails).
  - If risk is non-trivial, briefly apply `/deep-consider` to trade off speed vs safety.

---

## 2. Discover Existing CLI Ecosystem and Patterns

**Goal:** Reuse and extend what already exists instead of reinventing.

- **2.1 Scan local ecosystem**

  - Identify:
    - Existing scripts (`~/bin`, `~/.local/bin`, repo `scripts/`, `tools/`, `Makefile`, `Taskfile.yml`).
    - Dotfiles (`~/.bashrc`, `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/init.*` or `lua/`).
    - Existing aliases, functions, and tmux/nvim commands.

- **2.2 Classify integration points**

  - Where should the new automation plug in?
    - As a standalone script in `~/bin`.
    - As a function/alias in your shell.
    - As a **tmux key binding or hook**.
    - As a **neovim command / mapping / plugin helper**.
    - As a `systemd` unit/timer or `cron` job.

- **2.3 Use `/deep-docs` and `@web (search_web)` as needed**

  - For unfamiliar tools (e.g. `tmux`, `nvim`, `entr`, `inotifywait`, `systemd`):
    - Discover version and official docs.
    - Map relevant commands: `tmux run-shell`, `send-keys`, hooks, user commands, nvim `:terminal`, RPC, etc.

---

## 3. Design the CLI Workflow and Architecture

**Goal:** Treat the automation as a small system, not just “some commands”.

- **3.1 Define inputs, processing, outputs**

  - Inputs:
    - CLI arguments, env vars, files, stdin streams, current git repo, etc.
  - Processing steps:
    - Filters (`grep`, `rg`, `jq`), transformations (`sed`, `awk`), orchestration (loops, conditionals).
  - Outputs:
    - Files, logs, notifications, status messages, triggers for other tools/panes.

- **3.2 Choose tools and languages intentionally**

  - Decide:
    - What should be handled in **Bash** vs other CLIs (`python`, `jq`, `fd`, `rg`, `xargs`, `parallel`, `make`).
    - When to favor pipelines and standard tools vs complex Bash logic.
  - Prefer:
    - Simple, composable commands for performance and clarity.
    - Dedicated tools where they’re clearly better than hand-rolled Bash.

- **3.3 Design for robustness**

  - Plan for:
    - `set -euo pipefail` (or explicit error handling where appropriate).
    - Proper quoting and handling of spaces/newlines.
    - Idempotency where possible (safe to re-run).
    - Clear error messages and exit codes.

- **3.4 Decide on interaction model**

  - Non-interactive batch job.
  - Interactive prompts (e.g. `select`, `fzf` menus).
  - Long-running watch mode (file watchers, repeat loops).
  - tmux/nvim-driven interactions (panes, keybindings, commands).

---

## 4. Design Advanced Terminal Orchestration (tmux, Neovim, Multiplexers)

**Goal:** Use multiplexer “magic” when it’s the best UX.

- **4.1 Clarify tmux/nvim integration intent**

  Examples:
  - A script runs in one tmux pane and **sends commands or messages** to another pane/session.
  - A hook in tmux (e.g. `hook-pane-died`, `client-attached`, custom keybinding) runs a script that:
    - Logs, cleans up, or kicks off follow-up tasks.
    - Notifies another pane or status line.
  - Neovim keybinding or command that:
    - Triggers an external script.
    - Sends results back into a scratch buffer or quickfix list.
    - Coordinates with tmux (e.g. running tests in another pane).

- **4.2 Choose orchestration mechanisms**

  - For **tmux**:
    - `run-shell`, `if-shell`, hooks, `send-keys`, `display-message`.
    - Named sessions/panes and environment variables to target them safely.
  - For **Neovim**:
    - `:terminal` windows, job control, RPC/MCP integration.
    - Mappings/commands that call external scripts.
  - For **cross-pane/same-session hooks**:
    - Named pipes (FIFOs), temp files, or socket-based signaling.
    - Conventions for identifying the “originating” pane/session.

- **4.3 Design feedback loops**

  - How does the script **tell you** what happened?
    - Messages in tmux status line or another pane.
    - Logs in a dedicated window.
    - Updates to a file that Neovim auto-reloads into a buffer.

---

## 5. Implement Robust Bash / CLI Code

**Goal:** Write high-quality, maintainable shell code.

- **5.1 Script skeleton and standards**

  - Shebang and options:
    - `#!/usr/bin/env bash`
    - Consider `set -Eeuo pipefail` and `IFS=$'\n\t'` when appropriate.
  - Structure:
    - Functions with clear names.
    - `main` function wrapping logic.
    - Usage/help text, `--help` flag.

- **5.2 Arguments, config, and environment**

  - Use `getopts` or a simple argument parser.
  - Support:
    - `--dry-run`, `--verbose`, `--force`.
    - Config via env vars or config files when warranted.
  - Validate inputs early; fail fast with helpful messages.

- **5.3 Efficiency and composability**

  - Avoid unnecessary forks and subshells where performance matters.
  - Prefer streaming over loading whole files into memory.
  - Use `xargs`, `GNU parallel`, or background jobs when concurrency helps.

- **5.4 Integration points**

  - tmux:
    - Implement the `run-shell` / `send-keys` / hooks wiring.
  - Neovim:
    - Provide commands or script entrypoints that are easy to bind to mappings.
  - System:
    - If appropriate, define a `systemd` unit/timer or `cron` entry, and align with `/deep-infrastructure` for reliability.

---

## 6. Verify, Test, and Harden

**Goal:** Ensure the automation behaves correctly and safely under real conditions.

- **6.1 Dry-run and sandbox tests**

  - Run in:
    - Non-destructive mode first.
    - A safe directory or test dataset.
  - Verify:
    - Output is as expected.
    - No unintended side effects.

- **6.2 Edge cases and failure modes**

  - Test:
    - Missing files, empty inputs, weird filenames.
    - Network failures, permission errors.
    - Interrupted runs (Ctrl-C, pane killed, session detached).
  - For tmux/nvim-integrated flows:
    - What happens if the target pane/session doesn’t exist?
    - How does the script behave if Neovim is not running?

- **6.3 Observability and logging**

  - Decide how to log:
    - To stdout vs file vs syslog/journal.
  - Include:
    - Clear error messages.
    - Exit codes meaningful to callers (other scripts, CI, systemd).

---

## 7. Document and Integrate

**Goal:** Make the automation discoverable and maintainable.

- **7.1 Usage documentation**

  - Add:
    - In-script `--help`.
    - A short README section (goal, usage, examples).
  - Note:
    - Dependencies and environment assumptions.
    - Safety caveats (what it can break if misused).

- **7.2 Integration notes**

  - Document how it plugs into:
    - Shell (aliases, functions).
    - tmux (`.tmux.conf` snippets, keybindings, hooks).
    - Neovim (mappings, commands).
    - Infra (systemd units/timers, cron, CI jobs).

- **7.3 Future evolution**

  - Capture:
    - Obvious next improvements (features, flags).
    - Potential refactor points (if complexity grows, consider `/deep-refactor`).
    - How to extend to new environments (servers, containers).

---

## 8. When to Combine with Other Workflows

- Use `/deep-design` when:
  - You’re shaping a **larger CLI UX** (e.g. a suite of tools, cohesive keybindings, or a “developer cockpit” in tmux/nvim).

- Use `/deep-infrastructure` when:
  - The automation becomes a **critical piece of infra** (backups, deploys, monitoring hooks) and needs proper SLOs, runbooks, and IaC.

- Use `/deep-relentless` when:
  - You want a **max-effort** design/implementation pass:
    - More options explored.
    - More patterns considered.
    - More thorough testing and hardening.
