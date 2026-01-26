# Cross-Agent Compatibility System Design

## 1. Overview

This document specifies the end-to-end design of the **Cross-Agent Compatibility System** that combines:

- **Cross-Agent Compatibility Engine (CACE)** as the deterministic core for parsing, transforming, and rendering agent artifacts.
- A **generic `optimise` CLI** exposed by CACE for multi-agent compatibility and optimisation flows.
- An **LLM-powered refinement and analysis layer** that reviews CACE outputs and applies constrained, semantic tweaks.
- A **single cross-agent compatibility skill/command**, defined once (OpenSkills-style) and generated into multiple agents.
- An **intelligent installer and packaging story** for deploying CACE and the skill across supported agents.
- A **test and validation strategy** to ensure correctness, safety, and maintainability.

This is a **system-level design** that sits on top of and extends the existing
`cross-agent-compatibility-engine` architecture documented in
`cross-agent-compatibility-engine.md`. That document focuses on CACE internals
(IR, parsers, renderers). This document focuses on:

- How CACE is exposed via a generic `optimise` API/CLI.
- How LLM workflows orchestrate and refine CACE conversions.
- How the cross-agent skill is specified once and projected into each agent.
- How installation, upgrades, and validation are handled.

## 2. Problem Statement

Developers increasingly work across multiple AI coding agents (Claude Code,
Windsurf, Cursor, OpenCode, etc.). Each agent has its own:

- Workflow formats (skills, workflows, commands, templates).
- Execution hooks (shell integration, tools, memory models).
- Versioned features and capabilities.

Today, migrating or sharing workflows between agents is:

- **Manual and error-prone**: copy-paste and hand-edit.
- **Non-repeatable**: no reusable plans or compatibility reports.
- **Opaque**: users do not see what is lost or changed.

We already have:

- A static registry and generator (`deep-tools.json`, `bin/generate-deep-tools`).
- An emerging CACE architecture that can parse/transform/render agent artifacts.

We now want a **full-stack compatibility solution** that:

- Provides a **generic, agent-agnostic `optimise` command** that can convert
  between any supported agents, not just OpenCode.
- Combines **deterministic engine-based conversions** (CACE) with a **LLM-based
  analysis and refinement layer**.
- Is exposed to users as a **single cross-agent compatibility skill/command** in
  any agent, backed by a consistent installer and validation story.

## 3. Goals and Non-Goals

### 3.1 Goals

- **G1: Generic optimise flow**
  - Support `optimise` from any supported agent to any other (X → Y, X → Y,Z).
  - Model conversions via a stable IR and explicit compatibility rules.

- **G2: Hybrid deterministic + LLM architecture**
  - CACE performs all **structural** conversions and loss reporting.
  - LLM layer performs **semantic analysis and refinement**, not ad-hoc
    re-conversion.

- **G3: Single cross-agent skill/command**
  - One **source skill spec** (OpenSkills-style) that generates agent-native:
    - Windsurf workflows
    - Claude Code skills
    - Cursor commands
    - OpenCode commands

- **G4: Intelligent installer and packaging**
  - Install `cace` CLI and cross-agent commands into detected agents.
  - Support project-level and user-level installation.

- **G5: Strong validation and tests**
  - Tests for:
    - CLI behaviour and JSON outputs.
    - Generator wiring and skill artefacts.
    - Installer behaviour (dry-run vs apply).
  - Validation hooks usable from agents and CI.

### 3.2 Non-Goals (for this iteration)

- Building a **full web UI** on top of CACE.
- Providing first-class support for **every possible agent**; we focus on
  Claude Code, Windsurf, Cursor, and OpenCode first, with a pluggable path for
  more.
-- Implementing **deep semantic understanding** of arbitrary project code; the
  LLM refinement focuses on agent artefacts and conversion reports, not general
  static analysis of entire codebases.

## 4. High-Level Architecture

At a high level the system consists of the following components:

1. **CACE Engine** (separate repo)
   - Defines IR (`ComponentSpec`, `ActivationModel`, etc.).
   - Implements parsers/renderers and compatibility rules.
   - Exposes a **CLI** with commands such as:
     - `cace compat status`
     - `cace compat matrix`
     - `cace optimise`
     - `cace validate`

