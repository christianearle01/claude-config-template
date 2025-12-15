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

# Skills directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/../.claude/skills"

# Helper Functions

check_skills_dir() {
    if [ ! -d "$SKILLS_DIR" ]; then
        echo -e "${RED}✗${NC} Skills directory not found: $SKILLS_DIR"
        echo "Are you in the claude-config-template directory?"
        exit 1
    fi
}

get_skill_description() {
    local skill_path="$1"
    local skill_md="${skill_path}/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        echo "No SKILL.md found"
        return
    fi

    # Extract first line of description from YAML frontmatter
    awk '/^description:/ {
        sub(/^description:[[:space:]]*/, "");
        print;
        exit;
    }' "$skill_md" | head -c 60
}

get_skill_line_count() {
    local skill_path="$1"
    local skill_md="${skill_path}/SKILL.md"

    if [ ! -f "$skill_md" ]; then
        echo "0"
        return
    fi

    wc -l < "$skill_md" | tr -d ' '
}

# Commands

cmd_list() {
    check_skills_dir

    local format="table"

    # Parse flags
    while [[ $# -gt 0 ]]; do
        case $1 in
            --format)
                format="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done

    # Get all skill directories (exclude hidden files)
    local skills=()
    for dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$dir" ]; then
            local skill_name=$(basename "$dir")
            # Skip hidden directories
            if [[ ! "$skill_name" == .* ]]; then
                skills+=("$skill_name")
            fi
        fi
    done

    # Sort skills alphabetically
    IFS=$'\n' sorted=($(sort <<<"${skills[*]}"))
    unset IFS

    local total_skills=${#sorted[@]}

    if [ "$format" == "json" ]; then
        echo "{"
        echo "  \"total\": $total_skills,"
        echo "  \"skills\": ["
        local first=true
        for skill in "${sorted[@]}"; do
            local skill_path="$SKILLS_DIR/$skill"
            local description=$(get_skill_description "$skill_path")
            local lines=$(get_skill_line_count "$skill_path")

            if [ "$first" = true ]; then
                first=false
            else
                echo ","
            fi

            echo -n "    {"
            echo -n "\"name\": \"$skill\", "
            echo -n "\"description\": \"$description\", "
            echo -n "\"lines\": $lines"
            echo -n "}"
        done
        echo ""
        echo "  ]"
        echo "}"
    else
        # Table format (default)
        echo ""
        echo -e "${CYAN}📊 Available Skills (${total_skills} total)${NC}"
        echo ""

        local counter=1
        for skill in "${sorted[@]}"; do
            local skill_path="$SKILLS_DIR/$skill"
            local description=$(get_skill_description "$skill_path")

            # Pad skill name to 35 characters for alignment
            printf "  ${GREEN}%2d.${NC} %-35s %s\n" "$counter" "$skill" "$description"
            ((counter++))
        done

        echo ""
        echo -e "${YELLOW}Use './scripts/claude-skills.sh show <skill-name>' for details${NC}"
        echo ""
    fi
}

cmd_show() {
    check_skills_dir

    local skill_name="$1"

    if [ -z "$skill_name" ]; then
        echo -e "${RED}✗${NC} Error: Skill name required"
        echo "Usage: ./scripts/claude-skills.sh show <skill-name>"
        exit 1
    fi

    local skill_path="$SKILLS_DIR/$skill_name"
    local skill_md="$skill_path/SKILL.md"

    if [ ! -d "$skill_path" ]; then
        echo -e "${RED}✗${NC} Skill not found: $skill_name"
        echo ""
        echo "Available skills:"
        cmd_list --format table
        exit 1
    fi

    if [ ! -f "$skill_md" ]; then
        echo -e "${YELLOW}⚠️${NC}  Skill directory exists but SKILL.md not found: $skill_name"
        echo "Path: $skill_path"
        exit 1
    fi

    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}Skill: ${skill_name}${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    cat "$skill_md"

    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Location:${NC} $skill_path"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

cmd_search() {
    check_skills_dir

    local keyword="$1"

    if [ -z "$keyword" ]; then
        echo -e "${RED}✗${NC} Error: Search keyword required"
        echo "Usage: ./scripts/claude-skills.sh search <keyword>"
        exit 1
    fi

    echo ""
    echo -e "${CYAN}🔍 Searching skills for: \"${keyword}\"${NC}"
    echo ""

    local found=false

    # Search in all SKILL.md files
    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            if [ -f "$skill_md" ]; then
                # Search in YAML frontmatter (name, description) and content
                if grep -iq "$keyword" "$skill_md"; then
                    found=true
                    local description=$(get_skill_description "$skill_dir")

                    echo -e "${GREEN}✓${NC} ${BLUE}$skill_name${NC}"
                    echo "  $description"

                    # Show matching lines (first 3 matches)
                    local matches=$(grep -in "$keyword" "$skill_md" | head -3)
                    if [ -n "$matches" ]; then
                        echo -e "${YELLOW}  Matches:${NC}"
                        while IFS= read -r line; do
                            # Limit line length to 80 characters
                            local trimmed=$(echo "$line" | cut -c 1-80)
                            echo "    $trimmed"
                        done <<< "$matches"
                    fi
                    echo ""
                fi
            fi
        fi
    done

    if [ "$found" = false ]; then
        echo -e "${YELLOW}No skills found matching \"${keyword}\"${NC}"
        echo ""
        echo "Tip: Try broader search terms or use 'list' to see all skills"
        echo ""
    fi
}

cmd_stats() {
    check_skills_dir

    echo ""
    echo -e "${CYAN}📊 Skills Ecosystem Statistics${NC}"
    echo ""

    # Count total skills
    local total_skills=0
    local total_lines=0
    local skills_with_md=0
    local skills_with_examples=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")

            # Skip hidden directories
            if [[ "$skill_name" == .* ]]; then
                continue
            fi

            ((total_skills++))

            # Check for SKILL.md
            if [ -f "${skill_dir}SKILL.md" ]; then
                ((skills_with_md++))
                local lines=$(get_skill_line_count "$skill_dir")
                total_lines=$((total_lines + lines))
            fi

            # Check for examples directory with content
            if [ -d "${skill_dir}examples" ] && [ "$(ls -A "${skill_dir}examples" 2>/dev/null)" ]; then
                ((skills_with_examples++))
            fi
        fi
    done

    # Calculate averages
    local avg_lines=0
    if [ $skills_with_md -gt 0 ]; then
        avg_lines=$((total_lines / skills_with_md))
    fi

    # Calculate completeness percentage
    local completeness=0
    if [ $total_skills -gt 0 ]; then
        completeness=$(( (skills_with_md * 100) / total_skills ))
    fi

    echo -e "${GREEN}Total Skills:${NC}           $total_skills"
    echo -e "${GREEN}Skills with SKILL.md:${NC}   $skills_with_md ($completeness%)"
    echo -e "${GREEN}Skills with Examples:${NC}   $skills_with_examples"
    echo ""
    echo -e "${BLUE}Total Documentation:${NC}    $total_lines lines"
    echo -e "${BLUE}Average per Skill:${NC}      $avg_lines lines"
    echo ""

    # Show largest skills
    echo -e "${MAGENTA}Top 5 Largest Skills:${NC}"
    echo ""

    local skill_sizes=()
    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            if [[ ! "$skill_name" == .* ]] && [ -f "${skill_dir}SKILL.md" ]; then
                local lines=$(get_skill_line_count "$skill_dir")
                skill_sizes+=("$lines:$skill_name")
            fi
        fi
    done

    # Sort by size descending and show top 5
    IFS=$'\n' sorted_sizes=($(sort -rn <<<"${skill_sizes[*]}"))
    unset IFS

    local counter=1
    for entry in "${sorted_sizes[@]}"; do
        if [ $counter -le 5 ]; then
            local lines=$(echo "$entry" | cut -d: -f1)
            local name=$(echo "$entry" | cut -d: -f2)
            printf "  ${GREEN}%d.${NC} %-35s %s lines\n" "$counter" "$name" "$lines"
            ((counter++))
        fi
    done

    echo ""
}

cmd_help() {
    echo ""
    echo -e "${CYAN}Claude Skills Catalog${NC}"
    echo ""
    echo "Usage:"
    echo "  ./scripts/claude-skills.sh <command> [options]"
    echo ""
    echo "Commands:"
    echo -e "  ${GREEN}list${NC} [--format table|json]    List all available skills"
    echo -e "  ${GREEN}show${NC} <skill-name>             Show full SKILL.md content"
    echo -e "  ${GREEN}search${NC} <keyword>              Search skills by keyword"
    echo -e "  ${GREEN}stats${NC}                         Show ecosystem statistics"
    echo -e "  ${GREEN}help${NC}                          Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./scripts/claude-skills.sh list"
    echo "  ./scripts/claude-skills.sh show projects-registry"
    echo "  ./scripts/claude-skills.sh search \"test\""
    echo "  ./scripts/claude-skills.sh stats"
    echo ""
}

# Main execution

if [ $# -eq 0 ]; then
    cmd_help
    exit 0
fi

command="$1"
shift

case "$command" in
    list)
        cmd_list "$@"
        ;;
    show)
        cmd_show "$@"
        ;;
    search)
        cmd_search "$@"
        ;;
    stats)
        cmd_stats "$@"
        ;;
    help|--help|-h)
        cmd_help
        ;;
    *)
        echo -e "${RED}✗${NC} Unknown command: $command"
        echo ""
        cmd_help
        exit 1
        ;;
esac
