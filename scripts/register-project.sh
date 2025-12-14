#!/bin/bash
set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source helper functions
source "$SCRIPT_DIR/wizard-helpers.sh"

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
TEMPLATE_VERSION_FILE="$SCRIPT_DIR/../version.json"

# Helper Functions

generate_project_id() {
    local name="$1"
    # Sanitize name: lowercase, replace spaces with hyphens, remove special chars
    local sanitized=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local timestamp=$(date +%s)
    echo "${sanitized}-${timestamp}"
}

detect_template_version() {
    local project_path="$1"
    local expanded_path="${project_path/#\~/$HOME}"
    local version_file="${expanded_path}/version.json"

    if [ -f "$version_file" ]; then
        # Try to extract version using jq if available
        if command -v jq &> /dev/null; then
            local version=$(jq -r '.version' "$version_file" 2>/dev/null || echo "unknown")
            echo "$version"
        else
            # Fallback: use grep and sed
            local version=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$version_file" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' || echo "unknown")
            echo "$version"
        fi
    else
        echo "unknown"
    fi
}

get_current_template_version() {
    if [ -f "$TEMPLATE_VERSION_FILE" ]; then
        if command -v jq &> /dev/null; then
            jq -r '.version' "$TEMPLATE_VERSION_FILE" 2>/dev/null || echo "3.2.0"
        else
            grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$TEMPLATE_VERSION_FILE" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' || echo "3.2.0"
        fi
    else
        echo "3.2.0"
    fi
}

validate_project_path() {
    local path="$1"
    local expanded_path="${path/#\~/$HOME}"

    if [ -d "$expanded_path" ]; then
        return 0
    else
        return 1
    fi
}

check_duplicate_project() {
    local registry_file="$1"
    local name="$2"
    local path="$3"

    if [ ! -f "$registry_file" ]; then
        return 0  # No registry yet, no duplicates
    fi

    if command -v jq &> /dev/null; then
        # Check for duplicate name
        local name_exists=$(jq --arg name "$name" '.projects[] | select(.name == $name) | .name' "$registry_file" 2>/dev/null)
        if [ -n "$name_exists" ]; then
            echo "name"
            return 1
        fi

        # Check for duplicate path
        local path_exists=$(jq --arg path "$path" '.projects[] | select(.path == $path) | .path' "$registry_file" 2>/dev/null)
        if [ -n "$path_exists" ]; then
            echo "path"
            return 1
        fi
    fi

    return 0
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
        # Simple version comparison (assumes semantic versioning)
        if [[ "$project_version" < "$current_version" ]]; then
            echo "outdated"
        else
            echo "up-to-date"
        fi
    fi
}

backup_registry() {
    local registry_file="$1"
    if [ -f "$registry_file" ]; then
        cp "$registry_file" "${registry_file}.bak"
        echo -e "${GREEN}✓${NC} Backup created: ${registry_file}.bak"
    fi
}

create_registry() {
    local registry_file="$1"
    local registry_dir=$(dirname "$registry_file")

    # Create directory if it doesn't exist
    mkdir -p "$registry_dir"

    # Create initial registry structure
    cat > "$registry_file" << 'EOF'
{
  "$schema": "https://json.schemastore.org/claude-projects-registry-1.0.0.json",
  "version": "1.0",
  "lastSync": "",
  "projects": []
}
EOF

    echo -e "${GREEN}✓${NC} Created new registry: $registry_file"
}

add_project_to_registry() {
    local registry_file="$1"
    local project_id="$2"
    local name="$3"
    local path="$4"
    local version="$5"
    local status="$6"
    local tags="$7"
    local notes="$8"

    local current_date=$(date -u +"%Y-%m-%d")
    local current_timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Convert tags from comma-separated to JSON array
    local tags_array="[]"
    if [ -n "$tags" ]; then
        # Split by comma and build JSON array
        IFS=',' read -ra TAG_ARRAY <<< "$tags"
        tags_array="["
        for i in "${!TAG_ARRAY[@]}"; do
            local tag=$(echo "${TAG_ARRAY[$i]}" | xargs)  # trim whitespace
            if [ $i -gt 0 ]; then
                tags_array="$tags_array,"
            fi
            tags_array="$tags_array\"$tag\""
        done
        tags_array="$tags_array]"
    fi

    if command -v jq &> /dev/null; then
        # Use jq to add project
        local temp_file="${registry_file}.tmp"
        jq --arg id "$project_id" \
           --arg name "$name" \
           --arg path "$path" \
           --arg version "$version" \
           --arg installed "$current_date" \
           --arg updated "$current_date" \
           --arg status "$status" \
           --argjson tags "$tags_array" \
           --arg notes "$notes" \
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
           "$registry_file" > "$temp_file"

        mv "$temp_file" "$registry_file"
    else
        echo -e "${YELLOW}⚠${NC} jq not found. Please install jq for automatic registry updates."
        echo "You can manually add the project to $registry_file"
        return 1
    fi
}

# Main Script

clear

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════╗"
echo "║   📁 Projects Registry - Register New Project          ║"
echo "╚════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo
echo "This wizard helps you add a project to your centralized registry."
echo
echo "Registry location: $REGISTRY_FILE"
echo
echo "───────────────────────────────────────────────────────────"
echo

