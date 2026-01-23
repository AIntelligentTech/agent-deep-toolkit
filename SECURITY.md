# Security Policy

Agent Deep Toolkit is primarily a collection of Markdown workflows and a small Bash installer script (`install.sh`). While the surface area is intentionally small, security is still important.

## Supported versions

Until the project publishes a formal support matrix, the latest tagged release is considered the supported version. Older versions may not receive security fixes.

## Reporting a vulnerability

If you believe you have found a security issue in Agent Deep Toolkit:

- **Do not** open a public GitHub issue with exploit details.
- Instead, use one of the following options when the project is hosted on GitHub:
  - Open a private Security Advisory (if enabled for the repository).
  - If Security Advisories are not available, open a minimal issue that asks for a private contact channel without including sensitive details.

When reporting, please include:

- A description of the issue and its potential impact.
- Steps to reproduce or a minimal proof-of-concept, if possible.
- Any relevant environment details (OS, shell version, installation locations).

Maintainers will try to:

- Acknowledge your report in a reasonable timeframe.
- Investigate and, if appropriate, prepare a fix.
- Coordinate disclosure, including documenting the fix and crediting reporters where appropriate.

## Scope

The primary scope for security issues is:

- The behavior of `install.sh`, including where it writes files and how it handles user input.
- The integrity of the distributed workflows and skills.

Host environments (shells, terminals, editors, external tools such as Windsurf or Claude Code) are out of scope, except where their documented behavior is relied upon and demonstrably creates a security issue in this toolkit.
