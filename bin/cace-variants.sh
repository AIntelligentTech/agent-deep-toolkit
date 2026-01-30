#!/usr/bin/env bash
# Generate alias/synonym variants for converted skills

OUTPUTS_DIR="${1:-./outputs}"
REPO_ROOT="$(dirname "$(dirname "$0")")"
SKILLS_DIR="$REPO_ROOT/skills"

clean_command() {
  local cmd="$1"
  cmd="${cmd#/}"
  echo "$cmd"
}

generate_variants() {
  local agent_dir="$1"
  local agent
  agent=$(basename "$agent_dir")
  
  echo "Generating variants for $agent..."
  local variant_count=0
  
  find "$agent_dir" -maxdepth 2 -name "*.md" 2>/dev/null | while read -r md_file; do
    local skill_name
    skill_name=$(basename "$md_file" .md)
    
    local source_skill="$SKILLS_DIR/$skill_name/SKILL.md"
    [ -f "$source_skill" ] || continue
    
    local aliases synonyms
    aliases=$(grep -E '^\s*aliases:' "$source_skill" 2>/dev/null | sed 's/aliases:\s*\[//' | tr -d ']\n' | tr ',' '\n' | sed 's/"//g' | sed "s/'//g" | xargs)
    synonyms=$(grep -E '^\s*synonyms:' "$source_skill" 2>/dev/null | sed 's/synonyms:\s*\[//' | tr -d ']\n' | tr ',' '\n' | sed 's/"//g' | sed "s/'//g" | xargs)
    
    for alias in $aliases; do
      local clean_alias
      clean_alias=$(clean_command "$alias")
      if [ -n "$clean_alias" ] && [ "$clean_alias" != "$skill_name" ]; then
        if [ ! -f "$agent_dir/${clean_alias}.md" ]; then
          cp "$md_file" "$agent_dir/${clean_alias}.md"
          echo "  + ${clean_alias}.md (alias)"
          ((variant_count++)) || true
        fi
      fi
    done
    
    for synonym in $synonyms; do
      local clean_synonym
      clean_synonym=$(clean_command "$synonym")
      if [ -n "$clean_synonym" ] && [ "$clean_synonym" != "$skill_name" ]; then
        if [ ! -f "$agent_dir/${clean_synonym}.md" ]; then
          cp "$md_file" "$agent_dir/${clean_synonym}.md"
          echo "  + ${clean_synonym}.md (synonym)"
          ((variant_count++)) || true
        fi
      fi
    done
  done
  
  if [ "$variant_count" -gt 0 ]; then
    echo "Generated $variant_count variants for $agent"
  fi
}

echo "Generating alias/synonym variants..."

if [ ! -d "$OUTPUTS_DIR" ]; then
  echo "Error: Outputs directory not found: $OUTPUTS_DIR"
  exit 1
fi

for agent_dir in "$OUTPUTS_DIR"/*/; do
  if [ -d "$agent_dir" ]; then
    generate_variants "$agent_dir"
  fi
done

echo "Variant generation complete"
