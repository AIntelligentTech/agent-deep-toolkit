# Deep Search

## Objective

Perform structured local and repository search to locate relevant code, docs, and context inside the project

## Requirements

# Deep Search Workflow (Local and Repository Search)

This workflow instructs Cascade to search **within the current project and its immediate environment** before reaching for the wider web. It focuses on ripgrep/grep-style search, file navigation, and repository introspection.

## 1. Clarify the Search Target

- Restate what needs to be found in concrete terms (function, type, config value, log message, error string, etc.).
- Identify likely scopes:
  - Code modules, packages, or directories.
  - Config files, docs, ADRs, or runbooks.
  - Tests or fixtures that mention the target.

## 2. Plan Local Search Strategy

- Choose one or more search dimensions:
  - **Text search**: use `rg`/`search for patterns` across the repo for key identifiers, error messages, or config keys.
  - **Filename/path search**: locate files or directories whose names suggest relevance.
  - **Git history search**: search commits for the term when relevant (e.g., `deep-git` patterns).
- Prefer narrow, high-signal queries first (exact identifiers, error codes) before broad ones.

## 3. Execute Local Searches Iteratively

- Run targeted searches and inspect results in context:
  - Open surrounding code for matches, not just the single line.
  - Note clusters of matches that indicate important modules.
- If a search returns too many results:
  - Refine the query (add namespace, file extension filters, or directory scoping).
  - Use additional terms (e.g., function name + argument name).

## 4. Map Findings and Gaps

- From the matches, build a quick map of:
  - Where the concept is **defined** (types, functions, classes).
  - Where it is **used** (call sites, configs, tests).
  - Any **obvious entry points** (CLIs, HTTP handlers, jobs, workflows).
- Identify gaps that local search did not resolve (e.g., missing design rationale, external API behavior).

## 5. Decide on Next Step

- If local search reveals enough:
  - Switch to the appropriate deep-* workflow (e.g., `deep-code`, `deep-debug`, `deep-explore`) using the found code as anchors.
- If local search is insufficient or points to external systems:
  - Escalate to `deep-research` (web/multi-source research) to gather missing background.
- Document key search queries and findings briefly so they can be reused later.
