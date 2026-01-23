#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

WINDSURF_WORKFLOWS_DIR="$SCRIPT_DIR/windsurf/workflows"
CLAUDE_SKILLS_DIR="$SCRIPT_DIR/claude-code/skills"
TOOLKIT_VERSION="$(cat "$SCRIPT_DIR/VERSION" 2>/dev/null || echo "0.0.0")"

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME --agent <agent> --level <level> [--project-dir <dir>] [--force] [--dry-run]

Agents:
  windsurf        Install classic Windsurf workflows (.windsurf/workflows, ~/.windsurf/workflows)
  windsurf-next   Install Windsurf Next global workflows (~/.codeium|~/.codium/windsurf-next/global_workflows)
  claude          Install Claude Code skills (.claude/skills, ~/.claude/skills)
  all             Install for all supported agents at the chosen level

Levels:
  project         Install into the specified project (default: current directory)
  user            Install into user-level locations for the chosen agent(s)

Options:
  --project-dir <dir>  Project root to use for project-level installs (default: current directory)
  --force              Overwrite any existing agent-deep-toolkit installation at the destination
  --dry-run            Print what would be installed without making any filesystem changes

Examples:
  # Install Windsurf workflows into the current project
  $SCRIPT_NAME --agent windsurf --level project

  # Install Windsurf Next workflows into user-level global locations
  $SCRIPT_NAME --agent windsurf-next --level user

  # Install Claude Code skills into ~/.claude/skills
  $SCRIPT_NAME --agent claude --level user

  # Install everything for all agents at the user level
  $SCRIPT_NAME --agent all --level user
USAGE
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

if [ "$#" -eq 0 ]; then
  usage
  exit 0
fi

AGENT=""
LEVEL=""
PROJECT_DIR="$PWD"
FORCE=false
DRY_RUN=false

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

echo "[info] agent=$AGENT level=$LEVEL project_dir=$PROJECT_DIR force=$FORCE dry_run=$DRY_RUN"
if [ "$DRY_RUN" = true ]; then
  echo "[info] running in dry-run mode; no filesystem changes will be made."
fi

case "$AGENT" in
  windsurf)
    case "$LEVEL" in
      project)
        install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
        ;;
      user)
        install_windsurf_to "$HOME/.windsurf/workflows" "windsurf user"
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
        install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf-next project"
        ;;
      user)
        install_windsurf_to "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
        install_windsurf_to "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
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
        install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
        ;;
      user)
        install_claude_to "$HOME/.claude/skills" "claude user"
        ;;
      *)
        echo "[error] unsupported level for agent claude: $LEVEL" >&2
        usage
        exit 1
        ;;
    esac
    ;;
  all)
    case "$LEVEL" in
      project)
        install_windsurf_to "$PROJECT_DIR/.windsurf/workflows" "windsurf project"
        install_claude_to "$PROJECT_DIR/.claude/skills" "claude project"
        ;;
      user)
        install_windsurf_to "$HOME/.windsurf/workflows" "windsurf user"
        install_windsurf_to "$HOME/.codeium/windsurf-next/global_workflows" "windsurf-next user (~/.codeium)"
        install_windsurf_to "$HOME/.codium/windsurf-next/global_workflows" "windsurf-next user (~/.codium)"
        install_claude_to "$HOME/.claude/skills" "claude user"
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
