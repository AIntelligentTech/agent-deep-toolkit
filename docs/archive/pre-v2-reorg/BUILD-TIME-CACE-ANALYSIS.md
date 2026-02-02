---
title: "Build-Time CACE Analysis: Maintainer Tool, Not User Dependency"
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

# Build-Time CACE Analysis: Maintainer Tool, Not User Dependency

**Date:** 2026-01-26 **Version:** 2.0 - CORRECTED INTERPRETATION **Status:**
Re-evaluation with Build-Time Understanding

---

## Executive Summary

**Critical Clarification:** This document re-evaluates using CACE as a
**build-time tool for maintainers** (not a user runtime dependency). The
previous `OPTION-D-ANALYSIS.md` correctly rejected runtime user dependency but
was based on a misunderstanding of the proposal.

**Corrected Architecture:**

- Maintainers use CACE to generate outputs during development
- Generated outputs are committed to repository
- Users install pre-generated outputs (zero CACE dependency)
- CACE is internal/private tool (not public npm package)

**Final Recommendation:** **Still recommend Option C (Python Generator)**, but
for **completely different reasons** than the previous analysis.

---

## 1. What Changed: Corrected Understanding

### 1.1 Previous Interpretation (WRONG)

**What I analyzed in OPTION-D-ANALYSIS.md:**

```
User Workflow (WRONG):
  git clone agent-deep-toolkit
  cd agent-deep-toolkit
  ./install.sh --agent windsurf
    ↓
  [install.sh checks for CACE]
  [install.sh calls: cace convert skills/* --to windsurf]
  [install.sh installs converted files]
    ↓
  User needs: npm, Node.js, CACE CLI installed
  Failure mode: CACE not found → installation fails
```

**Deal-breakers (correctly identified for THIS interpretation):**

- ❌ Hard user dependency on CACE
- ❌ Offline installation impossible
- ❌ 100x slower (10s vs 0.1s)
- ❌ 7 external failure modes

**Verdict:** Absolutely correct rejection for runtime dependency model.

### 1.2 Actual Proposal (CORRECT)

**What you actually meant:**

```
Maintainer Workflow:
  vim skills/deep-architect/SKILL.md    # Edit Claude source
  cace convert skills/* --to windsurf   # Build step (local)
  cace convert skills/* --to cursor
  cace convert skills/* --to opencode
  git add skills/ outputs/
  git commit -m "feat: add workflow"
  git push
    ↓
User Workflow:
  git clone agent-deep-toolkit
  cd agent-deep-toolkit
  ./install.sh --agent windsurf
    ↓
  [install.sh copies: outputs/windsurf/*.md → ~/.windsurf/workflows/]
    ↓
  User needs: Nothing (outputs pre-generated)
  Installation time: 0.1s (same as current)
  Offline: Works (outputs committed)
```

**Key insight:** CACE is **maintainer-only build tool**, not user-facing.

---

## 2. Re-evaluated Architecture Comparison

### 2.1 Current System (JSON + Python Generator)

**Source:**

```json
// tools/deep-tools.json
{
  "id": "deep-architect",
  "windsurf": { "description": "...", "autoExecutionMode": 3 },
  "claude": { "name": "deep-architect", "description": "..." },
  "body": "# Deep Architect Workflow\n..."
}
```

**Build Process:**

```bash
# Maintainer workflow
vim tools/deep-tools.json             # Edit canonical spec
./bin/generate-deep-tools             # Python template renderer (196 lines)
git diff outputs/                     # Review generated files
git add tools/deep-tools.json outputs/
git commit -m "feat: add workflow"
```

**User Installation:**

```bash
./install.sh --agent windsurf --level user
# Copies: outputs/windsurf/*.md → ~/.windsurf/workflows/
# Time: 0.1s
# Requires: bash (standard)
```

### 2.2 Proposed System (Claude + Build-Time CACE)

**Source:**

