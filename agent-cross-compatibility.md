# Agent Cross-Compatibility Guide

A design-oriented guide to keeping **Windsurf**, **Claude Code**, and **Cursor** behaving consistently, and to designing a compatibility/translation layer that maps a single canonical workflow spec into each agent’s native format.

This document is written for maintainers of `agent-deep-toolkit` and for teams who want cross-agent, meta-cognitive workflows that feel the same regardless of IDE.

---

## 1. Mental model: agents and artifacts

At a high level, all three environments expose **reusable, named workflows** that can be invoked via `/slash` commands, but the artifact shapes differ.

### 1.1 Windsurf (Cascade) – rules and workflows

**Artifacts**

- **Rules**
  - Location: `.windsurf/rules/`
  - Purpose: Always-on or context-triggered behavioral guidelines.
  - Activation modes (from Windsurf samples):
    - Always-On
    - Model-Decision
    - Glob-Based (e.g. `*.ts,*.tsx`)
    - Manual
- **Workflows**
  - Location: `.windsurf/workflows/`
  - Purpose: Explicit, multi-step procedures invoked by `/workflow-name`.

**Workflow schema (as used here)**

- Frontmatter:
  - `description`: short human-readable summary for menus.
  - `auto_execution_mode`: numeric activation setting (semantics are defined by Windsurf; we treat it as a lever for how aggressively Cascade can auto-suggest/execute the workflow).
- Body:
  - Markdown content describing the workflow steps.
  - May explicitly reference Windsurf tools (`code_search`, `grep_search`, `run_command`, etc.).

**Invocation**

- Via `/workflow-name` in Windsurf.
- Auto-activation or recommendation behavior is influenced by `auto_execution_mode` and any higher-level customization rules.

### 1.2 Claude Code – SKILL-based slash commands

**Artifacts**

- **Skills (custom slash commands)**
  - Locations:
    - `~/.claude/skills/<skill-name>/SKILL.md`
    - `.claude/skills/<skill-name>/SKILL.md` (project overrides user)
    - `<plugin>/skills/<skill-name>/SKILL.md`
  - Also supports legacy `.claude/commands/` with similar frontmatter.
- Skills extend what Claude can do, and can be:
  - Auto-invoked by Claude when relevant.
  - Manually invoked via `/skill-name`.

**Skill schema (from official guide)**

- Frontmatter fields (subset most relevant to Deep Toolkit):
  - `name`: slash-name, e.g. `deep-architect`.
  - `description`: how/when to use the skill.
  - `argument-hint`: hint shown in autocomplete (e.g. `[filename]`).
  - `disable-model-invocation`: `true` to **forbid auto-invocation** (manual only).
  - `user-invocable`: `true` to show in `/` menu.
  - `allowed-tools`: restricts tool usage when the skill runs.
  - `model`: preferred model (optional; otherwise global/default).
  - `context`: can include `fork` to run the skill in its own sub-agent context.
  - `agent`: which sub-agent to use (e.g. `Explore`, `Plan`, `general-purpose`).
  - `hooks` and other advanced fields (beyond current Deep Toolkit scope).
- Body:
  - Markdown instructions, similar to Windsurf workflows.
  - Supports **arguments** via `$ARGUMENTS` placeholder.
  - Supports **dynamic context injection** via ``!`shell command` `` snippets.

**Invocation**

- Auto: Claude may use skills based on context unless `disable-model-invocation: true`.
- Manual: `/skill-name`, with optional arguments (e.g. `/fix-issue 123`).

### 1.3 Cursor – `.cursor/commands` markdown commands

**Artifacts**

- **Commands**
  - Locations:
    - Project-level: `.cursor/commands/*.md`
    - User-level: `~/.cursor/commands/*.md`
  - Cursor auto-scans both directories when you type `/`.

**Command schema (from Cursor docs and reference repo)**

- No required frontmatter.
- Each command is a plain **Markdown file** whose entire body is the prompt.
- Common structure (convention, not enforced):
  - `# Title`
  - `## Objective`
  - `## Requirements`
  - `## Output`

**Invocation**

