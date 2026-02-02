# Examples & Recipes

> **Quick Start:** Copy-paste these recipes into your AI agent (Claude Code, Windsurf, Cursor, OpenCode) after installing Agent Deep Toolkit.

## 🚀 Quick Wins (5 minutes each)

### 1. Strategic Feature Planning

**Goal:** Plan a new feature from concept to implementation.

```bash
# Step 1: Think deeply about the problem
/think "We need real-time notifications for user mentions. What are the architectural approaches?"

# Step 2: Design the system
/architect "Design a scalable pub/sub notification system. Consider WebSockets vs SSE vs polling."

# Step 3: Write specification
/spec "Write an ADR for notification architecture. Include decision criteria and trade-offs."

# Step 4: Plan implementation
/plan "Break notification system into shippable increments"
```

**Expected outcome:** ADR document, implementation roadmap, risk analysis.

---

### 2. Debugging Production Issues

**Goal:** Systematically diagnose and fix a production bug.

```bash
# Step 1: Investigate root cause
/investigate "API latency increased 300% after v2.3 deploy. Logs show database query timeouts."

# Step 2: Check observability
/observe "What metrics should we examine? Set up query performance monitoring."

# Step 3: Create postmortem
/incident "Generate postmortem template for latency incident"

# Step 4: Implement fix
/code "Optimize UserQuery with proper indexing and query caching"
```

**Expected outcome:** Root cause identified, fix implemented, postmortem ready.

---

### 3. Code Quality Improvement

**Goal:** Elevate codebase quality before releasing.

```bash
# Step 1: Review code structure
/review "Analyze src/auth/ for SOLID violations and security issues"

# Step 2: Refactor problematic areas
/refactor "Apply SOLID principles to UserService. Extract interfaces, reduce coupling."

# Step 3: Add test coverage
/test "Add missing test coverage for authentication flows. Target 80% branch coverage."

# Step 4: Final polish
/polish "Final quality pass on auth module before v3.0 release"
```

**Expected outcome:** Refactored code, comprehensive tests, production-ready quality.

---

### 4. Rapid Prototyping

**Goal:** Go from idea to working prototype in one session.

```bash
# Step 1: Generate ideas
/brainstorm "How can we reduce onboarding friction? Generate 10 alternative approaches."

# Step 2: Design experiment
/experiment "Design A/B test for simplified signup flow (email-only vs full profile)"

# Step 3: Implement MVP
/code "Implement MVP of email-only signup with deferred profile creation"

# Step 4: Break into iterations
/iterate "Break signup redesign into 3 shippable increments with verification steps"
```

**Expected outcome:** Working prototype, experiment design, iterative delivery plan.

---

## 🔥 Advanced Patterns

### Autonomous Execution (Ralph Loop)

**The `/loop` skill enables autonomous multi-hour work.** The agent breaks down your request, executes each step, verifies completion, and continues until done.

```bash
# Single command for complete implementation
/loop "Implement user authentication with OAuth2, JWT tokens, refresh logic, complete test suite, and API documentation"
```

**What happens:**
1. Agent decomposes into subtasks (OAuth setup, JWT generation, refresh endpoint, tests, docs)
2. Executes each autonomously using other skills (`/code`, `/test`, `/document`)
3. Verifies each step before proceeding
4. Reports progress and asks for input only when blocked
5. Continues until all acceptance criteria met

**Use cases:**
- Implementing entire features end-to-end
- Migrating systems (e.g., "Migrate from REST to GraphQL")
- Comprehensive refactoring projects

**Tips:**
- Provide clear acceptance criteria upfront
- Let it run for 30-60 minutes without interruption
- Review intermediate commits periodically

---

### Compound Workflows (Skill Chaining)

Chain skills together for complex workflows:

```bash
# Research → Design → Implement → Document
/think "What's the best approach for real-time collaboration?" && \
/architect "Design CRDT-based collaborative editing system" && \
/code "Implement Yjs integration with React" && \
/document "Write integration guide for collaborative editing"
```

**Platform-specific syntax:**
- **Claude Code:** Use `&&` or describe multi-step in one message
- **Windsurf:** Skills auto-chain based on context
- **Cursor:** Chain commands with `Cmd+K` repeatedly
- **OpenCode:** Use subtask mode to decompose

---

### Iterative Refinement Loop

Progressively improve code through cycles:

```bash
# Iteration 1: Basic implementation
/code "Implement user search with basic text matching"

# Iteration 2: Optimize
/optimize "Add full-text search with relevance ranking"

# Iteration 3: Refine
/simplify "Reduce search complexity. Extract SearchService."

# Iteration 4: Polish
/polish "Final pass: error handling, edge cases, performance"
```

---

### Multi-Perspective Analysis