2. **Generic Optimise API/CLI Layer** (within CACE)
   - Defines a stable CLI and JSON schema around optimisation and conversion
     flows.
   - Handles artefact discovery, plan computation, and application.

3. **LLM Refinement Layer** (agent workflows / skills)
   - LLM-based orchestration defined by the cross-agent skill.
   - Responsible for:
     - Calling CACE CLI commands.
     - Interpreting JSON plans/reports.
     - Performing constrained semantic tweaks.

4. **Cross-Agent Skill Source Spec** (CACE repo, OpenSkills-style)
   - Single declarative spec describing the cross-agent compatibility skill.
   - Translated by generators into agent-native artefacts.

5. **Agent-Deep-Toolkit Generators** (this repo)
   - Consume the skill source spec and produce:
     - Windsurf workflows.
     - Claude Code SKILL.md.
     - Cursor commands.
     - OpenCode commands.

6. **Installer / Packaging** (this repo, and/or CACE repo)
   - Shell-based installer that:
     - Installs or updates the `cace` CLI.
     - Installs generated commands/workflows into detected agents.
     - Supports dry runs, uninstalls, and upgrades.

7. **Tests & Validation** (both repos)
   - Unit and integration tests around:
     - CACE CLI behaviour.
     - Generator correctness.
     - Installer behaviour.
   - Optional project-level tests orchestrated via the skill.


## 5. Key Flows

### 5.1 User-Level Flow: Cross-Agent Optimise

1. **User invokes a cross-agent command** in their preferred agent, e.g.:
   - `/cross-agent-compatibility`
   - `/compatibility:optimise`

2. **Skill detects environment and goals**:
   - Detect installed agents and their artefacts (via filesystem heuristics and
     `cace compat status`).
   - Ask the user for:
     - Source agent(s) (e.g. `OpenCode`, `Windsurf`).
     - Target agent(s) (e.g. `Claude`, `multi-agent`).
     - Scope: commands, workflows, templates, rules, or whole project.

3. **Skill calls CACE `compat status`**:
   - `cace compat status --format=json [--path .]`
   - Receives a machine-readable summary of detected artefacts and their
     compatibility profile.

4. **Skill requests an optimisation plan**:
   - `cace optimise --from <SOURCE> --to <TARGETS> --plan-only --format=json`
   - CACE computes and returns a `MigrationPlan` (list of file-level and
     component-level changes) and a `CompatibilityReport`.

5. **Skill presents plan to user** (optional approval step):
   - Summarise high-level changes and potential losses.
   - Ask the user whether to apply the plan.

6. **Skill applies plan via CACE** (if approved):
   - `cace optimise --from <SOURCE> --to <TARGETS> --apply --backup-dir <DIR>`
   - CACE performs deterministic transformations and writes new artefacts.

7. **LLM refinement & analysis**:
   - Skill reads the plan and the resulting artefacts/diffs.
   - LLM analyses for:
     - Residual references to agent-specific features.
     - Opportunistic improvements (e.g. better defaults in frontmatter).
     - Contextual notes and TODOs for the user.
   - LLM may propose or apply **small, localised edits** that respect the CACE
     plan and do not contradict its structural decisions.

8. **Validation and tests**:
   - Skill optionally runs:
     - `cace validate --format=json`.
     - Project tests (`$TEST_COMMAND`, e.g. `bun test`, `npm test`).
   - Aggregates results into a final report.

9. **User reviews final summary**:
   - What CACE changed.
   - What the LLM refined.
   - Any remaining manual actions or TODOs.


### 5.2 Developer-Level Flow: Adding a New Agent

1. Implement a new agent plugin in CACE:
   - Parser, renderer, capability mappings.

2. Register the agent in the CACE registry and capability matrix.

3. Extend the cross-agent skill spec with:
   - Detection heuristics for the new agent.
   - Updated prompts that describe new agent capabilities to the LLM.

4. Regenerate agent-native artefacts via agent-deep-toolkit.

5. Re-run installer to deploy updated commands.

## 6. Component Responsibilities

### 6.1 CACE Optimise CLI

CACE provides a `cace` CLI with subcommands focused on compatibility and optimisation.

**Key commands (conceptual):**

