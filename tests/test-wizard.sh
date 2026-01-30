#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

test_info() {
  echo -e "${YELLOW}[TEST]${NC} $1"
}

test_pass() {
  echo -e "${GREEN}[PASS]${NC} $1"
  ((TESTS_PASSED++))
}

test_fail() {
  echo -e "${RED}[FAIL]${NC} $1"
  ((TESTS_FAILED++))
}

# ============================================================================
# Test: Syntax check
# ============================================================================

test_info "Checking install.sh syntax"
if bash -n "$SCRIPT_DIR/install.sh" >/dev/null 2>&1; then
  test_pass "install.sh syntax valid"
else
  test_fail "install.sh has syntax errors"
fi

# ============================================================================
# Test: Help output includes --wizard
# ============================================================================

test_info "Checking --wizard flag in help output"
if "$SCRIPT_DIR/install.sh" --help 2>&1 | grep -q "\--wizard"; then
  test_pass "--wizard flag documented in help"
else
  test_fail "--wizard flag not found in help output"
fi

# ============================================================================
# Test: CLI mode still works (backward compatibility)
# ============================================================================

test_info "Checking CLI mode backward compatibility"
cli_output=$("$SCRIPT_DIR/install.sh" --agent windsurf --level user --dry-run 2>&1)
if echo "$cli_output" | grep -q "agent=windsurf"; then
  test_pass "CLI mode (--agent, --level) still works"
else
  test_fail "CLI mode not functioning"
fi

# ============================================================================
# Test: Existing version detection
# ============================================================================

test_info "Checking version file"
if [ -f "$SCRIPT_DIR/VERSION" ]; then
  version=$(head -n 1 "$SCRIPT_DIR/VERSION" | cut -d'=' -f2)
  if [ "$version" = "3.2.0" ]; then
    test_pass "Version updated to 3.2.0"
  else
    test_fail "Version not updated (found: $version)"
  fi
else
  test_fail "VERSION file not found"
fi

# ============================================================================
# Test: README mentions wizard
# ============================================================================

test_info "Checking README documentation"
if grep -q "\-\-wizard" "$SCRIPT_DIR/README.md"; then
  test_pass "README documents --wizard flag"
else
  test_fail "README missing --wizard documentation"
fi

# ============================================================================
# Test: CHANGELOG mentions wizard
# ============================================================================

test_info "Checking CHANGELOG documentation"
if grep -q "3.2.0" "$SCRIPT_DIR/CHANGELOG.md"; then
  test_pass "CHANGELOG updated for v3.2.0"
else
  test_fail "CHANGELOG missing v3.2.0 entry"
fi

if grep -q "Interactive Installation Wizard" "$SCRIPT_DIR/CHANGELOG.md"; then
  test_pass "CHANGELOG describes wizard feature"
else
  test_fail "CHANGELOG missing wizard feature description"
fi

# ============================================================================
# Test: Box drawing functions exist
# ============================================================================

test_info "Checking wizard UI functions"
if grep -q "draw_box()" "$SCRIPT_DIR/install.sh"; then
  test_pass "draw_box() function implemented"
else
  test_fail "draw_box() function not found"
fi

if grep -q "draw_box_close()" "$SCRIPT_DIR/install.sh"; then
  test_pass "draw_box_close() function implemented"
else
  test_fail "draw_box_close() function not found"
fi

if grep -q "draw_box_line()" "$SCRIPT_DIR/install.sh"; then
  test_pass "draw_box_line() function implemented"
else
  test_fail "draw_box_line() function not found"
fi

# ============================================================================
# Test: Selection functions exist
# ============================================================================

test_info "Checking wizard selection functions"
if grep -q "wizard_select_agents()" "$SCRIPT_DIR/install.sh"; then
  test_pass "wizard_select_agents() function implemented"
else
  test_fail "wizard_select_agents() function not found"
fi

if grep -q "wizard_select_level()" "$SCRIPT_DIR/install.sh"; then
  test_pass "wizard_select_level() function implemented"
else
  test_fail "wizard_select_level() function not found"
fi

# ============================================================================
# Test: Main wizard function exists
# ============================================================================

test_info "Checking main wizard orchestrator"
if grep -q "run_wizard()" "$SCRIPT_DIR/install.sh"; then
  test_pass "run_wizard() function implemented"
else
  test_fail "run_wizard() function not found"
fi

# ============================================================================
# Test: Validation function exists
# ============================================================================

test_info "Checking wizard validation"
if grep -q "wizard_validate_prerequisites()" "$SCRIPT_DIR/install.sh"; then
  test_pass "wizard_validate_prerequisites() function implemented"
else
  test_fail "wizard_validate_prerequisites() function not found"
fi

# ============================================================================
# Test: Wizard state management
# ============================================================================

test_info "Checking wizard state management"
if grep -q "declare -g -A WIZARD_STATE=" "$SCRIPT_DIR/install.sh"; then
  test_pass "WIZARD_STATE array declared"
else
  test_fail "WIZARD_STATE array not found"
fi

# ============================================================================
# Summary
# ============================================================================

echo ""
echo "============================================"
echo "Test Summary"
echo "============================================"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
  echo -e "${GREEN}All tests passed!${NC}"
  exit 0
else
  echo -e "${RED}Some tests failed${NC}"
  exit 1
fi
