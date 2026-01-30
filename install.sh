#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CACE_VERSION="2.5.1"
CACE_DIR="/home/tony/business/tools/cross-agent-compatibility-engine"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Box drawing characters
BOX_TL="╔"
BOX_TR="╗"
BOX_BL="╚"
BOX_BR="╝"
BOX_H="═"
BOX_V="║"

# Separator characters
SEP_TL="┌"
SEP_TR="┐"
SEP_BL="└"
SEP_BR="┘"
SEP_H="─"
SEP_V="│"

# Status icons
ICON_CHECK="✓"
ICON_CROSS="✗"
ICON_WARN="⚠"
ICON_INFO="ⓘ"

# Spinner animation
SPINNER=("⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷")

log_info() { echo -e "${BLUE}[info]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[warn]${NC} $*"; }
log_error() { echo -e "${RED}[error]${NC} $*" >&2; }
log_success() { echo -e "${GREEN}[ok]${NC} $*"; }

# Wizard mode state
declare -g -A WIZARD_STATE=(
  [agents]=""
  [level]=""
  [force]=false
  [dry_run]=true
  [project_dir]="$PWD"
  [has_conflicts]=false
)

WIZARD_TEMP_DIR=""

cleanup_wizard() {
  if [ -n "$WIZARD_TEMP_DIR" ] && [ -d "$WIZARD_TEMP_DIR" ]; then
    rm -rf "$WIZARD_TEMP_DIR"
  fi
  tput cnorm 2>/dev/null || true
}

trap cleanup_wizard EXIT INT TERM

check_cace_prerequisites() {
  log_info "Checking CACE prerequisites..."
  
  if ! command -v node &> /dev/null; then
    log_error "Node.js is required for CACE-based conversion"
    return 1
  fi
  
  local node_version
  node_version=$(node --version 2>/dev/null | cut -d'v' -f2 | cut -d'.' -f1)
  if [ -z "$node_version" ] || [ "$node_version" -lt 18 ]; then
    log_error "Node.js >= 18.0.0 required. Found: $(node --version 2>/dev/null || echo 'not installed')"
    return 1
  fi
  
  if [ -f "$CACE_DIR/dist/cli/index.js" ]; then
    log_success "CACE available: $CACE_DIR"
    return 0
  fi
  
  log_warn "Local CACE not found at $CACE_DIR"
  log_info "Using CACE from: $(command -v cace 2>/dev/null || echo 'not installed')"
  
  if ! command -v cace &> /dev/null; then
    log_warn "CACE not found. Install with: npm install -g cace-cli"
    log_info "Falling back to Python-based build (bin/build-all-agents)"
  fi
  
  return 0
}

WINDSURF_WORKFLOWS_DIR="$SCRIPT_DIR/outputs/windsurf/.windsurf/workflows"
WINDSURF_SKILLS_DIR="$SCRIPT_DIR/outputs/windsurf/.windsurf/skills"
CLAUDE_SKILLS_DIR="$SCRIPT_DIR/outputs/claude/.claude/skills"
CURSOR_COMMANDS_DIR="$SCRIPT_DIR/outputs/cursor/.cursor/commands"
CURSOR_SKILLS_DIR="$SCRIPT_DIR/outputs/cursor/.cursor/skills"
OPENCODE_COMMANDS_DIR="$SCRIPT_DIR/outputs/opencode/.opencode"
TOOLKIT_VERSION="$(head -n 1 "$SCRIPT_DIR/VERSION" 2>/dev/null | cut -d'=' -f2 || echo "0.0.0")"

# ============================================================================
# UI Functions
# ============================================================================

