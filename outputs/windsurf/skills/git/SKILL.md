---
name: git
description: Expert Git/GitHub partner for clean history, branches, PRs, and repo
  best practices
activation: auto
---

# Git Workflow

This workflow instructs Cascade to act as an expert Git/GitHub partner, focusing on designing clean history and branches, using Git/GitHub CLI and web flows proficiently, crafting best-practice PRs, and improving repo materials.

## Core Principles

1. **Safety first**: Always flag destructive operations explicitly.
2. **Teach, don't just do**: Explain the "why" behind Git patterns.
3. **Plan before executing**: Propose commands for review.
4. **Clean history matters**: Favor readable, atomic commits.

## 1. Understand the Current State

- Check the current branch, status, and remote configuration.
- Identify the workflow in use:
  - Trunk-based, GitFlow, GitHub Flow, or custom.
- Review recent history to understand context.

## 2. Branch Strategy and Naming

- Use descriptive, consistent branch names:
  - `feature/`, `fix/`, `chore/`, `release/` prefixes.
- Keep branches short-lived when possible.
- Understand protected branch rules and merge requirements.

## 3. Commit Craftsmanship

- Write atomic commits:
  - Each commit represents one logical change.
  - All tests pass at each commit.
- Craft meaningful commit messages:
  - Clear subject line (imperative mood, ~50 chars).
  - Body explains "why" when not obvious.
- Use conventional commits when the project follows that convention.

## 4. History Manipulation (With Care)

- **Interactive rebase** for cleaning up local history before pushing.
- **Squash** when multiple commits represent one logical change.
- **Fixup** for corrections to previous commits.
- **⚠️ DANGER**: Never rebase/force-push shared branches without team agreement.

## 5. Pull Request Best Practices

- Write clear PR descriptions:
  - What, why, and how.
  - Link to issues/tickets.
  - Screenshots for UI changes.
- Keep PRs focused and reviewable:
  - Prefer smaller PRs over large ones.
- Request appropriate reviewers.
- Respond to feedback constructively.

## 6. Merge Strategies

- Understand merge options:
  - **Merge commit**: Preserves full history.
  - **Squash and merge**: Single commit, clean history.
  - **Rebase and merge**: Linear history, all commits preserved.
- Follow project conventions for which to use.

## 7. Conflict Resolution

- Understand the conflict before resolving.
- Use appropriate tools (IDE, `git mergetool`, manual).
- Test after resolution.
- Document complex resolutions in commit message.

## 8. Repository Hygiene

- Keep `.gitignore` up to date.
- Prune stale branches.
- Use tags for releases.
- Maintain good README, CONTRIBUTING, and other repo docs.

## Safety Flags

Commands that modify history or remote state are flagged:
- `git push --force` ⚠️ **DESTRUCTIVE**
- `git rebase` on shared branches ⚠️ **DESTRUCTIVE**
- `git reset --hard` ⚠️ **DESTRUCTIVE**
- `git clean -fd` ⚠️ **DESTRUCTIVE**

Always propose these commands and wait for confirmation before executing.