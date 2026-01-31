---
name: prune
description: Aggressively identify and remove legacy, deprecated, redundant, duplicate, and orphaned code with systematic impact analysis
command: /prune
aliases: ["/purge", "/cleanup", "/delete-dead-code", "/sweep"]
synonyms: ["/pruning", "/pruned", "/prunes", "/purging", "/purged", "/purges", "/cleaning", "/cleaned", "/cleanups", "/sweeping", "/swept", "/sweeps", "/delete-legacy", "/remove-dead"]
activation-mode: auto
user-invocable: true
disable-model-invocation: false
---

# Prune - Aggressive Codebase Cleanup

Systematically identify and remove legacy, deprecated, redundant, duplicate, and orphaned code. This skill operates with an aggressive-by-default posture: if code is committed and changes leave behind dead weight, **delete it**.

## Philosophy

AI agents resist deletion. They hedge, they preserve "just in case", they add backward-compatibility shims nobody asked for. This skill overrides that instinct.

**Core principles:**

- **Dead code is technical debt with zero value** — It confuses future agents, bloats context windows, and creates false dependencies
- **Committed code is recoverable** — Git exists. Deletion is reversible. There is no risk in removing code that's in version history
- **Backward compatibility is for public consumers only** — Internal code, private APIs, unused exports, and unreferenced modules get no protection
- **Aggressive pruning is cheap with AI agents** — If something breaks, an agent can fix it faster than a human can maintain dead code
- **Less code = fewer bugs, faster builds, clearer intent**

## When to Use

- **After any significant change** — New features, refactors, and redesigns leave orphaned code
- **After dependency upgrades** — Old compatibility shims, polyfills, and workarounds become dead weight
- **After feature removal** — Related utilities, types, tests, and docs linger
- **Periodic maintenance** — Codebases accumulate cruft over time
- **After `/integrate` or `/propagate`** — Integration changes often obsolete old implementations
- **When context windows are bloated** — Dead code wastes agent context budget

## When NOT to Prune

- **Public API with external consumers** — Libraries, SDKs, or APIs with users you don't control
- **Uncommitted work** — Always commit or stash before pruning
- **Active feature flags** — Code behind flags that are still being evaluated
- **Shared monorepo modules** — Unless you've verified all consumers

**Important:** "Someone might need this" is not a valid reason to keep dead code. "An external user depends on this" is.

## Core Prune Workflow

### 1. Establish Prune Scope

**Define what triggered the prune and what's in scope:**

```
🔍 Prune Scope
─────────────────────────────────────────────
**Trigger:** [What change created the dead code?]
**Scope:** [Files, directories, modules affected]
**Constraint:** [Any code that MUST be preserved]

**Public consumers?**
- [ ] Published npm package → Preserve public API
- [ ] REST API with external clients → Preserve endpoints
- [ ] Shared library across teams → Check all consumers
- [ ] Internal only → Full prune authority
─────────────────────────────────────────────
```

**If no public consumers exist: prune aggressively. No exceptions.**

### 2. Detect Dead Code

**Systematically scan for every category of dead code:**

**Category 1: Orphaned files**
```bash
# Find files not imported/required anywhere
# For each source file, check if any other file references it
for file in $(find src -name "*.ts" -o -name "*.js"); do
  basename=$(basename "$file" | sed 's/\.[^.]*$//')
  refs=$(grep -rl "$basename" src/ --include="*.ts" --include="*.js" | grep -v "$file" | wc -l)
  if [ "$refs" -eq 0 ]; then
    echo "ORPHAN: $file"
  fi
done
```

**Category 2: Unused exports**
```bash
# Find exported symbols not imported elsewhere
grep -rn "export " src/ | while read line; do
  symbol=$(echo "$line" | grep -oP '(?<=export (?:const|function|class|type|interface|enum) )\w+')
  if [ -n "$symbol" ]; then
    refs=$(grep -rl "$symbol" src/ | wc -l)
    if [ "$refs" -le 1 ]; then
      echo "UNUSED EXPORT: $symbol in $line"
    fi
  fi
done
```

**Category 3: Dead functions and variables**
- Functions/methods never called
- Variables assigned but never read
- Constants defined but never referenced
- Type definitions never used

**Category 4: Deprecated code**
- `@deprecated` annotations
- `// TODO: remove` comments
- `// DEPRECATED` markers
- `// legacy` or `// old` comments
- Commented-out code blocks

