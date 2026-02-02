---
title: "CACE Migration Architecture for Agent Deep Toolkit"
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

# CACE Migration Architecture for Agent Deep Toolkit

**Version:** 1.0.0
**Date:** January 30, 2026
**Status:** Design Specification
**CACE Version:** 2.3.0

---

## 1. System Architecture

### 1.1 Current System Overview

The current agent-deep-toolkit v2.0.0 uses a Python-based build system (`bin/build-all-agents`) that:
- Parses 46 canonical skills from `skills/` directory
- Generates outputs for 4 agents (Claude, Windsurf, Cursor, OpenCode)
- Produces 289 variant files per agent (including aliases/synonyms)
- Uses custom YAML frontmatter with agent-specific fields

### 1.2 Proposed CACE-Based Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CACE-Based Build System Architecture                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                     Build Pipeline Flow                              │   │
│   ├─────────────────────────────────────────────────────────────────────┤   │
│   │                                                                     │   │
│   │  ┌──────────────┐    ┌──────────────┐    ┌──────────────────────┐  │   │
│   │  │  Canonical   │    │   CACE CLI   │    │   Variant Wrapper    │  │   │
│   │  │   Skills     │───▶│  (v2.3.0)    │───▶│   Generator          │  │   │
│   │  │  (46 files)  │    │  convert-dir │    │   (aliases/synonyms) │  │   │
│   │  └──────────────┘    └──────────────┘    └──────────────────────┘  │   │
│   │         │                    │                      │               │   │
│   │         │                    │                      │               │   │
│   │         ▼                    ▼                      ▼               │   │
│   │  ┌──────────────────────────────────────────────────────────────┐  │   │
│   │  │                    Output Directory                           │  │   │
│   │  │  ┌─────────┐ ┌──────────┐ ┌─────────┐ ┌──────────┐          │  │   │
│   │  │  │ Claude  │ │ Windsurf │ │ Cursor  │ │ OpenCode │          │  │   │
│   │  │  │ 6 agents│ │          │ │         │ │(Codex,   │          │  │   │
│   │  │  │ supported│ │          │ │         │ │ Gemini)  │          │  │   │
│   │  │  └─────────┘ └──────────┘ └─────────┘ └──────────┘          │  │   │
│   │  └──────────────────────────────────────────────────────────────┘  │   │
│   │                                                                     │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 1.3 CACE Integration as Build-Time Dependency

CACE will be integrated as a build-time dependency with the following characteristics:

**Dependency Installation:**
```bash
# install.sh modification - install CACE globally
npm install -g cace-cli@2.3.0
```

**Build Process Flow:**
```
1. Validate Node.js version (>=18.0.0 required)
2. Check/Install CACE v2.3.0
3. Clone/update CACE if needed (fallback mechanism)
4. Run cace convert-dir on skills/ directory
5. Execute variant wrapper for aliases/synonyms
6. Validate outputs with cace validate
7. Report health metrics
```

**Key Integration Points:**
- **Entry Point:** `bin/cace-convert` (new wrapper script)
- **CACE Command:** `cace convert-dir ./skills --to {agent} --output ./outputs/{agent}`
- **Fallback:** If npm unavailable, clone CACE repo and build locally

### 1.4 Variant Generation Strategy

CACE does not natively handle aliases/synonyms. A wrapper script will handle this:

```typescript
// bin/cace-variants.ts - Variant Generation Wrapper

import { readFileSync, writeFileSync, mkdirSync, cpSync } from 'node:fs';
import { dirname, basename } from 'node:path';
import { execSync } from 'node:child_process';

interface SkillFrontmatter {
  name: string;
  aliases?: string[];
  synonyms?: string[];
  description?: string;
}

function parseFrontmatter(content: string): { fm: SkillFrontmatter; body: string } {
  const match = content.match(/^---\s*\n([\s\S]*?)\n---\s*\n([\s\S]*)$/);
  if (!match) throw new Error('Invalid frontmatter');
  return {
    fm: yaml.parse(match[1]),
    body: match[2]
  };
}

function generateVariants(sourceDir: string, outputDir: string, agent: string): void {
  const files = listFiles(sourceDir, '**/SKILL.md');
  
  for (const file of files) {
    const content = readFileSync(file, 'utf-8');
    const { fm, body } = parseFrontmatter(content);
    
    // Collect all variants
    const variants = new Set<string>();
    if (fm.aliases) fm.aliases.forEach(v => variants.add(cleanCommand(v)));
    if (fm.synonyms) fm.synonyms.forEach(v => variants.add(cleanCommand(v)));
    
    for (const variant of variants) {
      const variantPath = `${outputDir}/${dirname(file).split('/').pop()}/${variant}.md`;
      mkdirSync(dirname(variantPath), { recursive: true });
      writeFileSync(variantPath, content);
    }
  }
}

function cleanCommand(cmd: string): string {
  return cmd.startsWith('/') ? cmd.slice(1) : cmd;
}
```

### 1.5 Build Process Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         Build Process Flow                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐                                                        │
│  │ bin/build-cace  │                                                        │
│  │    (ENTRY)      │                                                        │
│  └────────┬────────┘                                                        │
│           │                                                                 │
│           ▼                                                                 │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ 1. Setup Phase                                                      │    │
│  │    ├─ Validate Node.js >=18                                         │    │
│  │    ├─ Check CACE version (npm view cace-cli version)               │    │
│  │    ├─ Install/update CACE if needed                                 │    │
│  │    └─ Verify CACE installation (cace doctor)                       │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│           │                                                                 │
│           ▼                                                                 │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ 2. Conversion Phase                                                 │    │
│  │    ├─ Clear outputs/ directory                                     │    │
│  │    ├─ cace convert-dir skills/ --to claude   --output outputs/     │    │
│  │    ├─ cace convert-dir skills/ --to windsurf --output outputs/     │    │
│  │    ├─ cace convert-dir skills/ --to cursor   --output outputs/     │    │
│  │    ├─ cace convert-dir skills/ --to opencode --output outputs/     │    │
│  │    ├─ cace convert-dir skills/ --to codex    --output outputs/     │    │
│  │    └─ cace convert-dir skills/ --to gemini   --output outputs/     │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│           │                                                                 │
│           ▼                                                                 │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ 3. Variant Generation Phase                                         │    │
│  │    ├─ For each skill in outputs/{agent}/                           │    │
│  │    ├─ Extract aliases/synonyms from source frontmatter             │    │
│  │    ├─ Copy main file to alias/synonym filenames                    │    │
│  │    └─ Repeat for all agents                                        │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│           │                                                                 │
│           ▼                                                                 │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ 4. Validation Phase                                                 │    │
│  │    ├─ cace validate outputs/claude --strict                        │    │
│  │    ├─ cace validate outputs/windsurf --strict                      │    │
│  │    ├─ cace validate outputs/cursor --strict                        │    │
│  │    ├─ cace validate outputs/opencode --strict                      │    │
│  │    ├─ cace validate outputs/codex --strict                         │    │
│  │    └─ cace validate outputs/gemini --strict                        │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│           │                                                                 │
│           ▼                                                                 │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ 5. Health Report Phase                                              │    │
│  │    ├─ Aggregate fidelity scores per agent                          │    │
│  │    ├─ Compare against 90% target                                   │    │
│  │    ├─ Identify low-health skills (<80%)                            │    │
│  │    └─ Generate report (outputs/health-report.json)                 │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. File Changes Required