draw_box() {
  local title="$1"
  local width="${2:-60}"

  local title_line=""
  if [ -n "$title" ]; then
    local padding=$((width - ${#title} - 4))
    title_line=" $title $(printf '%*s' $padding | tr ' ' "$BOX_H")"
  else
    title_line="$(printf '%*s' $width | tr ' ' "$BOX_H")"
  fi

  echo -e "${CYAN}${BOX_TL}${title_line}${BOX_TR}${NC}"
}

draw_box_close() {
  local width="${1:-60}"
  echo -e "${CYAN}${BOX_BL}$(printf '%*s' $width | tr ' ' "$BOX_H")${BOX_BR}${NC}"
}

draw_box_line() {
  local text="$1"
  local width="${2:-60}"

  local padding=$((width - ${#text} - 2))
  echo -e "${CYAN}${BOX_V}${NC} ${text}$(printf '%*s' $padding | tr ' ' ' ')${CYAN}${BOX_V}${NC}"
}

draw_separator() {
  local width="${1:-60}"
  echo -e "${CYAN}${SEP_BL}$(printf '%*s' $width | tr ' ' "$SEP_H")${SEP_BR}${NC}"
}

draw_table_header() {
  local width="${1:-60}"
  echo -e "${CYAN}${SEP_TL}$(printf '%*s' $width | tr ' ' "$SEP_H")${SEP_TR}${NC}"
}

show_spinner() {
  local message="$1"
  local spinner_idx=0

  tput civis 2>/dev/null || true

  while kill -0 $! 2>/dev/null; do
    echo -ne "\r${SPINNER[$((spinner_idx % ${#SPINNER[@]}))]}  ${message}"
    ((spinner_idx++))
    sleep 0.1
  done

  wait $!
  local exit_code=$?

  tput cnorm 2>/dev/null || true
  echo -ne "\r   "

  return $exit_code
}

# ============================================================================
# Wizard Selection Functions
# ============================================================================

wizard_select_agents() {
  local has_fzf=false
  if command -v fzf &>/dev/null; then
    has_fzf=true
  fi

  if [ "$has_fzf" = true ]; then
    wizard_select_agents_fzf
  else
    wizard_select_agents_fallback
  fi
}

wizard_select_agents_fzf() {
  local agents_file="$WIZARD_TEMP_DIR/agents.txt"

  cat > "$agents_file" << 'EOF'
windsurf|Windsurf Stable - ~/.windsurf/workflows
windsurf-next|Windsurf Next - ~/.codeium/windsurf-next/
claude|Claude Code - ~/.claude/skills
cursor|Cursor - ~/.cursor/commands + skills
opencode|OpenCode - ~/.config/opencode/commands
EOF

  local selected
  selected=$( \
    awk -F'|' '{print $1 " " $2}' "$agents_file" | \
    fzf --multi \
        --height 10 \
        --border \
        --margin 1 \
        --padding 1 \
        --header "Select Agents (TAB to select, ENTER to confirm)" \
        --color="border:$CYAN,header:$BOLD" \
        --preview-window hidden 2>&1 | \
    awk '{print $1}' | \
    paste -sd ',' - \
  )

  if [ -z "$selected" ]; then
    return 1
  fi

  WIZARD_STATE[agents]="$selected"
  return 0
}

wizard_select_agents_fallback() {
  echo ""
  draw_box "Select Agents" 60
  draw_box_line "Select one or more agents:" 60
  draw_box_line "" 60
  draw_box_close 60
  echo ""

  local agents=("windsurf:Windsurf Stable" "windsurf-next:Windsurf Next" "claude:Claude Code" "cursor:Cursor" "opencode:OpenCode")
  local selected_agents=()

  for agent_spec in "${agents[@]}"; do
    local agent="${agent_spec%%:*}"
    local label="${agent_spec##*:}"

    printf "  Install %s? (y/n) [n]: " "$label"
    read -r -t 5 reply || reply="n"
    if [[ "$reply" =~ ^[yY]$ ]]; then
      selected_agents+=("$agent")
    fi
  done

  if [ ${#selected_agents[@]} -eq 0 ]; then
    log_error "No agents selected"
    return 1
  fi

  local agents_str
  agents_str=$(IFS=,; echo "${selected_agents[*]}")
  WIZARD_STATE[agents]="$agents_str"
  return 0
}

wizard_select_level() {
  local has_fzf=false
  if command -v fzf &>/dev/null; then
    has_fzf=true
  fi

  if [ "$has_fzf" = true ]; then
    wizard_select_level_fzf
  else
    wizard_select_level_fallback
  fi
}

wizard_select_level_fzf() {
  local level_file="$WIZARD_TEMP_DIR/levels.txt"

  cat > "$level_file" << 'EOF'
user|User Level - Install to home directory (all projects)
project|Project Level - Install to current project only
EOF

  local selected
  selected=$( \
    awk -F'|' '{print $1 " " $2}' "$level_file" | \
    fzf --height 5 \
        --border \
        --margin 1 \
        --padding 1 \
        --header "Select Installation Level" \
        --color="border:$CYAN,header:$BOLD" \
        --preview-window hidden 2>&1 | \
    awk '{print $1}' \
  )

  if [ -z "$selected" ]; then
    return 1
  fi

  WIZARD_STATE[level]="$selected"
  return 0
}

wizard_select_level_fallback() {
  echo ""
  draw_box "Select Installation Level" 60
  draw_box_close 60
  echo ""

  printf "  Install to [u]ser home or [p]roject directory? [u]: "
  read -r -t 5 reply || reply="u"

  case "$reply" in
    p|P)
      WIZARD_STATE[level]="project"
      ;;
    *)
      WIZARD_STATE[level]="user"
      ;;
  esac

  return 0
}

# ============================================================================
# Wizard Validation Functions
# ============================================================================

wizard_validate_prerequisites() {
  local errors=0

  draw_box "Checking Prerequisites" 60

  # Check Node.js
  if command -v node &>/dev/null; then
    local node_version
    node_version=$(node --version 2>/dev/null | cut -d'v' -f2)
    draw_box_line "${GREEN}${ICON_CHECK}${NC} Node.js $node_version" 60
  else
    draw_box_line "${RED}${ICON_CROSS}${NC} Node.js not found (required)" 60
    ((errors++))
  fi

  # Check fzf
  if command -v fzf &>/dev/null; then
    local fzf_version
    fzf_version=$(fzf --version 2>/dev/null | awk '{print $1}')
    draw_box_line "${GREEN}${ICON_CHECK}${NC} fzf $fzf_version (optional, will fallback to bash)" 60
  else
    draw_box_line "${YELLOW}${ICON_INFO}${NC} fzf not found (optional, will use bash fallback)" 60
  fi

  # Check output directories
  if [ -d "$SCRIPT_DIR/outputs" ]; then
    draw_box_line "${GREEN}${ICON_CHECK}${NC} Output directory exists" 60
  else
    draw_box_line "${RED}${ICON_CROSS}${NC} Output directory not found" 60
    ((errors++))
  fi

  # Check VERSION file
  if [ -f "$SCRIPT_DIR/VERSION" ]; then
    draw_box_line "${GREEN}${ICON_CHECK}${NC} Toolkit v$TOOLKIT_VERSION" 60
  else
    draw_box_line "${RED}${ICON_CROSS}${NC} VERSION file not found" 60
    ((errors++))
  fi

  draw_box_close 60
  echo ""

  if [ $errors -gt 0 ]; then
    log_error "Prerequisites check failed with $errors error(s)"
    return 1
  fi

  log_success "All prerequisites satisfied"
  echo ""
  return 0
}

# ============================================================================
# Main Wizard Flow
# ============================================================================

wizard_welcome() {
  clear
  echo ""
  draw_box "Agent Deep Toolkit Installer" 60
  draw_box_line "" 60
  draw_box_line "Interactive Installation Wizard" 60
  draw_box_line "Version $TOOLKIT_VERSION" 60
  draw_box_line "" 60
  draw_box_line "This wizard will guide you through installing agent" 60
  draw_box_line "workflows and skills to your favorite code editors." 60
  draw_box_line "" 60
  draw_box_line "⚠  Backup your editor config before proceeding" 60
  draw_box_line "" 60
  draw_box_close 60
  echo ""

  printf "Press ENTER to continue..."
  read -r
  echo ""
}

wizard_show_summary() {
  local agents="${WIZARD_STATE[agents]}"
  local level="${WIZARD_STATE[level]}"

  clear
  draw_box "Installation Summary" 60
  draw_box_line "" 60
  draw_box_line "${BOLD}Configuration:${NC}" 60
  draw_box_line "" 60

  local agents_display=$(echo "$agents" | tr ',' ', ')
  draw_box_line "  Selected Agents: $agents_display" 60
  draw_box_line "  Installation Level: ${level^}" 60

  if [ "${WIZARD_STATE[dry_run]}" = "true" ]; then
    draw_box_line "  Mode: ${YELLOW}Dry-Run${NC} (preview only)" 60
  else
    draw_box_line "  Mode: ${GREEN}Install${NC} (will modify system)" 60
  fi

  draw_box_line "" 60
  draw_box_close 60
  echo ""

  printf "Proceed? [y/N]: "
  read -r reply

  if [[ ! "$reply" =~ ^[yY]$ ]]; then
    echo "Installation cancelled."
    return 1
  fi

  return 0
}

run_wizard() {
  WIZARD_TEMP_DIR=$(mktemp -d) || return 1

  # Show welcome screen
  wizard_welcome

  # Check prerequisites
  if ! wizard_validate_prerequisites; then
    echo "Cannot continue due to missing prerequisites."
    read -p "Press ENTER to exit..."
    return 1
  fi

  # Select agents
  clear
  echo "Selecting agents..."
  if ! wizard_select_agents; then
    log_error "No agents selected"
    read -p "Press ENTER to exit..."
    return 1
  fi

  # Select level
  clear
  echo "Selecting installation level..."
  if ! wizard_select_level; then
    log_error "Installation level not selected"
    read -p "Press ENTER to exit..."
    return 1
  fi

  # Show summary and confirm
  if ! wizard_show_summary; then
    return 1
  fi

  # Convert comma-separated agents to array and process
  local agents_list="${WIZARD_STATE[agents]}"
  local level="${WIZARD_STATE[level]}"
  local dry_run="${WIZARD_STATE[dry_run]}"

  # Set global variables for install functions
  LEVEL="$level"
  PROJECT_DIR="${WIZARD_STATE[project_dir]}"
  DRY_RUN="$dry_run"
  FORCE=false
  MODE="install"

  echo ""
  draw_box "Installation Progress" 60

  # Install each agent using existing installation logic
  local first_agent=true
  for AGENT in $(echo "$agents_list" | tr ',' '\n'); do
    if [ "$first_agent" = false ]; then
      echo ""
    fi
    first_agent=false

    case "$AGENT" in
      windsurf)
        STABLE_PATH="$(detect_windsurf_stable_installation)"
        draw_box_line "Installing Windsurf (auto-detected)..." 60
        install_windsurf_to "$STABLE_PATH" "windsurf user (auto-detected)"
        ;;
      windsurf-next)
        draw_box_line "Detecting Windsurf Next installations..." 60
        NEXT_PATHS=()
        while IFS= read -r path; do
          NEXT_PATHS+=("$path")
        done < <(detect_windsurf_next_installations)

        if [ "${#NEXT_PATHS[@]}" -eq 0 ]; then
          NEXT_PATHS=("$HOME/.codeium/windsurf-next/global_workflows")
        fi

        for next_path in "${NEXT_PATHS[@]}"; do
          LABEL="windsurf-next user ($(echo "$next_path" | sed "s|$HOME/||"))"
          draw_box_line "Installing $LABEL..." 60
          install_windsurf_to "$next_path" "$LABEL"
        done
        ;;
      claude)
        if [ "$LEVEL" = "project" ]; then
          draw_box_line "Installing Claude (project)..." 60
          install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
        else
          draw_box_line "Installing Claude (user)..." 60
          install_claude_to "$HOME/.claude/skills" "claude user"
        fi
        ;;
      cursor)
        if [ "$LEVEL" = "project" ]; then
          draw_box_line "Installing Cursor (project)..." 60
          install_cursor_to "$PROJECT_DIR/.cursor/commands" "cursor project"
        else
          draw_box_line "Installing Cursor (user)..." 60
          install_cursor_to "$HOME/.cursor/commands" "cursor user"
        fi
        ;;
      opencode)
        if [ "$LEVEL" = "project" ]; then
          draw_box_line "Installing OpenCode (project)..." 60
          install_opencode_to "$PROJECT_DIR/.opencode/commands" "opencode project"
        else
          draw_box_line "Installing OpenCode (user)..." 60
          install_opencode_to "$HOME/.config/opencode/commands" "opencode user"
        fi
        ;;
      *)
        draw_box_line "${RED}${ICON_CROSS}${NC} Unknown agent: $AGENT" 60
        ;;
    esac
  done

  draw_box_close 60
  echo ""
  log_success "Installation complete!"
  echo ""
  draw_box "Next Steps" 60
  draw_box_line "• Restart your editor to load new workflows/skills" 60
  draw_box_line "• Test with editor commands (e.g., /think)" 60
  draw_box_line "• See README.md for documentation" 60
  draw_box_close 60
  echo ""

  echo "Press ENTER to exit..."
  read -r

  return 0
}

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME [--wizard] or $SCRIPT_NAME --agent <agent> --level <level> [options...]

