---
name: deep-relentless
description: Multiply effort, breadth, and depth when running other workflows (search, think, investigate, refactor, etc.).
disable-model-invocation: true
user-invocable: true
---

# Deep Relentless Workflow

This workflow instructs Cascade to run in **effort-multiplier mode**.

When combined with another workflow (e.g.  
`/deep-relentless /deep-search "…"`,  
`/deep-relentless /deep-think "…"`) it means:

- Do **more** work than usual.
- Explore **more angles**, **more sources**, and **more iterations**.
- Use a **mix of wide scans and narrow probes**.
- Maintain rigor and safety, not noisy thrash.

Think of this as turning the base workflow’s intensity up from “standard” to “max thoroughness within sane limits”.

---

## Input & Composition Semantics

- Assume this workflow may be invoked **together with other `/workflow-*` commands** in the same message.
- Treat the **entire user message** (including any other slash commands) as the problem description.
- Do **not** assume that input comes only from text immediately after `/deep-relentless`.
- Ignore the literal `/workflow-*` tokens as natural language; instead, infer the user’s intent from the full message and conversation.

---

## 1. Identify and Bind to the Host Workflow

**Goal:** Understand what you are multiplying.

- **1.1 Detect the host**
  - If invoked as:  
    - `/deep-relentless /deep-search ...` → Host = `deep-search`.
    - `/deep-relentless /deep-think ...` → Host = `deep-think`.
    - `/deep-relentless /deep-investigate ...` → Host = `deep-investigate`.
    - `/deep-relentless /deep-refactor ...` → Host = `deep-refactor`.
    - Or any other deep-* workflow.

- **1.2 Inherit purpose and constraints**
  - Read the host workflow’s **problem framing, success criteria, and constraints**.
  - Do **not** change the goal; only change:
    - The **amount** of exploration.
    - The **diversity** of approaches.
    - The **number of iterations** before stopping or asking the user.

- **1.3 Confirm acceptable intensity**
  - If the user specified time/effort limits, treat them as **hard caps**.
  - Otherwise, assume a **high, but not unbounded**, effort budget:
    - Multiple waves of exploration.
    - Multiple angles/frameworks.
    - Multiple external sources.

---

## 2. General Effort-Multiplier Principles

**Goal:** Apply a consistent notion of “relentless” across workflows.

- **2.1 Expand the search space**
  - Always ask: *“What are 3–5 additional angles I haven’t checked yet?”*
  - Vary:
    - **Breadth**: broad, survey-style passes.
    - **Narrowness**: laser-focused probes on specific sub-questions.
    - **Complexity**: simple keyword queries plus structured, compound ones.

- **2.2 Increase iteration count**
  - Run the host workflow’s core loop **multiple times**:
    - First pass: baseline result.  
    - Second pass: critique and improve.  
    - Third pass: explore alternatives / edge cases.

- **2.3 Raise the bar for “good enough”**
  - Prefer:
    - Cross-checked answers (docs + GitHub + examples).  
    - Multiple candidate designs/solutions, not a single path.  
    - Explicit trade-offs and failure-mode thinking.

- **2.4 Maintain focus and safety**
  - Avoid infinite loops or unbounded web/tool calls.
  - If marginal returns clearly drop, summarize what’s known and flag possible next steps instead of blindly continuing.

---

## 3. When Host = `/deep-search` (Relentless Search)

**Goal:** Many more, more varied, multi-angle web searches.

- **3.1 Design a portfolio of queries**
  - Generate **10+ distinct query patterns** mixing:
    - Baseline queries using the exact user phrasing.
    - Synonyms and related concepts.
    - Different **time ranges** (recent vs older).
    - **Domain filters**: official docs, GitHub, standards orgs, high-signal blogs.
    - **Bug-focused** queries: `"issue"`, `"bug"`, `"regression"`, `"breaking change"`.
    - **How-to / example** queries: `"guide"`, `"tutorial"`, `"samples"`, `"reference implementation"`.

- **3.2 Mix wide and narrow passes**
  - **Wide passes**:
    - General queries with no domain filter.
    - Aim to discover unknown keywords, tools, and competing approaches.
  - **Narrow passes**:
    - `site:github.com`, `site:docs.*`, `site:stackexchange.com`, etc.
    - Version-specific queries (e.g. `"v3.4.2"`, `"2025 update"`).

- **3.3 Multi-source triangulation**
  - Systematically sample from:
    - **Official docs**.  
    - **GitHub repos/issues/PRs**.  
    - **Standards / specs** (RFCs, etc. if relevant).  
    - **High-quality blog posts and talks**.
  - Note where sources **agree**, **disagree**, or cover **different layers** (concept vs implementation vs caveats).

