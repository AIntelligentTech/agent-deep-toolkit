---
description: Discover, version-align, and deeply map official docs for all tools in a project, using llms.txt where available and rigorous web/GitHub search otherwise.
auto_execution_mode: 3
---

# Deep Docs Workflow

This workflow instructs Cascade to **identify the actual tools and versions in use**, then **systematically locate and map the best documentation** for them:
- Prefer **version-matched official docs**.
- Use **llms.txt / llms-full.txt** when available for progressive, LLM-friendly navigation.
- Fall back to **rigorous, multi-query web search** plus **GitHub** analysis when not.
- Produce a reusable **Docs Brief** for future work.

Use this when:
- You’re entering an unfamiliar stack.
- Major dependency upgrades are planned.
- You want your coding agent to rely on *current, accurate* docs instead of model priors.

---

## Input & Composition Semantics

- Assume this workflow may be invoked **together with other `/workflow-*` commands** in the same message.
- Treat the **entire user message** (including any other slash commands) as the problem description.
- Do **not** assume that input comes only from text immediately after `/deep-docs`.
- Ignore the literal `/workflow-*` tokens as natural language; instead, infer the user’s intent from the full message and conversation.

---

## 1. Frame the Documentation Mission

**Goal:** Be explicit about *why* you’re hunting docs and how deep you need to go.

- **1.1 Restate the task**

  > “I need authoritative docs for the tools used in **[PROJECT / SUBSYSTEM]**  
  > in order to **[design / debug / migrate / learn]**.”

- **1.2 Clarify depth and scope (borrow from `/deep-consider`)**

  - Are you doing:
    - **Quick orientation** (high-level guides, basic APIs)?  
    - **Architecture work** (configuration, deployment, scaling, failure modes)?  
    - **Migration** (version-to-version changes, deprecations)?  
    - **Debugging** (obscure edge cases, bug reports, change logs)?
  - Decide how many **top-priority tools** to fully map (typically 3–7).

- **1.3 Note constraints**

  - Timebox (e.g. 30–90 minutes of doc hunting).  
  - Any **specific questions** the docs must answer (e.g. “How does streaming work in vX.Y?”).

---

## 2. Discover Tools and Versions in the Project

**Goal:** Build a precise, evidence-based inventory of tools and their versions.

- **2.1 Crawl dependency definitions**

  Use `code_search` / Fast Context to find:

  - JavaScript/TypeScript:
    - `package.json`, `package-lock.json`, `pnpm-lock.yaml`, `yarn.lock`
  - Python:
    - `pyproject.toml`, `poetry.lock`, `requirements.txt`, `Pipfile.lock`
  - Other ecosystems:
    - `go.mod`, `Cargo.toml`, `Gemfile.lock`, `composer.json`, etc.
  - Infrastructure:
    - `Dockerfile`, `docker-compose.*`, `helm` charts, Terraform files.
  - Framework configs:
    - `next.config.*`, `vite.config.*`, `tsconfig.json`, `django/settings.py`, etc.

- **2.2 Extract a Tool Inventory**

  For each entry, create a row:

  - **Name** (as used in the ecosystem, e.g. `react`, `fastapi`).  
  - **Version constraint** (e.g. `^18.2.0`, `~=1.3`).  
  - **Resolved version** if lockfile present (pin exactly when possible).  
  - **Role** in the system:
    - Framework, ORM, HTTP client, test runner, infra tool, etc.

- **2.3 Sanity-check versions**

  - If lockfiles disagree or are missing, prefer:
    - Lockfile pins over range specs.
    - **CLI `--version`** (if available and safe) for critical tools (e.g. Node, Python, framework CLIs).
  - Explicitly flag tools whose exact version is **uncertain**.

- **2.4 Prioritize tools**

  Choose which tools get **full doc mapping**:

  - High architectural impact (frameworks, ORMs, message brokers).  
  - Directly relevant to the current question.  
  - Libraries with a history of breaking changes.

---

## 3. Locate Canonical Sources and GitHub Repos

**Goal:** For each prioritized tool, identify its *canonical home* before diving into docs.

For each tool in the prioritized list:

