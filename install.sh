#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WINDSURF_WORKFLOWS_DIR="$SCRIPT_DIR/outputs/windsurf/workflows"
CLAUDE_SKILLS_DIR="$SCRIPT_DIR/outputs/claude/skills"
CURSOR_COMMANDS_DIR="$SCRIPT_DIR/outputs/cursor/commands"
OPENCODE_COMMANDS_DIR="$SCRIPT_DIR/outputs/opencode/commands"
TOOLKIT_VERSION="$(cat "$SCRIPT_DIR/VERSION" 2>/dev/null || echo "0.0.0")"

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME --agent <agent> --level <level> [--project-dir <dir>] [--force] [--dry-run] [--uninstall] [--clean-up] [--detect-only] [--yes]

Agents:
  windsurf        Install Windsurf stable channel workflows (auto-detects installation path)
                  Checks: ~/.windsurf, ~/.codeium/.windsurf, ~/.codeium/windsurf
                  Default: ~/.windsurf/workflows if none found
  windsurf-next   Install Windsurf Next channel workflows (auto-detects installations)
                  Checks: ~/.codeium/windsurf-next
                  Installs to all detected Next installations
  claude          Install Claude Code skills (.claude/skills, ~/.claude/skills)
  cursor          Install Cursor commands (.cursor/commands, ~/.cursor/commands)
  opencode        Install OpenCode commands (.opencode/commands, ~/.config/opencode/commands)
  all             Install for all agents (intelligently detects all Windsurf installations)

Levels:
  project         Install into the specified project (default: current directory)
  user            Install into user-level locations for the chosen agent(s)

Options:
  --project-dir <dir>  Project root to use for project-level installs (default: current directory)
  --force              Overwrite any existing agent-deep-toolkit installation at the destination
  --dry-run            Print what would be done without making any filesystem changes
  --uninstall          Uninstall Agent Deep Toolkit artifacts for the selected agent/level instead of installing
  --clean-up           Like --uninstall, reserved for more aggressive cleanup in future versions
  --detect-only        Detect and report existing installations for the selected agent/level without changing the filesystem
  --yes, --non-interactive
                       Do not prompt for confirmation during uninstall; assume "yes" to prompts

Examples:
  # Install Windsurf workflows (auto-detects stable installation)
  $SCRIPT_NAME --agent windsurf --level user

  # Install Windsurf Next workflows (auto-detects all Next installations)
  $SCRIPT_NAME --agent windsurf-next --level user

  # Install to all agents and all detected Windsurf installations
  $SCRIPT_NAME --agent all --level user

  # Detect existing installations without installing
  $SCRIPT_NAME --agent all --level user --detect-only

  # Uninstall everything from all detected locations
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
  local files=("$WINDSURF_WORKFLOWS_DIR"/deep-*.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no deep-*.md files found in $WINDSURF_WORKFLOWS_DIR" >&2
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
  local files=("$CURSOR_COMMANDS_DIR"/deep-*.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no deep-*.md files found in $CURSOR_COMMANDS_DIR" >&2
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
  local files=("$OPENCODE_COMMANDS_DIR"/deep-*.md "$OPENCODE_COMMANDS_DIR"/compatibility-*.md)
  if [ "${#files[@]}" -eq 0 ]; then
    echo "[warn] no deep-*.md or compatibility-*.md files found in $OPENCODE_COMMANDS_DIR" >&2
    return 0
  fi

  for file in "${files[@]}"; do
    local base
    base="$(basename "$file")"
    if [ "${DRY_RUN:-false}" = true ]; then
      echo "[dry-run] would install OpenCode command $base -> $dest"
    else
      cp "$file" "$dest/$base"
      echo "[ok] installed OpenCode command $base -> $dest"
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

  copy_cursor_commands "$dest"
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

if [ -z "$AGENT" ] || [ -z "$LEVEL" ]; then
  echo "[error] --agent and --level are required" >&2
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
  local files=("$dest"/deep-*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no deep-*.md workflows or version file found in $dest ($label); nothing to uninstall."
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
  local files=("$dest"/deep-*.md "$dest"/compatibility-*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no deep-*.md or compatibility-*.md commands or version file found in $dest ($label); nothing to uninstall."
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
  local skill_dirs=("$dest_root"/deep-*)
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
  local files=("$dest"/deep-*.md)
  if [ "${#files[@]}" -eq 0 ] && [ ! -f "$version_file" ]; then
    echo "[info] no deep-*.md commands or version file found in $dest ($label); nothing to uninstall."
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