# Check if registry exists, create if not
if [ ! -f "$REGISTRY_FILE" ]; then
    echo -e "${YELLOW}⚠${NC} Registry file not found."
    echo
    if ask_yes_no "Create new registry at $REGISTRY_FILE?"; then
        create_registry "$REGISTRY_FILE"
        echo
    else
        echo -e "${RED}✗${NC} Cancelled. Registry not created."
        exit 0
    fi
else
    backup_registry "$REGISTRY_FILE"
    echo
fi

# Get current template version
CURRENT_VERSION=$(get_current_template_version)

# Prompt for project details
echo "Enter project details:"
echo

# Project Name
while true; do
    read -p "Project name: " PROJECT_NAME
    if [ -z "$PROJECT_NAME" ]; then
        echo -e "${RED}✗${NC} Project name cannot be empty."
        continue
    fi

    # Check for duplicate name
    duplicate_check=$(check_duplicate_project "$REGISTRY_FILE" "$PROJECT_NAME" "")
    if [ $? -ne 0 ] && [ "$duplicate_check" = "name" ]; then
        echo -e "${RED}✗${NC} A project with this name already exists in the registry."
        continue
    fi

    break
done

# Project Path
while true; do
    read -p "Project path: " PROJECT_PATH
    if [ -z "$PROJECT_PATH" ]; then
        echo -e "${RED}✗${NC} Project path cannot be empty."
        continue
    fi

    # Validate path exists
    if validate_project_path "$PROJECT_PATH"; then
        echo -e "${GREEN}✓${NC} Path exists and is accessible"
    else
        echo -e "${RED}✗${NC} Path does not exist: $PROJECT_PATH"
        continue
    fi

    # Check for duplicate path
    duplicate_check=$(check_duplicate_project "$REGISTRY_FILE" "" "$PROJECT_PATH")
    if [ $? -ne 0 ] && [ "$duplicate_check" = "path" ]; then
        echo -e "${RED}✗${NC} This project path is already registered."
        continue
    fi

    # Auto-detect version
    DETECTED_VERSION=$(detect_template_version "$PROJECT_PATH")
    if [ "$DETECTED_VERSION" != "unknown" ]; then
        echo -e "${GREEN}✓${NC} Detected template version: $DETECTED_VERSION"
    else
        echo -e "${YELLOW}⚠${NC} Could not detect template version (no version.json found)"
    fi

    break
done

# Tags (optional)
echo
read -p "Tags (comma-separated, optional): " PROJECT_TAGS

# Notes (optional)
read -p "Notes (optional): " PROJECT_NOTES

echo
echo "───────────────────────────────────────────────────────────"
echo

# Generate project ID
PROJECT_ID=$(generate_project_id "$PROJECT_NAME")

# Calculate status
PROJECT_STATUS=$(calculate_status "$DETECTED_VERSION" "$CURRENT_VERSION")

# Format tags for display
TAGS_DISPLAY="(none)"
if [ -n "$PROJECT_TAGS" ]; then
    TAGS_DISPLAY=$(echo "$PROJECT_TAGS" | tr ',' ' ')
fi

# Show summary
echo "Summary:"
echo "  Name:    $PROJECT_NAME"
echo "  Path:    $PROJECT_PATH"
echo "  Version: $DETECTED_VERSION"
if [ "$PROJECT_STATUS" = "up-to-date" ]; then
    echo -e "  Status:  ${GREEN}$PROJECT_STATUS ✓${NC}"
elif [ "$PROJECT_STATUS" = "outdated" ]; then
    echo -e "  Status:  ${YELLOW}$PROJECT_STATUS${NC} (current: $CURRENT_VERSION)"
else
    echo -e "  Status:  ${BLUE}$PROJECT_STATUS${NC}"
fi
echo "  Tags:    $TAGS_DISPLAY"
if [ -n "$PROJECT_NOTES" ]; then
    echo "  Notes:   $PROJECT_NOTES"
fi
echo

# Confirm
if ! ask_yes_no "Add this project to registry?"; then
    echo
    echo -e "${YELLOW}⚠${NC} Cancelled. Project not added."
    exit 0
fi

echo

# Add to registry
if add_project_to_registry "$REGISTRY_FILE" "$PROJECT_ID" "$PROJECT_NAME" "$PROJECT_PATH" \
                           "$DETECTED_VERSION" "$PROJECT_STATUS" "$PROJECT_TAGS" "$PROJECT_NOTES"; then
    echo
    echo -e "${GREEN}✅ Project registered successfully!${NC}"
    echo
    echo "Next steps:"
    echo "  • View registry: cat $REGISTRY_FILE"
    echo "  • Edit registry: nano $REGISTRY_FILE"
    echo "  • List projects: jq '.projects[] | .name' $REGISTRY_FILE"
    if command -v claude-projects &> /dev/null; then
        echo "  • Use CLI: claude-projects list"
    fi
    echo
else
    echo
    echo -e "${RED}✗${NC} Failed to add project to registry."
    echo "Please check that jq is installed and try again."
    exit 1
fi

echo "───────────────────────────────────────────────────────────"