**Category 5: Redundant implementations**
- Duplicate functions doing the same thing
- Wrapper functions that just pass through
- Compatibility shims for versions no longer supported
- Polyfills for features now natively available
- Re-exports that serve no abstraction purpose

**Category 6: Orphaned tests**
- Tests for deleted functions
- Test files for removed modules
- Test utilities only used by deleted tests
- Snapshot files for removed components

**Category 7: Orphaned documentation**
- Docs referencing deleted features
- README sections for removed functionality
- JSDoc/TSDoc for deleted functions
- Stale comments describing removed behavior

**Category 8: Orphaned configuration**
- Environment variables no longer read
- Config keys no longer used
- Feature flags for shipped/removed features
- Build targets for removed code

### 3. Assess Impact

**Before deleting, run impact analysis on each candidate:**

```
⚡ Impact Assessment
─────────────────────────────────────────────
**File/Symbol:** [what to delete]
**Category:** [orphan | unused | deprecated | redundant | duplicate]

**References found:**
- [ ] Direct imports: [count]
- [ ] Type references: [count]
- [ ] String references: [count]
- [ ] Test references: [count]
- [ ] Doc references: [count]

**Dependency chain:**
- [Who imports this?]
- [Who imports the importers?]
- [Is anything in the chain still live?]

**Public surface?**
- [ ] Exported from package entry point → CHECK CONSUMERS
- [ ] Internal module only → SAFE TO DELETE
- [ ] Test-only → SAFE TO DELETE

**Verdict:** [DELETE | PRESERVE (with reason) | INVESTIGATE]
─────────────────────────────────────────────
```

**Decision rules:**

| Condition | Action |
|-----------|--------|
| Zero references anywhere | **DELETE immediately** |
| Only referenced by other dead code | **DELETE the entire chain** |
| Referenced by tests only (no production code) | **DELETE code AND tests** |
| Referenced by docs only | **DELETE code AND update docs** |
| Marked `@deprecated` | **DELETE unless public API** |
| Commented-out code | **DELETE unconditionally** |
| Duplicate of another implementation | **DELETE the worse one, update refs** |
| Compatibility shim for old version | **DELETE if old version unsupported** |
| Re-export with no transformation | **DELETE, update import paths** |
| Referenced by live code | **PRESERVE (but investigate if reference is dead too)** |

### 4. Execute the Prune

**Delete aggressively, in dependency order:**

**Step 1: Delete leaf nodes first**
- Files with no dependents
- Unused exports
- Dead variables and functions

**Step 2: Delete newly orphaned parents**
- After deleting leaves, parents may become orphaned
- Re-scan and delete the next layer
- Repeat until no new orphans appear

**Step 3: Clean up references**
- Remove stale imports
- Remove unused type references
- Update index/barrel files
- Remove re-exports

**Step 4: Delete associated artifacts**
- Tests for deleted code
- Docs for deleted features
- Snapshots for deleted components
- Config for deleted modules

**Step 5: Clean up empty directories**
```bash
find src -type d -empty -delete
```

**Execution template:**
```bash
# Delete files
rm -f path/to/orphan1.ts
rm -f path/to/orphan2.ts
rm -f path/to/orphan3.test.ts

# Remove empty directories
find src -type d -empty -delete

# Verify build still works
npm run build
npm test

# Stage and commit
git add -A
git commit -m "chore: prune dead code from [scope]

Removed:
- [file1]: orphaned after [change]
- [file2]: unused export
- [file3]: deprecated since [version]
- [file4]: tests for removed [module]

Impact: No public API changes. All removed code was internal/unreferenced.
"
```

### 5. Verify the Prune

**Confirm nothing broke:**

```
✅ Prune Verification
─────────────────────────────────────────────
[ ] Build passes (no compilation errors)
[ ] All tests pass (no broken references)
[ ] Linter passes (no unused import warnings)
[ ] Type checker passes (no missing type references)
[ ] Application starts successfully
[ ] No runtime errors in logs
[ ] No new "module not found" errors
─────────────────────────────────────────────
```

**If something breaks:**
1. Check if the "broken" thing is also dead code (delete it too)
2. If live code broke, the reference analysis missed something — fix the reference
3. Do NOT restore deleted code "just in case" — fix the actual dependency

