#!/bin/bash

################################################################################
# Template Application Script
# Version: 1.0.0
# Purpose: Apply Claude preferences templates with inheritance and parameters
# Usage: ./apply-template.sh <template> [--param key=value]...
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Counters
ERRORS=0
WARNINGS=0
INFO_COUNT=0

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Template search directories
TEMPLATE_DIRS=(
    "$PROJECT_ROOT/examples/team-templates"
    "$PROJECT_ROOT/examples/preference-templates"
    "$PROJECT_ROOT/templates"
)

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Claude Template Applicator v1.0.0${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_usage() {
    echo "Usage: $0 <template> [--param key=value]..."
    echo ""
    echo "Arguments:"
    echo "  <template>           Template file path OR template ID"
    echo "  --param key=value    Parameter value (can be repeated)"
    echo "  --help               Show this help message"
    echo ""
    echo "Examples:"
    echo "  # Simple template (no params)"
    echo "  $0 team-standard"
    echo ""
    echo "  # Template with inheritance"
    echo "  $0 gallery-frontend-react"
    echo ""
    echo "  # Parameterized template (CLI args)"
    echo "  $0 gallery-fullstack \\"
    echo "      --param frontendFramework=react \\"
    echo "      --param backendFramework=fastapi \\"
    echo "      --param database=postgresql"
    echo ""
    echo "  # Interactive mode (prompts for params)"
    echo "  $0 gallery-fullstack"
}

print_check() {
    local status=$1
    local message=$2

    case $status in
        "pass")
            echo -e "  ${GREEN}✅${NC} $message"
            ;;
        "fail")
            echo -e "  ${RED}❌${NC} $message"
            ERRORS=$((ERRORS + 1))
            ;;
        "warn")
            echo -e "  ${YELLOW}⚠️${NC}  $message"
            WARNINGS=$((WARNINGS + 1))
            ;;
        "info")
            echo -e "  ${CYAN}ℹ️${NC}  $message"
            INFO_COUNT=$((INFO_COUNT + 1))
            ;;
    esac
}

# JSON value extraction (jq with fallback)
get_json_value() {
    local file=$1
    local path=$2

    if command -v jq &> /dev/null; then
        jq -r "$path // empty" "$file" 2>/dev/null
    else
        python3 -c "
import json, sys
try:
    with open('$file') as f:
        data = json.load(f)
    keys = '$path'.strip('.').replace('[','').replace(']','').replace('\"','').split('.')
    for k in keys:
        if k and k != '':
            data = data.get(k, {}) if isinstance(data, dict) else {}
    print(data if data and data != {} else '')
except:
    print('')
" 2>/dev/null
    fi
}

# Check if JSON is valid
validate_json_syntax() {
    local file=$1

    if command -v jq &> /dev/null; then
        if jq empty "$file" 2>/dev/null; then
            return 0
        else
            return 1
        fi
    else
        if python3 -c "import json; json.load(open('$file'))" 2>/dev/null; then
            return 0
        else
            return 1
        fi
    fi
}

