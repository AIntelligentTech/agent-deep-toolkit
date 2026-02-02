---
title: "Cross-Agent Compatibility Engine - Architecture Specification"
version: "0.1.0"
doc_version: "1"
generated_at: "2026-02-02T16:22:23Z"
generated_by: "llm-doc-system"
last_verified: "2026-02-02T16:22:23Z"
applies_to_version: ">=0.1.0"
status: "current"
toc: true
progressive_disclosure: true
---

# Cross-Agent Compatibility Engine - Architecture Specification

> **Option C Implementation**: A comprehensive, flexible, version-aware cross-agent compatibility engine for bidirectional conversion of agent components.

## 1. Executive Summary

This document specifies the architecture for a **Cross-Agent Compatibility Engine** that can:

1. **Parse** any agent-specific component (skill, workflow, command, hook, rule, etc.) from its native format
2. **Normalize** it into a canonical, agent-agnostic intermediate representation (IR)
3. **Transform** the IR bidirectionally between agents with version awareness
4. **Render** optimized output for any target agent
5. **Validate** that conversions preserve semantic intent and behavioral equivalence

**Supported Agents**: Claude Code, Windsurf (Cascade), Cursor, with extensibility for OpenCode, Aider, Continue, etc.

---

## 2. Domain Model

### 2.1 Core Entities

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        CROSS-AGENT COMPATIBILITY ENGINE                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────────┐    ┌──────────────────────────┐  │
│  │ SOURCE AGENT │───▶│ CANONICAL IR     │───▶│ TARGET AGENT             │  │
│  │              │    │ (Intermediate    │    │                          │  │
│  │ • Parser     │    │  Representation) │    │ • Renderer               │  │
│  │ • Validator  │    │                  │    │ • Optimizer              │  │
│  │ • Version    │    │ • ComponentSpec  │    │ • Version Adapter        │  │
│  │   Detector   │    │ • Capabilities   │    │ • Validator              │  │
│  └──────────────┘    │ • Metadata       │    └──────────────────────────┘  │
│                      │ • Semantic Model │                                   │
│                      └──────────────────┘                                   │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Bounded Contexts

| Context | Responsibility | Key Aggregates |
|---------|---------------|----------------|
| **Parsing** | Ingest agent-native artifacts into IR | `Parser`, `VersionDetector`, `SchemaValidator` |
| **Canonical Model** | Agent-agnostic representation | `ComponentSpec`, `CapabilitySet`, `SemanticIntent` |
| **Transformation** | Bidirectional conversion logic | `Transformer`, `CapabilityMapper`, `LossReporter` |
| **Rendering** | Emit optimized agent-native output | `Renderer`, `Optimizer`, `VersionAdapter` |
| **Registry** | Manage agents, versions, component types | `AgentRegistry`, `ComponentTypeRegistry`, `VersionCatalog` |

---

## 3. Canonical Intermediate Representation (IR)

### 3.1 ComponentSpec Schema

```typescript
interface ComponentSpec {
  // Identity
  id: string;                          // Canonical identifier (e.g., "deep-architect")
  version: SemanticVersion;            // Component version
  sourceAgent?: AgentDescriptor;       // Where this was parsed from (if imported)
  
  // Classification
  componentType: ComponentType;        // skill | workflow | command | rule | hook | memory | agent | config
  category?: string[];                 // Taxonomy tags (e.g., ["architecture", "design"])
  
  // Semantic Intent
  intent: SemanticIntent;              // What this component is trying to achieve
  
  // Behavioral Model
  activation: ActivationModel;         // When/how this component activates
  invocation: InvocationModel;         // How users/agents invoke it
  execution: ExecutionModel;           // How it runs (context, isolation, tools)
  
  // Content
  body: MarkdownContent;               // The actual instructions/prompt
  arguments?: ArgumentSpec[];          // Structured argument definitions
  
  // Capabilities & Requirements
  capabilities: CapabilitySet;         // What this component needs to function
  
  // Agent-Specific Overrides
  agentOverrides?: Record<AgentId, AgentOverride>;
  
  // Metadata
  metadata: ComponentMetadata;
}

type ComponentType = 
  | 'skill'      // Claude Code skill
  | 'workflow'   // Windsurf workflow
  | 'command'    // Cursor command
  | 'rule'       // Windsurf rule / behavioral guideline
  | 'hook'       // Lifecycle hook (Claude)
  | 'memory'     // Persistent memory/context
  | 'agent'      // Sub-agent definition
  | 'config';    // Configuration fragment
```

