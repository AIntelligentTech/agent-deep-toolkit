#!/usr/bin/env bash
# Quick test suite for CACE-based build system

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="${REPO_ROOT}/skills"
OUTPUTS_DIR="${REPO_ROOT}/outputs"
CACE_DIR="/home/tony/business/tools/cross-agent-compatibility-engine"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

assert_skill_name() {
  local skill_file="$1"
  local expected_name="$2"

  if ! grep -qE "^[[:space:]]*name:[[:space:]]*${expected_name}[[:space:]]*$" "$skill_file"; then
    echo -e "${RED}✗ FAIL${NC} - $skill_file missing expected frontmatter: name: $expected_name" >&2
    exit 1
  fi
}

assert_skill_command() {
  local skill_file="$1"
  local expected_command="$2"

  if ! grep -qE "^[[:space:]]*command:[[:space:]]*${expected_command}[[:space:]]*$" "$skill_file"; then
    echo -e "${RED}✗ FAIL${NC} - $skill_file missing expected frontmatter: command: $expected_command" >&2
    exit 1
  fi
}

run_cace() {
  if [[ -f "$CACE_DIR/dist/cli/index.js" ]]; then
    node "$CACE_DIR/dist/cli/index.js" "$@"
    return 0
  fi

  if command -v cace >/dev/null 2>&1; then
    cace "$@"
    return 0
  fi

  echo -e "${RED}✗ FAIL${NC} - CACE CLI not available (expected local checkout at $CACE_DIR)" >&2
  exit 1
}

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  CACE Conversion Quick Test"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Test 1: Windsurf conversion (workflows do NOT support auto execution)
echo "Test 1: Windsurf conversion does not emit auto_execution_mode..."
TMPDIR=/tmp run_cace convert "$SKILLS_DIR/architect/SKILL.md" -f claude -t windsurf -o /tmp/test-windsurf.md &>/dev/null
if [ -s /tmp/test-windsurf.md ] && ! grep -q "auto_execution_mode" /tmp/test-windsurf.md; then
  echo -e "${GREEN}✓ PASS${NC} - no auto_execution_mode emitted"
else
  echo -e "${RED}✗ FAIL${NC} - unexpected auto_execution_mode or empty output"
  exit 1
fi

# Test 2: Claude round-trip
echo "Test 2: Claude round-trip conversion..."
TMPDIR=/tmp run_cace convert "$SKILLS_DIR/code/SKILL.md" -f claude -t claude -o /tmp/test-claude.md &>/dev/null
if [ -s /tmp/test-claude.md ] && grep -q "^# Code Workflow" /tmp/test-claude.md && grep -q "user-invocable:" /tmp/test-claude.md; then
  echo -e "${GREEN}✓ PASS${NC} - Claude round-trip works"
else
  echo -e "${RED}✗ FAIL${NC} - Claude conversion failed"
  exit 1
fi

# Test 3: Cursor conversion
echo "Test 3: Cursor conversion..."
TMPDIR=/tmp run_cace convert "$SKILLS_DIR/test/SKILL.md" -f claude -t cursor -o /tmp/test-cursor.md &>/dev/null
if [ -s /tmp/test-cursor.md ] && grep -q "^# Test Workflow" /tmp/test-cursor.md; then
  echo -e "${GREEN}✓ PASS${NC} - Cursor conversion works"
else
  echo -e "${RED}✗ FAIL${NC} - Cursor conversion failed"
  exit 1
fi

# Test 4: New relentless skill + generated alias variants are present in outputs
echo "Test 4: /relentless outputs + variants exist..."

# Claude skills (directories)
for d in \
  "$OUTPUTS_DIR/claude/.claude/skills/relentless/SKILL.md" \
  "$OUTPUTS_DIR/claude/.claude/skills/try-hard/SKILL.md" \
  "$OUTPUTS_DIR/claude/.claude/skills/dont-stop/SKILL.md" \
  "$OUTPUTS_DIR/claude/.claude/skills/ultrathink/SKILL.md"; do
  [ -f "$d" ] || { echo -e "${RED}✗ FAIL${NC} - missing: $d"; exit 1; }
done
assert_skill_name "$OUTPUTS_DIR/claude/.claude/skills/try-hard/SKILL.md" "try-hard"
assert_skill_command "$OUTPUTS_DIR/claude/.claude/skills/try-hard/SKILL.md" "/try-hard"