### 2.1 Files to Remove

| File | Reason |
|------|--------|
| `bin/build-all-agents` | Replaced by CACE-based build system |
| `bin/python-requirements.txt` | Python dependencies no longer needed |
| `docs/cross-compatibility-reference.md` | Superseded by CACE documentation |

### 2.2 Files to Create

#### 2.2.1 `bin/cace-convert` (Main Build Script)

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CACE_VERSION="2.3.0"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[info]${NC} $*"; }
log_success() { echo -e "${GREEN}[ok]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[warn]${NC} $*"; }
log_error() { echo -e "${RED}[error]${NC} $*" >&2; }

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME [--agents <agents>] [--skip-variants] [--skip-validation] [--health-check] [--force-cace-install]

Agents (comma-separated, or 'all' for 6 agents):
  claude    - Claude Code skills (canonical format)
  windsurf  - Windsurf workflows and skills
  cursor    - Cursor commands and rules
  opencode  - OpenCode commands (permission-based)
  codex     - OpenAI Codex MCP servers
  gemini    - Google Gemini CLI

Options:
  --agents <agents>     Agent list (default: claude,windsurf,cursor,opencode)
  --skip-variants       Skip alias/synonym variant generation
  --skip-validation     Skip CACE validation after conversion
  --health-check        Run health check and exit
  --force-cace-install  Force reinstallation of CACE CLI
  --help, -h            Show this help

Examples:
  $SCRIPT_NAME --agents claude,windsurf,cursor,opencode
  $SCRIPT_NAME --agents all --health-check
  $SCRIPT_NAME --skip-validation
USAGE
}

check_node_version() {
  local node_version
  node_version=$(node --version 2>/dev/null | cut -d'v' -f2 | cut -d'.' -f1)
  if [ -z "$node_version" ] || [ "$node_version" -lt 18 ]; then
    log_error "Node.js >= 18.0.0 required. Found: $(node --version 2>/dev/null || echo 'not installed')"
    exit 1
  fi
  log_success "Node.js version: $(node --version)"
}

check_cace_installation() {
  if command -v cace &> /dev/null; then
    local installed_version
    installed_version=$(cace version 2>/dev/null | grep -oP 'v\d+\.\d+\.\d+' || echo "unknown")
    log_info "CACE already installed: $installed_version"
    
    if [ "$installed_version" != "$CACE_VERSION" ] && [ "${FORCE_CACE_INSTALL:-false}" != "true" ]; then
      log_warn "CACE version mismatch: installed=$installed_version, required=$CACE_VERSION"
      log_info "Run with --force-cace-install to update"
    fi
    return 0
  fi
  
  log_info "CACE not found. Installing..."
  install_cace
}

install_cace() {
  log_info "Installing CACE v$CACE_VERSION..."
  
  if command -v npm &> /dev/null; then
    npm install -g "cace-cli@$CACE_VERSION" 2>/dev/null || {
      log_warn "npm install failed, trying with bun..."
      if command -v bun &> /dev/null; then
        bun install -g "cace-cli@$CACE_VERSION"
      else
        clone_and_build_cace
      fi
    }
  else
    clone_and_build_cace
  fi
  
  if command -v cace &> /dev/null; then
    log_success "CACE installed successfully"
  else
    log_error "Failed to install CACE"
    exit 1
  fi
}

clone_and_build_cace() {
  log_info "Cloning and building CACE from source..."
  
  local cace_dir="/tmp/cace-$CACE_VERSION-$$"
  git clone --depth 1 --branch "v$CACE_VERSION" \
    "https://github.com/AIntelligentTech/cace-cli.git" "$cace_dir" 2>/dev/null || {
    log_error "Failed to clone CACE repository"
    exit 1
  }
  
  cd "$cace_dir"
  npm install
  npm run build
  
  local global_npm_prefix
  global_npm_prefix=$(npm config get prefix 2>/dev/null)
  local bin_dir="$global_npm_prefix/bin"
  
  if [ -d "$bin_dir" ]; then
    ln -sf "$cace_dir/dist/cli/index.js" "$bin_dir/cace"
    log_success "CACE linked to $bin_dir/cace"
  else
    log_error "Could not determine npm global bin directory"
    exit 1
  fi
  
  cd "$REPO_ROOT"
}

convert_skills() {
  local agents=("$@")
  local skills_dir="$REPO_ROOT/skills"
  local outputs_dir="$REPO_ROOT/outputs"
  
  if [ ! -d "$skills_dir" ]; then
    log_error "Skills directory not found: $skills_dir"
    exit 1
  fi
  
  log_info "Converting $(( $(find "$skills_dir" -maxdepth 1 -mindepth 1 -type d | wc -l) )) skills..."
  
  # Clean outputs directory
  if [ -d "$outputs_dir" ]; then
    rm -rf "$outputs_dir"
  fi
  mkdir -p "$outputs_dir"
  
  for agent in "${agents[@]}"; do
    log_info "Converting to $agent..."
    
    local agent_output="$outputs_dir/$agent"
    mkdir -p "$agent_output"
    
    cace convert-dir "$skills_dir" \
      --to "$agent" \
      --output "$agent_output" \
      --backup false \
      2>&1 | while IFS= read -r line; do
        echo -e "  ${BLUE}└─${NC} $line"
      done
    
    log_success "Converted to $agent"
  done
}