- Type `/` in Cursor’s AI chat → list of commands from project + global.
- Choose a command, which inserts the prompt and runs with project context.
- There is **no first-class argument system**; the user’s input after the slash is free-form chat that the model can interpret.

---

## 2. The canonical Deep Toolkit model (this repo)

`agent-deep-toolkit` already implements a **canonical, agent-agnostic representation** of each deep-* workflow and generates per-agent artifacts.

### 2.1 Canonical registry: `tools/deep-tools.json`

- Fields (simplified):
  - `schemaVersion`, `toolkit`, `version`.
  - `tools[]` – list of tool definitions.
    - `id`: canonical identifier (e.g. `deep-architect`).
    - `windsurf`: metadata for Windsurf.
      - `description`: human summary.
      - `autoExecutionMode`: numeric activation setting.
    - `claude` (optional): metadata for Claude skills.
      - `name`, `description`, `disableModelInvocation`, `userInvocable`, etc.
      - If omitted, defaults are derived from Windsurf metadata.
    - `body`: shared markdown workflow content used by **all** agents.

**Invariants**

- **Single source of truth**: every deep-* tool is defined once in `deep-tools.json`.
- **Shared cognitive body**: the same `body` is rendered into all agents.
- **Per-agent metadata** is additive and never leaks into the shared body.

### 2.2 Per-agent templates and generator

The generator (`bin/generate-deep-tools`) reads `deep-tools.json` and renders:

- Windsurf template → `outputs/windsurf/workflows/deep-*.md`
- Claude template → `outputs/claude/skills/deep-*/SKILL.md`
- Cursor template → `outputs/cursor/commands/deep-*.md`

**Templates**

- Windsurf `workflow-template.md`:
  - Frontmatter: `description`, `auto_execution_mode`.
  - `{{BODY}}` for shared content.
- Claude `skill-template.md`:
  - Frontmatter: `name`, `description`, `disable-model-invocation`, `user-invocable`.
  - `{{BODY}}` for shared content.
- Cursor `command-template.md`:
  - Body-only: `{{BODY}}`.

**Rendering functions (conceptual)**

- `render_windsurf_workflow(tool)`
  - Uses `tool.windsurf` metadata.
  - Injects `description`, `autoExecutionMode`, and shared `body`.
- `render_claude_skill(tool)`
  - Derives `name` and `description` from `tool.claude` or `tool.windsurf`.
  - Defaults: `disableModelInvocation=true`, `userInvocable=true` for safety.
  - Injects shared `body`.
- `render_cursor_command(tool)`
  - Drops frontmatter entirely.
  - Uses shared `body` as the command text.

This is already a **minimal compatibility layer**: one canonical model, three projections.

---

## 3. Feature equivalence across agents

Below is a coarse matrix capturing key dimensions.

| Dimension | Windsurf Workflow | Claude Skill | Cursor Command |
| --- | --- | --- | --- |
| Storage (user) | `~/.windsurf/workflows/` | `~/.claude/skills/<name>/SKILL.md` | `~/.cursor/commands/*.md` |
| Storage (project) | `.windsurf/workflows/` | `.claude/skills/<name>/SKILL.md` | `.cursor/commands/*.md` |
| Artifact shape | Markdown + YAML frontmatter | Markdown + YAML frontmatter | Markdown body only |
| Invocation | `/workflow-name` | `/skill-name` | `/command-file-name` |
| Auto vs manual | Controlled by `auto_execution_mode` & rules | `disable-model-invocation`, `user-invocable` | Manual only (via `/`) |
| Arguments | Free-form chat; no special placeholder | `$ARGUMENTS` placeholder + free-form chat | Free-form chat only (no structured args) |
| Dynamic context | Via tool calls (e.g. `code_search`, `run_command`) | ``!`command` `` shell injection + tools | Implicit via Cursor context (files, selection) |
| Sub-agents / modes | Rules/workflows; activation modes per rule | `agent` + `context: fork` for sub-agents | Single agent, multiple commands |
| Distribution | Copy `.windsurf/workflows/` files | Copy `.claude/skills/` trees | Copy `.cursor/commands/` files |

**Key insights**

