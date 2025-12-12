#!/bin/bash
set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Registry location
REGISTRY_FILE="${HOME}/.claude/projects-registry.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_VERSION_FILE="$SCRIPT_DIR/../version.json"

# Helper Functions

load_registry() {
    if [ ! -f "$REGISTRY_FILE" ]; then
        echo -e "${RED}✗${NC} Registry file not found: $REGISTRY_FILE"
        echo "Run './scripts/register-project.sh' to create a registry."
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        echo -e "${RED}✗${NC} jq is required but not installed."
        echo "Install jq: brew install jq (macOS) or apt-get install jq (Linux)"
        exit 1
    fi
}

get_current_version() {
    if [ -f "$TEMPLATE_VERSION_FILE" ]; then
        jq -r '.version' "$TEMPLATE_VERSION_FILE" 2>/dev/null || echo "3.2.0"
    else
        echo "3.2.0"
    fi
}

detect_version_from_project() {
    local project_path="$1"
    local expanded_path="${project_path/#\~/$HOME}"
    local version_file="${expanded_path}/version.json"

    if [ -f "$version_file" ]; then
        jq -r '.version' "$version_file" 2>/dev/null || echo "unknown"
    else
        echo "unknown"
    fi
}

calculate_status() {
    local project_version="$1"
    local current_version="$2"

    if [ "$project_version" = "unknown" ]; then
        echo "unknown"
        return
    fi

    if [ "$project_version" = "$current_version" ]; then
        echo "up-to-date"
    else
        if [[ "$project_version" < "$current_version" ]]; then
            echo "outdated"
        else
            echo "up-to-date"
        fi
    fi
}

# Commands

cmd_list() {
    load_registry

    local format="table"
    local filter_status=""
    local filter_tags=""

    # Parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            --format)
                format="$2"
                shift 2
                ;;
            --filter)
                filter_status="$2"
                shift 2
                ;;
            --tags)
                filter_tags="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    local query='.projects[]'

    # Apply filters
    if [ -n "$filter_status" ]; then
        query="$query | select(.status == \"$filter_status\")"
    fi

    if [ -n "$filter_tags" ]; then
        query="$query | select(.tags[] == \"$filter_tags\")"
    fi

    case $format in
        json)
            jq "$query" "$REGISTRY_FILE"
            ;;
        simple)
            jq -r "$query | .name" "$REGISTRY_FILE"
            ;;
        table|*)
            echo -e "${CYAN}Projects Registry${NC}"
            echo "─────────────────────────────────────────────────────────"
            printf "%-20s %-30s %-10s %-12s\n" "NAME" "PATH" "VERSION" "STATUS"
            echo "─────────────────────────────────────────────────────────"

            jq -r "$query | [.name, .path, .templateVersion, .status] | @tsv" "$REGISTRY_FILE" | \
            while IFS=$'\t' read -r name path version status; do
                # Truncate long paths
                if [ ${#path} -gt 30 ]; then
                    path="${path:0:27}..."
                fi

                # Color code status
                local status_display="$status"
                case $status in
                    up-to-date)
                        status_display="${GREEN}$status${NC}"
                        ;;
                    outdated)
                        status_display="${YELLOW}$status${NC}"
                        ;;
                    unknown)
                        status_display="${BLUE}$status${NC}"
                        ;;
                esac

                printf "%-20s %-30s %-10s %-12b\n" "$name" "$path" "$version" "$status_display"
            done
            ;;
    esac
}

cmd_add() {
    load_registry

    local project_path=""
    local project_name=""
    local project_tags=""
    local project_notes=""

    # Parse arguments
    if [ $# -eq 0 ]; then
        echo "Usage: claude-projects add <path> [--name NAME] [--tags TAG1,TAG2] [--notes NOTES]"
        exit 1
    fi

    project_path="$1"
    shift

    # Parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            --name)
                project_name="$2"
                shift 2
                ;;
            --tags)
                project_tags="$2"
                shift 2
                ;;
            --notes)
                project_notes="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    # Default name from path
    if [ -z "$project_name" ]; then
        project_name=$(basename "$project_path")
    fi

    # Validate path
    local expanded_path="${project_path/#\~/$HOME}"
    if [ ! -d "$expanded_path" ]; then
        echo -e "${RED}✗${NC} Path does not exist: $project_path"
        exit 1
    fi

    # Check for duplicates
    local existing=$(jq --arg name "$project_name" '.projects[] | select(.name == $name)' "$REGISTRY_FILE")
    if [ -n "$existing" ]; then
        echo -e "${RED}✗${NC} A project with name '$project_name' already exists."
        exit 1
    fi

    # Detect version
    local detected_version=$(detect_version_from_project "$project_path")
    local current_version=$(get_current_version)
    local status=$(calculate_status "$detected_version" "$current_version")

    # Generate ID
    local sanitized=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local timestamp=$(date +%s)
    local project_id="${sanitized}-${timestamp}"

    # Convert tags to array
    local tags_array="[]"
    if [ -n "$project_tags" ]; then
        IFS=',' read -ra TAG_ARRAY <<< "$project_tags"
        tags_array="["
        for i in "${!TAG_ARRAY[@]}"; do
            local tag=$(echo "${TAG_ARRAY[$i]}" | xargs)
            if [ $i -gt 0 ]; then
                tags_array="$tags_array,"
            fi
            tags_array="$tags_array\"$tag\""
        done
        tags_array="$tags_array]"
    fi

    # Add to registry
    local current_date=$(date -u +"%Y-%m-%d")
    local current_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local temp_file="${REGISTRY_FILE}.tmp"

    jq --arg id "$project_id" \
       --arg name "$project_name" \
       --arg path "$project_path" \
       --arg version "$detected_version" \
       --arg installed "$current_date" \
       --arg updated "$current_date" \
       --arg status "$status" \
       --argjson tags "$tags_array" \
       --arg notes "$project_notes" \
       --arg timestamp "$current_timestamp" \
       '.projects += [{
           id: $id,
           name: $name,
           path: $path,
           templateVersion: $version,
           installedDate: $installed,
           lastUpdated: $updated,
           status: $status,
           tags: $tags,
           notes: $notes
       }] | .lastSync = $timestamp' \
       "$REGISTRY_FILE" > "$temp_file"

    mv "$temp_file" "$REGISTRY_FILE"

    echo -e "${GREEN}✓${NC} Project '$project_name' added to registry"
    echo "  Path: $project_path"
    echo "  Version: $detected_version"
    echo -e "  Status: $([ "$status" = "up-to-date" ] && echo "${GREEN}$status${NC}" || echo "${YELLOW}$status${NC}")"
}