```markdown
## <!-- skills/deep-architect/SKILL.md -->

name: deep-architect description: Act as a world-class software architect...
disable-model-invocation: true user-invocable: true

---

# Deep Architect Workflow

...
```

**Build Process:**

```bash
# Maintainer workflow
vim skills/deep-architect/SKILL.md   # Edit Claude skill

# Option A: Manual conversion
cace convert skills/*/SKILL.md --to windsurf --output outputs/windsurf/
cace convert skills/*/SKILL.md --to cursor --output outputs/cursor/
cace convert skills/*/SKILL.md --to opencode --output outputs/opencode/

# Option B: Build script wrapper
./bin/build-with-cace                # Runs all conversions

git diff outputs/                    # Review CACE-generated files
git add skills/ outputs/
git commit -m "feat: add workflow"
```

**User Installation:**

```bash
./install.sh --agent windsurf --level user
# IDENTICAL to current:
# Copies: outputs/windsurf/*.md → ~/.windsurf/workflows/
# Time: 0.1s
# Requires: bash (standard)
```

---

## 3. Critical Comparison: Maintainer Perspective

### 3.1 User Experience (IDENTICAL)

| Aspect                   | Current (Python) | Build-Time CACE      |
| ------------------------ | ---------------- | -------------------- |
| **Installation Speed**   | 0.1s             | 0.1s (SAME)          |
| **Offline Installation** | ✅ Works         | ✅ Works (SAME)      |
| **Air-Gapped**           | ✅ Works         | ✅ Works (SAME)      |
| **Dependencies**         | bash, python3    | bash, python3 (SAME) |
| **Failure Modes**        | 2 (rare)         | 2 (SAME)             |

**Verdict:** User experience is **IDENTICAL**. Previous deal-breakers
eliminated.

### 3.2 Maintainer Experience (DIFFERENT)

#### Source Format

**Current (JSON):**

- Simple, flat structure (4 fields actively used)
- Agent-agnostic (no bias toward Claude)
- Easy for non-technical contributors
- Clear diffs in version control

**Proposed (Claude SKILL.md):**

- Rich metadata (20+ fields available)
- Claude-centric (other agents derived)
- Requires Claude expertise
- Markdown with frontmatter (still diffable)

**Analysis:**

From `OPTION-D-ANALYSIS.md` evidence, current workflows use:

- ✅ `name`, `description`, `body` (100%)
- ❌ `hooks`, `agents`, `context: fork`, `allowed-tools`, `model`,
  `argument-hint` (0%)

**Conclusion:** Claude format offers richness, but **69% of features unused**.

**Question:** Is unused richness "future-proofing" or "over-engineering"?

#### Build Tool

**Current (Python Generator):**

```python
# bin/generate-deep-tools (196 lines)
with open('templates/windsurf/workflow-template.md') as f:
    template = f.read()

output = template.replace('{{DESCRIPTION}}', tool['windsurf']['description'])
output = output.replace('{{BODY}}', tool['body'])

with open(f'outputs/windsurf/workflows/{tool_id}.md', 'w') as f:
    f.write(output)
```

**Characteristics:**

- Simple template substitution
- Full control over output
- Easy to customize (edit template or code)
- Zero external dependencies
- Immediate bug fixes (edit local code)

**Proposed (CACE):**

```bash
# External CLI tool
cace convert skills/deep-architect/SKILL.md \
  --to windsurf \
  --output outputs/windsurf/
```

**Characteristics:**

- Sophisticated conversion engine
- CACE controls output format
- Customization requires CACE changes
- External dependency (internal tool)
- Bug fixes require CACE update or fork

#### Customization Scenario

**Example:** Add custom frontmatter field `toolkit: "agent-deep-toolkit"` to
Windsurf outputs.

**Current (30 seconds):**

```bash
vim templates/windsurf/workflow-template.md
# Add line: toolkit: "agent-deep-toolkit"
./bin/generate-deep-tools
git diff outputs/windsurf/  # Verify
git commit
```

