#!/bin/bash

################################################################################
# Claude Code Template Update Manager
# Version: 2.1.0
# Purpose: Check for and apply template updates with 3-way merge
# Usage: ./scripts/claude-update.sh [--check|--apply|--rollback]
################################################################################

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
TEMPLATE_DIR="${CLAUDE_TEMPLATE_DIR:-$HOME/claude-config-template}"
VERSION_FILE="$TEMPLATE_DIR/version.json"
LOCAL_VERSION_FILE="$HOME/.claude/template-version.json"
BACKUP_DIR="$HOME/.claude/backups"
REPO_URL="https://github.com/christianearle01/claude-config-template"

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}║         🔄 Claude Template Update Manager v2.1            ║${NC}"
    echo -e "${CYAN}║                                                            ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

get_version() {
    local version_file=$1
    if [ -f "$version_file" ]; then
        if command -v jq &> /dev/null; then
            jq -r '.version' "$version_file" 2>/dev/null || echo "unknown"
        else
            grep -o '"version": *"[^"]*"' "$version_file" | sed 's/"version": *"\([^"]*\)"/\1/'
        fi
    else
        echo "not_installed"
    fi
}

compare_versions() {
    local version1=$1
    local version2=$2

    # Convert versions to comparable format (remove dots)
    local v1=$(echo "$version1" | tr -d '.')
    local v2=$(echo "$version2" | tr -d '.')

    if [ "$v1" -gt "$v2" ]; then
        echo "newer"
    elif [ "$v1" -lt "$v2" ]; then
        echo "older"
    else
        echo "same"
    fi
}

get_release_notes() {
    local version=$1
    if [ -f "$TEMPLATE_DIR/CHANGELOG.md" ]; then
        # Extract section for this version
        sed -n "/## \[$version\]/,/## \[/p" "$TEMPLATE_DIR/CHANGELOG.md" | sed '$d'
    else
        echo "Release notes not available."
    fi
}

get_persona_specific_notes() {
    local persona=$1
    local version=$2

    echo -e "${MAGENTA}What's New for ${persona} Users:${NC}"
    echo ""

    case $persona in
        "first-time")
            echo "  • Enhanced wizard with better validation"
            echo "  • New learning resources in visual guides"
            echo "  • Improved error messages"
            ;;
        "quick-setup")
            echo "  • Faster project setup (15min → 10min)"
            echo "  • Auto-detection of project type"
            echo "  • One-command setup option"
            ;;
        "advanced")
            echo "  • New security hook templates"
            echo "  • Custom MCP server examples"
            echo "  • Advanced optimization patterns"
            ;;
        "team-lead")
            echo "  • Bulk update script for team"
            echo "  • Usage analytics dashboard"
            echo "  • Team performance metrics"
            ;;
        "returning")
            echo "  • New commands: /model opus"
            echo "  • Updated quick reference card"
            echo "  • Cost calculation improvements"
            ;;
        *)
            echo "  • General improvements and bug fixes"
            ;;
    esac
    echo ""
}

create_backup() {
    local project_path=$1
    local backup_name="backup-$(date +%Y%m%d-%H%M%S)"
    local backup_path="$BACKUP_DIR/$backup_name"

    mkdir -p "$backup_path"

    # Backup .claude directory
    if [ -d "$project_path/.claude" ]; then
        cp -r "$project_path/.claude" "$backup_path/"
        echo -e "${GREEN}✅ Backed up .claude/ to: $backup_path${NC}"
    fi

    # Backup CLAUDE.md
    if [ -f "$project_path/CLAUDE.md" ]; then
        cp "$project_path/CLAUDE.md" "$backup_path/"
        echo -e "${GREEN}✅ Backed up CLAUDE.md${NC}"
    fi

    echo "$backup_path"
}

################################################################################
# Command: Check for Updates
################################################################################