cmd_update() {
    load_registry

    if [ $# -lt 2 ]; then
        echo "Usage: claude-projects update <name> --version VERSION"
        exit 1
    fi

    local project_name="$1"
    shift

    local new_version=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            --version)
                new_version="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    if [ -z "$new_version" ]; then
        echo "Error: --version flag is required"
        exit 1
    fi

    # Check if project exists
    local existing=$(jq --arg name "$project_name" '.projects[] | select(.name == $name)' "$REGISTRY_FILE")
    if [ -z "$existing" ]; then
        echo -e "${RED}✗${NC} Project '$project_name' not found in registry."
        exit 1
    fi

    # Update version and recalculate status
    local current_version=$(get_current_version)
    local new_status=$(calculate_status "$new_version" "$current_version")
    local current_date=$(date -u +"%Y-%m-%d")
    local current_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local temp_file="${REGISTRY_FILE}.tmp"

    jq --arg name "$project_name" \
       --arg version "$new_version" \
       --arg status "$new_status" \
       --arg updated "$current_date" \
       --arg timestamp "$current_timestamp" \
       '(.projects[] | select(.name == $name) | .templateVersion) = $version |
        (.projects[] | select(.name == $name) | .status) = $status |
        (.projects[] | select(.name == $name) | .lastUpdated) = $updated |
        .lastSync = $timestamp' \
       "$REGISTRY_FILE" > "$temp_file"

    mv "$temp_file" "$REGISTRY_FILE"

    echo -e "${GREEN}✓${NC} Project '$project_name' updated"
    echo "  New version: $new_version"
    echo -e "  Status: $([ "$new_status" = "up-to-date" ] && echo "${GREEN}$new_status${NC}" || echo "${YELLOW}$new_status${NC}")"
}

cmd_outdated() {
    load_registry

    local current_version=$(get_current_version)
    local outdated_projects=$(jq -r '.projects[] | select(.status == "outdated") | .name' "$REGISTRY_FILE")

    if [ -z "$outdated_projects" ]; then
        echo -e "${GREEN}✓${NC} All projects are up-to-date!"
        return
    fi

    echo -e "${YELLOW}Projects needing updates:${NC}"
    echo "─────────────────────────────────────────────────────────"
    printf "%-20s %-15s %-15s\n" "NAME" "CURRENT" "LATEST"
    echo "─────────────────────────────────────────────────────────"

    jq -r '.projects[] | select(.status == "outdated") | [.name, .templateVersion] | @tsv' "$REGISTRY_FILE" | \
    while IFS=$'\t' read -r name version; do
        printf "%-20s %-15s %-15s\n" "$name" "$version" "$current_version"
    done

    echo
    echo "To update a project:"
    echo "  claude-projects update <name> --version $current_version"
}