### 3.2 Activation Model

```typescript
interface ActivationModel {
  mode: 'manual' | 'suggested' | 'auto' | 'contextual' | 'hooked';
  triggers?: TriggerSpec[];            // For contextual/hooked activation
  safetyLevel: 'safe' | 'sensitive' | 'dangerous';
  requiresConfirmation?: boolean;
}
```

### 3.3 Capability Set

```typescript
interface CapabilitySet {
  // What the component needs
  needsShell: boolean;
  needsFilesystem: boolean;
  needsNetwork: boolean;
  needsGit: boolean;
  needsCodeSearch: boolean;
  needsBrowser: boolean;
  needsMcp?: string[];                 // MCP servers required
  
  // What the component provides
  providesAnalysis: boolean;
  providesCodeGeneration: boolean;
  providesRefactoring: boolean;
  providesDocumentation: boolean;
}
```

---

## 4. System Architecture (C4 Model)

### 4.1 Container Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CROSS-AGENT COMPATIBILITY ENGINE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         CLI / API LAYER                              │   │
│  │  • convert <source> --to <agent> [--version <v>]                     │   │
│  │  • validate <component>                                              │   │
│  │  • diff <component-a> <component-b>                                  │   │
│  │  • generate --from <registry> --to <agent>                           │   │
│  │  • import <path> --from <agent>                                      │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                     │                                        │
│         ┌───────────────────────────┼───────────────────────────┐           │
│         ▼                           ▼                           ▼           │
│  ┌──────────────┐  ┌──────────────────────────┐  ┌──────────────────────┐  │
│  │ PARSING      │  │ TRANSFORMATION           │  │ RENDERING            │  │
│  │ SUBSYSTEM    │  │ SUBSYSTEM                │  │ SUBSYSTEM            │  │
│  │              │  │                          │  │                      │  │
│  │ • Parsers    │  │ • Capability Mapper      │  │ • Renderers          │  │
│  │ • Validators │  │ • Semantic Transformer   │  │ • Optimizers         │  │
│  │ • Version    │  │ • Loss Calculator        │  │ • Version Adapters   │  │
│  │   Detectors  │  │ • Fallback Generator     │  │ • Post-Validators    │  │
│  └──────────────┘  └──────────────────────────┘  └──────────────────────┘  │
│                                     │                                        │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                         REGISTRY LAYER                               │   │
│  │  • Agent Registry    • Component Type Registry    • Version Catalog  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Capability Mapping Matrix

### 5.1 Mapping Strategies

```typescript
type MappingStrategy = 
  | { type: 'direct'; targetField: string }
  | { type: 'transform'; transformer: (value: any) => any }
  | { type: 'fallback'; fallbackValue: any; warning: string }
  | { type: 'unsupported'; lossDescription: string };
```

### 5.2 Example Mappings

| Source (Claude) | Target (Windsurf) | Strategy |
|-----------------|-------------------|----------|
| `disable-model-invocation: true` | `auto_execution_mode: 3` | Transform |
| `$ARGUMENTS` placeholder | Prose instruction | Transform + Warning |
| `context: fork` | No equivalent | Unsupported + Loss |
| `` !`command` `` injection | `run_command` hint | Transform + Warning |

| Source (Windsurf) | Target (Cursor) | Strategy |
|-------------------|-----------------|----------|
| `description` | `# Title` section | Transform |
| `auto_execution_mode` | N/A (all manual) | Fallback |
| Tool references | Prose hints | Transform |

---

## 6. Conversion Pipeline

