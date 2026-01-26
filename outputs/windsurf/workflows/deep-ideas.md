---
description: Generate high-leverage product, feature, and workflow ideas using current trends, tools, and constraints
auto_execution_mode: 3
tags:
  - architecture
  - testing
---
# Deep Ideas Workflow

This workflow instructs Cascade to deeply understand the current state of the product or workstream and generate innovative, valuable, and feasible ideas grounded in current technology and trends.

## 1. Clarify Problem Space and Constraints

- Restate the prompt as a clear opportunity space:
  - Product, feature, workflow, or business area we are ideating on.
  - Target users, goals, and pain points.
- Capture constraints:
  - Time, budget, team size/skills, platform and stack, regulatory/ethical boundaries.
- If the problem is vague, use `/deep-spec` or `/deep-think` to refine it.

## 2. Ground in Current Reality

- Use `/deep-explore` to understand the current implementation and workflows where relevant.
- Use `/deep-search` to gather:
  - Recent trends, patterns, and best practices (2024–2026) in the relevant domain.
  - New tools, libraries, platforms, and AI capabilities that might unlock new ideas.
- Summarize the current state and external context in a few bullet points before ideating.

## 3. Generate a Broad Idea Set

- Brainstorm ideas across different horizons and sizes:
  - Small improvements, medium features, and bold bets.
- Use multiple lenses:
  - UX/experience improvements (`/deep-ux`).
  - Architecture/platform leverage (`/deep-architect`).
  - Data/insight-driven ideas (`/deep-data`).
  - Automation/AI augmentation opportunities.
- Aim for diversity over early judgment; capture 15–30 ideas if possible.

## 4. Evaluate and Refine Ideas

- Apply `/deep-consider` and `/deep-decision`:
  - Define evaluation criteria (impact, effort, risk, learning, alignment, reversibility).
  - Score or at least qualitatively assess each idea.
- Refine the most promising ideas:
  - Clarify user journeys and value propositions.
  - Sketch rough implementation approaches (code, infra, UX) using `/deep-code`, `/deep-ux`, `/deep-infrastructure` where relevant.

## 5. Prioritize and Define Next Actions

- Select a small set of top candidates (e.g. 3–5):
  - Label at least one as a quick win, and one as a higher-risk/high-reward bet.
- For each selected idea:
  - Propose validation steps using `/deep-experiment`.
  - Identify any dependencies on other workflows (e.g. `deep-architect`, `deep-ux`, `deep-test`).
- Output should include:
  - Ranked list of ideas with rationale.
  - Suggested next steps and experiments for the top candidates.