**Proposed (hours to weeks):**

```bash
# Option 1: Modify CACE (internal tool, you control it)
vim ../cross-agent-compatibility-engine/src/rendering/windsurf-renderer.ts
# Add custom field logic
bun run build
npm link
cd agent-deep-toolkit
cace convert skills/* --to windsurf
git diff outputs/windsurf/
git commit

# Option 2: Post-process CACE output (fragile)
./bin/build-with-cace
./bin/add-custom-fields  # Hack: parse + inject
git commit

# Option 3: Fork CACE (maintainability nightmare)
# Not realistic
```

**Verdict:** Python generator provides **immediate customization**. CACE
requires **significant effort**.

---

## 4. When Build-Time CACE Makes Sense

### 4.1 Favorable Conditions

Build-time CACE would be **superior** if:

1. ✅ **Toolkit is Claude-primary**
   - Other agents are "export targets"
   - Claude format is natural canonical representation
   - Maintainers think in Claude terms

2. ✅ **Workflows use advanced Claude features**
   - Hooks, forks, tool restrictions, agents, structured arguments
   - These features worth preserving/converting
   - Rich metadata provides value

3. ✅ **CACE conversion demonstrably superior**
   - Better formatting, smarter transformations
   - Quality improvements over simple templates
   - Worth the trade-off of less control

4. ✅ **New agents added frequently**
   - CACE supports 8+ agents
   - Toolkit wants to expand rapidly
   - Automatic support valuable

5. ✅ **Generator maintenance is burden**
   - Python code complex, hard to maintain
   - Templates unwieldy
   - Bugs common

6. ✅ **CACE is deeply integrated**
   - Already used for other projects
   - Team expertise in CACE
   - Internal tool under your control

### 4.2 Reality Check

**Actual toolkit characteristics:**

| Condition              | Reality                                  | Met?        |
| ---------------------- | ---------------------------------------- | ----------- |
| Claude-primary         | ❌ Multi-agent equal (stated mission)    | ❌ No       |
| Advanced features used | ❌ 0/48 workflows use hooks/forks/agents | ❌ No       |
| CACE quality superior  | ⚠️ Good, but not significantly better    | ⚠️ Marginal |
| Frequent new agents    | ❌ 4 agents stable for months            | ❌ No       |
| Generator burden       | ❌ 196 lines, simple, stable             | ❌ No       |
| CACE integration       | ✅ Internal tool, you control            | ✅ Yes      |

**Score: 1/6 conditions met**

**Conclusion:** Build-time CACE is **technically viable** but **not
strategically aligned** with toolkit's current state.

---

## 5. Source Format Philosophy

### 5.1 The Core Question

**Is agent-deep-toolkit:**

- (A) **"Claude workflows, exported to other agents"** → Claude source makes
  sense
- (B) **"Agent-agnostic workflows, rendered for all agents"** → JSON source
  makes sense

**Evidence from toolkit mission** (README.md):

> "A portable, cross-agent meta-cognitive toolkit"

**Evidence from naming:**

- Repository: `agent-deep-toolkit` (not `claude-deep-toolkit`)
- Documentation: Emphasizes multi-agent support equally

**Evidence from history:**

- v0.1.0: Windsurf + Claude (equal)
- v0.3.0: Added Cursor (equal)
- v0.4.0: Added OpenCode (equal)

**Verdict:** Toolkit is **agent-agnostic** (B), not Claude-centric (A).

### 5.2 Implications

**If agent-agnostic:**

- Source format should be neutral (not Claude-specific)
- JSON or Universal markdown preferred
- Generate all agent formats from canonical spec

**If Claude-centric:**

- Claude SKILL.md as source makes sense
- Convert to other agents via CACE
- Accept that toolkit is "for Claude users primarily"

**Current approach (JSON) aligns with agent-agnostic mission.**

---

## 6. Build Process Comparison