Use reasoning skills together for comprehensive understanding:

```bash
# Initial exploration
/explore "Understand the caching layer architecture in src/cache/"

# Deep analysis
/think "What are the failure modes of this caching strategy?"

# Decision-making
/decide "Should we use Redis or Memcached? Consider latency, persistence, and cost."

# Verification
/investigate "Why is cache hit rate only 45%? Expected 80%+."
```

---

## 🛠️ Integration Examples

### CI/CD Pipeline Integration

**Goal:** Automated code quality checks in GitHub Actions.

```yaml
# .github/workflows/code-quality.yml
name: Code Quality
on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Agent Deep Toolkit
        run: |
          curl -fsSL https://raw.githubusercontent.com/AIntelligentTech/agent-deep-toolkit/main/install.sh | bash
          
      - name: Code Review
        run: |
          claude-agent "/review src/ --output review.md"
          
      - name: Security Audit
        run: |
          claude-agent "/audit --security --output security-report.md"
          
      - name: Upload Reports
        uses: actions/upload-artifact@v3
        with:
          name: quality-reports
          path: |
            review.md
            security-report.md
```

---

### Pre-commit Hook

**Goal:** Prevent low-quality commits.

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Install: chmod +x .git/hooks/pre-commit

echo "Running pre-commit quality checks..."

# Security scan
claude-agent "/audit --security --fast" || {
  echo "❌ Security issues detected. Fix before committing."
  exit 1
}

# Dependency check
claude-agent "/dependency --check-vulnerabilities" || {
  echo "⚠️  Vulnerable dependencies detected. Review before committing."
  # Don't block commit, just warn
}

echo "✅ Pre-commit checks passed"
```

---

### Pre-release Quality Gate

**Goal:** Final quality validation before shipping.

```bash
#!/bin/bash
# scripts/pre-release-check.sh

VERSION=$1

echo "🚀 Pre-release quality check for v$VERSION"

# Comprehensive review
claude-agent "/review . --comprehensive"

# Test coverage check
claude-agent "/test --coverage 80 --report coverage-report.md"

# Performance benchmarks
claude-agent "/benchmark --compare v$(($VERSION - 1))"

# Documentation completeness
claude-agent "/document --verify-complete"

# Security audit
claude-agent "/threat --full-scan"

echo "✅ Release candidate v$VERSION ready"
```

---

### Documentation Generation

**Goal:** Auto-generate comprehensive docs.

```bash
# Generate API docs
/document "Analyze src/api/ and generate OpenAPI spec with examples"

# Generate architecture docs
/architect "Document system architecture with C4 diagrams for docs/architecture/"

# Generate onboarding guide
/onboard "Create developer onboarding guide. Include setup, architecture, and first contribution."
```

---

## 📱 Platform-Specific Tips

### Claude Code

**Slash Commands:** Type `/` in chat to see all available skills.

```bash
# Basic invocation
/think "How should I architect this microservice?"

# With context
/review src/auth/ --focus security

# Autonomous mode
/loop "Implement feature X end-to-end"
```

**Pro Tips:**
- Skills are context-aware—reference files in your conversation
- Use `/index` to explore all available workflows
- Combine with filesystem tools: `/code "Fix bug in src/auth.ts" && /test`

---

### Windsurf Cascade

**Auto-execution:** Skills trigger contextually based on your work.

```text
# Editing auth.ts
→ Windsurf auto-suggests /security and /test

# Writing docs
→ Windsurf auto-suggests /document and /onboard
```

**Manual Invocation:** Type `/` in chat.

**Pro Tips:**
- Set `auto_execution_mode: 2` for proactive suggestions
- Skills work seamlessly with Cascade's flow state
- Use workflows for multi-step tasks

---

### Cursor

**Command Palette:** `Cmd+K` (Mac) or `Ctrl+K` (Windows/Linux)

```text
# Type command name
think <Enter>