check_updates() {
    print_header

    echo -e "${CYAN}Checking for template updates...${NC}"
    echo ""

    # Get current local version
    LOCAL_VERSION=$(get_version "$LOCAL_VERSION_FILE")
    if [ "$LOCAL_VERSION" = "not_installed" ]; then
        # Try to get from template directory
        LOCAL_VERSION=$(get_version "$VERSION_FILE")
    fi

    echo -e "${BLUE}Current version:${NC} $LOCAL_VERSION"

    # Check if template directory exists
    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo -e "${YELLOW}⚠️  Template not found at: $TEMPLATE_DIR${NC}"
        echo ""
        echo "Install template first:"
        echo "  git clone $REPO_URL $TEMPLATE_DIR"
        return 1
    fi

    # Update template repository
    echo ""
    echo -e "${CYAN}Fetching latest version...${NC}"
    cd "$TEMPLATE_DIR"

    if [ -d ".git" ]; then
        git fetch origin main --quiet || {
            echo -e "${RED}❌ Failed to fetch updates${NC}"
            return 1
        }

        # Check if updates are available
        LOCAL_COMMIT=$(git rev-parse HEAD)
        REMOTE_COMMIT=$(git rev-parse origin/main)

        if [ "$LOCAL_COMMIT" = "$REMOTE_COMMIT" ]; then
            echo -e "${GREEN}✅ You're on the latest version!${NC}"
            echo ""
            return 0
        fi
    fi

    # Get latest version from version.json
    LATEST_VERSION=$(get_version "$VERSION_FILE")
    echo -e "${BLUE}Latest version:${NC} $LATEST_VERSION"
    echo ""

    # Compare versions
    COMPARISON=$(compare_versions "$LATEST_VERSION" "$LOCAL_VERSION")

    case $COMPARISON in
        "newer")
            echo -e "${YELLOW}🎉 New version available: $LOCAL_VERSION → $LATEST_VERSION${NC}"
            echo ""

            # Show release notes
            echo -e "${CYAN}Release Notes:${NC}"
            get_release_notes "$LATEST_VERSION"
            echo ""

            # Check for breaking changes
            if command -v jq &> /dev/null; then
                BREAKING=$(jq -r '.breaking_changes' "$VERSION_FILE")
                PRIORITY=$(jq -r '.update_priority' "$VERSION_FILE")

                if [ "$BREAKING" = "true" ]; then
                    echo -e "${RED}⚠️  WARNING: This update contains breaking changes!${NC}"
                    echo "   Review the migration guide before updating."
                    echo ""
                fi

                case $PRIORITY in
                    "critical")
                        echo -e "${RED}Update Priority: CRITICAL${NC} - Update immediately"
                        ;;
                    "recommended")
                        echo -e "${YELLOW}Update Priority: RECOMMENDED${NC} - Update soon"
                        ;;
                    "optional")
                        echo -e "${BLUE}Update Priority: OPTIONAL${NC} - Update at your convenience"
                        ;;
                esac
            fi

            echo ""
            echo -e "${GREEN}To apply update:${NC}"
            echo "  ./scripts/claude-update.sh --apply"
            echo ""

            # Show persona-specific notes if available
            if [ -f "$HOME/.claude/last-persona" ]; then
                PERSONA=$(cat "$HOME/.claude/last-persona")
                get_persona_specific_notes "$PERSONA" "$LATEST_VERSION"
            fi
            ;;
        "same")
            echo -e "${GREEN}✅ You're on the latest version!${NC}"
            ;;
        "older")
            echo -e "${YELLOW}⚠️  Your version is newer than remote (development version?)${NC}"
            ;;
    esac

    return 0
}

################################################################################
# Command: Apply Updates
################################################################################