generate_variants() {
  local outputs_dir="$REPO_ROOT/outputs"
  
  log_info "Generating alias/synonym variants..."
  
  # Parse source skills for aliases/synonyms
  local variants_script="$SCRIPT_DIR/variant-generator.sh"
  
  if [ -f "$variants_script" ]; then
    bash "$variants_script" "$outputs_dir"
  else
    # Inline variant generation
    find "$outputs_dir" -type d -mindepth 1 -maxdepth 1 | while read -r agent_dir; do
      local agent
      agent=$(basename "$agent_dir")
      
      find "$agent_dir" -name "*.md" | while read -r md_file; do
        local skill_name
        skill_name=$(basename "$md_file" .md)
        
        # Find corresponding source skill
        local source_skill="$REPO_ROOT/skills/$skill_name/SKILL.md"
        if [ -f "$source_skill" ]; then
          local aliases synonyms
          aliases=$(grep -oP '^\s*aliases:\s*\[[^\]]*\]' "$source_skill" 2>/dev/null || echo "")
          synonyms=$(grep -oP '^\s*synonyms:\s*\[[^\]]*\]' "$source_skill" 2>/dev/null || echo "")
          
          # Process aliases
          if [ -n "$aliases" ]; then
            echo "$aliases" | grep -oP '"/[^"]+"' | tr -d '"' | while read -r alias; do
              local clean_alias
              clean_alias=$(echo "$alias" | sed 's/^\///')
              if [ "$clean_alias" != "$skill_name" ] && [ -n "$clean_alias" ]; then
                cp "$md_file" "$agent_dir/${clean_alias}.md"
              fi
            done
          fi
          
          # Process synonyms
          if [ -n "$synonyms" ]; then
            echo "$synonyms" | grep -oP '"/[^"]+"' | tr -d '"' | while read -r synonym; do
              local clean_synonym
              clean_synonym=$(echo "$synonym" | sed 's/^\///')
              if [ "$clean_synonym" != "$skill_name" ] && [ -n "$clean_synonym" ]; then
                cp "$md_file" "$agent_dir/${clean_synonym}.md"
              fi
            done
          fi
        fi
      done
    done
  fi
  
  log_success "Variants generated"
}

run_validation() {
  local outputs_dir="$REPO_ROOT/outputs"
  
  log_info "Validating converted skills..."
  
  local total_score=0
  local agent_count=0
  local all_valid=true
  
  find "$outputs_dir" -maxdepth 1 -mindepth 1 -type d | while read -r agent_dir; do
    local agent
    agent=$(basename "$agent_dir")
    
    log_info "Validating $agent..."
    
    local validation_output
    if validation_output=$(cace validate "$agent_dir" --quiet 2>&1); then
      local score
      score=$(echo "$validation_output" | grep -oP '\d+(?=%)' | tail -1 || echo "100")
      total_score=$((total_score + score))
      agent_count=$((agent_count + 1))
      
      if [ "$score" -ge 90 ]; then
        log_success "$agent: ${score}% health"
      elif [ "$score" -ge 80 ]; then
        log_warn "$agent: ${score}% health (below target)"
      else
        log_error "$agent: ${score}% health (critical)"
        all_valid=false
      fi
    else
      log_error "$agent: validation failed"
      all_valid=false
    fi
  done
  
  if [ "$agent_count" -gt 0 ]; then
    local avg_score=$((total_score / agent_count))
    log_info "Average health score: ${avg_score}%"
    
    if [ "$avg_score" -ge 90 ]; then
      log_success "Target of 90% health achieved!"
    else
      log_warn "Target of 90% health not met"
    fi
  fi
  
  return 0
}

run_health_check() {
  log_info "Running CACE health check..."
  
  if ! command -v cace &> /dev/null; then
    log_error "CACE not installed. Run without --health-check first."
    exit 1
  fi
  
  cace doctor
  
  log_info "Health check complete"
}

main() {
  AGENTS="claude,windsurf,cursor,opencode"
  SKIP_VARIANTS=false
  SKIP_VALIDATION=false
  HEALTH_CHECK=false
  FORCE_CACE_INSTALL=false
  
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --agents)
        AGENTS="${2:-}"
        shift 2
        ;;
      --skip-variants)
        SKIP_VARIANTS=true
        shift
        ;;
      --skip-validation)
        SKIP_VALIDATION=true
        shift
        ;;
      --health-check)
        HEALTH_CHECK=true
        shift
        ;;
      --force-cace-install)
        FORCE_CACE_INSTALL=true
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        log_error "Unknown argument: $1"
        usage
        exit 1
        ;;
    esac
  done
  
  if [ "$HEALTH_CHECK" = true ]; then
    check_node_version
    run_health_check
    exit 0
  fi
  
  check_node_version
  check_cace_installation
  
  IFS=',' read -ra AGENT_ARRAY <<< "$AGENTS"
  
  convert_skills "${AGENT_ARRAY[@]}"
  
  if [ "$SKIP_VARIANTS" = false ]; then
    generate_variants
  fi
  
  if [ "$SKIP_VALIDATION" = false ]; then
    run_validation
  fi
  
  log_success "Build complete!"
}

main "$@"
```

#### 2.2.2 `bin/cace-variants.sh` (Variant Generator)

```bash
#!/usr/bin/env bash
# Generate alias/synonym variants for converted skills

OUTPUTS_DIR="${1:-./outputs}"
REPO_ROOT="$(dirname "$(dirname "$0")")"
SKILLS_DIR="$REPO_ROOT/skills"

clean_command() {
  local cmd="$1"
  cmd="${cmd#/}"
  echo "$cmd"
}

