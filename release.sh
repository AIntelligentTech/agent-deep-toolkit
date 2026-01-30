#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$SCRIPT_DIR/INSTALLATION.yaml"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "${YELLOW}ℹ${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; }

if ! command -v yq &>/dev/null; then
    error "yq required (brew install yq)"
    exit 1
fi

BUMP_TYPE="${1:-}"
DRY_RUN=false
PUSH=false

shift || true
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run) DRY_RUN=true ;;
        --push) PUSH=true ;;
        *) error "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$BUMP_TYPE" ]] || [[ ! "$BUMP_TYPE" =~ ^(major|minor|patch)$ ]]; then
    echo -e "${BOLD}Usage:${NC} ./release.sh <major|minor|patch> [--dry-run] [--push]"
    exit 1
fi

CURRENT_VERSION=$(yq eval '.package.version' "$MANIFEST")
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case "$BUMP_TYPE" in
    major) NEW_VERSION="$((MAJOR + 1)).0.0" ;;
    minor) NEW_VERSION="$MAJOR.$((MINOR + 1)).0" ;;
    patch) NEW_VERSION="$MAJOR.$MINOR.$((PATCH + 1))" ;;
esac

echo ""
echo -e "${BOLD}Release: agent-deep-toolkit${NC}"
echo "  Current: $CURRENT_VERSION"
echo "  New:     $NEW_VERSION"
echo "  Type:    $BUMP_TYPE"
echo ""

if [[ "$DRY_RUN" == true ]]; then
    info "Dry run — no changes made"
    exit 0
fi

# Update INSTALLATION.yaml
yq eval -i ".package.version = \"$NEW_VERSION\"" "$MANIFEST"
success "Updated INSTALLATION.yaml to $NEW_VERSION"

# Update CHANGELOG.md header if it exists
if [[ -f "$SCRIPT_DIR/CHANGELOG.md" ]]; then
    DATE=$(date +%Y-%m-%d)
    # Prepend new version section after first heading
    sed -i '' "s/^## \[Unreleased\]/## [Unreleased]\n\n## [$NEW_VERSION] - $DATE/" "$SCRIPT_DIR/CHANGELOG.md" 2>/dev/null || true
fi

if [[ "$PUSH" == true ]]; then
    cd "$SCRIPT_DIR"
    git add INSTALLATION.yaml CHANGELOG.md 2>/dev/null
    git commit -m "chore(release): v$NEW_VERSION"
    git tag "v$NEW_VERSION"
    git push && git push --tags
    success "Pushed v$NEW_VERSION"
else
    info "Run: git add INSTALLATION.yaml && git commit -m 'chore(release): v$NEW_VERSION' && git tag v$NEW_VERSION"
fi