- `cace compat status [--path PATH] [--format json|text]`
  - Discovers known artefacts in the target path.
  - Outputs per-agent and per-artefact summaries.

- `cace compat matrix [--format json|text]`
  - Outputs high-level feature/compatibility matrix between agents.

- `cace optimise --from A --to B[,C] [--path PATH] [--plan-only] [--apply] [--backup-dir DIR] [--format json|text]`
  - Computes and optionally applies a `MigrationPlan`.
  - Returns structured JSON with:
    - `plan`: list of changes.
    - `report`: compatibility/loss report.

- `cace validate [--path PATH] [--format json|text]`
  - Validates artefacts against IR and agent-specific schemas.

All commands:

- **Support JSON output** for LLM consumption.
- Are **idempotent and safe by default** (e.g. require explicit `--apply`).
- Provide **exit codes** aligned with CI usage.

### 6.2 Cross-Agent Skill Source Spec

The skill source spec (maintained in the CACE repo) describes:

- **Metadata**
  - Name, description, tags (e.g. `compatibility`, `migration`, `multi-agent`).
  - Supported agents and minimum versions.

- **Capabilities**
  - Required host capabilities: shell command execution, filesystem access,
    reading and diffing files, optional git integration.

- **Interaction Model**
  - Prompts and flows for:
    - Detecting existing agents.
    - Asking the user for source/target agents and scope.
    - Handling approval for plan application.

- **CLI Hooks**
  - Canonical commands (with placeholders) for:
    - `cace compat status`
    - `cace optimise` (plan-only, apply)
    - `cace validate`
    - Optional project tests.

- **LLM Constraints**
  - Explicit instructions:
    - CACE is authoritative for **structural** changes.
    - The LLM may only perform **local, semantic refinements**.
    - The LLM must not contradict or undo CACE’s structural decisions.

This spec is consumed by generators in agent-deep-toolkit to produce
agent-native artefacts.

### 6.3 Agent-Deep-Toolkit Generators

In this repo, generators are responsible for:

- **Reading the skill source spec** (from the CACE repo or a shared location).
- **Rendering agent-native artefacts**, e.g.:
  - Windsurf workflow in `.windsurf/workflows/`.
  - Claude Code skill in `.claude/skills/...`.
  - Cursor command in `.cursor/commands/...`.
  - OpenCode command in `.opencode/commands/...`.

Key design points:

- Reuse existing generator patterns (e.g. `bin/generate-deep-tools`) where
  possible.
- Keep the skill spec **agent-agnostic**; agent-specific details live in
  templates.
-- Ensure generated artefacts are **idempotent** and can be safely regenerated
  on upgrades.

### 6.4 Installer

The installer (shell script, e.g. `install.sh` in this repo) is responsible for:

- **CACE CLI installation**
  - Detect if `cace` is available and at an acceptable version.
  - If not, install or instruct the user how to install.

- **Skill/command deployment**
  - Detect supported agents (e.g. by presence of `.windsurf/`, `.claude/`,
    `.cursor/`, `.opencode/` directories).
  - Copy or link generated artefacts into agent-specific locations.
  - Optionally support:
    - `--agent` flag to limit scope.
    - `--level` (`project`, `user`) for installation level.

-- **Safety and UX**
  - Support `--dry-run` to show planned actions.
  - Provide clear logging and error messages.
  - Never clobber user files without backups or confirmation.

## 7. LLM Refinement Layer Design

The LLM refinement layer is **not** a separate service; it is realised via
agent-native workflows/skills that follow these rules:

- **Inputs**
  - CACE JSON outputs (status, plan, report, validation results).
  - Selected artefact contents and diffs.

- **Allowed actions**
  - Propose or apply small, localised edits such as:
    - Improving descriptions and frontmatter.
    - Adding comments or TODOs where behaviour changes.
    - Suggesting alternative options (e.g. multiple target agents).
  - Summarise compatibility issues and potential trade-offs.

- **Disallowed actions**
  - Performing large structural rewrites that would compete with or contradict
    CACE’s plan.
  - Making changes without grounding them in CACE outputs.

-- **Prompts and guardrails**
  - Every agent-native artefact generated from the skill spec includes prompts
    that:
    - Clearly separate engine responsibilities from LLM responsibilities.
    - Emphasise that CACE is the source of truth for structural conversions.