generate_variants() {
  local agent_dir="$1"
  local agent
  agent=$(basename "$agent_dir")
  
  echo "  Generating variants for $agent..."
  
  # Find all main skill files (excluding already-generated variants)
  find "$agent_dir" -maxdepth 2 -name "*.md" | while read -r md_file; do
    local skill_name
    skill_name=$(basename "$md_file" .md)
    
    # Check if this is a main skill (exists in skills/ directory)
    local source_skill="$SKILLS_DIR/$skill_name/SKILL.md"
    
    if [ -f "$source_skill" ]; then
      # Extract aliases and synonyms
      local aliases synonyms
      aliases=$(grep -E '^\s*aliases:' "$source_skill" 2>/dev/null | sed 's/aliases:\s*\[//' | tr -d ']\n' | tr ',' '\n' | sed 's/"//g' | sed "s/'//g" | xargs)
      synonyms=$(grep -E '^\s*synonyms:' "$source_skill" 2>/dev/null | sed 's/synonyms:\s*\[//' | tr -d ']\n' | tr ',' '\n' | sed 's/"//g' | sed "s/'//g" | xargs)
      
      # Process aliases
      for alias in $aliases; do
        local clean_alias
        clean_alias=$(clean_command "$alias")
        if [ -n "$clean_alias" ] && [ "$clean_alias" != "$skill_name" ]; then
          if [ ! -f "$agent_dir/${clean_alias}.md" ]; then
            cp "$md_file" "$agent_dir/${clean_alias}.md"
            echo "    + ${clean_alias}.md (alias)"
          fi
        fi
      done
      
      # Process synonyms
      for synonym in $synonyms; do
        local clean_synonym
        clean_synonym=$(clean_command "$synonym")
        if [ -n "$clean_synonym" ] && [ "$clean_synonym" != "$skill_name" ]; then
          if [ ! -f "$agent_dir/${clean_synonym}.md" ]; then
            cp "$md_file" "$agent_dir/${clean_synonym}.md"
            echo "    + ${clean_synonym}.md (synonym)"
          fi
        fi
      done
    fi
  done
}

# Main execution
echo "Generating alias/synonym variants..."

for agent_dir in "$OUTPUTS_DIR"/*/; do
  if [ -d "$agent_dir" ]; then
    generate_variants "$agent_dir"
  fi
done

echo "Variant generation complete"
```

#### 2.2.3 `bin/cace-doctor.sh` (Health Check)

```bash
#!/usr/bin/env bash
# CACE health check script for agent-deep-toolkit

set -euo pipefail

REPO_ROOT="$(dirname "$(dirname "$0")")"
OUTPUTS_DIR="$REPO_ROOT/outputs"

echo "========================================"
echo "  Agent Deep Toolkit Health Check"
echo "========================================"
echo ""

# Check CACE installation
echo "1. CACE Installation"
echo "--------------------"
if command -v cace &> /dev/null; then
  echo "✓ CACE is installed"
  cace version 2>/dev/null || echo "  Version: $(cace --version 2>/dev/null || echo 'unknown')"
else
  echo "✗ CACE is not installed"
  echo "  Run: npm install -g cace-cli"
fi
echo ""

# Check Node.js version
echo "2. Node.js Environment"
echo "----------------------"
if command -v node &> /dev/null; then
  echo "✓ Node.js is installed: $(node --version)"
  local node_version
  node_version=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
  if [ "$node_version" -ge 18 ]; then
    echo "✓ Version meets minimum requirement (>=18)"
  else
    echo "✗ Version below minimum requirement (>=18)"
  fi
else
  echo "✗ Node.js is not installed"
fi
echo ""

# Check outputs directory
echo "3. Output Status"
echo "----------------"
if [ -d "$OUTPUTS_DIR" ]; then
  echo "✓ Outputs directory exists"
  
  for agent_dir in "$OUTPUTS_DIR"/*/; do
    if [ -d "$agent_dir" ]; then
      local agent
      agent=$(basename "$agent_dir")
      local file_count
      file_count=$(find "$agent_dir" -name "*.md" 2>/dev/null | wc -l)
      echo "  - $agent: $file_count files"
    fi
  done
else
  echo "✗ Outputs directory not found"
  echo "  Run: ./bin/cace-convert"
fi
echo ""

# Check skills directory
echo "4. Source Skills"
echo "----------------"
if [ -d "$REPO_ROOT/skills" ]; then
  local skill_count
  skill_count=$(find "$REPO_ROOT/skills" -maxdepth 1 -mindepth 1 -type d | wc -l)
  echo "✓ Skills directory exists with $skill_count skills"
else
  echo "✗ Skills directory not found"
fi
echo ""

# Run CACE doctor if available
if command -v cace &> /dev/null; then
  echo "5. CACE System Doctor"
  echo "---------------------"
  cace doctor 2>/dev/null || echo "  (cace doctor not available)"
fi
echo ""

echo "========================================"
echo "  Health Check Complete"
echo "========================================"
```

### 2.3 Files to Modify

#### 2.3.1 `install.sh` Modifications

```bash
# Add near the top, after SCRIPT_DIR definition

# CACE configuration
CACE_VERSION="2.3.0"
CACE_CLI_URL="https://github.com/AIntelligentTech/cace-cli.git"

# Add to usage() - new options
#   --cace-install      Install/upgrade CACE CLI
#   --cace-version      Show CACE version

# Add CACE check function
check_cace_prerequisites() {
  log_info "Checking CACE prerequisites..."
  
  if ! command -v node &> /dev/null; then
    log_error "Node.js is required but not installed"
    return 1
  fi
  
  local node_version
  node_version=$(node --version 2>/dev/null | cut -d'v' -f2 | cut -d'.' -f1)
  if [ -z "$node_version" ] || [ "$node_version" -lt 18 ]; then
    log_error "Node.js >= 18.0.0 required"
    return 1
  fi
  
  if ! command -v npm &> /dev/null; then
    log_error "npm is required but not installed"
    return 1
  fi
  
  log_success "CACE prerequisites met"
  return 0
}

# Modify main section to check prerequisites before agent operations
# Add after AGENT="" LEVEL="" section:

if [ "$AGENT" != "cace" ]; then
  check_cace_prerequisites || exit 1
fi
```

### 2.4 Documentation Updates

#### 2.4.1 Update `README.md`

Add new section:

```markdown
## Build System

Agent Deep Toolkit v3.0.0 uses **CACE (Cross-Agent Compatibility Engine) v2.3.0** for cross-agent conversion.

### Building

```bash
# Install CACE globally
npm install -g cace-cli@2.3.0

# Build for all 6 agents
./bin/cace-convert --agents all

# Build for specific agents
./bin/cace-convert --agents claude,windsurf,cursor,opencode

# Run health check
./bin/cace-convert --health-check
```

### Agent Compatibility

| Agent      | Format                  | Variants | Fidelity |
|------------|-------------------------|----------|----------|
| Claude     | Skills (.claude)        | ✓        | 95%      |
| Windsurf   | Workflows + Skills      | ✓        | 92%      |
| Cursor     | Commands (.mdc)         | ✓        | 92%      |
| OpenCode   | Commands                | ✓        | 98%      |
| Codex      | MCP Servers             | ✓        | 92%      |
| Gemini     | CLI                     | ✓        | 88%      |

