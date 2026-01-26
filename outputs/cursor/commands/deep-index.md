# Deep Index

## Objective

Index and navigator for all deep-* workflows, their categories, and dependencies

## Requirements

# Deep Index Workflow

This workflow provides an index over all deep-* workflows, showing when to use each one, how they relate, and which core workflows they depend on.

## 1. How to Use /deep-index

- Invoke `/deep-index` manually when you:
  - Aren't sure which deep-* workflow to run next.
  - Want to understand how the deep-* suite fits together.
  - Need to see dependencies and avoid conceptual loops.
- This workflow is **not auto-invoked** by others; it is a navigational aid and shared mental model.
- Other workflows may reference it conceptually ("see `/deep-index`"), but they do not depend on it for execution.

## 2. Core Reasoning and Decision Workflows

These are foundational workflows that many others conceptually depend on.

- **/deep-search**  
  - **Purpose:** Multi-source, up-to-date web/docs research.  
  - **Depends on:** —  
  - **Often used with:** `deep-think`, `deep-consider`, `deep-architect`, `deep-ux`.

- **/deep-think**  
  - **Purpose:** First-principles, multi-lens reasoning and edge-case analysis.  
  - **Depends on:** —  
  - **Often used with:** `deep-search`, `deep-decision`, `deep-architect`, `deep-code`.

- **/deep-consider**  
  - **Purpose:** Structured decision framing, criteria, trade-offs, and premortems.  
  - **Depends on:** `deep-think`, `deep-search`.  
  - **Often used with:** `deep-decision`, `deep-architect`, `deep-alternative`.

- **/deep-decision**  
  - **Purpose:** Synthesize options into a recommendation with guardrails and metrics.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-consider`.  
  - **Often used with:** `deep-experiment`, `deep-impact`, `deep-regulation`.

- **/deep-explore**  
  - **Purpose:** Deep structural understanding of a codebase and execution paths.  
  - **Depends on:** `deep-think`.  
  - **Often used with:** `deep-debug`, `deep-refactor`, `deep-audit`.

- **/deep-investigate**  
  - **Purpose:** Systematic investigation and root-cause analysis.  
  - **Depends on:** `deep-search`, `deep-think`.  
  - **Often used with:** `deep-debug`, `deep-incident`, `deep-audit`.

- **/deep-understand**  
  - **Purpose:** Build a deep, evidence-based mental model of a concept, code area, technology, or system by orchestrating exploration, reasoning, and research.  
  - **Depends on:** `deep-explore`, `deep-think`, `deep-search`, `deep-docs`, `deep-investigate`.  
  - **Often used with:** `deep-architect`, `deep-design`, `deep-code`, `deep-debug`, `deep-document`.

- **/deep-inventory**  
  - **Purpose:** Systematically enumerate items (entities, code, resources, concepts) in a target area and enrich them with contextual metadata to create a usable catalog.  
  - **Depends on:** `deep-explore`, `deep-search`, `deep-docs`, `deep-think`.  
  - **Often used with:** `deep-architect`, `deep-audit`, `deep-data`, `deep-document`, `deep-propagate`.

- **/deep-iterate**  
  - **Purpose:** Execute work in small, validated steps until the goal or timebox is reached.  
  - **Depends on:** `deep-think`.  
  - **Often used with:** Any implementation workflow (e.g. `deep-code`, `deep-refactor`, `deep-propagate`).

- **/deep-relentless**  
  - **Purpose:** Multiply depth, breadth, and rigor when applying other deep-* workflows, without losing focus or safety.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-iterate`.  
  - **Often used with:** Any other deep-* workflow for high-stakes or high-uncertainty work.

## 3. Architecture, Design, and UX Workflows

- **/deep-architect**  
  - **Purpose:** Modern architecture thinking (DDD, C4, quality attributes, trade-offs).  
  - **Depends on:** `deep-search`, `deep-think`, `deep-consider`.  
  - **Often used with:** `deep-code`, `deep-spec`, `deep-threat-model`, `deep-infrastructure`.