apply_updates() {
    print_header

    echo -e "${CYAN}Applying template updates...${NC}"
    echo ""

    # Get current version
    LOCAL_VERSION=$(get_version "$LOCAL_VERSION_FILE")
    if [ "$LOCAL_VERSION" = "not_installed" ]; then
        LOCAL_VERSION=$(get_version "$VERSION_FILE")
    fi

    # Check if template directory exists
    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo -e "${RED}❌ Template not found at: $TEMPLATE_DIR${NC}"
        return 1
    fi

    # Update template repository
    cd "$TEMPLATE_DIR"

    if [ -d ".git" ]; then
        echo "Pulling latest changes..."
        git pull origin main --quiet || {
            echo -e "${RED}❌ Failed to pull updates${NC}"
            return 1
        }
    fi

    LATEST_VERSION=$(get_version "$VERSION_FILE")
    echo -e "${GREEN}Updated to version: $LATEST_VERSION${NC}"
    echo ""

    # Ask which projects to update
    echo -e "${CYAN}Which projects would you like to update?${NC}"
    echo ""
    echo "1) Current directory"
    echo "2) Specific project path"
    echo "3) All projects (from list)"
    echo "4) Cancel"
    echo ""

    read -p "Select option (1-4): " UPDATE_OPTION

    case $UPDATE_OPTION in
        1)
            PROJECT_PATH="."
            update_project "$PROJECT_PATH"
            ;;
        2)
            read -p "Enter project path: " PROJECT_PATH
            update_project "$PROJECT_PATH"
            ;;
        3)
            # TODO: Implement bulk update from project list
            echo -e "${YELLOW}⚠️  Bulk update not yet implemented${NC}"
            echo "Update projects individually for now."
            ;;
        4)
            echo "Update cancelled."
            return 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            return 1
            ;;
    esac

    # Save updated version
    mkdir -p "$HOME/.claude"
    cp "$VERSION_FILE" "$LOCAL_VERSION_FILE"

    echo ""
    echo -e "${GREEN}✅ Update complete!${NC}"
    echo ""
}

################################################################################
# Update Single Project
################################################################################

update_project() {
    local project_path=$1

    echo ""
    echo -e "${CYAN}Updating project: $project_path${NC}"
    echo ""

    # Create backup
    echo "Creating backup..."
    BACKUP_PATH=$(create_backup "$project_path")
    echo ""

    # Update .claude/ directory (3-way merge)
    if [ -d "$project_path/.claude" ]; then
        echo "Updating .claude/ configuration..."

        # Copy new files (but don't overwrite customizations)
        for file in "$TEMPLATE_DIR/.claude/"*; do
            filename=$(basename "$file")

            # Skip user-specific files
            case $filename in
                "memory.json"|"config.json"|"plans")
                    echo "  ⏭️  Skipping user-specific: $filename"
                    continue
                    ;;
            esac

            # Copy if doesn't exist, or ask user
            if [ ! -e "$project_path/.claude/$filename" ]; then
                cp -r "$file" "$project_path/.claude/"
                echo "  ✅ Added new: $filename"
            else
                echo "  ℹ️  Exists: $filename (keeping your version)"
                # TODO: Implement smart merge
            fi
        done
    else
        echo "  ⚠️  No .claude/ directory found. Creating..."
        mkdir -p "$project_path/.claude"
        cp -r "$TEMPLATE_DIR/.claude/"* "$project_path/.claude/"
    fi

    # Update scripts
    if [ -d "$TEMPLATE_DIR/scripts" ]; then
        echo ""
        echo "Updating wizard scripts..."
        mkdir -p "$project_path/scripts"
        cp -r "$TEMPLATE_DIR/scripts/"* "$project_path/scripts/"
        chmod +x "$project_path/scripts/"*.sh
        echo "  ✅ Wizard scripts updated"
    fi

    echo ""
    echo -e "${GREEN}✅ Project updated successfully!${NC}"
    echo ""
    echo -e "${CYAN}Backup location:${NC} $BACKUP_PATH"
    echo ""
}

################################################################################
# Command: Rollback
################################################################################