Interactive Mode (Recommended):
  --wizard              Launch interactive installation wizard with guided setup

CLI Mode (for automation):
  --agent <agent>       Agent to install (windsurf|windsurf-next|claude|cursor|opencode|all)
  --level <level>       Installation level (project|user)

Agents (CLI mode):
  windsurf        Install Windsurf stable channel workflows (auto-detects installation path)
                  Checks: ~/.windsurf, ~/.codeium/.windsurf, ~/.codeium/windsurf
                  Default: ~/.windsurf/workflows if none found
  windsurf-next   Install Windsurf Next channel workflows (auto-detects installations)
                  Checks: ~/.codeium/windsurf-next
                  Installs to all detected Next installations
  claude          Install Claude Code skills (.claude/skills, ~/.claude/skills)
  cursor          Install Cursor skills + commands (.cursor/skills + .cursor/commands, ~/.cursor/skills + ~/.cursor/commands)
  opencode        Install OpenCode commands (.opencode/commands, ~/.config/opencode/commands)
  all             Install for all agents (intelligently detects all Windsurf installations)

Levels:
  project         Install into the specified project (default: current directory)
  user            Install into user-level locations for the chosen agent(s)

CLI Options:
  --project-dir <dir>  Project root to use for project-level installs (default: current directory)
  --force              Overwrite any existing agent-deep-toolkit installation at the destination
  --dry-run            Print what would be done without making any filesystem changes
  --uninstall          Uninstall Agent Deep Toolkit artifacts for the selected agent/level instead of installing
  --clean-up           Like --uninstall, reserved for more aggressive cleanup in future versions
  --detect-only        Detect and report existing installations for the selected agent/level without changing the filesystem
  --yes, --non-interactive
                       Do not prompt for confirmation during uninstall; assume "yes" to prompts