- **/deep-spec**  
  - **Purpose:** Writing clear specs and ADRs.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-architect`.  
  - **Often used with:** `deep-code`, `deep-test`, `deep-decision`.

- **/deep-design**  
  - **Purpose:** Product and interaction design at the conceptual level.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-ux`.  
  - **Often used with:** `deep-ideas`, `deep-polish`.

- **/deep-ux**  
  - **Purpose:** Systematic UX evaluation, accessibility, visual/interaction design, and frontend handoff.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-code`, `deep-design-token`, `deep-svg`.  
  - **Often used with:** `deep-polish`, `deep-test`.

- **/deep-design-token**  
  - **Purpose:** Extracting and systematizing design tokens from existing UI.  
  - **Depends on:** `deep-search`, `deep-ux`, `deep-code`.  
  - **Often used with:** `deep-ux`, `deep-svg`, `deep-polish`.

- **/deep-svg**  
  - **Purpose:** Generating, validating, and integrating AI-produced SVGs.  
  - **Depends on:** `deep-search`, `deep-design-token`, `deep-code`, `deep-ux`.  
  - **Often used with:** `deep-polish`, `deep-ux`.

- **/deep-polish**  
  - **Purpose:** Final refinement of UI/UX, copy, motion, and responsiveness.  
  - **Depends on:** `deep-ux`, `deep-design-token`, `deep-svg`, `deep-test`.  
  - **Often used with:** `deep-code`, `deep-ideas`.

- **/deep-document**  
  - **Purpose:** Create high-quality, durable technical documentation and specs aligned with modern docs-as-code and architecture practices.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-architect`.  
  - **Often used with:** `deep-spec`, `deep-index`, `deep-retrospective`.

- **/deep-threat-model**  
  - **Purpose:** Security/privacy threat modelling.  
  - **Depends on:** `deep-search`, `deep-architect`.  
  - **Often used with:** `deep-infrastructure`, `deep-regulation`, `deep-ethics`.

## 4. Code Quality, Testing, and Refactoring Workflows

- **/deep-code**  
  - **Purpose:** High-quality implementation (clarity, correctness, maintainability).  
  - **Depends on:** `deep-think`, `deep-architect`, `deep-spec`.  
  - **Often used with:** `deep-test`, `deep-debug`, `deep-refactor`.

- **/deep-test**  
  - **Purpose:** Test strategy and high-value automated tests.  
  - **Depends on:** `deep-architect`, `deep-code`.  
  - **Often used with:** All change workflows (e.g. `deep-refactor`, `deep-propagate`, `deep-impact`).

- **/deep-debug**  
  - **Purpose:** Systematic debugging with code-path tracing.  
  - **Depends on:** `deep-investigate`, `deep-explore`, `deep-code`, `deep-test`.  
  - **Often used with:** `deep-observability`, `deep-incident`.

- **/deep-refactor**  
  - **Purpose:** Safe, incremental refactors while preserving behavior.  
  - **Depends on:** `deep-code`, `deep-test`, `deep-explore`.  
  - **Often used with:** `deep-prune`, `deep-optimize`, `deep-audit`.

- **/deep-prune**  
  - **Purpose:** Removing dead or low-value code/config safely.  
  - **Depends on:** `deep-explore`, `deep-audit`, `deep-test`.  
  - **Often used with:** `deep-refactor`.

- **/deep-optimize**  
  - **Purpose:** Performance and scalability optimization.  
  - **Depends on:** `deep-architect`, `deep-code`, `deep-observability`, `deep-test`.  
  - **Often used with:** `deep-incident`, `deep-impact`.

## 5. Data, Infra, Operations, and Governance Workflows

- **/deep-observability**  
  - **Purpose:** Logs, metrics, traces, SLOs, and health checks.  
  - **Depends on:** `deep-architect`, `deep-code`.  
  - **Often used with:** `deep-incident`, `deep-optimize`, `deep-impact`.

- **/deep-infrastructure**  
  - **Purpose:** Infrastructure design, reliability, and cost.  
  - **Depends on:** `deep-architect`, `deep-observability`, `deep-threat-model`.  
  - **Often used with:** `deep-incident`, `deep-regulation`.