## 8. Testing and Validation Strategy

Testing spans both repos and the combined flows.

### 8.1 CACE Tests (Engine Repo)

- **Unit tests**
  - Parsing, transformation, rendering, capability mappings.

- **CLI tests**
  - Behaviour of `compat status`, `compat matrix`, `optimise`, `validate`.
  - JSON schema conformance.

- **Integration tests**
  - Round-trip conversions for representative artefacts across agents.

### 8.2 Agent-Deep-Toolkit Tests (This Repo)

- **Generator tests**
  - Given a sample cross-agent skill spec, verify the generated artefacts:
    - Contain correct metadata and prompts.
    - Reference the right `cace` commands.

- **Installer tests**
  - Dry-run tests that simulate different environments:
    - No agents installed.
    - Single agent installed.
    - Multiple agents installed.
  - Validate correct copying/linking behaviour without touching the real
    filesystem (using temp dirs in test harness).

- **End-to-end smoke tests** (where feasible)
  - Within a controlled fixture directory:
    - Run the installer.
    - Invoke generated commands in a simulated agent context.
    - Assert that they call `cace` with expected arguments (mocked).

### 8.3 LLM Workflow Tests

LLM behaviour is harder to test deterministically, but we can:

- Provide **prompt-level regression tests** (golden prompts and expected
  high-level behaviours/constraints).
- Use **scenario scripts** that:
  - Feed sample CACE JSON outputs into the agent workflows.
  - Verify that instructions emphasise the right guardrails.


## 9. Rollout and Migration Plan

- **Phase 1: Architecture & Spec (this document)**
  - Finalise this system-level design.
  - Align CACE CLI and IR with the `optimise` flows described here.

- **Phase 2: CLI & IR Scaffolding**
  - Implement CACE `compat` and `optimise` CLI subcommands with JSON schemas.
  - Provide a minimal `MigrationPlan` and `CompatibilityReport` structure.

- **Phase 3: Cross-Agent Skill Spec & Generators**
  - Define the cross-agent skill source spec in the CACE repo.
  - Extend agent-deep-toolkit generators to render agent-native artefacts.

- **Phase 4: Installer & Packaging**
  - Extend or add installer logic to:
    - Install `cace`.
    - Install/update generated commands/workflows.

- **Phase 5: Validation, Docs, and Examples**
  - Add tests as described above.
  - Document usage patterns and examples for each supported agent.


## 10. Risks and Mitigations

- **R1: Divergence between CACE and skill expectations**
  - *Risk*: CLI or JSON shape changes in CACE break agent workflows.
  - *Mitigation*: Version JSON schemas; include version fields in outputs; add
    compatibility checks in generators and installer.

- **R2: Overreach of LLM refinements**
  - *Risk*: LLM makes structural edits that conflict with CACE.
  - *Mitigation*: Tight prompt constraints; explicit allowed/disallowed actions;
    encourage review of LLM-suggested edits; keep CACE as authoritative.

- **R3: Installer complexity across environments**
  - *Risk*: Installer mis-detects agents or modifies user environments
    unexpectedly.
  - *Mitigation*: Conservative heuristics; dry-run mode; clear logging; opt-in
    flags; focus first on project-level installs.


## 11. Open Questions

1. **Skill spec location and versioning**
   - How exactly is the skill source spec shared between CACE and
     agent-deep-toolkit (git submodule, package, or published artefact)?

2. **Agent detection heuristics**
   - What precise signals do we use to detect installed agents, and how do we
     handle ambiguous or partial setups?

3. **User-configurable policies**
   - How can users configure policies such as:
     - Preferred target agents.
     - Aggressiveness of LLM refinements.
     - Whether to auto-run validation and tests.

4. **CI/CD integration**
   - How do we integrate CACE-based compatibility checks and migrations into CI
     without requiring an interactive agent?

## 12. Summary

This document defines the overall design of the Cross-Agent Compatibility
System: a hybrid of deterministic engine-based conversions (CACE) and
LLM-powered refinement, exposed as a single cross-agent skill and installed via
an intelligent installer. It provides a blueprint for implementing the generic
`optimise` flow, the surrounding orchestration, and the validation and rollout
story across agents.