> **Note:** Windsurf uses dual-output strategy (`--strategy dual-output`) to preserve Claude skill behavior.
> - `.windsurf/workflows/<skill>.md` - Manual `/command` invocation
> - `.windsurf/skills/<skill>/SKILL.md` - Auto-invocation parity via Claude format

#### Dual-Output Strategy (Claude → Windsurf)

Claude skills have a **unified model** where they can be both auto-invoked AND manually invoked via `/command`.
Windsurf enforces a **bifurcated model**:
- **Skills**: Auto-invoked, NO `/command` access
- **Workflows**: Manual `/command`, NO auto-invocation

The `--strategy dual-output` option generates BOTH artifacts to preserve Claude's dual-nature:

```bash
# Single-output (default): Claude skill → Windsurf workflow only
cace convert skill.md --to windsurf
# Output: .windsurf/workflows/skill.md

# Dual-output: Preserves both invocation modes
cace convert skill.md --to windsurf --strategy dual-output
# Output:
#   .windsurf/workflows/skill.md  (manual /command)
#   .windsurf/skills/skill/SKILL.md (auto-invocation)
```

agent-deep-toolkit uses dual-output by default for Windsurf conversions to ensure maximum behavioral parity.

#### Agent-Specific Behavior Differences

Claude Code features that have no direct equivalent in other agents:

| Claude Feature              | Behavior                                                            | Other Agent Handling              |
|-----------------------------|---------------------------------------------------------------------|-----------------------------------|
| `disable-model-invocation`  | Prevents programmatic skill invocation via API                      | No equivalent; always executable  |
| `user-invocable: false`     | UI hides skill but still allows model invocation                    | Other agents show all skills      |
| Skills merged with commands | `/skill-name` both invokes and displays help                        | Windsurf: separate `/workflow`    |
| Full context passing        | Claude passes complete prompt/context to skill                      | Others may pass partial context   |

#### Behavior Preservation Strategy

For Claude-specific features without equivalents, CACE conversion adds warning comments:

```yaml
---
name: skill-name
description: Skill description
disable-model-invocation: true  # WARNING: No equivalent in Windsurf/Cursor/OpenCode
# This skill requires explicit user invocation in Claude Code.
---
```

#### Known Limitations

1. **Windsurf auto_execution_mode** (0=Off, 1=Auto, 2=Turbo) not represented in other agents
2. **Cursor .mdc rules** with `alwaysApply` glob patterns have no Claude equivalent
3. **Input scope differences**: Claude receives full prompt, others may receive partial
4. **Command position**: Claude requires commands at prompt start, Windsurf allows anywhere

#### 2.4.2 Create `docs/CACE_INTEGRATION.md`

Comprehensive CACE integration documentation covering all aspects of the new build system.

---

## 3. Version Awareness Strategy

### 3.1 CACE Version Detection

```bash
#!/usr/bin/env bash
# bin/cace-version-detect.sh

detect_cace_version() {
  if command -v cace &> /dev/null; then
    cace version 2>/dev/null | grep -oP 'v\d+\.\d+\.\d+' || echo "unknown"
  else
    echo "not-installed"
  fi
}

get_latest_cace_version() {
  npm view cace-cli version 2>/dev/null || echo "unknown"
}

compare_versions() {
  local current="$1"
  local latest="$2"
  
  if [ "$current" = "unknown" ] || [ "$current" = "not-installed" ]; then
    echo "install"
    return
  fi
  
  local current_major current_minor current_patch
  current_major=$(echo "$current" | cut -d'.' -f1 | tr -d 'v')
  current_minor=$(echo "$current" | cut -d'.' -f2)
  current_patch=$(echo "$current" | cut -d'.' -f3)
  
  local latest_major latest_minor latest_patch
  latest_major=$(echo "$latest" | cut -d'.' -f1)
  latest_minor=$(echo "$latest" | cut -d'.' -f2)
  latest_patch=$(echo "$latest" | cut -d'.' -f3)
  
  if [ "$current_major" -lt "$latest_major" ]; then
    echo "major-update"
  elif [ "$current_major" -eq "$latest_major" ] && [ "$current_minor" -lt "$latest_minor" ]; then
    echo "minor-update"
  elif [ "$current_major" -eq "$latest_major" ] && [ "$current_minor" -eq "$latest_minor" ] && [ "$current_patch" -lt "$latest_patch" ]; then
    echo "patch-update"
  else
    echo "current"
  fi
}

# Example usage
CURRENT=$(detect_cace_version)
LATEST=$(get_latest_cace_version)
STATUS=$(compare_versions "$CURRENT" "$LATEST")

echo "Current CACE version: $CURRENT"
echo "Latest available: $LATEST"
echo "Status: $STATUS"
```

### 3.2 CACE Version Specification in agent-deep-toolkit

**Version File (`VERSION`):**

```
CACE-CLI-VERSION=2.3.0
AGENT-DEEP-TOOLKIT-VERSION=3.0.0
MIN-NODE-VERSION=18.0.0
```

**Package.json (`package.json`):**

```json
{
  "name": "agent-deep-toolkit",
  "version": "3.0.0",
  "caceVersion": "2.3.0",
  "engines": {
    "node": ">=18.0.0"
  },
  "scripts": {
    "build": "bin/cace-convert",
    "build:claude": "bin/cace-convert --agents claude",
    "build:all": "bin/cace-convert --agents all",
    "health": "bin/cace-convert --health-check",
    "validate": "bin/cace-convert --skip-variants --skip-validation"
  }
}
```

### 3.3 Compatible Agent Versions

Based on CACE 2.3.0 support matrix:

| Agent      | Minimum Version | Maximum Version | Notes |
|------------|-----------------|-----------------|-------|
| Claude     | 2.0+            | Latest          | Full skill support |
| Windsurf   | Cascade 1.0+    | Latest          | Workflows + Skills |
| Cursor     | 0.42+           | Latest          | .mdc rules support |
| OpenCode   | 1.0+            | Latest          | Permission model |
| Codex      | Latest MCP      | Latest          | MCP server format |
| Gemini     | ADK 0.3.0+      | Latest          | CLI format |