# Or use alias
reason <Enter>
```

**Rules:** Skills apply contextually via `.cursor/rules/*.mdc`

**Pro Tips:**
- Commands integrate with Cursor's inline editing
- Rules auto-activate based on file globs
- Chain commands: `Cmd+K` → `think` → `Cmd+K` → `code`

---

### OpenCode

**Commands:** Type `/` in chat or use command palette.

```bash
# Parametric invocation
/think "arguments here"

# Subtask mode (breaks down into smaller steps)
/code --subtask "Implement OAuth2 flow"
```

**Pro Tips:**
- Commands support `$ARGUMENTS` for dynamic input
- `agent` and `model` metadata enables intelligent routing
- Subtask mode ideal for complex implementations

---

## 🎯 Real-World Scenarios

### Scenario 1: Onboarding to a New Codebase

```bash
# Day 1: Understand structure
/explore "Map out the architecture of this project. What are the main components?"

# Day 1: Inventory tech stack
/inventory "List all dependencies, frameworks, and services used"

# Day 2: Deep dive on critical path
/think "How does user authentication work end-to-end?"

# Day 2: Find improvement opportunities
/review "Identify technical debt and improvement opportunities in src/"

# Day 3: Make first contribution
/code "Implement feature X based on my understanding"
```

---

### Scenario 2: Performance Crisis

```bash
# T+0: Immediate investigation
/investigate "Response time increased from 200ms to 3s. Database CPU at 95%."

# T+5min: Observability setup
/observe "Set up query performance monitoring. Identify slow queries."

# T+15min: Quick fix
/optimize "Add database indexes for User.email and Post.created_at"

# T+30min: Benchmark improvements
/benchmark "Compare response times before and after indexing"

# T+60min: Postmortem
/incident "Create postmortem for performance incident. Include timeline and prevention."
```

---

### Scenario 3: Security Audit

```bash
# Step 1: Threat modeling
/threat "Threat model for user authentication system. Consider OWASP Top 10 2025."

# Step 2: Code audit
/audit "Security audit of src/auth/. Check for SQL injection, XSS, CSRF."

# Step 3: Dependency scan
/dependency "Check for vulnerable dependencies. Upgrade critical CVEs."

# Step 4: Compliance check
/compliance "Verify GDPR compliance for user data handling"
```

---

### Scenario 4: Feature Estimation

```bash
# Step 1: Understand scope
/explore "Real-time notification system requirements"

# Step 2: Break down
/plan "Break notification system into tasks with dependencies"

# Step 3: Estimate effort
/estimate "Size each task (XS/S/M/L/XL). Consider unknowns."

# Step 4: Impact analysis
/impact "What systems are affected by adding notifications?"
```

---

## 🧪 Experimental Features

### Multi-Agent Collaboration (Claude Code)

Use sub-agents for parallel work:

```bash
# Spawn specialized agents for different tasks
/loop "Agent 1: Implement frontend" &
/loop "Agent 2: Implement backend API" &
/loop "Agent 3: Write integration tests" &

# Main agent coordinates and integrates
/integrate "Coordinate frontend, backend, and test implementations"
```

---

### Relentless Mode (High-Stakes Work)

For critical work where you need maximum depth:

```bash
/relentless "Architectural review for Series A fundraising. Must be flawless."
```

**What it does:**
- 3x thinking depth
- Multiple verification passes
- Exhaustive edge case analysis
- Triple-checked logic

**Use sparingly—expensive in time and compute.**

---

## 📚 Recipe Collections

### The "New Feature" Recipe
1. `/think` → Problem analysis
2. `/architect` → System design
3. `/spec` → Write ADR
4. `/code` → Implement
5. `/test` → Validate
6. `/document` → User guide

---

### The "Bug Fix" Recipe
1. `/investigate` → Root cause
2. `/debug` → Isolate issue
3. `/code` → Fix implementation
4. `/test` → Regression tests
5. `/incident` → Postmortem (if production)

---

### The "Refactor" Recipe
1. `/review` → Identify issues
2. `/think` → Plan approach
3. `/refactor` → Transform code
4. `/test` → Verify behavior preserved
5. `/simplify` → Remove complexity

---

### The "Launch" Recipe
1. `/audit` → Final review
2. `/benchmark` → Performance check
3. `/threat` → Security scan
4. `/document` → Release notes
5. `/deploy` → Rollout strategy

---

## 💡 Pro Tips

1. **Start broad, then narrow:** `/explore` before `/code`
2. **Verify before shipping:** `/test` + `/review` + `/audit`
3. **Document as you go:** `/document` after each feature
4. **Use `/loop` for flow state:** Let the agent work autonomously
5. **Chain complementary skills:** `/think` + `/decide` for hard choices
6. **Leverage aliases:** `/fix` is faster to type than `/debug`

---

## 🆘 Troubleshooting

**Skill not found?**
- Check installation: `~/.claude/skills/` or `.windsurf/workflows/`
- Verify agent supports skills (Claude Code 2.1+, Windsurf Cascade)
- Reinstall: `./install.sh --agent <name> --force`

**Skill not working as expected?**
- Read full skill definition: `cat ~/.claude/skills/think/SKILL.md`
- Check activation mode (some skills are contextual, not manual)
- Review ARCHITECTURE.md for platform differences

**Want to customize a skill?**
- Fork agent-deep-toolkit
- Edit `skills/<name>/SKILL.md`
- Rebuild: `./bin/build-all-agents`
- Reinstall: `./install.sh --agent all --force`

---

**Have a great recipe?** Contribute via PR to expand this guide!
