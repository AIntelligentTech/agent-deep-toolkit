---
description: Conduct rigorous, multi-method investigations into issues, claims, ideas, and feasibility using structured problem-solving frameworks
auto_execution_mode: 3
---

# Deep Investigate Workflow

This workflow instructs Cascade to investigate systematically, combining scientific-method thinking, root-cause analysis tools, and creative exploration.

## 1. Frame the Investigation Clearly

- Restate what is being investigated as a precise question or hypothesis.
- Classify the investigation type:
  - Defect/incident, performance issue, security concern.
  - Product/feature feasibility, architectural choice, process question.
- Use a lightweight **CSD Matrix**:
  - **Certainties** – facts and hard data.
  - **Suppositions** – assumptions that seem likely.
  - **Doubts** – unknowns, ambiguities, or contested claims.
- Define success criteria: what counts as a satisfactory answer or level of confidence.

## 2. Collect Initial Evidence and Context

- Gather available artifacts:
  - Logs, traces, metrics, error messages.
  - User reports, tickets, acceptance criteria, existing docs.
- Map where in the codebase and system this likely lives using `code_search` and `grep_search`.
- Use `search_web` for quick orientation when relevant (framework behavior, platform quirks, known bugs), confirming versions and dates.

## 3. Generate Hypotheses Broadly

- Brainstorm plausible explanations or outcomes before investigating deeply.
- Use an **Ishikawa/Fishbone-inspired** lens for software:
  - People (skills, communication, process).
  - Process (SDLC, reviews, testing, release practices).
  - Platform/Environment (infrastructure, config, dependencies).
  - Code/Logic (algorithms, data structures, branching, edge cases).
  - Data (schema, migrations, quality, contracts).
- For product/feasibility questions, include multiple conceptual options, not just the “obvious” one.

## 4. Prioritize Lines of Inquiry

- Rank hypotheses using simple risk and plausibility:
  - Impact if true (severity, cost, user impact).
  - Likelihood given the evidence so far.
- Optionally apply:
  - A quick **Pareto** mindset (what 20% of causes likely produce 80% of impact).
  - A small **decision matrix** when multiple investigative directions compete for limited attention.

## 5. Design Targeted Experiments

- For the top hypotheses, design minimal, high-signal experiments:
  - What observation, test, or probe will distinguish between hypotheses?
  - What data will be collected (logs, metrics, traces, user behavior, benchmarks)?
  - What outcome would confirm vs refute each hypothesis?
- Ensure experiments are safe (non-destructive, minimal production risk) and prioritized by information value.

## 6. Execute, Observe, and Update the Model

- Run experiments iteratively rather than all at once.
- After each experiment:
  - Update the CSD Matrix (promote suppositions to certainties or move them to doubts).
  - Eliminate or refine hypotheses.
  - Note surprises and anomalies explicitly.
- Use `search_web` and repository history (git logs, PRs) to relate findings to known changes or external information.

## 7. Deep Root Cause and Risk Analysis

- Once a leading explanation emerges, probe deeper:
  - Apply **5 Whys** to move from surface symptom to systemic cause.
  - Optionally sketch a simple **Fault Tree**: start from the observed problem and decompose contributing conditions.
- For systemic or recurring issues, think in **FMEA** terms:
  - What are the main failure modes in this area?
  - For each: Severity, Occurrence likelihood, Detection capability (even if only qualitatively ranked).
  - Use this to highlight where mitigation or monitoring is most urgent.

## 8. Synthesis, Recommendations, and Open Questions

- Summarize the investigation:
  - Question asked and why it matters.
  - Evidence gathered and experiments run.
  - Hypotheses considered and which were ruled out.
  - The most likely explanation(s) and residual uncertainty.
- Provide recommendations at multiple levels where applicable:
  - Immediate fixes or mitigations.
  - Structural or process changes to prevent recurrence.
  - Monitoring/observability improvements to detect similar issues earlier.
- Explicitly list remaining open questions and suggest next investigative steps if higher confidence is required.

