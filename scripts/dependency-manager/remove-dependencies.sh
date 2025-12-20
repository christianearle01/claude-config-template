#!/bin/bash

# remove-dependencies.sh
# Safely remove dependency directories from dependency-scan-results.txt

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RESULTS_FILE="$SCRIPT_DIR/dependency-scan-results.txt"
BACKUP_FILE="$SCRIPT_DIR/deleted-dependencies-$(date +%Y%m%d-%H%M%S).txt"

# Check if results file exists
if [[ ! -f "$RESULTS_FILE" ]]; then
    echo -e "${RED}❌ Error: Results file not found at $RESULTS_FILE${NC}"
    echo -e "   Run ./scripts/dependency-manager/find-dependencies.sh first to generate the results."
    exit 1
fi

# Extract paths from results file (skip header, get only lines with sizes)
extract_paths() {
    tail -n +10 "$RESULTS_FILE" | grep -E '^[0-9]+\.' | awk '{print $2}'
}

# Count directories by type
count_by_type() {
    local pattern="$1"
    extract_paths | grep -c "/$pattern$" || echo "0"
}

# Calculate total size by type
size_by_type() {
    local pattern="$1"
    local total_kb=0

    tail -n +10 "$RESULTS_FILE" | grep -E '^[0-9]+\.' | grep "/$pattern$" | while read -r line; do
        local size=$(echo "$line" | awk '{print $1}')
        local size_kb=0

        # Convert to KB
        if [[ "$size" =~ ([0-9.]+)G ]]; then
            size_kb=$(echo "${BASH_REMATCH[1]} * 1024 * 1024" | bc)
        elif [[ "$size" =~ ([0-9.]+)M ]]; then
            size_kb=$(echo "${BASH_REMATCH[1]} * 1024" | bc)
        elif [[ "$size" =~ ([0-9.]+)K ]]; then
            size_kb="${BASH_REMATCH[1]}"
        fi

        total_kb=$(echo "$total_kb + $size_kb" | bc)
    done

    # Convert KB to human readable
    local total_mb=$(echo "scale=1; $total_kb / 1024" | bc)
    local total_gb=$(echo "scale=1; $total_mb / 1024" | bc)

    if (( $(echo "$total_gb >= 1" | bc -l) )); then
        echo "${total_gb}G"
    else
        echo "${total_mb}M"
    fi
}

# Show summary
show_summary() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║          Dependency Removal - Summary                         ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    local total_count=$(extract_paths | wc -l | xargs)
    local total_size=$(tail -n 1 "$RESULTS_FILE" | grep -oE '[0-9.]+[KMGT]')

    echo -e "${CYAN}📊 Overview:${NC}"
    echo -e "   Total directories: ${YELLOW}$total_count${NC}"
    echo -e "   Total size: ${RED}$total_size${NC}"
    echo ""

    echo -e "${CYAN}📁 Breakdown by type:${NC}"

    # Count each type
    local node_modules_count=$(count_by_type "node_modules")
    local venv_count=$(count_by_type "venv")
    local dotenv_count=$(count_by_type ".venv")
    local env_count=$(count_by_type "env")
    local vendor_count=$(count_by_type "vendor")
    local target_count=$(count_by_type "target")
    local dist_count=$(count_by_type "dist")
    local build_count=$(count_by_type "build")
    local pycache_count=$(count_by_type "__pycache__")

    [[ "$node_modules_count" -gt 0 ]] && echo -e "   ${YELLOW}node_modules:${NC} $node_modules_count directories"
    [[ "$venv_count" -gt 0 ]] && echo -e "   ${YELLOW}venv:${NC} $venv_count directories"
    [[ "$dotenv_count" -gt 0 ]] && echo -e "   ${YELLOW}.venv:${NC} $dotenv_count directories"
    [[ "$env_count" -gt 0 ]] && echo -e "   ${YELLOW}env:${NC} $env_count directories"
    [[ "$vendor_count" -gt 0 ]] && echo -e "   ${YELLOW}vendor:${NC} $vendor_count directories"
    [[ "$target_count" -gt 0 ]] && echo -e "   ${YELLOW}target:${NC} $target_count directories"
    [[ "$dist_count" -gt 0 ]] && echo -e "   ${YELLOW}dist:${NC} $dist_count directories"
    [[ "$build_count" -gt 0 ]] && echo -e "   ${YELLOW}build:${NC} $build_count directories"
    [[ "$pycache_count" -gt 0 ]] && echo -e "   ${YELLOW}__pycache__:${NC} $pycache_count directories"

    echo ""
}

# Dry run - show what would be deleted
dry_run() {
    echo -e "${YELLOW}🔍 DRY RUN - Showing what would be deleted:${NC}"
    echo ""

    local count=0
    extract_paths | while read -r path; do
        ((count++))
        echo -e "${CYAN}[$count]${NC} $path"
    done

    echo ""
    echo -e "${GREEN}✅ Dry run complete. No files were deleted.${NC}"
}