```
SOURCE ARTIFACT
     │
     ▼
┌─────────────┐
│ 1. PARSE    │  Detect agent + version, extract to IR
└─────────────┘
     │
     ▼
┌─────────────┐
│ 2. VALIDATE │  Check IR completeness, semantic consistency
└─────────────┘
     │
     ▼
┌─────────────┐
│ 3. ENRICH   │  Infer missing capabilities, normalize metadata
└─────────────┘
     │
     ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    CANONICAL IR (ComponentSpec)                      │
└─────────────────────────────────────────────────────────────────────┘
     │
     ▼
┌─────────────┐
│ 4. MAP      │  Apply capability mappings for target agent
└─────────────┘
     │
     ▼
┌─────────────┐
│ 5. ADAPT    │  Apply version-specific adaptations
└─────────────┘
     │
     ▼
┌─────────────┐
│ 6. RENDER   │  Generate target-native artifact
└─────────────┘
     │
     ▼
┌─────────────┐
│ 7. OPTIMIZE │  Apply agent-specific best practices
└─────────────┘
     │
     ▼
┌─────────────┐
│ 8. VALIDATE │  Verify output structure, report losses
└─────────────┘
     │
     ▼
TARGET ARTIFACT + ConversionReport
```

---

## 7. Loss Reporting

```typescript
interface ConversionReport {
  source: ComponentSpec;
  target: ComponentSpec;
  
  // What was preserved
  preservedSemantics: string[];
  
  // What was lost or degraded
  losses: ConversionLoss[];
  
  // Warnings about potential behavioral differences
  warnings: ConversionWarning[];
  
  // Suggestions for manual review
  suggestions: string[];
  
  // Overall fidelity score (0-100)
  fidelityScore: number;
}

interface ConversionLoss {
  category: 'activation' | 'execution' | 'capability' | 'metadata';
  severity: 'info' | 'warning' | 'critical';
  description: string;
  sourceField: string;
  recommendation?: string;
}
```

---

## 8. Version Awareness

### 8.1 Version Catalog

```typescript
interface VersionCatalog {
  agents: Record<AgentId, AgentVersionHistory>;
}

interface AgentVersionHistory {
  versions: AgentVersion[];
  latestStable: SemanticVersion;
  deprecatedPatterns: DeprecatedPattern[];
}

interface AgentVersion {
  version: SemanticVersion;
  releaseDate: string;
  features: AgentFeatureSet;
  breakingChanges?: BreakingChange[];
  migrationGuide?: string;
}
```

### 8.2 Version-Aware Rendering

```typescript
function renderForVersion(
  spec: ComponentSpec, 
  targetAgent: AgentId, 
  targetVersion: SemanticVersion
): RenderResult {
  const adapter = getVersionAdapter(targetAgent, targetVersion);
  const features = adapter.getFeatures();
  
  let output = adapter.render(spec);
  
  if (features.quirks) {
    output = adapter.applyQuirkWorkarounds(output);
  }
  
  return {
    artifact: output,
    compatibilityNotes: adapter.getCompatibilityNotes()
  };
}
```

---

## 9. Extensibility

### 9.1 Agent Plugin Interface

```typescript
interface AgentPlugin {
  agentId: AgentId;
  displayName: string;
  versions: AgentVersion[];
  
  parser: AgentParser;
  renderer: AgentRenderer;
  capabilityMappings: CapabilityMapping[];
  validators: Validator[];
}

// Register a new agent
engine.registerAgent(openCodePlugin);
```

### 9.2 Component Type Extensions

```typescript
interface ComponentTypePlugin {
  componentType: ComponentType;
  supportedAgents: AgentId[];
  schema: JSONSchema;
  parser?: ComponentTypeParser;
  renderer?: ComponentTypeRenderer;
}
```

---

## 10. Component Type Support Matrix

| Type | Claude | Windsurf | Cursor | Conversion Support |
|------|--------|----------|--------|-------------------|
| **Skill/Workflow/Command** | ✅ | ✅ | ✅ | Full bidirectional |
| **Rule** | ⚠️ (CLAUDE.md) | ✅ | ❌ | One-way with loss |
| **Hook** | ✅ | ❌ | ❌ | One-way with significant loss |
| **Memory** | ✅ | ✅ | ❌ | Runtime, not static |
| **Agent/Subagent** | ✅ | ❌ | ❌ | Claude-specific |
| **Config** | ✅ | ✅ | ✅ | Partial overlap |

---

## 11. Quality Attributes