- **3.4 Summarize with provenance**
  - Aggregate findings with clear references:
    - What came from docs?
    - What came from GitHub?
    - What came from secondary commentary?
  - Highlight **open questions** that remain unresolved even after heavy search.

---

## 4. When Host = `/deep-think` (Relentless Thinking)

**Goal:** Spend more time and effort applying structured reasoning.

- **4.1 Use multiple frameworks, not just one**
  - Apply **several** lenses in sequence, for example:
    - CSD Matrix (Certainties / Suppositions / Doubts).  
    - Golden Circle (Why / How / What).  
    - Risk/Impact matrix.  
    - Scenario analysis (best / base / worst case).  
    - Inversion (“how would this fail badly?”).
  - For each lens, write a separate, explicit pass.

- **4.2 Generate and refine multiple options**
  - Aim for **at least 4–6 distinct options**:
    - Minimal / maximal.  
    - Fast / safe / cheap variants.  
    - Short-term vs long-term optimal.
  - Then:
    - Compare using a **decision matrix**.  
    - Eliminate or merge dominated options.  
    - Improve the top 1–2.

- **4.3 Explore edge cases and second-order effects deeply**
  - Spend a full pass only on:
    - Edge cases and failure modes.  
    - Second-order and path-dependent consequences.  
    - Organizational and operational impacts, not just technical.

- **4.4 Synthesize with clear recommendations + caveats**
  - Deliver:
    - A primary recommendation.  
    - A “Plan B” with different trade-offs.  
    - Clear guardrails and conditions that would trigger revisiting the decision.

---

## 5. When Host = `/deep-investigate` (Relentless Investigation)

**Goal:** Consider more hypotheses, more experiments, more evidence.

- **5.1 Hypothesis expansion**
  - Enumerate **many plausible hypotheses** (10+ small ones is fine), grouped by:
    - Code/logic, data, environment, process, people.
  - Don’t stop at the obvious; deliberately add “weird” possibilities.

- **5.2 Prioritized but broader inquiry**
  - Still prioritize by impact/likelihood, but:
    - Investigate **more than just the top 1–2**; explore a *layer* of secondary suspects.
    - Use additional data sources (logs, metrics, version control history, release notes).

- **5.3 Design richer experiments**
  - For leading hypotheses, design **multiple probes**, not just one:
    - Reproduction attempts under slightly different conditions.  
    - Environment toggles (config changes, dependency versions).  
    - Synthetic data variations.

- **5.4 Deeper root-cause analysis**
  - Apply **5 Whys** to the leading explanation.  
  - Sketch a lightweight **Fault Tree** or FMEA-style view:
    - What other similar failures are likely?  
    - Where is detection currently weak?

---

## 6. When Host = `/deep-refactor` (Relentless Refactor)

**Goal:** Go beyond a minimal refactor while still safe.

- **6.1 Expand scope cautiously**
  - Identify adjacent smells or design issues:
    - Duplicate patterns, leaky abstractions, unclear boundaries.
  - Consider:
    - Refactoring a **whole cluster or slice** instead of a single function, if safe.

- **6.2 Apply multiple design passes**
  - First pass: basic cleanup and simplification.  
  - Second pass: introduce clearer abstractions, better boundaries.  
  - Third pass: improve naming, documentation, and small ergonomics.

- **6.3 Strengthen tests and safety nets**
  - Add or improve:
    - Unit tests around refactored areas.  
    - High-value integration tests if appropriate.
  - Use refactoring to make **future changes safer**, not just current code prettier.

- **6.4 Summarize structural improvements**
  - Clearly describe:
    - Before vs after design.  
    - Invariants and contracts that are now better enforced.  
    - Any debt that remains intentional.

---

## 7. Safeguards and Stop Conditions

**Goal:** Be relentless, not reckless.

- **7.1 Respect user-specified boundaries**
  - Time, resource, or network limits are **authoritative**.
  - If in doubt, prefer asking:
    - “I can explore 3–4 more angles or we can stop here. Which do you prefer?”

- **7.2 Watch for diminishing returns**
  - If recent iterations add very little new information:
    - Stop or slow down.  
    - Summarize what’s known and what is still unknown.  
    - Propose next steps for *future* sessions.

- **7.3 Make extra effort visible**
  - Explicitly state:
    - How many search waves were run.  
    - How many options/hypotheses were considered.  
    - How many design/refactor passes were done.

---

## 8. Outputs

When `/deep-relentless` is used, the final output should clearly show:

- **Extra breadth** – more options, hypotheses, queries, or refactor targets.  
- **Extra depth** – more detailed reasoning, evidence, examples, or tests.  
- **Explicit trade-offs** – what was gained from the extra effort and where further work could go next.
