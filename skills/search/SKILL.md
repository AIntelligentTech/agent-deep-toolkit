---
name: search
description: Perform structured search across local repositories and the web to locate relevant code, docs, and context
command: /search
aliases: ["/find", "/lookup", "/locate", "/research"]
synonyms: ["/searching", "/searched", "/searches", "/researching", "/researched", "/find", "/locate", "/gather"]
activation-mode: contextual
user-invocable: true
disable-model-invocation: true
category: information-retrieval
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

# Search Workflow

This workflow instructs Cascade to search systematically—starting locally, then escalating to the web when needed. It combines repository search with multi-source web research.

<scope_constraints>
Search scope: Code, documentation, configuration, architecture, and external resources. Not applicable to design asset searches, media retrieval, or private data sources.
</scope_constraints>

<context>
Effective search is foundational to understanding systems, finding solutions, and making evidence-based decisions. This workflow emphasizes starting with high-signal local searches before expanding to web research, ensuring efficiency and relevance.
</context>

<instructions>

## Inputs

- Search target or query (function name, error message, config key, concept, etc.)
- Repository context (if local search is needed)
- Scope boundaries (local-only vs. web-inclusive)
- Time constraints or version requirements

### Step 1: Clarify the Search Target

- Restate what needs to be found in concrete terms (function, type, config value, log message, error string, etc.).
- Identify likely scopes:
  - Code modules, packages, or directories.
  - Config files, docs, ADRs, or runbooks.
  - Tests or fixtures that mention the target.
- Define whether this requires **local search only** or **web research**.

### Step 2: Execute Local Search First

- **Text search**: use `rg`/`grep_search` across the repo for key identifiers, error messages, or config keys.
- **Filename/path search**: locate files or directories whose names suggest relevance.
- **Git history search**: search commits for the term when relevant.
- Prefer narrow, high-signal queries first (exact identifiers, error codes) before broad ones.

### Step 3: Map Local Findings

- From the matches, build a quick map of:
  - Where the concept is **defined** (types, functions, classes).
  - Where it is **used** (call sites, configs, tests).
  - Any **obvious entry points** (CLIs, HTTP handlers, jobs, workflows).
- Identify gaps that local search did not resolve.

### Step 4: Escalate to Web Research When Needed

If local search is insufficient:

- Use `search_web` aggressively with multiple distinct queries.
- **Keyword Expansion**: Explicitly search for synonyms, acronyms, and outdated terminology related to the target.
- **Expand Context**: Include **Slack/Discord/Email** or internal knowledge bases as explicit search targets for "team context" if accessible.
- Target multiple dimensions: syntax, best practices, security, recent changes/deprecations.
- Prioritize authoritative sources:
  - Official Documentation
  - GitHub Repositories (issues, discussions, code)
  - RFCs and Standards
  - Reputable Technical Blogs

### Step 5: Apply Temporal Filtering (Current Year)

- Explicitly look for content relevant to the current timeframe.
- Check for "latest" versions, recent releases in search terms.
- Discard outdated information unless maintaining legacy systems.

### Step 6: Synthesize and Document

- Summarize findings, highlighting consensus and conflicts.
- Explicitly state *why* a particular approach is chosen based on the research.
- Cite sources to provide evidence for decisions.
- Document key search queries and findings briefly so they can be reused later.

### Step 7: Decide on Next Step

- If search reveals enough:
  - Switch to the appropriate workflow (e.g., `/code`, `/debug`, `/explore`) using the found code as anchors.
- If gaps remain:
  - Document remaining questions and suggest follow-up searches.

## Error Handling

- If no local results are found, escalate to web search immediately.
- If search queries return too many results, refine scope and use filtering.
- If sources conflict, document both perspectives and explain which is preferred.
- If information is outdated, explicitly flag as "legacy" and suggest current alternatives.

</instructions>

<output_format>
Provide a map of findings organized by definition, usage, and entry points. Include source citations and key search queries used. Highlight gaps and recommend next workflow steps.
</output_format>