### 6.1 Maintainer Workflow: Add New Tool

**Current (JSON + Python):**

```bash
# Time: 5 minutes

# 1. Edit canonical spec
vim tools/deep-tools.json
# Add new tool entry (copy existing, modify)

# 2. Generate outputs
./bin/generate-deep-tools
# Takes: <1 second

# 3. Review changes
git diff outputs/
# See exactly what changed (deterministic)

# 4. Commit
git add tools/deep-tools.json outputs/
git commit -m "feat: add deep-newfeature"
```

**Proposed (Claude + CACE):**

```bash
# Time: 10-15 minutes

# 1. Create Claude skill
mkdir skills/deep-newfeature
vim skills/deep-newfeature/SKILL.md
# Write full Claude skill (frontmatter + body)

# 2. Convert with CACE
cace convert skills/deep-newfeature/SKILL.md --to windsurf --output outputs/windsurf/
cace convert skills/deep-newfeature/SKILL.md --to cursor --output outputs/cursor/
cace convert skills/deep-newfeature/SKILL.md --to opencode --output outputs/opencode/
# Takes: 2-5 seconds (external process overhead)

# 3. Review CACE outputs
git diff outputs/
# Hope CACE output is correct (less control)

# 4. Test manually (CACE output not guaranteed to match expectations)
cat outputs/windsurf/workflows/deep-newfeature.md
cat outputs/cursor/commands/deep-newfeature.md
cat outputs/opencode/commands/deep-newfeature.md

# 5. Commit
git add skills/deep-newfeature/ outputs/
git commit -m "feat: add deep-newfeature"
```

**Analysis:**

- Current: 5 min, deterministic, reviewable
- Proposed: 10-15 min, CACE-dependent, less predictable

### 6.2 Maintainer Workflow: Update Existing Tool

**Current:**

```bash
# Time: 2 minutes

vim tools/deep-tools.json
# Edit body or metadata
./bin/generate-deep-tools
git diff outputs/
# See EXACTLY what changed (line-by-line diff)
git commit -a -m "fix: update deep-architect description"
```

**Proposed:**

```bash
# Time: 5 minutes

vim skills/deep-architect/SKILL.md
# Edit body or frontmatter
./bin/build-with-cace
git diff outputs/
# CACE may change more than expected (formatting, tags, etc.)
git commit -a -m "fix: update deep-architect description"
```

### 6.3 CI/CD Setup

**Current:**

```yaml
# .github/workflows/build.yml
name: Generate Outputs
on: [push, pull_request]
jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: ./bin/generate-deep-tools
      - run: git diff --exit-code outputs/
        # Fails if outputs not committed
```

**Proposed:**

```yaml
# .github/workflows/build.yml
name: Generate Outputs
on: [push, pull_request]
jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # NEW: Install CACE
      - uses: actions/setup-node@v4
      - name: Install CACE (private tool)
        run: |
          # Option A: If CACE is in private npm registry
          npm config set @aintelligenttech:registry https://npm.internal.company.com/
          npm install -g @aintelligenttech/cace@0.2.0

          # Option B: If CACE is vendored in repo
          cd vendor/cace && npm install && npm link

          # Option C: If CACE is pulled from private repo
          git clone git@github.com:internal/cace.git
          cd cace && npm install && npm link

      - run: ./bin/build-with-cace
      - run: git diff --exit-code outputs/
```

**Analysis:**

- Current: 3 lines, zero setup
- Proposed: 15+ lines, CACE installation complexity
- Private tool adds authentication/registry complexity

---

## 7. Risk Analysis: Build-Time vs Runtime

### 7.1 Previous Analysis (Runtime CACE) - Correctly Rejected

**From OPTION-D-ANALYSIS.md:**