- **/deep-incident**  
  - **Purpose:** Incident response and learning.  
  - **Depends on:** `deep-investigate`, `deep-observability`, `deep-decision`.  
  - **Often used with:** `deep-retrospective`, `deep-audit`.

- **/deep-data**  
  - **Purpose:** Data models, quality controls, and governance.  
  - **Depends on:** `deep-search`, `deep-architect`, `deep-ethics`.  
  - **Often used with:** `deep-regulation`, `deep-impact`.

- **/deep-ethics**  
  - **Purpose:** Ethical risk evaluation, especially for AI systems.  
  - **Depends on:** `deep-search`, `deep-think`.  
  - **Often used with:** `deep-data`, `deep-regulation`, `deep-impact`.

- **/deep-regulation**  
  - **Purpose:** Regulatory and compliance alignment (e.g. UK/EU 2026).  
  - **Depends on:** `deep-search`, `deep-data`, `deep-ethics`, `deep-decision`.  
  - **Often used with:** `deep-impact`, `deep-architect`, `deep-infrastructure`.

- **/deep-audit**  
  - **Purpose:** Systematic review and prioritized improvement list.  
  - **Depends on:** `deep-explore`, `deep-investigate`, `deep-data`, `deep-decision`.  
  - **Often used with:** `deep-refactor`, `deep-prune`, `deep-incident`.

- **/deep-experiment**  
  - **Purpose:** Designing and running experiments.  
  - **Depends on:** `deep-search`, `deep-think`, `deep-decision`, `deep-test`.  
  - **Often used with:** `deep-ideas`, `deep-impact`.

- **/deep-retrospective**  
  - **Purpose:** Retrospectives and postmortems.  
  - **Depends on:** `deep-explore`, `deep-investigate`, `deep-decision`, `deep-iterate`.  
  - **Often used with:** `deep-incident`, `deep-audit`.

## 6. Creativity, Ideas, and Change Propagation (Planned)

These workflows are planned specializations that build on the existing deep-* suite.

- **/deep-impact**  
  - **Purpose:** Assess impact of a change across code, performance, UX, security, cost, and governance.  
  - **Will depend on:** `deep-search`, `deep-think`, `deep-consider`, `deep-architect`, `deep-code`, `deep-observability`, `deep-test`, `deep-regulation`, `deep-ethics`, `deep-decision`.

- **/deep-propagate**  
  - **Purpose:** Safely propagate an approved change across code, tests, docs, infra, and external systems.  
  - **Will depend on:** `deep-impact`, `deep-architect`, `deep-code`, `deep-audit`, `deep-iterate`, `deep-test`, `deep-observability`, `deep-regulation`, `deep-data`.

- **/deep-ideas**  
  - **Purpose:** Generate innovative ideas and opportunities using current trends and tools.  
  - **Will depend on:** `deep-search`, `deep-think`, `deep-experiment`, `deep-design`, `deep-ux`, `deep-architect`, `deep-decision`.

- **/deep-followup**  
  - **Purpose:** Propose and prioritize follow-up work based on current tasks, progress, and roadmap.  
  - **Will depend on:** `deep-explore`, `deep-investigate`, `deep-ideas`, `deep-decision`, `deep-iterate`.

- **/deep-alternative**  
  - **Purpose:** Evaluate alternative approaches, tools, and architectures.  
  - **Will depend on:** `deep-search`, `deep-think`, `deep-consider`, `deep-decision`, `deep-architect`, `deep-code`, `deep-test`.

## 7. Guardrails Against Loops

- Do not recursively invoke workflows in a tight loop (e.g., `deep-audit` → `deep-refactor` → `deep-audit` indefinitely).  
- Use core reasoning workflows (`deep-search`, `deep-think`, `deep-consider`, `deep-decision`) as shared primitives rather than duplicating their steps.  
- When chaining workflows, make the sequence and stopping conditions explicit (for example, "run `/deep-audit` once, then apply `/deep-refactor` and `/deep-test` before re-auditing").