- The **lowest common denominator** is: *"markdown prompt accessible via `/name`"*.
- Metadata around **when** and **how** to invoke is richer in Windsurf and Claude than in Cursor.
- Claude has the richest execution context controls (tools, agents, hooks, forked context, shell injection).
- Windsurf has the richest **IDE-integrated command set** (code search, file ops) via tools.

---

## 4. Conversion and adaptation patterns

This section focuses on practical conversion strategies. The guiding principle is:

> **Do not convert directly between agents. Normalize into the canonical Deep Toolkit spec, then project into each agent.**

### 4.1 Normalization pattern (recommended for all conversions)

1. **Extract core workflow body**
   - Strip agent-specific frontmatter and any purely syntactic sugar.
   - Preserve headings, steps, and cross-references.
2. **Define canonical metadata**
   - `id`: choose a stable, kebab-case name (e.g. `deep-ux`).
   - `description`: short, neutral summary.
   - Agent-specific metadata under `windsurf`, `claude`, `cursor` (if needed later).
3. **Add or update entry in `tools/deep-tools.json`**
   - `body`: paste the normalized markdown.
   - `windsurf.description` and `windsurf.autoExecutionMode`.
   - Optional `claude` object (see below).
4. **Regenerate outputs**
   - Run `bin/generate-deep-tools`.
   - Install to target environments with `install.sh`.

All per-agent adaptation logic then lives in template rendering, not in the workflow prose.

### 4.2 Windsurf → Claude

- **Mapping**
  - `description` → `description` (SKILL frontmatter).
  - `auto_execution_mode` → influences whether to set `disableModelInvocation`:
    - Conservative baseline: set `disable-model-invocation: true` for all imported workflows unless you have a strong reason to allow auto-invocation.
    - Use `user-invocable: true` to keep everything visible in `/` menu.
- **Arguments**
  - If the Windsurf workflow expects a parameter (e.g. "target file"), encode that in the **body** as a clear instruction, and optionally:
    - Add `argument-hint` (e.g. `[path or glob]`).
    - Use `$ARGUMENTS` in strategic places.
- **Dynamic context**
  - Windsurf-specific tool usage (e.g. `code_search`) can be mirrored with Claude’s tools if available, but that’s out of scope for this toolkit. Keep the workflow conceptual; let each agent use its own tools.

**Best practices**

- Prefer **manual invocation** first; you can always relax later by editing `claude` metadata in `deep-tools.json`.
- Avoid heavy use of ``!`command` `` that has no Windsurf equivalent; keep the core workflow interoperable.

### 4.3 Windsurf → Cursor

- **Mapping**
  - Drop frontmatter entirely; use the workflow body as-is.
  - Optionally add a short `# Title` and `## Objective` section at the top if not present.
- **Arguments / parameters**
  - There is no structured `$ARGUMENTS`, so:
    - Show the expected usage explicitly in the body (e.g. "When you invoke this command, the text you type after `/deep-architect` should describe: …").
    - Encourage the user to include filenames or snippets via selection, and design the instructions accordingly.

**Best practices**

- Keep Cursor commands **focused** and **shorter** than Windsurf/Claude equivalents where possible; Cursor users tend to favor quick, composable prompts.
- Rely on Cursor’s natural context (open files, selection) rather than shell commands.

### 4.4 Claude → Windsurf

- **Frontmatter**
  - `name` → workflow filename.
  - `description` → workflow description.
  - `disable-model-invocation` and `user-invocable` do not map 1:1.
    - Express the *intent* via `auto_execution_mode` (e.g. more manual vs more proactive), but keep in mind that exact numeric semantics are defined by Windsurf.
- **Body**
  - `$ARGUMENTS` placeholders can be rephrased as free-form guidance, e.g.:
    - "Interpret the user’s last message as the arguments originally expected in `$ARGUMENTS`."
  - Shell injections (``!`command` ``) do not have a direct Windsurf equivalent; consider:
    - Converting them into suggested `run_command` calls inside the instructions.
    - Or dropping them if they are too environment-specific.

### 4.5 Claude → Cursor

- Similar to Windsurf → Cursor:
  - Drop frontmatter; keep body.
  - Expand `$ARGUMENTS` into prose about expected inputs.
  - Inline any critical `!command` behavior as high-level instructions.