### 6. Report What Was Pruned

**Document the cleanup for transparency:**

```
🗑️ Prune Report
─────────────────────────────────────────────
**Trigger:** [What change caused this prune]
**Scope:** [What was scanned]

**Deleted:**
| Category | Count | Examples |
|----------|-------|----------|
| Orphaned files | [N] | [file1, file2] |
| Unused exports | [N] | [symbol1, symbol2] |
| Dead functions | [N] | [fn1, fn2] |
| Deprecated code | [N] | [module1] |
| Redundant impls | [N] | [dup1] |
| Orphaned tests | [N] | [test1, test2] |
| Orphaned docs | [N] | [doc1] |
| Stale config | [N] | [key1] |

**Lines removed:** [N]
**Files removed:** [N]
**Directories removed:** [N]

**Build status:** ✅ PASS
**Test status:** ✅ PASS ([N] tests, [M] removed)

**Preserved (with reason):**
- [file/symbol]: [reason — must be public API or active consumer]
─────────────────────────────────────────────
```

## Prune Patterns

### Pattern 1: Post-Refactor Prune

After refactoring a module:
1. Old implementation files → **DELETE**
2. Old interface/type files if superseded → **DELETE**
3. Old tests → **DELETE** (new tests should cover new impl)
4. Old re-exports/barrel entries → **DELETE**
5. Compatibility wrappers → **DELETE**
6. `_old`, `_backup`, `_legacy` suffixed files → **DELETE**

### Pattern 2: Post-Dependency-Upgrade Prune

After upgrading a dependency:
1. Polyfills for features now in the dependency → **DELETE**
2. Workarounds for bugs fixed in new version → **DELETE**
3. Version-specific compatibility code → **DELETE**
4. Old lock file entries (handled by package manager) → N/A
5. Shims or adapters for old API → **DELETE**

### Pattern 3: Post-Feature-Removal Prune

After removing a feature:
1. Feature implementation files → **DELETE**
2. Feature-specific components → **DELETE**
3. Feature tests → **DELETE**
4. Feature documentation → **DELETE**
5. Feature-specific config/env vars → **DELETE**
6. Feature flag code → **DELETE**
7. API endpoints for the feature → **DELETE** (unless public)
8. Database migration? → **PRESERVE** (migrations are append-only)

### Pattern 4: Codebase Audit Prune

Periodic full-codebase sweep:
1. Run dead code detection tools (`ts-prune`, `knip`, `unimported`)
2. Check for TODO/FIXME comments older than 90 days
3. Find files not modified in 6+ months with zero references
4. Check for commented-out code blocks
5. Find duplicate implementations across modules
6. Delete everything that has no live consumer

## Agent Anti-Patterns to Override

AI agents commonly resist deletion in these ways. This skill explicitly overrides each:

| Agent Behavior | Override |
|----------------|----------|
| "Keeping for backward compatibility" | **DELETE** unless public API with external consumers |
| "Renaming to `_unused` or `_deprecated`" | **DELETE** entirely — renamed dead code is still dead code |
| "Adding `// @deprecated` instead of deleting" | **DELETE** — deprecation notices are for public APIs only |
| "Moving to `legacy/` folder" | **DELETE** — a graveyard folder is still dead code |
| "Commenting out instead of deleting" | **DELETE** — commented code is the worst form of dead code |
| "Re-exporting for potential future use" | **DELETE** — YAGNI. Git has the history |
| "Keeping tests for deleted code" | **DELETE** — tests for dead code are dead tests |
| "Adding a TODO to remove later" | **DELETE NOW** — "later" never comes |
| "Wrapping in feature flag" | **DELETE** — feature flags are for live features |
| "Preserving the interface, just removing impl" | **DELETE** both — orphaned interfaces are dead code too |

## Tool Integration

**Use with `/impact` for thorough analysis:**
```
/prune [scope] — includes automatic /impact assessment
```

**Use after `/integrate`:**
```
/integrate [changes]
/prune — clean up what the integration obsoleted
```

**Use with `/loop` for autonomous cleanup:**
```
/loop /prune [codebase] — keep pruning until nothing dead remains
```

**Use with `/relentless` for deep audit:**
```
/relentless /prune [codebase] — scan every file, test every reference
```

## Language-Specific Detection