# Delete by type
delete_by_type() {
    local pattern="$1"
    local count=$(count_by_type "$pattern")

    if [[ "$count" -eq 0 ]]; then
        echo -e "${YELLOW}No $pattern directories found.${NC}"
        return
    fi

    echo -e "${YELLOW}Found $count $pattern directories${NC}"
    echo -e "${RED}⚠️  This will delete all $pattern directories!${NC}"
    read -p "Are you sure? Type 'yes' to confirm: " confirm

    if [[ "$confirm" != "yes" ]]; then
        echo -e "${BLUE}Cancelled.${NC}"
        return
    fi

    echo "" > "$BACKUP_FILE"
    local deleted=0

    extract_paths | grep "/$pattern$" | while read -r path; do
        if [[ -d "$path" ]]; then
            echo "$path" >> "$BACKUP_FILE"
            echo -e "${YELLOW}Deleting:${NC} $path"
            rm -rf "$path"
            ((deleted++))
            echo -e "${GREEN}✅ Deleted ($deleted/$count)${NC}"
        else
            echo -e "${BLUE}⏭️  Already deleted:${NC} $path"
        fi
    done

    echo ""
    echo -e "${GREEN}✅ Deleted $count $pattern directories${NC}"
    echo -e "${BLUE}📝 Backup list saved to: $BACKUP_FILE${NC}"
}

# Interactive deletion
interactive_delete() {
    echo -e "${YELLOW}🔄 Interactive deletion mode${NC}"
    echo -e "${BLUE}You'll be asked to confirm each directory.${NC}"
    echo ""

    echo "" > "$BACKUP_FILE"
    local deleted=0
    local skipped=0
    local total=$(extract_paths | wc -l | xargs)

    extract_paths | while read -r path; do
        local current=$((deleted + skipped + 1))
        echo ""
        echo -e "${CYAN}[$current/$total]${NC} $path"

        if [[ ! -d "$path" ]]; then
            echo -e "${BLUE}⏭️  Already deleted${NC}"
            ((skipped++))
            continue
        fi

        read -p "Delete this directory? (y/n/q): " choice

        case "$choice" in
            y|Y)
                echo "$path" >> "$BACKUP_FILE"
                rm -rf "$path"
                ((deleted++))
                echo -e "${GREEN}✅ Deleted${NC}"
                ;;
            q|Q)
                echo -e "${BLUE}Quit - Stopped at $current/$total${NC}"
                echo -e "${GREEN}Deleted: $deleted${NC}"
                echo -e "${BLUE}Skipped: $skipped${NC}"
                exit 0
                ;;
            *)
                ((skipped++))
                echo -e "${BLUE}Skipped${NC}"
                ;;
        esac
    done

    echo ""
    echo -e "${GREEN}✅ Interactive deletion complete${NC}"
    echo -e "${GREEN}Deleted: $deleted${NC}"
    echo -e "${BLUE}Skipped: $skipped${NC}"
    echo -e "${BLUE}📝 Backup list saved to: $BACKUP_FILE${NC}"
}

# Delete all
delete_all() {
    local total=$(extract_paths | wc -l | xargs)
    local total_size=$(tail -n 1 "$RESULTS_FILE" | grep -oE '[0-9.]+[KMGT]')

    echo -e "${RED}⚠️  WARNING: This will delete ALL $total directories ($total_size)!${NC}"
    echo ""
    read -p "Are you ABSOLUTELY sure? Type 'DELETE ALL' to confirm: " confirm

    if [[ "$confirm" != "DELETE ALL" ]]; then
        echo -e "${BLUE}Cancelled. (You must type 'DELETE ALL' exactly)${NC}"
        return
    fi

    echo "" > "$BACKUP_FILE"
    local deleted=0

    extract_paths | while read -r path; do
        if [[ -d "$path" ]]; then
            echo "$path" >> "$BACKUP_FILE"
            ((deleted++))
            echo -e "${YELLOW}[$deleted/$total]${NC} Deleting: $path"
            rm -rf "$path"
        else
            echo -e "${BLUE}⏭️  Already deleted:${NC} $path"
        fi
    done

    echo ""
    echo -e "${GREEN}✅ Deleted all directories${NC}"
    echo -e "${BLUE}📝 Backup list saved to: $BACKUP_FILE${NC}"
}

# Main menu
show_menu() {
    clear
    show_summary

    echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║          Deletion Options                                      ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}1.${NC} Dry run (show what would be deleted)"
    echo -e "${CYAN}2.${NC} Delete all node_modules"
    echo -e "${CYAN}3.${NC} Delete all Python environments (venv/.venv/env)"
    echo -e "${CYAN}4.${NC} Delete all build/dist directories"
    echo -e "${CYAN}5.${NC} Delete all __pycache__ directories"
    echo -e "${CYAN}6.${NC} Interactive deletion (confirm each)"
    echo -e "${CYAN}7.${NC} Delete ALL directories (${RED}DANGEROUS!${NC})"
    echo -e "${CYAN}8.${NC} Exit"
    echo ""
    read -p "Choose an option (1-8): " choice

    case "$choice" in
        1)
            clear
            dry_run
            ;;
        2)
            clear
            delete_by_type "node_modules"
            ;;
        3)
            clear
            echo -e "${YELLOW}Deleting Python environments...${NC}"
            delete_by_type "venv"
            delete_by_type ".venv"
            delete_by_type "env"
            ;;
        4)
            clear
            echo -e "${YELLOW}Deleting build/dist directories...${NC}"
            delete_by_type "build"
            delete_by_type "dist"
            ;;
        5)
            clear
            delete_by_type "__pycache__"
            ;;
        6)
            clear
            interactive_delete
            ;;
        7)
            clear
            delete_all
            ;;
        8)
            echo -e "${BLUE}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option. Please choose 1-8.${NC}"
            sleep 2
            ;;
    esac

    echo ""
    read -p "Press Enter to return to menu..."
}

# Main loop
while true; do
    show_menu
done
