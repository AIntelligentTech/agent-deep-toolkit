---
title: "Release System Assessment"
version: "0.1.0"
doc_version: "1"
generated_at: "2026-02-02T16:22:23Z"
generated_by: "llm-doc-system"
last_verified: "2026-02-02T16:22:23Z"
applies_to_version: ">=0.1.0"
status: "current"
toc: true
progressive_disclosure: true
---

# Release System Assessment

## Manifest-First Architecture

As of v3.2.0, agent-deep-toolkit uses **INSTALLATION.yaml as the sole version
source of truth**.

### Version Resolution (2 sources)

1. **INSTALLATION.yaml** (primary) —
   `yq eval '.package.version' INSTALLATION.yaml`
2. **Git tag** (secondary fallback) — `git describe --tags --abbrev=0`

The legacy `VERSION` file has been removed. No `package.json` or
`pyproject.toml` fallbacks exist.

### Release Flow

```
./release.sh <major|minor|patch> [--dry-run] [--push]
```

1. Reads current version from `INSTALLATION.yaml`
2. Computes new version
3. Updates `INSTALLATION.yaml` in-place via `yq`
4. Optionally updates CHANGELOG.md, commits, tags, and pushes

### Integration with release-manager

The `release-manager` CLI reads `INSTALLATION.yaml` for version discovery:

- `release status` → reads manifest version
- `release bump patch --repo agent-deep-toolkit` → delegates to `release.sh`
  (configured via `release.script` in manifest)
- `release manifest summary` → shows manifest metadata

### CI/CD

GitHub Actions workflow (`.github/workflows/ci.yml`):

- Validates INSTALLATION.yaml structure
- Ensures no legacy VERSION file
- Runs ShellCheck
- Runs test suite
- Tests `release.sh --dry-run`

### Migration Status

| Component                 | Status |
| ------------------------- | ------ |
| INSTALLATION.yaml created | Done   |
| VERSION file removed      | Done   |
| install.sh reads manifest | Done   |
| release.sh created        | Done   |
| Tests updated             | Done   |
| CI/CD configured          | Done   |

### Naming Decision

Kept **install-manifest** (not "release-manifest"). The manifest describes the
installation — what to install, how to install it, what it depends on. Release
is one concern among many. Renaming would create churn across 26 repos, docs,
and imports for marginal semantic gain.
