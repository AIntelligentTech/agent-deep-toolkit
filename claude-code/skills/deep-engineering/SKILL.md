---
name: deep-engineering
description: Engineering workflows for deep code understanding, debugging, testing, refactoring, optimization, and related tasks using bundled deep-* procedures.
disable-model-invocation: true
user-invocable: true
---

# Deep Engineering Skill

Use this skill when you want Claude to follow **structured engineering workflows** rather than responding informally about code.

Invoking this skill (for example as `/deep-engineering`) tells Claude to:

- Clarify the code or system area under investigation.
- Select one or more engineering deep-* workflows from the bundled references.
- Follow those procedures step by step, making its use of each workflow explicit.

## When to use this skill

Use `/deep-engineering` when you need any of the following:

- **Deep code understanding and design** – `deep-code`, `deep-spec`, `deep-polish`.
- **Debugging and fault isolation** – `deep-debug`.
- **Testing strategy and coverage** – `deep-test`.
- **Refactoring and pruning** – `deep-refactor`, `deep-prune`.
- **Performance and data work** – `deep-optimize`, `deep-data`.
- **Git and history workflows** – `deep-git`.

The detailed procedures live in the `references/` directory next to this file and are treated as **canonical specs** for how to think and act:

- `references/deep-code.md`
- `references/deep-debug.md`
- `references/deep-test.md`
- `references/deep-optimize.md`
- `references/deep-refactor.md`
- `references/deep-prune.md`
- `references/deep-data.md`
- `references/deep-spec.md`
- `references/deep-git.md`
- `references/deep-polish.md`

Claude should load only the reference files that are relevant to the current request, not all of them at once, to conserve context.

## Usage pattern

When this skill is invoked:

1. **Clarify the engineering mission** (e.g. fix a bug, improve performance, design tests).
2. **State explicitly** which workflows from `references/` will be followed.
3. **Follow the steps** in those reference files, adapting to the repository and stack in front of Claude.
4. **Summarize outcomes** in the formats suggested by the workflows (for example, bug root-cause narrative, test plan, refactor plan).

## Safety and invocation policy

- This skill is **user-invocable only** (`disable-model-invocation: true`).
- Claude **must not** auto-trigger this skill based on normal questions; the user must explicitly choose to run a deep engineering workflow.
- The skill itself is **procedural**; when workflows recommend code edits, git operations, or shell commands, Claude should continue to:
  - Propose changes clearly.
  - Ask for confirmation before running any potentially destructive commands.

