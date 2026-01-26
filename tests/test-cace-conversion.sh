#!/usr/bin/env bash
# Quick test suite for CACE-based build system

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="${REPO_ROOT}/skills"
OUTPUTS_DIR="${REPO_ROOT}/outputs"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  CACE Conversion Quick Test"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Test 1: Windsurf conversion with activation mode
echo "Test 1: Windsurf conversion preserves auto_execution_mode..."
TMPDIR=/tmp cace convert "$SKILLS_DIR/deep-architect/SKILL.md" -t windsurf -o /tmp/test-windsurf.md &>/dev/null
if grep -q "auto_execution_mode: 3" /tmp/test-windsurf.md; then
  echo -e "${GREEN}✓ PASS${NC} - auto_execution_mode preserved"
else
  echo -e "${RED}✗ FAIL${NC} - auto_execution_mode not found"
  exit 1
fi

# Test 2: Claude round-trip
echo "Test 2: Claude round-trip conversion..."
TMPDIR=/tmp cace convert "$SKILLS_DIR/deep-code/SKILL.md" -t claude -o /tmp/test-claude.md &>/dev/null
if [ -s /tmp/test-claude.md ] && grep -q "Deep Code Workflow" /tmp/test-claude.md && grep -q "user-invocable:" /tmp/test-claude.md; then
  echo -e "${GREEN}✓ PASS${NC} - Claude round-trip works"
else
  echo -e "${RED}✗ FAIL${NC} - Claude conversion failed"
  exit 1
fi

# Test 3: Cursor conversion
echo "Test 3: Cursor conversion..."
TMPDIR=/tmp cace convert "$SKILLS_DIR/deep-test/SKILL.md" -t cursor -o /tmp/test-cursor.md &>/dev/null
if [ -s /tmp/test-cursor.md ] && grep -q "Deep Test Workflow" /tmp/test-cursor.md; then
  echo -e "${GREEN}✓ PASS${NC} - Cursor conversion works"
else
  echo -e "${RED}✗ FAIL${NC} - Cursor conversion failed"
  exit 1
fi

# Test 4: All builds succeeded
echo "Test 4: Build outputs exist..."
claude_count=$(find "$OUTPUTS_DIR/claude" -name "*.md" | wc -l | tr -d ' ')
windsurf_count=$(find "$OUTPUTS_DIR/windsurf" -name "*.md" | wc -l | tr -d ' ')
cursor_count=$(find "$OUTPUTS_DIR/cursor" -name "*.md" | wc -l | tr -d ' ')

if [[ $claude_count == 48 && $windsurf_count == 48 && $cursor_count == 48 ]]; then
  echo -e "${GREEN}✓ PASS${NC} - All 48 tools built for each agent"
else
  echo -e "${RED}✗ FAIL${NC} - Expected 48 files each, got: Claude=$claude_count, Windsurf=$windsurf_count, Cursor=$cursor_count"
  exit 1
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo -e "  ${GREEN}All tests passed!${NC}"
echo "═══════════════════════════════════════════════════════════"
echo ""