| Attribute | Target | Measurement |
|-----------|--------|-------------|
| **Accuracy** | >90% semantic fidelity on core conversions | Round-trip validation tests |
| **Extensibility** | Add new agent in <1 day | Plugin implementation time |
| **Performance** | 100 workflows in <5 seconds | CI benchmark |
| **Safety** | Zero silent data loss | Loss reporting coverage |
| **Reversibility** | >90% round-trip fidelity | Automated round-trip tests |

---

## 12. Implementation Roadmap

### Phase 1: Core Engine (MVP)
- [ ] Define `ComponentSpec` schema (JSON Schema + TypeScript types)
- [ ] Implement parsers for Claude, Windsurf, Cursor
- [ ] Implement renderers for Claude, Windsurf, Cursor
- [ ] Basic capability mapping matrix
- [ ] CLI: `convert`, `validate` commands
- [ ] Loss reporting

### Phase 2: Version Awareness
- [ ] Version catalog for each agent
- [ ] Version detection in parsers
- [ ] Version-specific rendering adapters
- [ ] Migration guides for breaking changes

### Phase 3: Advanced Features
- [ ] Bidirectional round-trip validation
- [ ] Semantic diff between components
- [ ] Batch conversion with parallelization
- [ ] Plugin system for new agents

### Phase 4: Ecosystem Integration
- [ ] IDE extensions (VS Code, JetBrains)
- [ ] CI/CD integration (GitHub Actions)
- [ ] Web UI for browsing and converting
- [ ] Registry of community components

---

## 13. File Structure

```
agent-deep-toolkit/
├── engine/                          # Cross-Agent Compatibility Engine
│   ├── src/
│   │   ├── core/
│   │   │   ├── types.ts             # ComponentSpec, IR types
│   │   │   ├── schema.json          # JSON Schema for validation
│   │   │   └── constants.ts         # Agent IDs, component types
│   │   ├── parsing/
│   │   │   ├── parser-factory.ts
│   │   │   ├── claude-parser.ts
│   │   │   ├── windsurf-parser.ts
│   │   │   └── cursor-parser.ts
│   │   ├── transformation/
│   │   │   ├── capability-mapper.ts
│   │   │   ├── transformer.ts
│   │   │   └── loss-calculator.ts
│   │   ├── rendering/
│   │   │   ├── renderer-factory.ts
│   │   │   ├── claude-renderer.ts
│   │   │   ├── windsurf-renderer.ts
│   │   │   └── cursor-renderer.ts
│   │   ├── registry/
│   │   │   ├── agent-registry.ts
│   │   │   └── version-catalog.ts
│   │   ├── cli/
│   │   │   ├── convert.ts
│   │   │   ├── validate.ts
│   │   │   └── index.ts
│   │   └── index.ts                 # Public API
│   ├── data/
│   │   ├── capability-mappings.json
│   │   └── version-catalog.json
│   ├── tests/
│   └── package.json
├── tools/
│   └── deep-tools.json              # Existing canonical registry
├── templates/                        # Existing templates
├── outputs/                          # Existing generated outputs
└── docs/
    └── architecture/
        └── cross-agent-compatibility-engine.md
```

---

## 14. ADR Summary

**Context**: The existing static generator (`bin/generate-deep-tools`) provides one-way conversion from a canonical JSON registry to agent-native artifacts. This is insufficient for importing existing workflows, bidirectional conversion, and version-aware adaptation.

**Decision**: Implement Option C - a comprehensive Cross-Agent Compatibility Engine with:
- Rich semantic IR (ComponentSpec)
- Bidirectional parsing and rendering
- Version-aware adapters
- Loss reporting and validation
- Plugin architecture for extensibility

**Consequences**:
- **Positive**: Full bidirectional conversion, version awareness, extensibility, semantic fidelity
- **Negative**: Increased complexity, maintenance burden, requires careful versioning as agents evolve
- **Mitigations**: Plugin architecture isolates agent-specific logic; comprehensive test suite ensures correctness

---

## 15. Open Questions

1. **IR Versioning**: How do we version the ComponentSpec schema itself as it evolves?
2. **Conflict Resolution**: When round-tripping, how do we handle conflicts between preserved source metadata and target-native conventions?
3. **Community Contributions**: How do we accept and validate community-contributed agent plugins?
4. **Performance at Scale**: What caching strategies are needed for large workflow libraries?

---

*This document was generated following the `/deep-architect` and `/deep-design` workflows.*
