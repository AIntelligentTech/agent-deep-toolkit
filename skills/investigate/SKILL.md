---
name: investigate
description: Conduct rigorous, multi-method investigations into issues, claims, ideas, and feasibility using structured problem-solving frameworks
command: /investigate
aliases: ["/dig", "/probe", "/examine"]
synonyms: ["/investigating", "/investigated", "/investigates", "/investigation", "/digging", "/probing", "/probed", "/examining", "/examined"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
category: analysis
model: inherit
created: 2026-01-15
updated: 2026-02-01
---

<scope_constraints>
This skill focuses on systematic investigation using structured problem-solving frameworks. It combines scientific thinking, root-cause analysis, and evidence gathering. It produces recommendations but does not execute fixes—that's for implementation skills.
</scope_constraints>

<context>
This workflow instructs the agent to investigate systematically, combining scientific-method thinking, root-cause analysis tools, and creative exploration. It is suitable for technical issues, architectural decisions, feasibility questions, and claims verification.
</context>

<instructions>

## Inputs

- Question or hypothesis to investigate
- Context and constraints (time, resource, risk limits)
- Available evidence sources (logs, code, documentation, users)
- Success criteria (what constitutes satisfactory conclusion)

## Scope

- **Defect/incident investigation**: Why is something broken?
- **Performance issue analysis**: Why is performance degraded?
- **Security concern assessment**: What is the risk?
- **Feature feasibility**: Can we build this?
- **Architectural decisions**: Which approach is best?
- **Process questions**: Why are we doing it this way?

# Investigate Workflow

This workflow instructs the agent to investigate systematically, combining scientific-method thinking, root-cause analysis tools, and creative exploration.

## Step 1: Frame the Investigation Clearly

- Restate what is being investigated as a precise question or hypothesis.
- Classify the investigation type:
  - Defect/incident, performance issue, security concern.
  - Product/feature feasibility, architectural choice, process question.
- Use a lightweight **CSD Matrix**:
  - **Certainties** – facts and hard data.
  - **Suppositions** – assumptions that seem likely.
  - **Doubts** – unknowns, ambiguities, or contested claims.
- Define success criteria: what counts as a satisfactory answer or level of confidence.

## Step 2: Collect Initial Evidence and Context

- Gather available artifacts:
  - Logs, traces, metrics, error messages.
  - User reports, tickets, acceptance criteria, existing docs.
- Map where in the codebase and system this likely lives using code search and grep search.
- Use web search for quick orientation when relevant (framework behavior, platform quirks, known bugs), confirming versions and dates.

## Step 3: Generate Hypotheses Broadly

- Brainstorm plausible explanations or outcomes before investigating deeply.
- Use an **Ishikawa/Fishbone-inspired** lens for software:
  - People (skills, communication, process).
  - Process (SDLC, reviews, testing, release practices).
  - Platform/Environment (infrastructure, config, dependencies).
  - Code/Logic (algorithms, data structures, branching, edge cases).
  - Data (schema, migrations, quality, contracts).
- For product/feasibility questions, include multiple conceptual options, not just the "obvious" one.

## Step 4: Prioritize Lines of Inquiry

- Rank hypotheses using simple risk and plausibility:
  - Impact if true (severity, cost, user impact).
  - Likelihood given the evidence so far.
- Optionally apply:
  - A quick **Pareto** mindset (what 20% of causes likely produce 80% of impact).
  - A small **decision matrix** when multiple investigative directions compete for limited attention.

## Step 5: Design Targeted Experiments

- For the top hypotheses, design minimal, high-signal experiments:
  - What observation, test, or probe will distinguish between hypotheses?
  - What data will be collected (logs, metrics, traces, user behavior, benchmarks)?
  - What outcome would confirm vs refute each hypothesis?
- Ensure experiments are safe (non-destructive, minimal production risk) and prioritized by information value.

## Step 6: Execute, Observe, and Update the Model

- Run experiments iteratively rather than all at once.
- After each experiment:
  - Update the CSD Matrix (promote suppositions to certainties or move them to doubts).
  - Eliminate or refine hypotheses.
  - Note surprises and anomalies explicitly.
- Use repository history (git logs, PRs) to relate findings to known changes or external information.

## Step 7: Deep Root Cause and Risk Analysis

- Once a leading explanation emerges, probe deeper:
  - Apply **5 Whys** to move from surface symptom to systemic cause.
  - Optionally sketch a simple **Fault Tree**: start from the observed problem and decompose contributing conditions.
- For systemic or recurring issues, think in **FMEA** terms:
  - What are the main failure modes in this area?
  - For each: Severity, Occurrence likelihood, Detection capability (even if only qualitatively ranked).
  - Use this to highlight where mitigation or monitoring is most urgent.

## Step 8: Synthesis, Recommendations, and Open Questions

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

## Error Handling

- **Inconclusive evidence**: Document confidence level and remaining unknowns
- **Contradictory findings**: Investigate root of contradiction, flag for expert review
- **Production risk**: Design non-destructive experiments or move to staging
- **Blocked investigation**: Identify blocker, suggest workaround or escalation path

</instructions>

<output_format>
- **Investigation summary**: Question asked, scope, and key findings
- **CSD Matrix**: Certainties, suppositions, doubts (updated throughout)
- **Evidence collected**: Artifacts, logs, metrics reviewed
- **Hypotheses**: Generated, ranked by plausibility, eliminated/refined through experimentation
- **Experiments**: Designed and executed with results
- **Root cause analysis**: 5 Whys, Fault Tree, FMEA (as applicable)
- **Findings**: Most likely explanation(s) with confidence levels
- **Recommendations**: Immediate fixes, systemic changes, monitoring improvements
- **Open questions**: Remaining unknowns with suggested next steps
</output_format>
