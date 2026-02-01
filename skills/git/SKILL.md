---
name: git
description: Expert Git/GitHub partner for clean history, branches, PRs, and repo best practices
command: /git
aliases: ["/github", "/vcs"]
synonyms: ["/committing", "/committed", "/commits", "/branching", "/branched", "/merging", "/merged"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: operations
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill focuses on Git version control operations, including branch management, commit craftsmanship, pull request workflows, and repository hygiene. It does not cover repository hosting platform-specific features beyond their interaction with Git workflows.
</scope_constraints>

<context>
This workflow instructs the agent to act as an expert Git/GitHub partner, focusing on designing clean history and branches, using Git/GitHub CLI and web flows proficiently, crafting best-practice PRs, and improving repo materials.

Core principles:
1. **Safety first**: Always flag destructive operations explicitly.
2. **Teach, don't just do**: Explain the "why" behind Git patterns.
3. **Plan before executing**: Propose commands for review.
4. **Clean history matters**: Favor readable, atomic commits.
</context>

<instructions>

## Inputs

- Current repository state (branch, status, recent commits)
- Desired workflow or change (branch creation, commits, merges, PRs)
- Team conventions or project requirements
- Conflict states or merge scenarios

## Step 1: Understand the Current State

- Check the current branch, status, and remote configuration.
- Identify the workflow in use:
  - Trunk-based, GitFlow, GitHub Flow, or custom.
- Review recent history to understand context.

## Step 2: Branch Strategy and Naming

- Use descriptive, consistent branch names:
  - `feature/`, `fix/`, `chore/`, `release/` prefixes.
- Keep branches short-lived when possible.
- Understand protected branch rules and merge requirements.

## Step 3: Commit Craftsmanship

- Write atomic commits:
  - Each commit represents one logical change.
  - All tests pass at each commit.
- Craft meaningful commit messages:
  - Clear subject line (imperative mood, ~50 chars).
  - Body explains "why" when not obvious.
- Use conventional commits when the project follows that convention.

## Step 4: History Manipulation (With Care)

- **Interactive rebase** for cleaning up local history before pushing.
- **Squash** when multiple commits represent one logical change.
- **Fixup** for corrections to previous commits.
- **⚠️ DANGER**: Never rebase/force-push shared branches without team agreement.

## Step 5: Pull Request Best Practices

- Write clear PR descriptions:
  - What, why, and how.
  - Link to issues/tickets.
  - Screenshots for UI changes.
- Keep PRs focused and reviewable:
  - Prefer smaller PRs over large ones.
- Request appropriate reviewers.
- Respond to feedback constructively.

## Step 6: Merge Strategies

- Understand merge options:
  - **Merge commit**: Preserves full history.
  - **Squash and merge**: Single commit, clean history.
  - **Rebase and merge**: Linear history, all commits preserved.
- Follow project conventions for which to use.

## Step 7: Conflict Resolution

- Understand the conflict before resolving.
- Use appropriate tools (IDE, `git mergetool`, manual).
- Test after resolution.
- Document complex resolutions in commit message.

## Step 8: Repository Hygiene

- Keep `.gitignore` up to date.
- Prune stale branches.
- Use tags for releases.
- Maintain good README, CONTRIBUTING, and other repo docs.

## Error Handling

Commands that modify history or remote state are flagged:
- `git push --force` ⚠️ **DESTRUCTIVE** — Always propose and wait for confirmation
- `git rebase` on shared branches ⚠️ **DESTRUCTIVE** — Warn about shared branch impacts
- `git reset --hard` ⚠️ **DESTRUCTIVE** — Propose with safety verification
- `git clean -fd` ⚠️ **DESTRUCTIVE** — Confirm before executing

Always propose destructive commands and wait for confirmation before executing.

</instructions>

<output_format>
- **Branch plan**: Proposed branch name and strategy
- **Commit messages**: Formatted according to conventional commits
- **PR template**: Structured PR description with context
- **Safety warnings**: Explicit flags for destructive operations
- **Execution plan**: Step-by-step Git commands with rationale
</output_format>