# Find template by ID or path
find_template() {
    local input=$1

    # If it's a direct file path that exists, use it
    if [ -f "$input" ]; then
        echo "$input"
        return 0
    fi

    # Search in template directories
    for dir in "${TEMPLATE_DIRS[@]}"; do
        local template_file="$dir/${input}.json"
        if [ -f "$template_file" ]; then
            echo "$template_file"
            return 0
        fi
    done

    # Not found
    echo -e "${RED}❌ Template not found: $input${NC}" >&2
    echo "" >&2
    echo -e "${YELLOW}Available templates:${NC}" >&2
    for dir in "${TEMPLATE_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            echo -e "${CYAN}  $dir:${NC}" >&2
            ls "$dir"/*.json 2>/dev/null | xargs -n1 basename | sed 's/\.json$//' | sed 's/^/    /' >&2
        fi
    done
    return 1
}

################################################################################
# Inheritance Resolution
################################################################################

# Deep merge two JSON files
deep_merge() {
    local parent_file=$1
    local child_file=$2

    if command -v jq &> /dev/null; then
        # Simplified merge: child overrides parent at top level, recursively merge objects
        jq -s '.[0] * .[1]' "$parent_file" "$child_file"
    else
        python3 << PYTHON_SCRIPT
import json, sys

def deep_merge(base, overlay):
    """Deep merge overlay into base, with overlay taking precedence."""
    if not isinstance(base, dict) or not isinstance(overlay, dict):
        return overlay

    result = base.copy()
    for key, value in overlay.items():
        if key in result and isinstance(result[key], dict) and isinstance(value, dict):
            result[key] = deep_merge(result[key], value)
        else:
            result[key] = value
    return result

with open('$parent_file') as f1, open('$child_file') as f2:
    parent = json.load(f1)
    child = json.load(f2)
    merged = deep_merge(parent, child)
    print(json.dumps(merged, indent=2))
PYTHON_SCRIPT
    fi
}

# Resolve template inheritance
resolve_inheritance() {
    local template_file=$1
    local visited=$2
    local depth=$3

    # Check max depth
    if [ "$depth" -ge 5 ]; then
        echo -e "${RED}❌ Max inheritance depth exceeded (5 levels)${NC}" >&2
        exit 1
    fi

    # Read template
    local template_id=$(get_json_value "$template_file" '.templateMetadata.id')

    # Check for cycle
    if echo "$visited" | grep -q "\b$template_id\b"; then
        echo -e "${RED}❌ Circular inheritance detected: $visited -> $template_id${NC}" >&2
        exit 1
    fi

    # Check if template extends another
    local extends=$(get_json_value "$template_file" '.templateMetadata.extends')

    if [ -n "$extends" ]; then
        print_check "info" "Resolving inheritance: $template_id extends $extends"

        # Find parent template
        local parent_file=$(find_template "$extends")
        if [ $? -ne 0 ]; then
            echo -e "${RED}❌ Parent template not found: $extends${NC}" >&2
            exit 1
        fi

        # Recursively resolve parent
        local new_visited="$visited $template_id"
        local parent_resolved=$(resolve_inheritance "$parent_file" "$new_visited" $((depth + 1)))

        # Extract contents from parent
        local parent_temp="/tmp/claude/parent-$$-$depth.json"
        mkdir -p /tmp/claude
        echo "$parent_resolved" | jq '.contents' > "$parent_temp" 2>/dev/null

        # Extract contents from child
        local child_temp="/tmp/claude/child-$$-$depth.json"
        cat "$template_file" | jq '.contents' > "$child_temp" 2>/dev/null

        # Deep merge parent.contents with child.contents
        local merged_contents=$(deep_merge "$parent_temp" "$child_temp")

        # Rebuild full template with merged contents
        local full_template=$(cat "$template_file" | jq --argjson contents "$merged_contents" '.contents = $contents' 2>/dev/null)

        rm -f "$parent_temp" "$child_temp"

        echo "$full_template"
    else
        # No inheritance, return as-is
        cat "$template_file"
    fi
}

################################################################################
# Parameter Handling
################################################################################

# Discover all ${varName} references
discover_parameters() {
    local json_string=$1

    echo "$json_string" | grep -oE '\$\{[^}]+\}' | sed 's/\${//' | sed 's/}.*//' | cut -d':' -f1 | sort -u
}

# Parse CLI parameters into JSON
parse_cli_params() {
    local params=("$@")
    local json="{"

    for param in "${params[@]}"; do
        local key=$(echo "$param" | cut -d'=' -f1)
        local value=$(echo "$param" | cut -d'=' -f2-)

        # Add to JSON (simple string values for now)
        if [ -n "$json" ] && [ "$json" != "{" ]; then
            json+=","
        fi
        json+="\"$key\":\"$value\""
    done

    json+="}"
    echo "$json"
}