cmd_sync() {
    load_registry

    echo "Syncing all projects..."
    echo

    local current_version=$(get_current_version)
    local projects=$(jq -r '.projects[] | @base64' "$REGISTRY_FILE")
    local count=0
    local updated=0

    for project in $projects; do
        _jq() {
            echo ${project} | base64 --decode | jq -r ${1}
        }

        local name=$(_jq '.name')
        local path=$(_jq '.path')
        local old_version=$(_jq '.templateVersion')

        # Detect current version
        local detected_version=$(detect_version_from_project "$path")

        if [ "$detected_version" != "$old_version" ] && [ "$detected_version" != "unknown" ]; then
            # Update version and status
            local new_status=$(calculate_status "$detected_version" "$current_version")
            local current_date=$(date -u +"%Y-%m-%d")
            local temp_file="${REGISTRY_FILE}.tmp"

            jq --arg name "$name" \
               --arg version "$detected_version" \
               --arg status "$new_status" \
               --arg updated "$current_date" \
               '(.projects[] | select(.name == $name) | .templateVersion) = $version |
                (.projects[] | select(.name == $name) | .status) = $status |
                (.projects[] | select(.name == $name) | .lastUpdated) = $updated' \
               "$REGISTRY_FILE" > "$temp_file"

            mv "$temp_file" "$REGISTRY_FILE"

            echo -e "${GREEN}✓${NC} $name: $old_version → $detected_version"
            ((updated++))
        fi

        ((count++))
    done

    # Update lastSync
    local current_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local temp_file="${REGISTRY_FILE}.tmp"
    jq --arg timestamp "$current_timestamp" '.lastSync = $timestamp' "$REGISTRY_FILE" > "$temp_file"
    mv "$temp_file" "$REGISTRY_FILE"

    echo
    echo -e "${GREEN}✓${NC} Sync complete: $updated of $count projects updated"
}

cmd_remove() {
    load_registry

    if [ $# -eq 0 ]; then
        echo "Usage: claude-projects remove <name>"
        exit 1
    fi

    local project_name="$1"

    # Check if project exists
    local existing=$(jq --arg name "$project_name" '.projects[] | select(.name == $name)' "$REGISTRY_FILE")
    if [ -z "$existing" ]; then
        echo -e "${RED}✗${NC} Project '$project_name' not found in registry."
        exit 1
    fi

    # Confirm
    read -p "Remove project '$project_name' from registry? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 0
    fi

    # Backup
    cp "$REGISTRY_FILE" "${REGISTRY_FILE}.bak"

    # Remove from registry
    local current_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local temp_file="${REGISTRY_FILE}.tmp"

    jq --arg name "$project_name" \
       --arg timestamp "$current_timestamp" \
       'del(.projects[] | select(.name == $name)) | .lastSync = $timestamp' \
       "$REGISTRY_FILE" > "$temp_file"

    mv "$temp_file" "$REGISTRY_FILE"

    echo -e "${GREEN}✓${NC} Project '$project_name' removed from registry"
    echo "Backup saved: ${REGISTRY_FILE}.bak"
}

cmd_show() {
    load_registry

    if [ $# -eq 0 ]; then
        echo "Usage: claude-projects show <name>"
        exit 1
    fi

    local project_name="$1"

    # Get project details
    local project=$(jq --arg name "$project_name" '.projects[] | select(.name == $name)' "$REGISTRY_FILE")

    if [ -z "$project" ]; then
        echo -e "${RED}✗${NC} Project '$project_name' not found in registry."
        exit 1
    fi

    echo -e "${CYAN}Project Details: $project_name${NC}"
    echo "─────────────────────────────────────────────────────────"
    echo "$project" | jq -r '
        "  ID:              \(.id)",
        "  Name:            \(.name)",
        "  Path:            \(.path)",
        "  Version:         \(.templateVersion)",
        "  Status:          \(.status)",
        "  Installed:       \(.installedDate)",
        "  Last Updated:    \(.lastUpdated)",
        "  Tags:            \(.tags | join(", "))",
        "  Notes:           \(.notes)"
    '
}

cmd_help() {
    echo "claude-projects - Multi-Project Management CLI"
    echo
    echo "Usage: claude-projects <command> [options]"
    echo
    echo "Commands:"
    echo "  list [--format table|json|simple] [--filter STATUS] [--tags TAG]"
    echo "      List all projects in registry"
    echo
    echo "  add <path> [--name NAME] [--tags TAG1,TAG2] [--notes NOTES]"
    echo "      Add a new project to registry"
    echo
    echo "  update <name> --version VERSION"
    echo "      Update project version and status"
    echo
    echo "  outdated"
    echo "      Show projects that need updates"
    echo
    echo "  sync"
    echo "      Auto-detect versions for all projects"
    echo
    echo "  remove <name>"
    echo "      Remove project from registry"
    echo
    echo "  show <name>"
    echo "      Display detailed project information"
    echo
    echo "  help"
    echo "      Show this help message"
    echo
    echo "Examples:"
    echo "  claude-projects list"
    echo "  claude-projects add ~/Developer/my-app --name \"My App\" --tags production,react"
    echo "  claude-projects outdated"
    echo "  claude-projects sync"
}

# Main

if [ $# -eq 0 ]; then
    cmd_help
    exit 0
fi

COMMAND="$1"
shift

case $COMMAND in
    list)
        cmd_list "$@"
        ;;
    add)
        cmd_add "$@"
        ;;
    update)
        cmd_update "$@"
        ;;
    outdated)
        cmd_outdated "$@"
        ;;
    sync)
        cmd_sync "$@"
        ;;
    remove)
        cmd_remove "$@"
        ;;
    show)
        cmd_show "$@"
        ;;
    help|--help|-h)
        cmd_help
        ;;
    *)
        echo "Unknown command: $COMMAND"
        echo "Run 'claude-projects help' for usage information."
        exit 1
        ;;
esac