| Risk                        | Impact             | Severity        |
| --------------------------- | ------------------ | --------------- |
| CACE not installed (user)   | Installation fails | **CRITICAL** ❌ |
| npm registry down (user)    | Cannot install     | **HIGH** ❌     |
| Offline installation (user) | Impossible         | **CRITICAL** ❌ |
| CACE breaking change (user) | All users broken   | **CRITICAL** ❌ |

**Verdict:** Unacceptable for users. **CORRECT REJECTION.**

### 7.2 Re-assessed Risks (Build-Time CACE)

**NEW risk profile:**

| Risk                  | Who Affected     | Impact                             | Severity      |
| --------------------- | ---------------- | ---------------------------------- | ------------- |
| CACE not installed    | Maintainers only | Cannot build                       | **LOW** ⚠️    |
| CACE breaking change  | Maintainers only | Build breaks, update needed        | **MEDIUM** ⚠️ |
| CACE conversion bug   | Maintainers only | Wrong outputs (detected in review) | **LOW** ⚠️    |
| CI/CD complexity      | Maintainers only | Slower CI, auth complexity         | **LOW** ⚠️    |
| Loss of customization | Maintainers only | Hard to customize outputs          | **MEDIUM** ⚠️ |

**Users completely unaffected** (outputs pre-generated).

**Comparison:**

| Stakeholder     | Runtime CACE              | Build-Time CACE             |
| --------------- | ------------------------- | --------------------------- |
| **Users**       | ❌ **7 risks** (CRITICAL) | ✅ **0 risks**              |
| **Maintainers** | ✅ 0 risks                | ⚠️ **5 risks** (LOW-MEDIUM) |

**Verdict:** Build-time CACE is **acceptable risk level** (maintainer-only
impact).

---

## 8. Recommendation: Still Prefer Current Approach

### 8.1 Why NOT Adopt Build-Time CACE

Despite eliminating all user-facing deal-breakers, I still recommend **keeping
the current Python generator** for these reasons:

#### 1. **Philosophical Mismatch**

Toolkit's stated mission is **agent-agnostic**. Using Claude as canonical source
contradicts this.

**Evidence:**

- README: "portable, cross-agent toolkit"
- Equal treatment of all agents in docs
- No "Claude-first" positioning

**Using Claude source signals:** "This is really a Claude toolkit that happens
to support others"

#### 2. **Feature Utilization Analysis**

From codebase analysis (OPTION-D-ANALYSIS.md):

- Claude format offers: 13 optional fields
- Workflows actually use: 4 fields (69% unused)

**Workflows are documentation prose, not structured execution.**

Advanced Claude features (hooks, forks, agents, tool restrictions) are
**irrelevant** for documentation workflows.

**Using Claude format for simple workflows = over-engineering.**

#### 3. **Maintainer Simplicity**

**Current (196 lines Python):**

- Simple template substitution
- Full control, immediate customization
- Zero external dependencies
- Deterministic outputs

**Proposed (CACE):**

- External tool (even if internal, still external to toolkit)
- Limited customization (black box)
- CI/CD complexity (installation, auth)
- CACE-dependent outputs

**Trade-off:** Lose simplicity/control for... what benefit?

#### 4. **No Compelling Advantage**

**What CACE provides:**

- ✅ Automatic new agent support (if CACE adds them)
- ✅ Sophisticated conversion logic
- ✅ Built-in validation

**Current system provides:**

- ✅ Full control over output
- ✅ Immediate customization
- ✅ Simple build process
- ✅ Zero external dependencies

**Missing from CACE value prop:** Toolkit doesn't add new agents frequently (4
stable agents), sophisticated conversion not needed (simple prose), validation
can be added separately.

#### 5. **Can Have Best of Both Worlds**

**Recommended: Hybrid Approach**

```
Source: tools/deep-tools.json (agent-agnostic)
  ↓
Build: bin/generate-deep-tools (Python - simple)
  ↓
Validate: bin/validate-with-cace (CACE - optional)
  ↓
Outputs: Committed (fast user install)
```

This provides:

- ✅ Simple maintainer workflow
- ✅ Full control over outputs
- ✅ CACE validation benefits
- ✅ Agent-agnostic philosophy
- ✅ Zero user-facing CACE dependency

---

## 9. When to Reconsider

### 9.1 Triggers for Re-evaluation

**Adopt build-time CACE if:**

1. **Toolkit becomes Claude-primary**
   - Mission changes to "Claude workflows for everyone"
   - Claude users are 80%+ of user base
   - Other agents become "export" features

2. **Workflows evolve to use advanced features**
   - 50%+ workflows use hooks/forks/agents
   - Structured execution becomes common
   - Claude's richness provides real value

3. **Generator becomes maintenance burden**
   - Python code exceeds 500 lines
   - Template complexity explodes
   - Bugs common, hard to fix

4. **CACE conversion objectively superior**
   - A/B testing shows users prefer CACE output
   - CACE handles edge cases better
   - Quality difference measurable

5. **New agents added monthly**
   - Toolkit expands to 10+ agents
   - Manual template creation bottleneck
   - CACE's automatic support critical

**Current reality:**

- ❌ Multi-agent equal (not Claude-primary)
- ❌ Simple prose workflows (no advanced features)
- ❌ Generator is simple (196 lines, stable)
- ⚠️ CACE quality good (but not meaningfully better)
- ❌ 4 agents stable (not rapidly expanding)

**Likelihood of triggers: <20% in next 12 months**

---

## 10. Practical Recommendation

### 10.1 Immediate Action: Enhance Current System

**Phase 1: Add CACE Validation (Week 1)**

```bash
# bin/validate-with-cace
#!/usr/bin/env bash
# Optional validation tool (maintainers only)

if ! command -v cace; then
  echo "CACE not found - skipping validation"
  exit 0
fi

./bin/generate-deep-tools

echo "Validating outputs with CACE..."
for skill in outputs/claude/skills/*/SKILL.md; do
  cace validate "$skill" || exit 1
done

echo "Testing conversion fidelity..."
for skill in outputs/claude/skills/*/SKILL.md; do
  fidelity=$(cace convert "$skill" --to windsurf --dry-run | grep Fidelity | cut -d: -f2)
  if [ "${fidelity%\%}" -lt 90 ]; then
    echo "WARNING: Low fidelity for $skill: $fidelity"
  fi
done

echo "All validations passed"
```

**Phase 2: Add Semantic Metadata (Month 1)**

```json
// tools/deep-tools.json v4
{
  "tools": [{
    "id": "deep-architect",

    // NEW: CACE-compatible semantic metadata
    "intent": {
      "summary": "Act as world-class software architect",
      "purpose": "Design scalable, maintainable system architecture",
      "whenToUse": "When designing new systems or refactoring"
    },
    "activation": "manual",
    "capabilities": {
      "needsShell": true,
      "needsFilesystem": true,
      "providesAnalysis": true
    },

    // Existing fields
    "windsurf": { ... },
    "claude": { ... },
    "body": "..."
  }]
}
```

**Phase 3: CI Validation (Week 1)**

```yaml
# .github/workflows/validate.yml
name: Validate Outputs
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4

      # Install CACE (optional - CI only)
      - name: Install CACE
        run: npm install -g @aintelligenttech/cace@0.2.0
        # If private: add authentication

      - name: Generate
        run: ./bin/generate-deep-tools

      - name: Validate
        run: ./bin/validate-with-cace

      - name: Check committed
        run: git diff --exit-code outputs/
```

**Benefits:**

- ✅ CACE validates output quality
- ✅ Semantic metadata aligns with ComponentSpec
- ✅ No change to core generation process
- ✅ Users unaffected
- ✅ Maintainers get validation benefits

### 10.2 Alternative: Experimental Branch

**If you want to try build-time CACE:**