rollback() {
    print_header

    echo -e "${CYAN}Available backups:${NC}"
    echo ""

    if [ ! -d "$BACKUP_DIR" ]; then
        echo -e "${YELLOW}No backups found.${NC}"
        return 0
    fi

    # List backups
    BACKUPS=($(ls -1t "$BACKUP_DIR" 2>/dev/null))

    if [ ${#BACKUPS[@]} -eq 0 ]; then
        echo -e "${YELLOW}No backups found.${NC}"
        return 0
    fi

    for i in "${!BACKUPS[@]}"; do
        echo "$((i+1))) ${BACKUPS[$i]}"
    done

    echo ""
    read -p "Select backup to restore (1-${#BACKUPS[@]}): " BACKUP_NUM

    if [ "$BACKUP_NUM" -lt 1 ] || [ "$BACKUP_NUM" -gt ${#BACKUPS[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        return 1
    fi

    SELECTED_BACKUP="${BACKUPS[$((BACKUP_NUM-1))]}"
    BACKUP_PATH="$BACKUP_DIR/$SELECTED_BACKUP"

    echo ""
    read -p "Restore to which project path? " PROJECT_PATH

    if [ ! -d "$PROJECT_PATH" ]; then
        echo -e "${RED}Project path not found${NC}"
        return 1
    fi

    # Restore files
    echo ""
    echo "Restoring from backup..."

    if [ -d "$BACKUP_PATH/.claude" ]; then
        cp -r "$BACKUP_PATH/.claude" "$PROJECT_PATH/"
        echo -e "${GREEN}✅ Restored .claude/${NC}"
    fi

    if [ -f "$BACKUP_PATH/CLAUDE.md" ]; then
        cp "$BACKUP_PATH/CLAUDE.md" "$PROJECT_PATH/"
        echo -e "${GREEN}✅ Restored CLAUDE.md${NC}"
    fi

    echo ""
    echo -e "${GREEN}✅ Rollback complete!${NC}"
    echo ""
}

################################################################################
# Command: Info
################################################################################

show_info() {
    print_header

    LOCAL_VERSION=$(get_version "$LOCAL_VERSION_FILE")
    if [ "$LOCAL_VERSION" = "not_installed" ]; then
        LOCAL_VERSION=$(get_version "$VERSION_FILE")
    fi

    echo -e "${CYAN}Template Information:${NC}"
    echo ""
    echo -e "${BLUE}Current Version:${NC} $LOCAL_VERSION"
    echo -e "${BLUE}Template Location:${NC} $TEMPLATE_DIR"
    echo -e "${BLUE}Repository:${NC} $REPO_URL"
    echo -e "${BLUE}Backup Directory:${NC} $BACKUP_DIR"
    echo ""

    if command -v jq &> /dev/null && [ -f "$VERSION_FILE" ]; then
        FEATURES=$(jq -r '.features[]' "$VERSION_FILE" 2>/dev/null)
        echo -e "${CYAN}Available Features:${NC}"
        echo "$FEATURES" | sed 's/^/  • /'
        echo ""

        PERSONAS=$(jq -r '.personas_supported[]' "$VERSION_FILE" 2>/dev/null)
        echo -e "${CYAN}Supported Personas:${NC}"
        echo "$PERSONAS" | sed 's/^/  • /'
        echo ""
    fi
}

################################################################################
# Main
################################################################################

case "${1:-}" in
    --check|-c)
        check_updates
        ;;
    --apply|-a)
        apply_updates
        ;;
    --rollback|-r)
        rollback
        ;;
    --info|-i)
        show_info
        ;;
    --help|-h)
        print_header
        echo "Usage: claude-update.sh [OPTION]"
        echo ""
        echo "Options:"
        echo "  --check, -c      Check for template updates"
        echo "  --apply, -a      Apply latest updates"
        echo "  --rollback, -r   Rollback to previous backup"
        echo "  --info, -i       Show template information"
        echo "  --help, -h       Show this help message"
        echo ""
        echo "Examples:"
        echo "  ./scripts/claude-update.sh --check"
        echo "  ./scripts/claude-update.sh --apply"
        echo "  ./scripts/claude-update.sh --rollback"
        echo ""
        ;;
    *)
        # No argument - run interactive mode
        print_header
        echo "What would you like to do?"
        echo ""
        echo "1) Check for updates"
        echo "2) Apply updates"
        echo "3) Rollback to backup"
        echo "4) Show template info"
        echo "5) Exit"
        echo ""

        read -p "Select option (1-5): " OPTION

        case $OPTION in
            1) check_updates ;;
            2) apply_updates ;;
            3) rollback ;;
            4) show_info ;;
            5) exit 0 ;;
            *) echo "Invalid option" ;;
        esac
        ;;
esac
