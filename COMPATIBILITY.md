# Agent Compatibility Matrix (January 2026)

This document outlines how the `agent-deep-toolkit` source skills are transformed into optimal artifacts for each supported agent.

## 1. Compatibility Matrix

| Feature | Claude Code (v2.1+) | Cursor | Windsurf (Cascade) | OpenCode |
| :--- | :--- | :--- | :--- | :--- |
| **Primary Standard** | [Agent Skills](https://claude.ai/skills) | Rules & Commands | Workflows & Skills | YAML-MD Commands |
| **Artifact Path** | `.claude/skills/<name>/SKILL.md` | `.cursor/rules/*.mdc`<br>`.cursor/commands/*.md` | `.windsurf/workflows/*.md`<br>`.windsurf/skills/<name>/SKILL.md` | `.opencode/commands/*.md` |
| **Auto-Invocation** | `disable-model-invocation: false` | `alwaysApply: true` (Rules) | `auto_execution_mode: 2` | `description` matching |
| **Synonym Support** | `aliases` in frontmatter | Multiple file variants | Multiple file variants | Multiple file variants |
| **Multi-Agent** | `context: fork` | Manual sub-agent | Workflow chaining | `agent`, `subtask` tags |
| **Dynamic Inputs** | Contextual/Full Prompt | Contextual/Full Prompt | Sequence steps | `$ARGUMENTS`, `$n` |

---

## 2. Agent-Specific Details

### Claude Code (v2.1+)
- **Integrated Skills**: Slash commands are now unified with skills.
- **Aliases**: We use the `aliases` field in `SKILL.md` to support multiple command names for a single skill logic.
- **Tools**: `allowed-tools` is set to `["*"]` by default to allow full agentic capability.

### Cursor
- **Rules (.mdc)**: Used for persistent "mental models" and best practices. Controlled by `globs` and `alwaysApply`.
- **Commands (.md)**: Located in the command library for explicit slash-invocation.

### Windsurf (Cascade)
- **Workflows**: Sequence-based automation. We generate `.md` files in `workflows/` for each synonym.
- **Skills**: We create a `SKILL.md` directory structure to allow Cascade to follow robust procedures.

### OpenCode
- **Metadata**: Enhanced frontmatter for `agent` and `model` selection.
- **Parametric**: We inject `$ARGUMENTS` into the template to ensure the command can consume user-provided text explicitly.

---

## 3. Chaining & Prompt Parsing

As of Jan 2026, the toolkit assumes **Contextual Chaining** behavior. While some agents (Claude, Windsurf) allow message queuing, the optimal way to use these tools is:
1.  **Direct Invocation**: Typing `/think` or `/architect` directly.
2.  **Contextual Directive**: Adding `/thought /architect` to a complex prompt. The generator ensures that the commands are designed to "read" the entire conversation context to provide maximum value.