### 4.6 Cursor → Windsurf / Claude

- Cursor commands are already close to the **lowest common denominator**:
  - A markdown prompt with headings.
- For import:
  - Use the **normalization pattern**.
  - Add `description` and IDs.
  - Decide how aggressive auto behavior should be (Windsurf `autoExecutionMode`, Claude `disableModelInvocation`/`userInvocable`).

---

## 5. Best practices for cross-agent consistency

- **1. Single canonical body per workflow**
  - Maintain all workflow logic in `tools/deep-tools.json` → `body`.
  - Treat per-agent files under `outputs/` as **generated artifacts**, never edited by hand.

- **2. Keep agent-specific behavior in metadata, not prose**
  - Use `windsurf`, `claude`, and future `cursor` metadata blocks to express activation and policy.
  - Keep the body focused on steps, reasoning modes, and expected outputs.

- **3. Design workflows for the lowest common denominator, then enhance locally**
  - Write instructions that make sense in any of the three environments.
  - Use optional agent-specific hints (e.g. "If you are in Windsurf, you can use `code_search`…") sparingly.

- **4. Make invocation semantics explicit in each agent**
  - Windsurf: choose `autoExecutionMode` consistent with how often the workflow should run implicitly.
  - Claude: set `disable-model-invocation` and `user-invocable` explicitly for every skill.
  - Cursor: give commands descriptive filenames and clear `Objective`/`Requirements` sections.

- **5. Avoid tight coupling to a single agent’s advanced features**
  - Features like Claude hooks or shell injections are powerful but non-portable.
  - Prefer patterns that can degrade gracefully in other agents.

- **6. Test workflows in all three environments**
  - When adding or changing a workflow:
    - Regenerate outputs.
    - Install to a sample Windsurf, Claude Code, and Cursor environment.
    - Verify that:
      - The slash names are parallel.
      - The behaviors feel similar.
      - There are no surprising auto-invocations.

---

## 6. Compatibility / translation layer designs

This section sketches several architectural approaches for a more formal compatibility layer, and evaluates them using Deep Architect / Deep Design lenses.

### 6.1 Requirements and constraints

**Goals**

- **G1 – Single source of truth**: Define each workflow once and project into agents.
- **G2 – Cross-agent behavioral consistency**: Same mental model and steps, regardless of IDE.
- **G3 – Extensibility**: Add new agents (e.g. other IDEs, CLI, web UIs) with minimal changes.
- **G4 – Safety**: Avoid surprising auto-invocation or unsafe side effects by default.
- **G5 – Maintainability**: Simple enough to be maintained by typical OSS contributors.

**Constraints**

- Agents evolve independently (fields, behaviors may change).
- Not all capabilities are portable (e.g. Claude hooks, Windsurf auto-execution internals).
- This repo should stay lightweight (no heavy runtime dependencies).

### 6.2 Option A – Strengthen the existing static generator (recommended baseline)

**Concept**

- Treat `tools/deep-tools.json` as the **canonical schema**.
- Keep `bin/generate-deep-tools` as a **pure code generator**:
  - Inputs: canonical JSON.
  - Outputs: per-agent artifacts.
- Evolve the JSON schema to capture more cross-agent semantics (activation, arguments, capabilities).

**Design sketch**

- **Domain model** (conceptual):
  - `ToolSpec` with:
    - `id`, `description`, `body`.
    - `activation`: a small, agent-agnostic enum, e.g. `manual`, `suggested`, `auto`.
    - `arguments`: description of expected arguments (name, example).
    - `capabilities`: optional flags (e.g. `needsShell`, `needsGit`, `needsFilesystem`).
    - `windsurf`, `claude`, `cursor`: override blocks.
- **Renderers**:
  - `renderWindsurf(toolSpec)`
    - Map `activation` → `auto_execution_mode`.
    - Infer safe defaults when unknown.
  - `renderClaude(toolSpec)`
    - Map `activation` → `disable-model-invocation` / `user-invocable`.
    - Map `arguments` → `argument-hint` and optional `$ARGUMENTS` usage.
  - `renderCursor(toolSpec)`
    - Incorporate `arguments` into an `Objective`/`Requirements` section.