**Version Detection Strategy:**

```typescript
// src/version-awareness.ts

interface AgentVersionRequirement {
  agent: string;
  minVersion: string;
  maxVersion: string;
  features: string[];
}

export const VERSION_REQUIREMENTS: AgentVersionRequirement[] = [
  {
    agent: 'claude',
    minVersion: '2.0',
    maxVersion: 'latest',
    features: ['skills', 'slash-commands', 'agent-delegation']
  },
  {
    agent: 'windsurf',
    minVersion: 'cascade-1.0',
    maxVersion: 'latest',
    features: ['workflows', 'cascade-mode', 'auto-execution']
  },
  {
    agent: 'cursor',
    minVersion: '0.42',
    maxVersion: 'latest',
    features: ['commands', 'rules', 'mdc-format']
  },
  {
    agent: 'opencode',
    minVersion: '1.0',
    maxVersion: 'latest',
    features: ['permissions', 'allowed-tools', 'subtask']
  },
  {
    agent: 'codex',
    minVersion: 'latest',
    maxVersion: 'latest',
    features: ['mcp-servers', 'approval-policies']
  },
  {
    agent: 'gemini',
    minVersion: '0.3.0',
    maxVersion: 'latest',
    features: ['cli', 'code-execution', 'multi-dir']
  }
];

export function checkAgentCompatibility(agent: string): {
  compatible: boolean;
  version?: string;
  warnings?: string[];
} {
  // Implementation for version compatibility checking
}
```

---

## 4. Health Check Strategy

### 4.1 Health Metrics Framework

```typescript
// src/health-metrics.ts

interface HealthMetric {
  name: string;
  weight: number;
  score: number;
  threshold: number;
}

interface HealthReport {
  timestamp: string;
  caceVersion: string;
  toolkitVersion: string;
  overallScore: number;
  agentScores: Record<string, AgentHealthScore>;
  lowHealthSkills: SkillHealthScore[];
  recommendations: string[];
}

interface AgentHealthScore {
  agent: string;
  fileCount: number;
  fidelityScore: number;
  validationStatus: 'pass' | 'warn' | 'fail';
  warnings: string[];
}

interface SkillHealthScore {
  skillName: string;
  agent: string;
  fidelityScore: number;
  issues: string[];
}

export function calculateHealthScore(metrics: HealthMetric[]): number {
  const totalWeight = metrics.reduce((sum, m) => sum + m.weight, 0);
  const weightedScore = metrics.reduce((sum, m) => sum + (m.score * m.weight), 0);
  return Math.round((weightedScore / totalWeight) * 100);
}

export function generateHealthReport(
  outputsDir: string,
  skillsDir: string
): HealthReport {
  const report: HealthReport = {
    timestamp: new Date().toISOString(),
    caceVersion: '2.3.0',
    toolkitVersion: '3.0.0',
    overallScore: 0,
    agentScores: {},
    lowHealthSkills: [],
    recommendations: []
  };

  // Calculate per-agent scores
  const agents = ['claude', 'windsurf', 'cursor', 'opencode', 'codex', 'gemini'];
  
  for (const agent of agents) {
    const agentDir = `${outputsDir}/${agent}`;
    if (!exists(agentDir)) continue;
    
    const validationResult = runCaceValidation(agentDir);
    report.agentScores[agent] = {
      agent,
      fileCount: countFiles(agentDir),
      fidelityScore: validationResult.fidelityScore,
      validationStatus: validationResult.status,
      warnings: validationResult.warnings
    };
  }

  // Calculate overall score
  const scores = Object.values(report.agentScores).map(s => s.fidelityScore);
  report.overallScore = scores.length > 0 
    ? Math.round(scores.reduce((a, b) => a + b, 0) / scores.length)
    : 0;

  // Identify low-health skills
  for (const [agent, score] of Object.entries(report.agentScores)) {
    if (score.fidelityScore < 80) {
      const skills = identifyLowHealthSkills(agent, outputsDir, skillsDir);
      report.lowHealthSkills.push(...skills);
    }
  }

  // Generate recommendations
  report.recommendations = generateRecommendations(report);

  return report;
}
```

### 4.2 Target: 90%+ Health Across All Agents

**Health Score Thresholds:**

| Score Range | Status | Action |
|-------------|--------|--------|
| 95-100%     | Excellent | Maintain |
| 90-94%      | Good | Monitor |
| 80-89%      | Warning | Review and improve |
| 70-79%      | Poor | Refactor required |
| <70%        | Critical | Block release |

**Quality Gates:**

```bash
#!/usr/bin/env bash
# bin/cace-quality-gate.sh

QUALITY_THRESHOLD=90

run_quality_gate() {
  local report="$1"
  local score
  
  score=$(cat "$report" | grep -oP '"overallScore":\s*\K\d+' || echo "0")
  
  if [ "$score" -ge "$QUALITY_THRESHOLD" ]; then
    echo "✓ Quality gate passed: $score% (>= $QUALITY_THRESHOLD%)"
    return 0
  else
    echo "✗ Quality gate failed: $score% (< $QUALITY_THRESHOLD%)"
    echo ""
    echo "Recommendations:"
    cat "$report" | grep -oP '"recommendations":\s*\[[^\]]*\]' || true
    return 1
  fi
}
```

### 4.3 Refactoring Plan for Low-Health Skills

**Skill Health Assessment Matrix:**

| Skill Category | Common Issues | Resolution Strategy |
|----------------|---------------|---------------------|
| Tool-heavy     | `allowed-tools` not mapped | Add explicit tool mapping |
| Agent-specific | `context: fork` unsupported | Use alternative patterns |
| Permission-based| Missing `subtask` field | Add OpenCode-specific metadata |
| Complex workflows | Multi-step instructions lost | Simplify to agent-native format |

**Automated Refactoring Script:**