- **3.1 Identify the canonical package and maintainer**

  - Use `@web (search_web)` queries like:
    - `"<tool-name>" official documentation`
    - `"<tool-name>" "GitHub"`, `"<tool-name>" "npm"`, `"<tool-name>" "PyPI"`
  - Confirm:
    - Official site domain (e.g. `https://react.dev`, `https://fastapi.tiangolo.com`).  
    - Maintainer org (e.g. `facebook/react`, `tiangolo/fastapi` on GitHub).

- **3.2 Always map GitHub**

  - Find the **canonical GitHub repo** (not forks or mirrors).  
  - Note:
    - Default branch name.  
    - `docs/`, `documentation/`, or `website/` directories.  
    - `CHANGELOG`, `RELEASE_NOTES`, `UPGRADING` files.  
    - Open/closed issues or discussions about your specific version when relevant.

- **3.3 Capture the official docs domain and structure**

  - Identify:
    - Main docs root URL (e.g. `https://docs.djangoproject.com/`).  
    - Versioning scheme (URL path, query params, or subdomains).  
    - Any obvious **“API reference”**, **“Guides”**, **“Migration”**, and **“Best practices”** sections.

---

## 4. Probe for `llms.txt` / `llms-full.txt` (Progressive Disclosure)

**Goal:** Use llms.txt when available to navigate docs efficiently with an LLM.

For each tool’s official docs domain:

- **4.1 Check for llms.txt**

  Using `@web (search_web)` + URL fetching:

  - Try:
    - `https://<docs-domain>/llms.txt`  
    - `https://<docs-domain>/llms-full.txt`  
    - If docs are on a subpath (e.g. `/docs`), also:
      - `https://<docs-domain>/docs/llms.txt`
      - `https://<docs-domain>/docs/llms-full.txt`
  - If the GitHub repo mentions `llms.txt`, follow any links or paths given.

- **4.2 If llms.txt exists, parse top-level structure**

  With llms.txt / llms-full.txt:

  - Extract:
    - **Site title & scope**.  
    - **Version coverage** if indicated.  
    - Recommended **entrypoints** (e.g. “Start here”, “Quickstart”, “Core APIs”).  
    - Any **section indices / tables of contents**.

- **4.3 Apply progressive disclosure**

  Do *not* ingest everything at once. Instead:

  1. Read the **overview** sections.  
  2. Identify subsections relevant to your mission (e.g. configuration, streaming API, ORM relationships).  
  3. Fetch only those sections/pages next.  
  4. If needed, drill down further using cross-references within llms.txt.  

  Use `llms-full.txt` only when you truly need broad understanding; otherwise favor the leaner `llms.txt` plus targeted pages.

- **4.4 If llms.txt is missing or low-signal**

  Note its absence and move to the **Deep Web & GitHub Search** phase for this tool.

---

## 5. Deep Web & GitHub Search (No llms.txt or as Supplement)

**Goal:** Find high-quality, version-correct docs when llms.txt is absent, incomplete, or insufficient.

For each tool:

- **5.1 Targeted version-aware queries (borrow from `/deep-search`)**

  Use `@web (search_web)` with multiple query patterns:

  - `"${tool} ${major.minor.patch} documentation"`  
  - `"${tool} ${major.minor} docs"`, `"${tool} v${major}" API reference"`  
  - `"${tool} official docs"`, `"${tool} getting started"`, `"${tool} configuration"`  
  - `"${tool} ${version} breaking changes"`, `"${tool} ${version} migration guide"`.
  - Add **domain filters** when known:
    - `site:${docs-domain} "${tool}"`  
    - `site:readthedocs.io "${tool}"` (for many Python tools).

- **5.2 Align docs with your version**

  - Prefer documentation that:
    - Explicitly lists your **major.minor** in the URL or on-page version switcher.  
    - Mentions your version range in a “supported versions” table.
  - If only latest docs exist:
    - Use **release notes** and **UPGRADING/MIGRATION** guides from GitHub to infer differences vs your version.  
    - Note mismatches explicitly in your summary.