Examples:
  # Interactive wizard (recommended for first-time users)
  $SCRIPT_NAME --wizard

  # CLI mode: Install Windsurf workflows (auto-detects stable installation)
  $SCRIPT_NAME --agent windsurf --level user

  # CLI mode: Install to all agents and all detected Windsurf installations
  $SCRIPT_NAME --agent all --level user

  # CLI mode: Detect existing installations without installing
  $SCRIPT_NAME --agent all --level user --detect-only

  # CLI mode: Uninstall everything from all detected locations
  $SCRIPT_NAME --agent all --level user --uninstall --yes
USAGE
}

prompt_confirm() {
  local message="$1"
  if [ "${YES:-false}" = true ] || [ "${DRY_RUN:-false}" = true ]; then
    return 0
  fi
  printf "%s [y/N] " "$message" >&2
  # shellcheck disable=SC2162
  read reply || return 1
  case "$reply" in
    y|Y|yes|YES)
      return 0
      ;;
    *)
      echo "[info] operation cancelled by user" >&2
      return 1
      ;;
  esac
}

detect_windsurf_stable_installation() {
  # Detect Windsurf stable channel installation (priority order)
  # Returns the path to the workflows directory if found, defaults to standard location

  # Priority order for stable channel detection:
  # 1. ~/.windsurf/workflows (traditional/standard location)
  # 2. ~/.codeium/.windsurf/workflows (codeium subdirectory variant)
  # 3. ~/.codeium/windsurf/global_workflows (global workflows in codeium)

  local candidates=(
    "$HOME/.windsurf/workflows"
    "$HOME/.codeium/.windsurf/workflows"
    "$HOME/.codeium/windsurf/global_workflows"
  )

  for path in "${candidates[@]}"; do
    # Check if parent directory exists (the windsurf installation root)
    local parent_dir="${path%/*}"
    if [ -d "$parent_dir" ]; then
      echo "$path"
      return 0
    fi
  done

  # Default to traditional stable location if nothing found
  echo "$HOME/.windsurf/workflows"
  return 0
}

detect_windsurf_next_installations() {
  # Detect all Windsurf Next channel installations
  # Returns array of paths that exist

  local candidates=(
    "$HOME/.codeium/windsurf-next/global_workflows"
  )

  local found_paths=()
  for path in "${candidates[@]}"; do
    local parent_dir="${path%/*}"
    if [ -d "$parent_dir" ]; then
      found_paths+=("$path")
    fi
  done

  # Return found paths or default if none exist
  if [ "${#found_paths[@]}" -eq 0 ]; then
    echo "$HOME/.codeium/windsurf-next/global_workflows"
  else
    printf '%s\n' "${found_paths[@]}"
  fi
}

detect_all_windsurf_stable_installations() {
  # Detect all Windsurf stable channel installations
  # Returns array of paths that exist

  local candidates=(
    "$HOME/.windsurf/workflows"
    "$HOME/.codeium/.windsurf/workflows"
    "$HOME/.codeium/windsurf/global_workflows"
  )

  local found_paths=()
  for path in "${candidates[@]}"; do
    local parent_dir="${path%/*}"
    if [ -d "$parent_dir" ]; then
      found_paths+=("$path")
    fi
  done

  # Return found paths or default if none exist
  if [ "${#found_paths[@]}" -eq 0 ]; then
    echo "$HOME/.windsurf/workflows"
  else
    printf '%s\n' "${found_paths[@]}"
  fi
}

detect_all_windsurf_installations() {
  # Detect all Windsurf installations (all stable + all next)
  # Returns array of unique paths

  local all_paths=()

  # Add all stable installations
  while IFS= read -r stable_path; do
    all_paths+=("$stable_path")
  done < <(detect_all_windsurf_stable_installations)

  # Add all next installations
  while IFS= read -r next_path; do
    all_paths+=("$next_path")
  done < <(detect_windsurf_next_installations)

  printf '%s\n' "${all_paths[@]}"
}