**Pros**

- Minimal change from current architecture.
- Easy to reason about, test, and extend.
- Keeps all cross-agent logic **centralized** in one generator.

**Cons**

- Still one-way: assumes canonical JSON is the source; cannot easily import existing ad-hoc workflows from agents.
- Requires careful versioning as agents evolve.

### 6.3 Option B – Bidirectional compatibility layer (import + export)

**Concept**

- Build **parsers** for existing agent artifacts to ingest them into the canonical schema.
- Support both `render` and `parse` for each agent:
  - `parseWindsurfWorkflow(path) -> ToolSpec`.
  - `parseClaudeSkill(path) -> ToolSpec`.
  - `parseCursorCommand(path) -> ToolSpec`.

**Use cases**

- Import legacy Windsurf-only workflows into the Deep Toolkit.
- Migrate existing `.claude/skills` or `.cursor/commands` libraries into the shared registry.

**Pros**

- Enables gradual adoption: teams can start from whichever agent they use most.
- Helps with **deep-audit** style analysis of existing configs.

**Cons**

- Parsing is lossy and heuristic:
  - Some semantics (e.g. activation rules, advanced hooks) have no canonical equivalent.
- Increases complexity and maintenance cost.
- Needs robust tests to avoid silently misinterpreting configs.

### 6.4 Option C – Capability-driven meta-schema

**Concept**

- Instead of mapping fields directly, define a **meta-schema** that describes capabilities and intentions:
  - Activation: `manual`, `suggested`, `auto`.
  - Invocation surface: `slash-command`, `background`, `hooked`.
  - Context needs: `needsSelection`, `needsWorkspace`, `needsShell`, `needsNetwork`.
  - Safety level: `safe`, `sensitive`, `dangerous`.
- For each agent, define a mapping from this meta-schema to concrete fields.

**Example**

- `activation: manual` →
  - Windsurf: conservative `auto_execution_mode`.
  - Claude: `disable-model-invocation: true`, `user-invocable: true`.
  - Cursor: no special handling (all are manual).

**Pros**

- Cleaner separation between **intent** and **implementation**.
- Scales better to future agents and platforms.

**Cons**

- More up-front design work.
- May be overkill if Deep Toolkit remains focused on a small set of workflows and agents.

### 6.5 Recommended path (near term)

Given current scope and complexity, a pragmatic approach is:

1. **Adopt Option A as the core**, evolving `ToolSpec` incrementally:
   - Document the canonical schema in `tools/deep-tools.json` (and/or a separate schema file).
   - Add small, high-value fields like `activation` and `arguments`.
2. **Cherry-pick elements from Option C** where they provide clarity:
   - Use a few meta-capabilities that obviously map across agents (e.g. activation, safety).
3. **Defer Option B** (importers) until there is a concrete migration need.

This yields a **robust, cross-agent compatibility layer** that:

- Keeps Deep Toolkit maintainable.
- Offers a clear extension story for new agents.
- Preserves agent-specific strengths while maintaining a shared cognitive core.

---

## 7. Roadmap and next steps

Short-term improvements:

- **Document the canonical schema** for `tools/deep-tools.json` (possibly as JSON Schema).
- **Align all existing tools** with the canonical assumptions described here (e.g. consistent descriptions, cautious activation defaults).
- **Add notes per-agent** in the README pointing to this guide for contributors.

Medium-term ideas:

- Introduce a small `activation` and `arguments` section in the canonical spec.
- Factor generator logic into a tiny reusable module (e.g. a Python or Node package) to make testing and extension easier.
- Add smoke tests that:
  - Regenerate outputs.
  - Assert structural invariants for each agent (e.g. valid frontmatter, matching IDs).

Longer-term vision:

- Extend the toolkit to additional agents (other IDEs, CLIs, web-based tooling) via the same canonical model.
- Explore a **UI or CLI** for browsing and composing workflows across agents dynamically.
- Use Deep Audit and Deep Explore workflows on this very compatibility layer to keep it healthy as the ecosystem evolves.
