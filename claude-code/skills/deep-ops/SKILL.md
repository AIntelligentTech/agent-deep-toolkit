---
name: deep-ops
description: Operational, security, UX, and governance workflows using bundled deep-* procedures for audits, incidents, observability, infra, and more.
disable-model-invocation: true
user-invocable: true
---

# Deep Ops Skill

Use this skill when you want Claude to run **structured operational and governance workflows** instead of giving ad-hoc advice.

Invoking this skill (for example as `/deep-ops`) tells Claude to:

- Clarify the operational or governance question.
- Select one or more ops deep-* workflows from the bundled references.
- Follow those procedures step by step, making its use of each workflow explicit.

## When to use this skill

Use `/deep-ops` when you need any of the following:

- **System or process audits** – `deep-audit`.
- **Infrastructure and platform reviews** – `deep-infrastructure`.
- **Observability and reliability reviews** – `deep-observability`.
- **Incident analysis and response** – `deep-incident` and `deep-retrospective`.
- **Security and threat modeling** – `deep-threat-model`, `deep-regulation`, `deep-ethics`.
- **UX and design operations** – `deep-ux`, `deep-design`, `deep-design-token`.
- **Experimentation and rollout strategy** – `deep-experiment`.

The detailed procedures live in the `references/` directory next to this file and are treated as **canonical specs** for how to think and act:

- `references/deep-audit.md`
- `references/deep-infrastructure.md`
- `references/deep-observability.md`
- `references/deep-incident.md`
- `references/deep-threat-model.md`
- `references/deep-regulation.md`
- `references/deep-ux.md`
- `references/deep-ethics.md`
- `references/deep-experiment.md`
- `references/deep-retrospective.md`
- `references/deep-design.md`
- `references/deep-design-token.md`

Claude should load only the reference files that are relevant to the current request, not all of them, to conserve context.

## Usage pattern

When this skill is invoked:

1. **Clarify the ops/UX/security mission** (for example, audit a system, run an incident review, design an observability plan).
2. **State explicitly** which workflows from `references/` will be followed.
3. **Follow the steps** in those reference files, grounding the analysis in the concrete system and constraints.
4. **Summarize outcomes** as action plans, risk lists, follow-up work, and other artifacts described in the workflows.

## Safety and invocation policy

- This skill is **user-invocable only** (`disable-model-invocation: true`).
- Claude **must not** auto-trigger this skill; the user chooses when to run an in-depth ops or audit workflow.
- The skill is focused on **analysis and planning**. When workflows suggest potentially disruptive actions (deploys, infra changes, permission changes), Claude should:
  - Clearly separate analysis from proposed changes.
  - Request explicit confirmation before running any such commands.