# Windsurf workflows (.md) + skills (directories)
for f in \
  "$OUTPUTS_DIR/windsurf/.windsurf/workflows/relentless.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/workflows/try-hard.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/workflows/dont-stop.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/workflows/ultrathink.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/skills/relentless/SKILL.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/skills/try-hard/SKILL.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/skills/dont-stop/SKILL.md" \
  "$OUTPUTS_DIR/windsurf/.windsurf/skills/ultrathink/SKILL.md"; do
  [ -f "$f" ] || { echo -e "${RED}✗ FAIL${NC} - missing: $f"; exit 1; }
done
assert_skill_name "$OUTPUTS_DIR/windsurf/.windsurf/skills/try-hard/SKILL.md" "try-hard"
assert_skill_command "$OUTPUTS_DIR/windsurf/.windsurf/skills/try-hard/SKILL.md" "/try-hard"

# Cursor commands (.md) + skills (directories)
for f in \
  "$OUTPUTS_DIR/cursor/.cursor/commands/relentless.md" \
  "$OUTPUTS_DIR/cursor/.cursor/commands/try-hard.md" \
  "$OUTPUTS_DIR/cursor/.cursor/commands/dont-stop.md" \
  "$OUTPUTS_DIR/cursor/.cursor/commands/ultrathink.md" \
  "$OUTPUTS_DIR/cursor/.cursor/skills/relentless/SKILL.md" \
  "$OUTPUTS_DIR/cursor/.cursor/skills/try-hard/SKILL.md" \
  "$OUTPUTS_DIR/cursor/.cursor/skills/dont-stop/SKILL.md" \
  "$OUTPUTS_DIR/cursor/.cursor/skills/ultrathink/SKILL.md"; do
  [ -f "$f" ] || { echo -e "${RED}✗ FAIL${NC} - missing: $f"; exit 1; }
done
assert_skill_name "$OUTPUTS_DIR/cursor/.cursor/skills/try-hard/SKILL.md" "try-hard"
assert_skill_command "$OUTPUTS_DIR/cursor/.cursor/skills/try-hard/SKILL.md" "/try-hard"

echo -e "${GREEN}✓ PASS${NC} - relentless + variants present across agents"

echo "Test 5: Legacy top-level tools are available as skills..."

# These used to be top-level commands; they must exist as *skills* (not only commands/workflows)
# for agents that use skill indexing (e.g., Cursor/Windsurf).
for tool in understand docs research consider prune retrospective regulation; do
  # Cursor
  [ -f "$OUTPUTS_DIR/cursor/.cursor/skills/$tool/SKILL.md" ] || { echo -e "${RED}✗ FAIL${NC} - missing Cursor skill: $tool"; exit 1; }
  assert_skill_name "$OUTPUTS_DIR/cursor/.cursor/skills/$tool/SKILL.md" "$tool"
  assert_skill_command "$OUTPUTS_DIR/cursor/.cursor/skills/$tool/SKILL.md" "/$tool"

  # Windsurf
  [ -f "$OUTPUTS_DIR/windsurf/.windsurf/skills/$tool/SKILL.md" ] || { echo -e "${RED}✗ FAIL${NC} - missing Windsurf skill: $tool"; exit 1; }
  assert_skill_name "$OUTPUTS_DIR/windsurf/.windsurf/skills/$tool/SKILL.md" "$tool"
  assert_skill_command "$OUTPUTS_DIR/windsurf/.windsurf/skills/$tool/SKILL.md" "/$tool"

  # Claude
  [ -f "$OUTPUTS_DIR/claude/.claude/skills/$tool/SKILL.md" ] || { echo -e "${RED}✗ FAIL${NC} - missing Claude skill: $tool"; exit 1; }
  assert_skill_name "$OUTPUTS_DIR/claude/.claude/skills/$tool/SKILL.md" "$tool"
  assert_skill_command "$OUTPUTS_DIR/claude/.claude/skills/$tool/SKILL.md" "/$tool"
done

echo -e "${GREEN}✓ PASS${NC} - legacy top-level tools present as skills"

echo ""
echo "═══════════════════════════════════════════════════════════"
echo -e "  ${GREEN}All tests passed!${NC}"
echo "═══════════════════════════════════════════════════════════"
echo ""