# Prompt for a single parameter
prompt_for_parameter() {
    local name=$1
    local definition=$2
    local required=$3
    local default=$4

    echo ""
    if [ -n "$definition" ]; then
        echo -e "  ${CYAN}$name${NC} - $definition"
    else
        echo -e "  ${CYAN}$name${NC}"
    fi

    if [ -n "$default" ]; then
        echo -e "  [default: $default]"
    fi

    if [ "$required" = "true" ]; then
        echo -e "  ${YELLOW}(required)${NC}"
    fi

    echo -n "  Value: "
    read -r value

    if [ -z "$value" ] && [ -n "$default" ]; then
        value="$default"
    fi

    echo "$value"
}

# Collect all parameters
collect_parameters() {
    local resolved_template=$1
    local cli_params=$2

    echo ""
    echo -e "${CYAN}📝 Collecting parameter values:${NC}"

    # Discover parameters in template
    local discovered=$(discover_parameters "$resolved_template")

    if [ -z "$discovered" ]; then
        print_check "info" "No parameters found in template"
        echo "{}"
        return 0
    fi

    print_check "info" "Found $(echo "$discovered" | wc -l | tr -d ' ') parameters"

    # Build params JSON
    local params_json="{"
    local first=true

    for param in $discovered; do
        # Check if provided in CLI
        local cli_value=$(echo "$cli_params" | jq -r ".$param // empty" 2>/dev/null)

        local value=""
        if [ -n "$cli_value" ]; then
            value="$cli_value"
            print_check "pass" "$param = $value (from CLI)"
        else
            # Prompt interactively
            value=$(prompt_for_parameter "$param" "" "false" "")
        fi

        # Add to JSON
        if [ "$first" = true ]; then
            first=false
        else
            params_json+=","
        fi
        params_json+="\"$param\":\"$value\""
    done

    params_json+="}"

    echo ""
    print_check "pass" "All parameters collected"

    echo "$params_json"
}

# Substitute parameters in JSON
substitute_parameters() {
    local json_string=$1
    local params=$2

    # For each parameter, replace ${key} with value
    local result="$json_string"

    if command -v jq &> /dev/null; then
        local keys=$(echo "$params" | jq -r 'keys[]' 2>/dev/null)
        for key in $keys; do
            local value=$(echo "$params" | jq -r ".$key")
            # Escape special characters for sed
            local escaped_value=$(echo "$value" | sed 's/[\/&]/\\&/g')
            result=$(echo "$result" | sed "s/\${$key}/$escaped_value/g")
            result=$(echo "$result" | sed "s/\${$key:[^}]*}/$escaped_value/g")
        done
    fi

    echo "$result"
}

################################################################################
# Preview & Apply
################################################################################

# Generate preview file
generate_preview() {
    local resolved_json=$1

    # Extract contents field
    local contents=$(echo "$resolved_json" | jq '.contents' 2>/dev/null || echo "$resolved_json")

    # Write to preview file
    local preview_file=".claude/settings.preview.json"
    mkdir -p .claude
    echo "$contents" | jq '.' > "$preview_file" 2>/dev/null || echo "$contents" > "$preview_file"

    echo "$preview_file"
}