### TypeScript/JavaScript
```bash
# Unused exports
npx ts-prune
npx knip

# Unused files
npx unimported

# Dead code in bundles
npx webpack-bundle-analyzer
```

### Python
```bash
# Unused imports and variables
vulture src/
autoflake --check src/

# Unused dependencies
pip-extra-reqs
```

### Go
```bash
# Unused code
staticcheck ./...
deadcode ./...
```

### General
```bash
# Commented-out code (any language)
grep -rn "^[[:space:]]*//" src/ | grep -v "^[[:space:]]*//$" | head -50

# TODO/FIXME older than 90 days
git log --diff-filter=A --format='%H %ai' -- '*TODO*' | while read hash date rest; do
  if [[ "$date" < "$(date -v-90d +%Y-%m-%d)" ]]; then
    echo "STALE TODO from $date"
  fi
done
```

## Examples

### Example 1: Post-Refactor Cleanup

**Trigger:** Refactored auth module from class-based to functional

**Detected dead code:**
- `src/auth/AuthService.ts` (old class — replaced by `src/auth/validate.ts`)
- `src/auth/AuthService.test.ts` (tests for old class)
- `src/auth/types/AuthServiceOptions.ts` (type only used by old class)
- `src/auth/index.ts` re-exports `AuthService` (no consumers)
- `src/utils/auth-compat.ts` (compatibility wrapper for old API)

**Action:** Delete all 5 files. Update `src/auth/index.ts` to export only new functions.

**Result:** 450 lines removed, 5 files deleted, build passes, tests pass.

### Example 2: Dependency Upgrade Cleanup

**Trigger:** Upgraded `express` from v4 to v5

**Detected dead code:**
- `src/middleware/async-wrapper.ts` (express v5 handles async natively)
- `src/middleware/error-handler-v4.ts` (v4-specific error signature)
- `src/types/express-augment.d.ts` (augmenting types fixed in v5)
- 12 uses of `asyncWrapper()` in route files

**Action:** Delete 3 files, remove all `asyncWrapper()` calls from routes (express v5 handles async errors natively).

**Result:** 180 lines removed, 3 files deleted, 12 files simplified.

### Example 3: Feature Removal Cleanup

**Trigger:** Removed "dark mode" experiment

**Detected dead code:**
- `src/components/ThemeToggle.tsx` (UI component)
- `src/hooks/useDarkMode.ts` (state hook)
- `src/styles/dark-theme.css` (styles)
- `src/config/themes.ts` (theme definitions)
- `src/__tests__/ThemeToggle.test.tsx` (tests)
- `src/__tests__/useDarkMode.test.tsx` (tests)
- `DARK_MODE_ENABLED` env var in `.env.example`
- `dark_mode` feature flag in config

**Action:** Delete all 8 files/references.

**Result:** 620 lines removed, 6 files deleted, 2 config entries removed.

## Anti-Patterns

❌ **"Let's keep it just in case"**
- Git has the history. Delete it now.

❌ **"I'll add a deprecation notice"**
- Deprecation notices are for public APIs. Internal code gets deleted.

❌ **"Let me move it to a legacy folder"**
- A folder full of dead code is still dead code. Delete it.

❌ **"I'll comment it out"**
- Commented code is the worst. It confuses grep, clutters diffs, and never gets uncommented. Delete it.

❌ **"Someone might need this later"**
- YAGNI. If someone needs it later, they can find it in git history or rewrite it (probably better) in minutes with an AI agent.

❌ **"I'll rename it with an underscore prefix"**
- `_oldFunction` is still dead code with a hat on. Delete it.

## Tips

✅ **Always commit before pruning** (so you can diff/revert)
✅ **Delete leaf nodes first, then cascade upward**
✅ **Run build + tests after each batch of deletions**
✅ **Delete commented-out code unconditionally**
✅ **Delete tests for deleted code** (they're dead too)
✅ **Check the entire dependency chain** (deleting one file may orphan others)
✅ **Use language-specific tools** (ts-prune, knip, vulture, deadcode)
✅ **Don't preserve internal code for "backward compatibility"**
✅ **Git is your safety net** — deletion is always reversible
✅ **When in doubt, delete** — if something breaks, fix the reference, don't restore the dead code

---

**Remember**: Dead code has negative value. It wastes context, confuses agents, creates false dependencies, and accumulates indefinitely. The only good dead code is deleted dead code. Be aggressive. Git has your back.
