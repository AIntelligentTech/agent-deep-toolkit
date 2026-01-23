---
name: deep-meta
description: Meta-cognitive workflows for deep understanding, documentation, decision-making, and architecture using the bundled deep-* procedures.
disable-model-invocation: true
user-invocable: true
---

# Deep Meta Skill

Use this skill when you want Claude to follow a **structured deep-* workflow** instead of answering in an ad-hoc way.

Invoking this skill (for example as `/deep-meta`) tells Claude to:

- Clarify the target and desired outcome.
- Select one or more appropriate deep-* workflows from the bundled references.
- Follow those procedures step by step, making its use of each workflow explicit.

## When to use this skill

Use `/deep-meta` when you need any of the following:

- **Deep architecture work** – use the `deep-architect` procedure.
- **Structured decision-making** – use `deep-consider` and/or `deep-decide`.
- **Documentation and reference mapping** – use `deep-document`.
- **Exploratory understanding and mapping** – use `deep-explore`, `deep-search`, `deep-think`, `deep-iterate`, or `deep-investigate`.

The detailed procedures live in the `references/` directory next to this file and are treated as **canonical specs** for how to think and act:

- `references/deep-architect.md`
- `references/deep-consider.md`
- `references/deep-decide.md`
- `references/deep-document.md`
- `references/deep-explore.md`
- `references/deep-iterate.md`
- `references/deep-search.md`
- `references/deep-think.md`
- `references/deep-investigate.md`

Claude should load only the reference files that are relevant to the current request, not all of them at once, in order to conserve context.

## Usage pattern

When this skill is invoked:

1. **Clarify the mission** using the appropriate deep-* workflow (for example, deep-architect or deep-investigate).
2. **State explicitly** which workflows from `references/` will be followed.
3. **Follow the steps** in those reference files, adapting only where the user’s context requires.
4. **Summarize outcomes** in the formats suggested by the workflows (for example, CSD matrix, architecture summary, decision analysis).

## Safety and invocation policy

- This skill is **user-invocable only** (`disable-model-invocation: true`).
- Claude **must not** auto-trigger this skill based on normal questions; the user must explicitly choose to run a deep-* workflow.
- The skill is purely procedural and should not itself perform destructive actions; when workflows suggest code or tooling changes, Claude should still confirm with the user before running any risky operations.