- **5.3 Mine GitHub for real-world behavior**

  On the canonical GitHub repo:

  - Search issues / PRs for:
    - Your version number.  
    - Key features / bugs you care about.  
    - Terms like “breaking change”, “regression”, “backwards incompatible”.
  - Skim `examples/` or sample apps for idiomatic usage.

- **5.4 Filter out low-quality sources**

  - Prefer:
    - Official docs and maintainers’ blogs.  
    - Well-maintained, recent posts or tutorials.  
  - De-prioritize:
    - Out-of-date StackOverflow answers referencing old versions.  
    - Random gists or unmaintained personal blogs unless nothing else exists.

---

## 6. Synthesize a Tool-Specific Docs Map

**Goal:** Turn scattered URLs into a coherent, reusable map for each tool.

For every prioritized tool, build a concise **Docs Map** entry:

- **6.1 Core identity**

  - Tool name, ecosystem, role, confirmed version.  
  - Canonical doc site and GitHub repo.

- **6.2 Primary docs**

  - Main **Getting Started / Overview** pages.  
  - **Configuration** and **deployment** sections.  
  - **API reference** entrypoints.  
  - Any **migration / upgrade** guides for your version.

- **6.3 Version details**

  - Which docs are **exactly version-aligned** vs approximate (latest-major or latest-only).  
  - Links to:
    - Release notes for your version.  
    - Any docs that highlight version-specific behavior.

- **6.4 LLM-friendly sources**

  - Whether **llms.txt / llms-full.txt** is present.  
  - Any curated “For AI” or “API catalog” sections.  
  - Good entrypoints for future agent runs (e.g. “Use this page as base for streaming API questions”).

- **6.5 Known gaps / caveats**

  - Missing or ambiguous areas (e.g. “No explicit docs for feature X in vY, only in vZ”).  
  - Notable discrepancies between docs and GitHub issues.

---

## 7. Cross-Tool View and Architectural Insight

**Goal:** Help architectural and design decisions by viewing docs across tools.

- **7.1 Compare overlapping tools**

  - If multiple tools address similar concerns (e.g. several HTTP clients, ORMs, or queues), use `/deep-consider`:
    - Compare support status, ecosystem maturity, feature sets.  
    - Weigh migration costs given the docs and changelogs you’ve found.

- **7.2 Inform architecture decisions**

  - Feed the newly mapped docs into `/deep-architect`:
    - e.g. pick queue vs event bus, decide on caching, choose database patterns.  
  - Explicitly note which **quality attributes** are supported or constrained by each tool, anchored in docs (not guesses).

---

## 8. Produce and Store a Docs Brief

**Goal:** Capture everything in a durable artifact.

Create a **Docs Brief** document (e.g. `DOCS-BRIEF-[PROJECT]-[DATE].md`) containing:

1. **Mission & Scope**  
   - Why these tools matter right now.  
   - Depth/constraints of the research.

2. **Tool Inventory Table**  
   - Name, version, role, priority.

3. **Per-Tool Docs Maps**  
   - From Section 6, one entry per prioritized tool.

4. **Cross-Tool Observations**  
   - Gaps, conflicts, and architectural implications.

5. **Open Questions & Next Searches**  
   - Remaining ambiguities with suggested future queries:
     - Web searches to try next.  
     - GitHub issues to inspect.  
     - Docs sections left unexplored.

Store this where your agents and future you will find it easily (e.g. in your vault, `docs/architecture/`, or `/50-engineering/03-tooling/` area).

---

## 9. Best Practices

- **Version-first mindset:** Never assume “latest” docs match your production version. Always verify.  
- **llms.txt when possible:** Treat `llms.txt` / `llms-full.txt` as the *table of contents* for LLM-driven doc work and use progressive disclosure.  
- **GitHub as ground truth:** Use repo structure, examples, and issues to cross-check and enrich official docs.  
- **Build once, reuse:** Reuse the Docs Brief across debugging, design, and refactors instead of re-doing ad-hoc searches each time.  
- **Escalate to `/deep-search`** when:
  - Official docs are thin.  
  - Behavior is only documented piecemeal across blogs, issues, or PRs.  
  - You need multi-source evidence before making a risky change.
