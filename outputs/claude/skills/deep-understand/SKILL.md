---
name: deep-understand
description: Systematically build deep, evidence-based understanding of a target area (concept, topic, codebase, system, solution) by combining exploration, reasoning, and multi-source research
disable-model-invocation: true
user-invocable: true
---

# Deep Understand Workflow

This workflow instructs Cascade to **develop a robust, testable mental model** of a target:

- Concept or domain topic
- Codebase area, feature, or system
- Technology, library, or architectural pattern
- Proposed solution or design

It orchestrates `/deep-explore`, `/deep-think`, `/deep-search`, `/deep-docs`, and `/deep-investigate` to move from scattered information to **structured, evidence-grounded understanding**.

---

## 1. Frame the Understanding Mission

- **1.1 Name the target explicitly**
  - Restate what needs to be understood in one precise sentence.
  - Classify the primary target type:
    - Concept / theory / pattern
    - Codebase area / component / feature
    - Technology / tool / library / framework
    - Product / system behavior / solution
- **1.2 Define depth and purpose**
  - What level of mastery is required?
    - Orientation: explain at a high level and navigate docs/code.
    - Working: comfortably design, modify, or debug with it.
    - Expert: reason about edge cases, trade-offs, and failure modes.
  - Why understanding is needed now (design, debugging, migration, teaching, decision).
- **1.3 Identify key questions and use-cases**
  - List **3–7 guiding questions** the understanding must answer (e.g. "When does X fail?", "How does Y scale?", "How does this integrate with Z?").
  - Capture at least one concrete **scenario** in which this understanding will be applied soon.

---

## 2. Inventory Prior Knowledge, Assumptions, and Gaps

- **2.1 Quick prior-knowledge pass**
  - Summarize what is already believed to be true about the target (even if rough).
  - Note related experiences (similar tools, patterns, systems).
- **2.2 Build a lightweight CSD Matrix for understanding**
  - **Certainties** – hard facts with clear evidence (docs, code, logs, prior experiments).
  - **Suppositions** – plausible beliefs that need confirmation.
  - **Doubts** – explicit unknowns, confusions, or conflicting information.
- **2.3 Define knowledge boundaries**
  - What is **in scope** vs **out of scope** for this understanding mission.
  - Any constraints (timebox, environment, inability to run code, etc.).

---

## 3. Map Structural Representations of the Target

Use this section to create a **structural map** before deep dives.

- **3.1 For codebases / systems – call `/deep-explore`**
  - Identify entry points, modules, components, data flows, and key responsibilities.
  - Produce a textual "map" of how control and data move through the relevant area.
- **3.2 For technologies / tools – lean on `/deep-docs`**
  - Identify official docs, GitHub repos, versions, and key conceptual sections.
  - Map the main building blocks (e.g. core abstractions, lifecycle, data model).
- **3.3 For abstract concepts / patterns**
  - Decompose into smaller notions (inputs, transformations, outputs, invariants).
  - Place it in context: where it sits in a broader taxonomy or stack.
- **3.4 Create a first-pass concept map**
  - List the **core entities or concepts**, their relationships, and typical workflows.
  - Note any terms that appear overloaded or ambiguous.

---

## 4. Gather Multi-Source Evidence (Docs, Code, Web, Examples)

- **4.1 Plan a research strategy (borrow from `/deep-search`)**
  - Derive **specific queries** from your guiding questions and CSD matrix.
  - Decide which dimensions to cover:
    - Definitions and fundamentals
    - Typical usage and best practices
    - Edge cases, limitations, and failure modes
    - Version-specific behavior and deprecations
- **4.2 Execute multi-source research**
  - Use `search_web` aggressively with varied queries.
  - Prioritize authoritative sources:
    - Official docs and spec pages
    - Canonical GitHub repo (issues, discussions, examples)
    - Reputable technical blogs or reference implementations
  - For code targets, read **both**:
    - Implementation code (core modules, helpers)
    - Call sites and tests demonstrating real usage.
- **4.3 Anchor findings against versions and context**
  - Always check that examples and docs match the relevant versions / stack.
  - Flag any mismatches or uncertainty explicitly in the CSD matrix.

---

## 5. Apply Deep Reasoning to Build a Coherent Mental Model

- **5.1 Use `/deep-think` lenses**
  - Analyze from multiple perspectives:
    - Architectural (where it sits in larger systems).
    - Performance (time/space, scaling behavior, bottlenecks).
    - Reliability and failure modes.
    - Security, data, and UX impact where relevant.
  - Identify applicable patterns and anti-patterns.
- **5.2 Derive core principles and invariants**
  - Extract the handful of rules that seem to govern behavior ("if X, then Y").
  - Clarify invariants: what must always hold true for the target to work correctly.
- **5.3 Build a layered explanation**
  - Construct explanation at three levels:
    - High-level intuition / analogy (for quick communication).
    - Mid-level conceptual model (components, flows, responsibilities).
    - Low-level mechanics (algorithms, APIs, data structures, protocols).
- **5.4 Identify contradictions and surprises**
  - Note where docs, code, and examples **disagree**.
  - Turn surprises into explicit questions or hypotheses for further investigation.

---

## 6. Test and Refine Understanding with Concrete Scenarios

- **6.1 Feynman-style check**
  - Attempt to explain the target simply, as if teaching a peer who knows the adjacent stack but not this specific topic.
  - Highlight any parts of the explanation that feel hand-wavy or uncertain.
- **6.2 Design small experiments or thought experiments**
  - For code/tech:
    - Propose minimal test cases, examples, or REPL experiments that would validate key beliefs.
    - Where running code isn’t possible, use **thought experiments** grounded in the documented behavior.
  - For concepts/processes:
    - Walk through realistic scenarios step-by-step and predict outcomes.
- **6.3 Use `/deep-investigate` if needed**
  - When specific behaviors are unclear or contested, frame them as investigation questions.
  - Design targeted probes (tests, logging strategies, metrics) to distinguish between competing mental models.
- **6.4 Update the CSD Matrix**
  - Promote confirmed suppositions to certainties.
  - Move disproven beliefs out; record corrections and their evidence.
  - Keep a short list of remaining doubts.

---

## 7. Synthesize a Durable Understanding Artifact

- **7.1 Capture a structured summary**
  - Include:
    - The target and purpose of understanding.
    - The mental model (high, mid, low levels).
    - Key principles, invariants, and constraints.
    - Common pitfalls, edge cases, and "sharp edges".
- **7.2 Create practical reference material**
  - Where appropriate, outline:
    - Checklists for using or modifying the target safely.
    - "How to get started" steps.
    - "When not to use this" caveats.
- **7.3 Link sources and evidence**
  - List key docs, code locations, and web resources that underpin the understanding.
  - Note version information and dates for time-sensitive material.
- **7.4 Store where future you and agents can find it**
  - Suggest a location (e.g. knowledge/base path, `/50-engineering/`, or relevant product folder) aligned with the project’s documentation conventions.

---

## 8. Identify Next Questions and Integration Points

- **8.1 Surface remaining uncertainties**
  - List open questions that matter for future design, debugging, or decisions.
  - Propose how to answer them (experiments, additional research, stakeholder input).
- **8.2 Connect to other deep-* workflows**
  - For upcoming work:
    - Use `/deep-architect` or `/deep-design` when applying this understanding to new systems or UX.
    - Use `/deep-optimize` when performance characteristics are central.
    - Use `/deep-test` when turning the mental model into regression tests and safety nets.
  - Make explicit which downstream workflows would benefit most from this newfound understanding.
