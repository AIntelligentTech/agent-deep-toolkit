# Contributing to Agent Deep Toolkit

Thank you for your interest in improving Agent Deep Toolkit. This project provides shared deep-* workflows and a small installer script that other tools can depend on, so changes here should be careful, well-documented, and easy for others to understand.

## Ways to contribute

- **Improve workflows** under `windsurf/workflows/` and the mirrored Claude Code `references/`.
- **Refine Claude skills** in `claude-code/skills/` (for example, clarifying usage patterns or updating references lists).
- **Enhance the installer** (`install.sh`) for better UX, safety, or platform compatibility.
- **Improve documentation** (README, this file, SECURITY, Code of Conduct) to make the toolkit easier to adopt.

## Development workflow

1. **Fork** the repository and create a feature branch.
2. Make your changes in small, focused commits.
3. Manually run basic checks before opening a PR:
   - Ensure `install.sh` still runs with `-h` / `--help` and prints useful information.
   - On at least one supported platform (macOS or Linux), sanity-check a project-level and a user-level install, and a `--dry-run` invocation.
4. Update documentation where relevant:
   - If you change user-visible behavior, update `README.md` and `CHANGELOG.md`.
   - If you adjust workflows or skills in a way that changes semantics, briefly describe this in the changelog entry.
5. Open a pull request with a clear description of what changed and why.

## Style and design guidelines

- **Keep workflows consistent**
  - Follow the existing structure (YAML frontmatter, numbered sections, bullet-point steps).
  - Avoid introducing agent-specific details into the generic deep-* workflow text; agent-specific wiring belongs in the installer or skills.

- **Treat Windsurf workflows as canonical**
  - When updating a deep-* procedure, update the Windsurf workflow first.
  - Mirror the same changes into the corresponding Claude Code `references/deep-*.md` file, keeping the procedures conceptually identical.

- **Installer changes should be conservative**
  - Do not introduce network calls or privileged operations (such as `sudo`).
  - Prefer additive options (like `--dry-run`) over breaking existing flags and semantics.
  - Keep `install.sh` readable and well-factored; avoid tightly coupling Windsurf- and Claude-specific logic.

- **Documentation as a first-class artifact**
  - The workflows and skills are the primary product of this repository.
  - Treat changes to them with the same care as code: clear rationale, small increments, and review.

## Versioning and changelog

This project follows Semantic Versioning. When you make a change that affects users:

- Bump the version number in `VERSION` in a separate commit or as part of the release PR, according to the maintainer's guidance.
- Add an entry to `CHANGELOG.md` under the appropriate version.

If you are unsure how your change should be versioned, describe the impact in your PR and maintainers will help classify it.

## Code of conduct

By participating in this project, you agree to abide by the guidelines in `CODE_OF_CONDUCT.md`. Please review it before contributing.
