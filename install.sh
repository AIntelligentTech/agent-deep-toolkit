#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WINDSURF_WORKFLOWS_DIR="$SCRIPT_DIR/outputs/windsurf/workflows"
CLAUDE_SKILLS_DIR="$SCRIPT_DIR/outputs/claude/skills"
CURSOR_COMMANDS_DIR="$SCRIPT_DIR/outputs/cursor/commands"
TOOLKIT_VERSION="$(cat "$SCRIPT_DIR/VERSION" 2>/dev/null || echo "0.0.0")"

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME --agent <agent> --level <level> [--project-dir <dir>] [--force] [--dry-run] [--uninstall] [--clean-up] [--detect-only] [--yes]

Agents:
  windsurf        Install classic Windsurf workflows (.windsurf/workflows, ~/.windsurf/workflows)
  windsurf-next   Install Windsurf Next global workflows (~/.codeium|~/.codium/windsurf-next/global_workflows)
  claude          Install Claude Code skills (.claude/skills, ~/.claude/skills)
  cursor          Install Cursor commands (.cursor/commands, ~/.cursor/commands)
  all             Install for all supported agents at the chosen level

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
  # Install Windsurf workflows into the current project
  $SCRIPT_NAME --agent windsurf --level project

  # Install Windsurf Next workflows into user-level global locations
  $SCRIPT_NAME --agent windsurf-next --level user

  # Install Claude Code skills into ~/.claude/skills
  $SCRIPT_NAME --agent claude --level user

  # Install Cursor commands into ~/.cursor/commands
  $SCRIPT_NAME --agent cursor --level user

  # Install everything for all agents at the user level
  $SCRIPT_NAME --agent all --level user

  # Uninstall everything for all agents at the user level
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
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$HOME/.windsurf/workflows" "windsurf user"
        else
          uninstall_windsurf_from "$HOME/.windsurf/workflows" "windsurf user"
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
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
          install_windsurf_to "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
        else
          uninstall_windsurf_from "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
          uninstall_windsurf_from "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
        fi
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
  all)
    case "$LEVEL" in
      project)
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
          install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
          install_cursor_to "$PROJECT_DIR/.cursor/commands" "cursor project"
        else
          uninstall_windsurf_from "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
          uninstall_claude_from "$PROJECT_DIR/.claude/skills" "claude project"
          uninstall_cursor_from "$PROJECT_DIR/.cursor/commands" "cursor project"
        fi
        ;;
      user)
        if [ "$MODE" = "install" ]; then
          install_windsurf_to "$HOME/.windsurf/workflows" "windsurf user"
          install_windsurf_to "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
          install_windsurf_to "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
          install_claude_to "$HOME/.claude/skills" "claude user"
          install_cursor_to "$HOME/.cursor/commands" "cursor user"
        else
          uninstall_windsurf_from "$HOME/.windsurf/workflows" "windsurf user"
          uninstall_windsurf_from "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
          uninstall_windsurf_from "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
          uninstall_claude_from "$HOME/.claude/skills" "claude user"
          uninstall_cursor_from "$HOME/.cursor/commands" "cursor user"
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