# Show diff
show_diff() {
    local current=$1
    local preview=$2

    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Template Preview${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""

    if [ ! -f "$current" ]; then
        echo -e "${YELLOW}No existing settings.json found. Preview:${NC}"
        echo ""
        cat "$preview" | head -20
        if [ $(cat "$preview" | wc -l) -gt 20 ]; then
            echo "..."
            echo -e "${CYAN}($(cat "$preview" | wc -l | tr -d ' ') lines total)${NC}"
        fi
    else
        echo "Changes to be applied:"
        if command -v colordiff &> /dev/null; then
            diff -u "$current" "$preview" | colordiff || true
        else
            diff -u "$current" "$preview" || true
        fi

        echo ""
        local additions=$(diff "$current" "$preview" 2>/dev/null | grep -c '^>' || echo 0)
        local deletions=$(diff "$current" "$preview" 2>/dev/null | grep -c '^<' || echo 0)
        echo -e "${GREEN}+$additions additions${NC}, ${RED}-$deletions deletions${NC}"
    fi
}

# Apply template
apply_template() {
    local preview_file=$1
    local target=".claude/settings.json"

    # Backup existing
    if [ -f "$target" ]; then
        cp "$target" "${target}.backup"
        print_check "pass" "Backed up existing settings to ${target}.backup"
    fi

    # Move preview to target
    mv "$preview_file" "$target"
    print_check "pass" "Applied template to $target"

    echo ""
    echo -e "${GREEN}🎉 Template applied successfully!${NC}"
}

# Confirm and apply
confirm_and_apply() {
    local preview_file=$1

    echo ""
    echo -e "${BLUE}────────────────────────────────────────${NC}"
    echo -n "Apply these changes? (y/n): "
    read -r response

    if [[ $response =~ ^[Yy]$ ]]; then
        apply_template "$preview_file"
    else
        echo ""
        echo -e "${YELLOW}Changes not applied. Preview saved to: $preview_file${NC}"
        exit 0
    fi
}

################################################################################
# Main
################################################################################

main() {
    print_header

    # Parse arguments
    TEMPLATE=""
    CLI_PARAMS=()

    while [[ $# -gt 0 ]]; do
        case $1 in
            --param)
                if [ -z "$2" ]; then
                    echo -e "${RED}❌ --param requires a value${NC}"
                    exit 1
                fi
                CLI_PARAMS+=("$2")
                shift 2
                ;;
            --help|-h)
                print_usage
                exit 0
                ;;
            *)
                if [ -z "$TEMPLATE" ]; then
                    TEMPLATE="$1"
                else
                    echo -e "${RED}❌ Unknown argument: $1${NC}"
                    print_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done

    # Check template provided
    if [ -z "$TEMPLATE" ]; then
        echo -e "${RED}❌ Template required${NC}"
        echo ""
        print_usage
        exit 1
    fi

    # Find template
    echo -e "${CYAN}🔍 Finding template:${NC} $TEMPLATE"
    echo ""
    TEMPLATE_FILE=$(find_template "$TEMPLATE")
    if [ $? -ne 0 ]; then
        exit 1
    fi

    print_check "pass" "Template found: $TEMPLATE_FILE"

    # Validate JSON
    if validate_json_syntax "$TEMPLATE_FILE"; then
        print_check "pass" "Valid JSON syntax"
    else
        print_check "fail" "Invalid JSON syntax"
        exit 1
    fi

    # Check schema
    local schema=$(get_json_value "$TEMPLATE_FILE" '."$schema"')
    if [ "$schema" = "claude-preferences-export-v1" ]; then
        print_check "pass" "Schema: claude-preferences-export-v1"
    else
        print_check "fail" "Invalid schema (expected: claude-preferences-export-v1, got: $schema)"
        exit 1
    fi

    # Check for parameters
    local has_params=$(get_json_value "$TEMPLATE_FILE" '.templateMetadata.parameters')
    if [ -n "$has_params" ] && [ "$has_params" != "null" ] && [ "$has_params" != "{}" ]; then
        print_check "info" "Parameterized template"
    fi

    # Resolve inheritance
    echo ""
    echo -e "${CYAN}🔗 Resolving inheritance chain...${NC}"
    RESOLVED=$(resolve_inheritance "$TEMPLATE_FILE" "" 0)

    # Parse CLI params
    local cli_params_json="{}"
    if [ ${#CLI_PARAMS[@]} -gt 0 ]; then
        cli_params_json=$(parse_cli_params "${CLI_PARAMS[@]}")
    fi

    # Collect parameters
    PARAMS=$(collect_parameters "$RESOLVED" "$cli_params_json")

    # Substitute parameters
    FINAL=$(substitute_parameters "$RESOLVED" "$PARAMS")

    # Generate preview
    PREVIEW_FILE=$(generate_preview "$FINAL")

    # Show diff
    show_diff ".claude/settings.json" "$PREVIEW_FILE"

    # Confirm and apply
    confirm_and_apply "$PREVIEW_FILE"
}

main "$@"