copy_windsurf_workflows() {
  local dest="$1"

  if [ ! -d "$WINDSURF_WORKFLOWS_DIR" ]; then
    echo "[error] Windsurf workflows directory not found: $WINDSURF_WORKFLOWS_DIR" >&2
    exit 1
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest"
  else
    mkdir -p "$dest"
  fi

  shopt -s nullglob
  local files=("$WINDSURF_WORKFLOWS_DIR"/*.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no .md files found in $WINDSURF_WORKFLOWS_DIR" >&2
    return 0
  fi

  for file in "${files[@]}"; do
    local base
    base="$(basename "$file")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would install Windsurf workflow $base -> $dest"
    else
      cp "$file" "$dest/$base"
      echo "[ok] installed Windsurf workflow $base -> $dest"
    fi
  done
}

copy_windsurf_skills() {
  local dest_root="$1"

  if [ ! -d "$WINDSURF_SKILLS_DIR" ]; then
    echo "[warn] Windsurf skills directory not found: $WINDSURF_SKILLS_DIR" >&2
    echo "[info] This is expected if using single-output strategy (no dual-output)"
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest_root"
  else
    mkdir -p "$dest_root"
  fi

  shopt -s nullglob
  local skills=("$WINDSURF_SKILLS_DIR"/*)
  if [ "${#skills[@]}" -eq 0 ]; then
    echo "[warn] no skills found in $WINDSURF_SKILLS_DIR" >&2
    return 0
  fi

  for skill_dir in "${skills[@]}"; do
    if [ ! -d "$skill_dir" ]; then
      continue
    fi
    local name
    name="$(basename "$skill_dir")"
    local dest_skill_dir="$dest_root/$name"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would ensure directory exists: $dest_skill_dir"
      echo "[dry-run] would install Windsurf skill $name -> $dest_skill_dir"
    else
      mkdir -p "$dest_skill_dir"
      cp -R "$skill_dir"/. "$dest_skill_dir"/
      echo "[ok] installed Windsurf skill $name -> $dest_skill_dir"
    fi
  done
}

copy_claude_skills() {
  local dest_root="$1"

  if [ ! -d "$CLAUDE_SKILLS_DIR" ]; then
    echo "[error] Claude skills directory not found: $CLAUDE_SKILLS_DIR" >&2
    exit 1
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest_root"
  else
    mkdir -p "$dest_root"
  fi

  shopt -s nullglob
  local skills=("$CLAUDE_SKILLS_DIR"/*)
  if [ "${#skills[@]}" -eq 0 ]; then
    echo "[warn] no skills found in $CLAUDE_SKILLS_DIR" >&2
    return 0
  fi

  for skill_dir in "${skills[@]}"; do
    if [ ! -d "$skill_dir" ]; then
      continue
    fi
    local name
    name="$(basename "$skill_dir")"
    local dest_skill_dir="$dest_root/$name"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would ensure directory exists: $dest_skill_dir"
      echo "[dry-run] would install Claude skill $name -> $dest_skill_dir"
    else
      mkdir -p "$dest_skill_dir"
      cp -R "$skill_dir"/. "$dest_skill_dir"/
      echo "[ok] installed Claude skill $name -> $dest_skill_dir"
    fi
  done
}

copy_cursor_commands() {
  local dest="$1"

  if [ ! -d "$CURSOR_COMMANDS_DIR" ]; then
    echo "[error] Cursor commands directory not found: $CURSOR_COMMANDS_DIR" >&2
    exit 1
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest"
  else
    mkdir -p "$dest"
  fi

  shopt -s nullglob
  local files=("$CURSOR_COMMANDS_DIR"/*.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no .md files found in $CURSOR_COMMANDS_DIR" >&2
    return 0
  fi

  for file in "${files[@]}"; do
    local base
    base="$(basename "$file")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would install Cursor command $base -> $dest"
    else
      cp "$file" "$dest/$base"
      echo "[ok] installed Cursor command $base -> $dest"
    fi
  done
}

copy_cursor_skills() {
  local dest_root="$1"

  if [ ! -d "$CURSOR_SKILLS_DIR" ]; then
    echo "[warn] Cursor skills directory not found: $CURSOR_SKILLS_DIR" >&2
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest_root"
  else
    mkdir -p "$dest_root"
  fi

  shopt -s nullglob
  local skills=("$CURSOR_SKILLS_DIR"/*)
  if [ "${#skills[@]}" -eq 0 ]; then
    echo "[warn] no skills found in $CURSOR_SKILLS_DIR" >&2
    return 0
  fi

  for skill_dir in "${skills[@]}"; do
    if [ ! -d "$skill_dir" ]; then
      continue
    fi
    local name
    name="$(basename "$skill_dir")"
    local dest_skill_dir="$dest_root/$name"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would ensure directory exists: $dest_skill_dir"
      echo "[dry-run] would install Cursor skill $name -> $dest_skill_dir"
    else
      mkdir -p "$dest_skill_dir"
      cp -R "$skill_dir"/. "$dest_skill_dir"/
      echo "[ok] installed Cursor skill $name -> $dest_skill_dir"
    fi
  done
}

copy_opencode_commands() {
  local dest="$1"

  if [ ! -d "$OPENCODE_COMMANDS_DIR" ]; then
    echo "[error] OpenCode commands directory not found: $OPENCODE_COMMANDS_DIR" >&2
    exit 1
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would ensure directory exists: $dest"
  else
    mkdir -p "$dest"
  fi

  shopt -s nullglob
  local files=("$OPENCODE_COMMANDS_DIR"/*/SKILL.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no SKILL.md files found in $OPENCODE_COMMANDS_DIR/*/" >&2
    return 0
  fi

  for file in "${files[@]}"; do
    local skill_name
    skill_name=$(basename "$(dirname "$file")")
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would install OpenCode command $skill_name -> $dest"
    else
      cp "$file" "$dest/${skill_name}.md"
      echo "[ok] installed OpenCode command ${skill_name}.md -> $dest"
    fi
  done
}

install_windsurf_to() {
  local dest="$1"
  local label="$2"
  local version_file="$dest/.agent-deep-toolkit-version"

  if [ -f "$version_file" ] && [ "${FORCE:-false}" != "true" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would detect existing agent-deep-toolkit version $existing in $dest ($label); rerun with --force to overwrite."
    else
      echo "[info] existing agent-deep-toolkit version $existing detected in $dest ($label); use --force to overwrite." >&2
    fi
    return 0
  fi

  copy_windsurf_workflows "$dest"
  
  # Also install Windsurf skills for dual-output parity (auto-invocation support)
  local skills_dest="$dest/.windsurf/skills"
  copy_windsurf_skills "$skills_dest"
  
  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would record toolkit version $TOOLKIT_VERSION in $version_file"
  else
    echo "$TOOLKIT_VERSION" >"$version_file"
  fi
}

install_claude_to() {
  local dest="$1"
  local label="$2"
  local version_file="$dest/.agent-deep-toolkit-version"

  if [ -f "$version_file" ] && [ "${FORCE:-false}" != "true" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would detect existing agent-deep-toolkit version $existing in $dest ($label); rerun with --force to overwrite."
    else
      echo "[info] existing agent-deep-toolkit version $existing detected in $dest ($label); use --force to overwrite." >&2
    fi
    return 0
  fi

  copy_claude_skills "$dest"
  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would record toolkit version $TOOLKIT_VERSION in $version_file"
  else
    echo "$TOOLKIT_VERSION" >"$version_file"
  fi
}

install_cursor_to() {
  local dest="$1"
  local label="$2"
  local version_file="$dest/.agent-deep-toolkit-version"

  if [ -f "$version_file" ] && [ "${FORCE:-false}" != "true" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would detect existing agent-deep-toolkit version $existing in $dest ($label); rerun with --force to overwrite."
    else
      echo "[info] existing agent-deep-toolkit version $existing detected in $dest ($label); use --force to overwrite." >&2
    fi
    return 0
  fi

  # Best-effort cleanup of legacy Cursor command names when forcing install.
  # Older toolkit releases installed `deep-*.md` into ~/.cursor/commands. Those are no longer canonical.
  if [ "${FORCE:-false}" = "true" ]; then
    shopt -s nullglob
    local legacy=("$dest"/deep-*.md)
    if [ "${#legacy[@]}" -gt 0 ]; then
      if [ "${DRY_RUN:-false}" = true ]; then
        for f in "${legacy[@]}"; do
          echo "[dry-run] would remove legacy Cursor command $(basename "$f") from $dest"
        done
      else
        for f in "${legacy[@]}"; do
          rm -f "$f"
          echo "[ok] removed legacy Cursor command $(basename "$f") from $dest"
        done
      fi
    fi
  fi

  copy_cursor_commands "$dest"
  # Also install Cursor skills (Cursor 2.4+ Agent Skills standard)
  local cursor_root
  cursor_root="$(dirname "$dest")"
  local skills_dest="$cursor_root/skills"
  copy_cursor_skills "$skills_dest"
  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would record toolkit version $TOOLKIT_VERSION in $version_file"
  else
    echo "$TOOLKIT_VERSION" >"$version_file"
  fi
}

install_opencode_to() {
  local dest="$1"
  local label="$2"
  local version_file="$dest/.agent-deep-toolkit-version"

  if [ -f "$version_file" ] && [ "${FORCE:-false}" != "true" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would detect existing agent-deep-toolkit version $existing in $dest ($label); rerun with --force to overwrite."
    else
      echo "[info] existing agent-deep-toolkit version $existing detected in $dest ($label); use --force to overwrite." >&2
    fi
    return 0
  fi

  copy_opencode_commands "$dest"
  if [ "${DRY_RUN:-false}" = true ]; then
    echo "[dry-run] would record toolkit version $TOOLKIT_VERSION in $version_file"
  else
    echo "$TOOLKIT_VERSION" >"$version_file"
  fi
}

if [ "$#" -eq 0 ]; then
  usage
  exit 0
fi

WIZARD_MODE=false
AGENT=""
LEVEL=""
PROJECT_DIR="$PWD"
FORCE=false
DRY_RUN=false
UNINSTALL=false
CLEAN_UP=false
DETECT_ONLY=false
YES=false

while [ "$#" -gt 0 ]; do
  case "$1" in
    --wizard)
      WIZARD_MODE=true
      shift 1
      ;;
    --agent)
      AGENT="${2:-}"
      shift 2
      ;;
    --level)
      LEVEL="${2:-}"
      shift 2
      ;;
    --project-dir)
      PROJECT_DIR="${2:-}"
      shift 2
      ;;
    --force|--overwrite)
      FORCE=true
      shift 1
      ;;
    --dry-run)
      DRY_RUN=true
      shift 1
      ;;
    --uninstall)
      UNINSTALL=true
      shift 1
      ;;
    --clean-up)
      CLEAN_UP=true
      shift 1
      ;;
    --detect-only)
      DETECT_ONLY=true
      shift 1
      ;;
    --yes|--non-interactive)
      YES=true
      shift 1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[error] unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

# Handle wizard mode
if [ "$WIZARD_MODE" = true ]; then
  run_wizard
  exit $?
fi

# CLI mode validation
if [ -z "$AGENT" ] || [ -z "$LEVEL" ]; then
  echo "[error] --agent and --level are required (or use --wizard)" >&2
  usage
  exit 1
fi

if [ "$LEVEL" = "project" ] && [ "$PROJECT_DIR" = "/" ]; then
  echo "[error] refusing to install into project-dir '/' (this is almost certainly unintended)." >&2
  exit 1
fi

MODE="install"
if [ "$DETECT_ONLY" = true ]; then
  MODE="detect"
elif [ "$UNINSTALL" = true ] || [ "$CLEAN_UP" = true ]; then
  MODE="uninstall"
fi

echo "[info] agent=$AGENT level=$LEVEL project_dir=$PROJECT_DIR force=$FORCE dry_run=$DRY_RUN mode=$MODE"
if [ "$DRY_RUN" = true ]; then
  echo "[info] running in dry-run mode; no filesystem changes will be made."
fi

uninstall_windsurf_from() {
  local dest="$1"
  local label="$2"

  if [ ! -d "$dest" ]; then
    echo "[info] no Windsurf directory found at $dest ($label); nothing to do."
    return 0
  fi

  local version_file="$dest/.agent-deep-toolkit-version"
  if [ -f "$version_file" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    echo "[info] detected agent-deep-toolkit version $existing in $dest ($label)."
  else
    echo "[info] no .agent-deep-toolkit-version found in $dest ($label); will still look for deep-*.md workflows."
  fi

  shopt -s nullglob
  local files=("$dest"/*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no .md workflows or version file found in $dest ($label); nothing to uninstall."
    return 0
  fi

  echo "[info] the following Windsurf workflows would be removed from $dest ($label):"
  for file in "${files[@]}"; do
    echo "  - $(basename "$file")"
  done
  if [ -f "$version_file" ]; then
    echo "  - .agent-deep-toolkit-version"
  fi

  if [ "$MODE" = "detect" ]; then
    return 0
  fi

  if ! prompt_confirm "Proceed with uninstall from $dest ($label)?"; then
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    for file in "${files[@]}"; do
      echo "[dry-run] would remove $file"
    done
    if [ -f "$version_file" ]; then
      echo "[dry-run] would remove $version_file"
    fi
  else
    for file in "${files[@]}"; do
      rm -f "$file"
      echo "[ok] removed $file"
    done
    if [ -f "$version_file" ]; then
      rm -f "$version_file"
      echo "[ok] removed $version_file"
    fi
  fi
}

uninstall_opencode_from() {
  local dest="$1"
  local label="$2"

  if [ ! -d "$dest" ]; then
    echo "[info] no OpenCode commands directory found at $dest ($label); nothing to do."
    return 0
  fi

  local version_file="$dest/.agent-deep-toolkit-version"
  if [ -f "$version_file" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    echo "[info] detected agent-deep-toolkit version $existing in $dest ($label)."
  else
    echo "[info] no .agent-deep-toolkit-version found in $dest ($label); will still look for deep-*.md commands."
  fi

  shopt -s nullglob
  local files=("$dest"/*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no .md commands or version file found in $dest ($label); nothing to uninstall."
    return 0
  fi

  echo "[info] the following OpenCode commands would be removed from $dest ($label):"
  for file in "${files[@]}"; do
    echo "  - $(basename "$file")"
  done
  if [ -f "$version_file" ]; then
    echo "  - .agent-deep-toolkit-version"
  fi

  if [ "$MODE" = "detect" ]; then
    return 0
  fi

  if ! prompt_confirm "Proceed with uninstall from $dest ($label)?"; then
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    for file in "${files[@]}"; do
      echo "[dry-run] would remove $file"
    done
    if [ -f "$version_file" ]; then
      echo "[dry-run] would remove $version_file"
    fi
  else
    for file in "${files[@]}"; do
      rm -f "$file"
      echo "[ok] removed $file"
    done
    if [ -f "$version_file" ]; then
      rm -f "$version_file"
      echo "[ok] removed $version_file"
    fi
  fi
}

uninstall_claude_from() {
  local dest_root="$1"
  local label="$2"

  if [ ! -d "$dest_root" ]; then
    echo "[info] no Claude skills directory found at $dest_root ($label); nothing to do."
    return 0
  fi

  local version_file="$dest_root/.agent-deep-toolkit-version"
  if [ -f "$version_file" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    echo "[info] detected agent-deep-toolkit version $existing in $dest_root ($label)."
  else
    echo "[info] no .agent-deep-toolkit-version found in $dest_root ($label); will still look for deep-* skills."
  fi

  shopt -s nullglob
  local skill_dirs=("$dest_root"/*)
  local found=false
  echo "[info] the following Claude skills/directories would be removed from $dest_root ($label) if present:"
  for sd in "${skill_dirs[@]}"; do
    if [ -d "$sd" ]; then
      found=true
      echo "  - $(basename "$sd")"
    fi
  done
  if [ -f "$version_file" ]; then
    echo "  - .agent-deep-toolkit-version"
  fi

  if [ "$found" = false ] && [ ! -f "$version_file" ]; then
    echo "[info] no deep-* skills or version file found in $dest_root ($label); nothing to uninstall."
    return 0
  fi

  if [ "$MODE" = "detect" ]; then
    return 0
  fi

  if ! prompt_confirm "Proceed with uninstall from $dest_root ($label)?"; then
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    for sd in "${skill_dirs[@]}"; do
      if [ -d "$sd" ]; then
        echo "[dry-run] would remove directory $sd"
      fi
    done
    if [ -f "$version_file" ]; then
      echo "[dry-run] would remove $version_file"
    fi
  else
    for sd in "${skill_dirs[@]}"; do
      if [ -d "$sd" ]; then
        rm -rf "$sd"
        echo "[ok] removed directory $sd"
      fi
    done
    if [ -f "$version_file" ]; then
      rm -f "$version_file"
      echo "[ok] removed $version_file"
    fi
  fi
}

uninstall_cursor_from() {
  local dest="$1"
  local label="$2"

  if [ ! -d "$dest" ]; then
    echo "[info] no Cursor commands directory found at $dest ($label); nothing to do."
    return 0
  fi

  local version_file="$dest/.agent-deep-toolkit-version"
  if [ -f "$version_file" ]; then
    local existing
    existing="$(cat "$version_file" 2>/dev/null || echo "unknown")"
    echo "[info] detected agent-deep-toolkit version $existing in $dest ($label)."
  else
    echo "[info] no .agent-deep-toolkit-version found in $dest ($label); will still look for deep-*.md commands."
  fi

  shopt -s nullglob
  local files=("$dest"/*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no .md commands or version file found in $dest ($label); nothing to uninstall."
    return 0
  fi

  echo "[info] the following Cursor commands would be removed from $dest ($label):"
  for file in "${files[@]}"; do
    echo "  - $(basename "$file")"
  done
  if [ -f "$version_file" ]; then
    echo "  - .agent-deep-toolkit-version"
  fi

  if [ "$MODE" = "detect" ]; then
    return 0
  fi

  if ! prompt_confirm "Proceed with uninstall from $dest ($label)?"; then
    return 0
  fi

  if [ "${DRY_RUN:-false}" = true ]; then
    for file in "${files[@]}"; do
      echo "[dry-run] would remove $file"
    done
    if [ -f "$version_file" ]; then
      echo "[dry-run] would remove $version_file"
    fi
  else
    for file in "${files[@]}"; do
      rm -f "$file"
      echo "[ok] removed $file"
    done
    if [ -f "$version_file" ]; then
      rm -f "$version_file"
      echo "[ok] removed $version_file"
    fi
  fi
}

case "$AGENT" in
  windsurf)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
        else
          uninstall_windsurf_from "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
        fi
        ;;
      user)
        STABLE_PATH="$(detect_windsurf_stable_installation)"
        if [ "$MODE" = "install" ]; then
          echo "[info] detected Windsurf stable installation path: $STABLE_PATH"
          install_windsurf_to "$STABLE_PATH" "windsurf user (auto-detected)"
        else
          uninstall_windsurf_from "$STABLE_PATH" "windsurf user (auto-detected)"
        fi
        ;;
      *)
        echo "[error] unsupported level for agent windsurf: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  windsurf-next)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf-next project"
        else
          uninstall_windsurf_from "$PROJECT_DIR/.windsurf/workflows" "windsurf-next project"
        fi
        ;;
      user)
        echo "[info] detecting Windsurf Next installations..."
        NEXT_PATHS=()
        while IFS= read -r path; do
          NEXT_PATHS+=("$path")
        done < <(detect_windsurf_next_installations)

        if [ "${#NEXT_PATHS[@]}" -eq 0 ]; then
          echo "[warn] no Windsurf Next installations detected; using default"
          NEXT_PATHS=(
            "$HOME/.codeium/windsurf-next/global_workflows"
          )
        else
          echo "[info] found ${#NEXT_PATHS[@]} Windsurf Next installation(s)"
        fi

        for next_path in "${NEXT_PATHS[@]}"; do
          LABEL="windsurf-next user ($(echo "$next_path" | sed "s|$HOME/||"))"
          if [ "$MODE" = "install" ]; then
            install_windsurf_to "$next_path" "$LABEL"
          else
            uninstall_windsurf_from "$next_path" "$LABEL"
          fi
        done
        ;;
      *)
        echo "[error] unsupported level for agent windsurf-next: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  claude)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
        else
          uninstall_claude_from "$PROJECT_DIR/.claude/skills" "claude project"
        fi
        ;;
      user)
        if [ "$MODE" = "install" ]; then
          install_claude_to "$HOME/.claude/skills" "claude user"
        else
          uninstall_claude_from "$HOME/.claude/skills" "claude user"
        fi
        ;;
      *)
        echo "[error] unsupported level for agent claude: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  cursor)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_cursor_to "$PROJECT_DIR/.cursor/commands" "cursor project"
        else
          uninstall_cursor_from "$PROJECT_DIR/.cursor/commands" "cursor project"
        fi
        ;;
      user)
        if [ "$MODE" = "install" ]; then
          install_cursor_to "$HOME/.cursor/commands" "cursor user"
        else
          uninstall_cursor_from "$HOME/.cursor/commands" "cursor user"
        fi
        ;;
      *)
        echo "[error] unsupported level for agent cursor: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  opencode)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_opencode_to "$PROJECT_DIR/.opencode/commands" "opencode project"
        else
          uninstall_opencode_from "$PROJECT_DIR/.opencode/commands" "opencode project"
        fi
        ;;
      user)
        if [ "$MODE" = "install" ]; then
          install_opencode_to "$HOME/.config/opencode/commands" "opencode user"
        else
          uninstall_opencode_from "$HOME/.config/opencode/commands" "opencode user"
        fi
        ;;
      *)
        echo "[error] unsupported level for agent opencode: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  all)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
          install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
          install_cursor_to "$PROJECT_DIR/.cursor/commands" "cursor project"
          install_opencode_to "$PROJECT_DIR/.opencode/commands" "opencode project"
        else
          uninstall_windsurf_from "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
          uninstall_claude_from "$PROJECT_DIR/.claude/skills" "claude project"
          uninstall_cursor_from "$PROJECT_DIR/.cursor/commands" "cursor project"
          uninstall_opencode_from "$PROJECT_DIR/.opencode/commands" "opencode project"
        fi
        ;;
      user)
        echo "[info] detecting all Windsurf installations..."
        ALL_WINDSURF_PATHS=()
        while IFS= read -r path; do
          ALL_WINDSURF_PATHS+=("$path")
        done < <(detect_all_windsurf_installations)

        echo "[info] found ${#ALL_WINDSURF_PATHS[@]} total Windsurf installation path(s)"

        if [ "$MODE" = "install" ]; then
          # Install to all detected Windsurf paths
          for ws_path in "${ALL_WINDSURF_PATHS[@]}"; do
            WS_LABEL="windsurf ($(echo "$ws_path" | sed "s|$HOME/||"))"
            install_windsurf_to "$ws_path" "$WS_LABEL"
          done
          install_claude_to "$HOME/.claude/skills" "claude user"
          install_cursor_to "$HOME/.cursor/commands" "cursor user"
          install_opencode_to "$HOME/.config/opencode/commands" "opencode user"
        else
          # Uninstall from all detected Windsurf paths
          for ws_path in "${ALL_WINDSURF_PATHS[@]}"; do
            WS_LABEL="windsurf ($(echo "$ws_path" | sed "s|$HOME/||"))"
            uninstall_windsurf_from "$ws_path" "$WS_LABEL"
          done
          uninstall_claude_from "$HOME/.claude/skills" "claude user"
          uninstall_cursor_from "$HOME/.cursor/commands" "cursor user"
          uninstall_opencode_from "$HOME/.config/opencode/commands" "opencode user"
        fi
        ;;
      *)
        echo "[error] unsupported level for agent all: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  *)
    echo "[error] unsupported agent: $AGENT" >&2
    usage
    exit 1
    ;;
esac