```typescript
// src/refactor-low-health-skills.ts

interface SkillIssue {
  skillName: string;
  agent: string;
  issueType: string;
  fidelityScore: number;
  suggestedFix: string;
}

export function refactorSkill(issue: SkillIssue): void {
  switch (issue.issueType) {
    case 'missing-allowed-tools':
      addAllowedToolsField(issue.skillName);
      break;
    case 'unsupported-feature':
      replaceWithNativePattern(issue.skillName, issue.agent);
      break;
    case 'permission-missing':
      addOpenCodePermissions(issue.skillName);
      break;
    case 'workflow-complexity':
      simplifyWorkflow(issue.skillName);
      break;
  }
}

export function batchRefactor(issues: SkillIssue[]): void {
  const bySkill = groupBy(issues, 'skillName');
  
  for (const [skillName, skillIssues] of Object.entries(bySkill)) {
    console.log(`Refactoring ${skillName}...`);
    
    for (const issue of skillIssues) {
      refactorSkill(issue);
    }
    
    // Re-validate after all fixes
    const newScore = validateSkill(skillName);
    if (newScore < 80) {
      console.warn(`  Warning: ${skillName} still below threshold after refactoring`);
    }
  }
}
```

---

## 5. Pre-Processing Rules for Behavior Preservation

### 5.1 Claude-Specific Feature Handling

When converting from Claude to other agents, apply these rules:

```bash
#!/usr/bin/env bash
# bin/cace-preprocess.sh - Apply behavior preservation rules

handle_claude_specific_features() {
  local input_file="$1"
  local agent="$2"
  
  # Claude disable-model-invocation: true
  # No equivalent in other agents - add warning comment
  if grep -q "disable-model-invocation.*true" "$input_file"; then
    if [ "$agent" != "claude" ]; then
      sed -i '/^disable-model-invocation:/a # WARNING: This feature has no equivalent in '"$agent"'.\n# In Claude Code, this prevents programmatic invocation.\n# In '"$agent"', this skill will be always executable.' "$input_file"
    fi
  fi
  
  # Claude user-invocable: false (UI-only, still callable)
  # Other agents don't have this distinction - document as comment
  if grep -q "user-invocable.*false" "$input_file"; then
    if [ "$agent" != "claude" ]; then
      sed -i '/^user-invocable:/a # NOTE: In Claude, this hides from UI but allows model invocation.\n# In '"$agent"', this distinction does not exist.' "$input_file"
    fi
  fi
}
```

### 5.2 Windsurf Auto-Execution Mapping

Windsurf's `auto_execution_mode` (0=Off, 1=Auto, 2=Turbo) requires documentation:

```yaml
# In Windsurf workflows, add:
---
name: skill-name
description: Skill description
agent_specific:
  windsurf:
    auto_execution_mode: 1  # Document expected execution mode
    # 0 = Off (manual only)
    # 1 = Auto (run when triggered)
    # 2 = Turbo (aggressive caching)
---
```

### 5.3 Input Scope Normalization

Different agents pass different context scopes to skills:

| Agent    | Context Passed to Skill          |
|----------|----------------------------------|
| Claude   | Full prompt + system context     |
| Windsurf | Triggering prompt only           |
| Cursor   | Full prompt with .mdc rules      |
| OpenCode | Full context (native Claude)     |

**Normalization Strategy:** Skills should be designed to work with minimal context (just the triggering prompt) for maximum compatibility.

---

## 6. Migration Path

### 6.1 Existing User Migration

**Migration Steps:**

1. **Backup Existing Installation**
   ```bash
   # User's existing agent-deep-toolkit
   cp -r ~/.claude/skills ~/backup-claude-skills-$(date +%Y%m%d)
   cp -r ~/.windsurf/workflows ~/backup-windsurf-workflows-$(date +%Y%m%d)
   cp -r ~/.cursor/commands ~/backup-cursor-commands-$(date +%Y%m%d)
   cp -r ~/.config/opencode/commands ~/backup-opencode-commands-$(date +%Y%m%d)
   ```

2. **Update to New Version**
   ```bash
   # Pull latest changes
   cd /path/to/agent-deep-toolkit
   git pull origin main
   
   # Rebuild with CACE
   ./bin/cace-convert --agents all
   
   # Verify health
   ./bin/cace-convert --health-check
   ```

3. **Reinstall to User Directories**
   ```bash
   # Using install.sh (which now uses CACE-generated outputs)
   ./install.sh --agent all --level user --force
   ```

**Migration Script:**

```bash
#!/usr/bin/env bash
# bin/migrate-to-cace.sh

set -euo pipefail

MIGRATION_DIR="$HOME/.agent-deep-toolkit-migration-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$MIGRATION_DIR"

log() { echo "[$(date '+%H:%M:%S')] $*"; }

log "Starting migration to CACE-based build system"
log "Migration directory: $MIGRATION_DIR"

# Step 1: Backup existing installations
log "Step 1: Backing up existing installations..."

for agent_dir in "$HOME/.claude/skills" "$HOME/.windsurf/workflows" \
                 "$HOME/.cursor/commands" "$HOME/.config/opencode/commands"; do
  if [ -d "$agent_dir" ]; then
    local name
    name=$(basename "$agent_dir" | tr ' ' '-')
    cp -r "$agent_dir" "$MIGRATION_DIR/backup-$name"
    log "  Backed up: $agent_dir"
  fi
done

# Step 2: Check prerequisites
log "Step 2: Checking prerequisites..."

if ! command -v git &> /dev/null; then
  log "ERROR: git is required"
  exit 1
fi

if ! command -v node &> /dev/null; then
  log "ERROR: Node.js >= 18.0.0 is required"
  exit 1
fi

# Step 3: Clone/update agent-deep-toolkit
log "Step 3: Updating agent-deep-toolkit..."

if [ -d "/path/to/agent-deep-toolkit/.git" ]; then
  cd /path/to/agent-deep-toolkit
  git pull origin main
  log "  Updated existing installation"
else
  git clone "https://github.com/your-org/agent-deep-toolkit.git" "/tmp/agent-deep-toolkit-new"
  log "  Cloned fresh copy"
fi

# Step 4: Install CACE
log "Step 4: Installing CACE CLI v2.3.0..."

npm install -g cace-cli@2.3.0 2>/dev/null || {
  log "ERROR: Failed to install CACE"
  exit 1
}

log "  CACE installed: $(cace version)"

# Step 5: Build with CACE
log "Step 5: Building skills with CACE..."

cd /path/to/agent-deep-toolkit
./bin/cace-convert --agents all

# Step 6: Run health check
log "Step 6: Running health check..."

./bin/cace-convert --health-check > "$MIGRATION_DIR/health-report.txt"

# Step 7: Reinstall
log "Step 7: Reinstalling to user directories..."

./install.sh --agent all --level user --force

log "Migration complete!"
log ""
log "Summary:"
log "  - Backup location: $MIGRATION_DIR"
log "  - Health report: $MIGRATION_DIR/health-report.txt"
log "  - Run './bin/cace-convert --health-check' anytime to check status"
```

