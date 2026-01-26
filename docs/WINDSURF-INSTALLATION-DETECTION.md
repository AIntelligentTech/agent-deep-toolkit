# Windsurf Installation Detection

## Overview

The installer now intelligently detects Windsurf installations across multiple
possible locations and installation types (stable vs next channel).

## Detection Logic

### Stable Channel Detection (`--agent windsurf`)

When using `--agent windsurf --level user`, the installer detects Windsurf
stable channel installations in priority order:

1. `~/.windsurf/workflows` - Traditional/standard Windsurf stable configuration
2. `~/.codeium/.windsurf/workflows` - Stable in codeium subdirectory variant
3. `~/.codium/.windsurf/workflows` - Stable in codium subdirectory variant
4. `~/.codeium/windsurf/global_workflows` - Global workflows in codeium app data
5. `~/.codium/windsurf/global_workflows` - Global workflows in codium app data

**Behavior:** Installs to the **first detected** location. If none exist,
defaults to `~/.windsurf/workflows`.

### Next Channel Detection (`--agent windsurf-next`)

When using `--agent windsurf-next --level user`, the installer detects all
Windsurf Next channel installations:

1. `~/.codeium/windsurf-next/global_workflows`
2. `~/.codium/windsurf-next/global_workflows`

**Behavior:** Installs to **all detected** Next installations. If none exist,
installs to both default locations.

### All Agents Detection (`--agent all`)

When using `--agent all --level user`, the installer detects:

- **All stable channel installations** (all paths listed above that exist)
- **All next channel installations** (all paths listed above that exist)

**Behavior:** Installs to **every detected** Windsurf installation path.

## Installation Paths Explained

### Why Multiple Paths?

Windsurf can be installed in different configurations:

#### Traditional Stable (`~/.windsurf`)

- Configuration directory: `~/.windsurf/`
- Workflows location: `~/.windsurf/workflows/`
- Used by: Standard Windsurf stable channel installations

#### Codeium/Codium App Data Stable

- App data directory: `~/.codeium/windsurf/` or `~/.codium/windsurf/`
- Global workflows: `~/.codeium/windsurf/global_workflows/` or
  `~/.codium/windsurf/global_workflows/`
- Used by: Windsurf stable channel for global (cross-project) workflows

#### Next Channel

- App data directory: `~/.codeium/windsurf-next/` or `~/.codium/windsurf-next/`
- Global workflows: `~/.codeium/windsurf-next/global_workflows/` or
  `~/.codium/windsurf-next/global_workflows/`
- Used by: Windsurf Next (preview) channel

### Why Both `.codeium` and `.codium`?

Some Windsurf installations use `~/.codeium/` (Codeium branded) while others use
`~/.codium/` (VSCodium/Codium branded). The installer checks both to ensure
compatibility with all variants.

## Examples

### Example 1: Default Fresh Installation

**System state:** No Windsurf installed

```bash
./install.sh --agent windsurf --level user --dry-run
# → Would install to: ~/.windsurf/workflows (default)
```

### Example 2: Traditional Stable Installation

**System state:** `~/.windsurf/` exists

```bash
./install.sh --agent windsurf --level user
# → Installs to: ~/.windsurf/workflows (detected stable)
```

### Example 3: Multiple Stable Paths

**System state:**

- `~/.windsurf/` exists
- `~/.codeium/windsurf/` exists

```bash
./install.sh --agent windsurf --level user
# → Installs to: ~/.windsurf/workflows (first detected, highest priority)

./install.sh --agent all --level user
# → Installs to:
#   - ~/.windsurf/workflows (stable #1)
#   - ~/.codeium/windsurf/global_workflows (stable #2)
```

### Example 4: Next Channel Only

**System state:**

- `~/.codeium/windsurf-next/` exists
- `~/.codium/windsurf-next/` exists

```bash
./install.sh --agent windsurf-next --level user
# → Installs to both:
#   - ~/.codeium/windsurf-next/global_workflows
#   - ~/.codium/windsurf-next/global_workflows
```

### Example 5: Mixed Stable and Next

**System state:**

- `~/.windsurf/` exists (stable)
- `~/.codeium/windsurf/` exists (stable global workflows)
- `~/.codeium/windsurf-next/` exists (next channel)

```bash
./install.sh --agent windsurf --level user
# → Installs to: ~/.windsurf/workflows only

./install.sh --agent windsurf-next --level user
# → Installs to: ~/.codeium/windsurf-next/global_workflows only

./install.sh --agent all --level user
# → Installs to all detected:
#   - ~/.windsurf/workflows
#   - ~/.codeium/windsurf/global_workflows
#   - ~/.codeium/windsurf-next/global_workflows
```

## Detection Functions

The installer provides three detection functions:

### `detect_windsurf_stable_installation()`

- Returns: First detected stable installation path
- Fallback: `~/.windsurf/workflows` if none found
- Used by: `--agent windsurf`

### `detect_windsurf_next_installations()`

- Returns: All detected Next channel installation paths
- Fallback: Both default Next paths if none found
- Used by: `--agent windsurf-next`

### `detect_all_windsurf_installations()`

- Returns: All detected stable + Next installation paths
- Used by: `--agent all`

### `detect_all_windsurf_stable_installations()`

- Returns: All detected stable channel installation paths
- Fallback: `~/.windsurf/workflows` if none found
- Used by: `--agent all` (internally)

## Verification

To see what the installer would detect on your system:

```bash
# Dry-run shows detection without making changes
./install.sh --agent all --level user --dry-run

# Detect-only mode reports installations without installing
./install.sh --agent all --level user --detect-only
```

## Migration Notes

### v0.3.x → v0.4.0

**Old behavior:**

- `--agent windsurf`: Always installed to `~/.windsurf/workflows`
- `--agent windsurf-next`: Always installed to both `~/.codeium/windsurf-next`
  and `~/.codium/windsurf-next`
- `--agent all`: Hardcoded to specific paths

**New behavior (v0.4.0+):**

- `--agent windsurf`: Intelligently detects stable installation, prioritizes
  `~/.windsurf/workflows`
- `--agent windsurf-next`: Detects and installs to all existing Next
  installations
- `--agent all`: Detects and installs to all existing Windsurf installations
  (stable + next)

**Impact:** If you have Windsurf installed in a non-standard location (e.g.,
only `~/.codeium/windsurf`), the installer will now find it automatically
instead of creating a new installation in the default location.