```bash
git checkout -b experimental/build-time-cace

# Convert deep-tools.json → skills/*.md (one-time)
./bin/convert-json-to-skills

# Replace bin/generate-deep-tools with bin/build-with-cace
# Update CI/CD
# Test for 1 month

# Decision criteria:
# - Is it actually easier?
# - Is CACE output meaningfully better?
# - Is loss of control acceptable?

# If yes to all: merge
# If no to any: keep current
```

**This allows safe exploration without commitment.**

---

## 11. Conclusion

### 11.1 Corrected Analysis Summary

**Previous OPTION-D-ANALYSIS.md:**

- ✅ Correctly rejected CACE as **user runtime dependency**
- ✅ Deal-breakers accurately identified
- ❌ Based on misunderstanding of proposal

**This Analysis:**

- ✅ Correctly understands CACE as **maintainer build tool**
- ✅ All user-facing deal-breakers eliminated
- ⚠️ Still recommends current approach for **maintainer experience** reasons

### 11.2 The Real Question

**Not:** "Should users install CACE?" → **NO** (correctly rejected)

**Actually:** "Should maintainers use CACE for builds?" → **NO, but it's close**

**Why NO:**

1. Toolkit is agent-agnostic (not Claude-centric)
2. Workflows don't use advanced features (simple prose)
3. Python generator is simple, proven, controllable
4. CACE doesn't provide compelling advantages
5. Loss of customization control is significant

**Why it's CLOSE:**

1. Build-time CACE is technically sound
2. No user-facing downsides
3. CACE quality is good
4. Internal tool (you control it)
5. Could simplify if workflows become complex

### 11.3 Final Recommendation

**Short-term (Now):** ✅ **Keep Python generator** ✅ **Add CACE validation**
(optional, CI-only) ✅ **Add semantic metadata** (align with ComponentSpec) ✅
**Document decision** (this ADR)

**Medium-term (6 months):** ⚠️ **Re-evaluate** if conditions change:

- Workflows evolve to use advanced features
- New agents added frequently
- Generator becomes complex/unmaintainable
- CACE quality improvements significant

**Long-term (12+ months):** 💡 **Consider build-time CACE** if toolkit mission
shifts to Claude-primary

---

## 12. Decision Record

**Date:** 2026-01-26

**Decision:** Maintain current Python generator, enhance with CACE validation

**Rationale:**

1. Agent-agnostic philosophy preserved
2. Maintainer simplicity/control maintained
3. CACE benefits captured via validation
4. Users completely unaffected
5. Reversible decision (can adopt CACE later)

**Alternatives Considered:**

- ❌ Build-time CACE (Claude source) - Rejected for philosophical mismatch
- ❌ Runtime user CACE - Correctly rejected in OPTION-D-ANALYSIS.md
- ✅ Hybrid (Python + CACE validation) - Recommended

**Success Criteria (6 months):**

- Generator remains simple (<300 lines)
- CACE validation catches issues
- Semantic metadata adopted
- No maintainer complaints about workflow

**Re-evaluation Triggers:**

- Workflows use advanced features (hooks/forks)
- 5+ new agents added
- Generator exceeds 500 lines
- CACE quality significantly better

---

## Document Metadata

**Author:** Claude Sonnet 4.5 (corrected analysis) **Date:** 2026-01-26
**Version:** 2.0 **Status:** Final Recommendation **Confidence:** 95% (corrected
understanding)

**Evidence Base:**

- Corrected architectural understanding (build-time vs runtime)
- 196-line Python generator analysis
- 48-workflow usage analysis (69% unused Claude features)
- Toolkit mission analysis (agent-agnostic)
- CACE 0.2.0 internal tool capabilities

**Key Insight:** Build-time CACE eliminates ALL user-facing deal-breakers but
introduces maintainer complexity without compelling advantages for current use
case.

**Next Steps:**

1. Implement Option C enhancements (CACE validation)
2. Add semantic metadata to deep-tools.json
3. Monitor for triggers (advanced features, new agents)
4. Re-evaluate in 6 months