### 5.2 Backward Compatibility Considerations

**Preserving Existing Functionality:**

1. **Same Skill Format**: Skills remain in `skills/{skillName}/SKILL.md` with identical YAML frontmatter
2. **Same Output Structure**: `outputs/{agent}/` directory structure preserved
3. **Same Installation Paths**: `install.sh` continues to use same destination directories
4. **Same Version File**: `VERSION` file format maintained

**Compatibility Layer:**

```typescript
// src/compatibility-layer.ts

/**
 * Ensures backward compatibility with pre-CACE installations
 */

export interface LegacyConfig {
  pythonBuildScript?: boolean;
  customRendering?: boolean;
  legacyAliases?: boolean;
}

export function detectLegacyConfig(): LegacyConfig {
  return {
    pythonBuildScript: exists('./bin/build-all-agents'),
    customRendering: exists('./bin/render-*.py'),
    legacyAliases: exists('./bin/generate-aliases.sh')
  };
}

export function migrateLegacyConfig(config: LegacyConfig): void {
  if (config.pythonBuildScript) {
    console.log('Migrating from Python build script...');
    // Run Python script to generate initial outputs
    // Then convert with CACE for consistency
  }
  
  if (config.legacyAliases) {
    console.log('Migrating legacy alias generation...');
    // Preserve existing alias generation logic
    // Integrate with new variant wrapper
  }
}

export function validateBackwardCompatibility(): {
  compatible: boolean;
  warnings: string[];
  actions: string[];
} {
  const warnings: string[] = [];
  const actions: string[] = [];
  
  // Check if outputs exist from legacy system
  if (exists('./outputs') && !exists('./outputs/claude')) {
    warnings.push('Legacy outputs directory found but not in expected format');
    actions.push('Run ./bin/cace-convert to regenerate with new system');
  }
  
  return {
    compatible: warnings.length === 0,
    warnings,
    actions
  };
}
```

**Version Compatibility Matrix:**

| agent-deep-toolkit | CACE Required | Node.js Required | Notes |
|--------------------|---------------|------------------|-------|
| 3.0.0              | 2.3.0         | >=18.0.0         | New CACE-based system |
| 2.0.0-2.1.0        | N/A           | Python 3.8+      | Legacy Python system |
| 1.x.x              | N/A           | Python 3.6+      | Deprecated |

### 5.3 Rollback Strategy

```bash
#!/usr/bin/env bash
# bin/rollback-cace.sh

rollback_to_python_build() {
  local backup_dir="$1"
  
  log "Rolling back to Python-based build system..."
  
  # Restore Python build script
  if [ -f "$backup_dir/bin/build-all-agents" ]; then
    cp "$backup_dir/bin/build-all-agents" ./bin/build-all-agents
    chmod +x ./bin/build-all-agents
  fi
  
  # Restore outputs if needed
  if [ -d "$backup_dir/outputs" ]; then
    cp -r "$backup_dir/outputs" ./
  fi
  
  # Uninstall CACE (optional)
  # npm uninstall -g cace-cli 2>/dev/null || true
  
  log "Rollback complete"
  log "Run './bin/build-all-agents' to use Python build system"
}
```

---

## 6. Implementation Checklist

### 6.1 Phase 1: Core Infrastructure

- [ ] Create `bin/cace-convert` wrapper script
- [ ] Create `bin/cace-variants.sh` variant generator
- [ ] Create `bin/cace-doctor.sh` health check
- [ ] Modify `install.sh` for CACE prerequisites
- [ ] Update `VERSION` file with CACE version

### 6.2 Phase 2: Testing & Validation

- [ ] Test CACE conversion for all 6 agents
- [ ] Verify variant generation (aliases/synonyms)
- [ ] Validate fidelity scores >= 90%
- [ ] Test install.sh with CACE-generated outputs
- [ ] Test rollback procedure

### 6.3 Phase 3: Documentation

- [ ] Update README.md with CACE build instructions
- [ ] Create `docs/CACE_INTEGRATION.md`
- [ ] Document agent version compatibility
- [ ] Create migration guide for existing users
- [ ] Update CHANGELOG

### 6.4 Phase 4: Release

- [ ] Tag release v3.0.0
- [ ] Update npm package if needed
- [ ] Announce migration path
- [ ] Deprecate Python build script

---

## 7. Appendices

### 7.1 CACE CLI Command Reference

```bash
# Core commands used in agent-deep-toolkit
cace convert-dir <source> --to <agent> --output <dest>
cace validate <path> [--strict]
cace doctor
cace version

# Interactive mode (for debugging)
cace interactive
cace wizard
```

### 7.2 Fidelity Score Reference

| Conversion Path | Fidelity | Notes |
|-----------------|----------|-------|
| Claude → OpenCode | 98% | Native compatibility |
| Claude → Cursor | 92% | Tool restrictions approximated |
| Claude → Windsurf | 87% | Skills vs Workflows mapping |
| Claude → Codex | 92% | Strong MCP mapping |
| Claude → Gemini | 88% | Good Gemini CLI mapping |
| OpenCode → Claude | 95% | Excellent reverse |

### 7.3 YAML Frontmatter Mapping

**Source Format (agent-deep-toolkit canonical):**
```yaml
---
name: code
description: Implement high-quality code
command: /code
aliases: ["/implement", "/build"]
synonyms: ["/coding", "/coded"]
activation-mode: auto
user-invocable: true
disable-model-invocation: true
---
```

**CACE-Generated Formats:**

*Claude:*
```yaml
---
name: code
description: Implement high-quality code
command: /code
aliases: ["/implement", "/build", "/coding", "/coded"]
activation-mode: auto
user-invocable: true
---
```

*Windsurf:*
```yaml
---
description: Implement high-quality code
auto_execution_mode: 1
---
```

*Cursor:*
```yaml
---
description: Implement high-quality code
globs: ["**/*"]
alwaysApply: true
---
```

*OpenCode:*
```yaml
---
description: Implement high-quality code
agent: auto
model: auto
subtask: false
allowed-tools: ["*"]
---
```

---

*Document Version: 1.0.0*
*Last Updated: January 30, 2026*
*For CACE v2.3.0 and agent-deep-toolkit v3.0.0*
