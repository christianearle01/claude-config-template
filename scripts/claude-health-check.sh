#!/bin/bash

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

# Counters
total_checks=7
passed_checks=0

# Results arrays
declare -a issues=()

# Helper Functions

check_skills_dir() {
    if [ ! -d "$SKILLS_DIR" ]; then
        echo -e "${RED}✗${NC} Skills directory not found: $SKILLS_DIR"
        echo "Are you in the claude-config-template directory?"
        exit 1
    fi
}

add_issue() {
    issues+=("$1")
}

# Health Checks

check_1_file_existence() {
    echo -n "Checking file existence... "

    local total_skills=0
    local skills_with_md=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")

            # Skip hidden directories
            if [[ "$skill_name" == .* ]]; then
                continue
            fi

            ((total_skills++))

            if [ -f "${skill_dir}SKILL.md" ]; then
                ((skills_with_md++))
            else
                add_issue "Missing SKILL.md in $skill_name"
            fi
        fi
    done

    if [ $skills_with_md -eq $total_skills ]; then
        echo -e "${GREEN}✅ File Existence: ${skills_with_md}/${total_skills} skills have SKILL.md${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  File Existence: ${skills_with_md}/${total_skills} skills have SKILL.md${NC}"
    fi
}

check_2_yaml_validity() {
    echo -n "Checking YAML frontmatter validity... "

    local total_yaml=0
    local valid_yaml=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "$skill_md" ]; then
                continue
            fi

            ((total_yaml++))

            # Check for YAML frontmatter delimiters
            if head -1 "$skill_md" | grep -q "^---$" && sed -n '2,10p' "$skill_md" | grep -q "^---$"; then
                # Check for required fields
                if grep -q "^name:" "$skill_md" && grep -q "^description:" "$skill_md"; then
                    ((valid_yaml++))
                else
                    add_issue "Invalid YAML in $skill_name (missing name or description)"
                fi
            else
                add_issue "Invalid YAML frontmatter in $skill_name"
            fi
        fi
    done

    if [ $valid_yaml -eq $total_yaml ]; then
        echo -e "${GREEN}✅ YAML Validity: ${valid_yaml}/${total_yaml} skills parse correctly${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  YAML Validity: ${valid_yaml}/${total_yaml} skills parse correctly${NC}"
    fi
}

check_3_structure_completeness() {
    echo -n "Checking structure completeness... "

    local total_skills=0
    local complete_skills=0

    # Required sections to check for
    local required_sections=("## Purpose" "## " "### Operation")

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "$skill_md" ]; then
                continue
            fi

            ((total_skills++))

            # Check for at least basic structure (Purpose section)
            if grep -q "## Purpose" "$skill_md"; then
                ((complete_skills++))
            else
                add_issue "Incomplete structure in $skill_name (missing sections)"
            fi
        fi
    done

    if [ $complete_skills -eq $total_skills ]; then
        echo -e "${GREEN}✅ Structure Completeness: ${complete_skills}/${total_skills} complete${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  Structure Completeness: ${complete_skills}/${total_skills} complete${NC}"
    fi
}

check_4_cross_references() {
    echo -n "Checking cross-reference integrity... "

    local total_references=0
    local valid_references=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "$skill_md" ]; then
                continue
            fi

            # Find "See Also" section and extract skill references
            if grep -q "## See Also" "$skill_md"; then
                # Extract skill names mentioned in See Also section
                local references=$(sed -n '/## See Also/,/^##/p' "$skill_md" | grep -oP '(?<=\*\*)[^*]+(?=\*\*)' 2>/dev/null || true)

                for ref in $references; do
                    ((total_references++))

                    # Check if referenced skill exists
                    if [ -d "$SKILLS_DIR/$ref" ]; then
                        ((valid_references++))
                    else
                        add_issue "Broken cross-reference in $skill_name → $ref"
                    fi
                done
            fi
        fi
    done

    if [ $total_references -eq 0 ]; then
        echo -e "${GREEN}✅ Cross-References: No cross-references to validate${NC}"
        ((passed_checks++))
    elif [ $valid_references -eq $total_references ]; then
        echo -e "${GREEN}✅ Cross-References: ${valid_references}/${total_references} links valid${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  Cross-References: ${valid_references}/${total_references} links valid${NC}"
    fi
}

check_5_example_directories() {
    echo -n "Checking example directories... "

    local total_skills=0
    local skills_with_examples=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "${skill_dir}SKILL.md" ]; then
                continue
            fi

            ((total_skills++))

            # Check for examples directory with content
            if [ -d "${skill_dir}examples" ]; then
                if [ "$(ls -A "${skill_dir}examples" 2>/dev/null)" ]; then
                    ((skills_with_examples++))
                else
                    add_issue "Empty examples directory in $skill_name"
                fi
            fi
        fi
    done

    # This is a softer requirement - we don't fail if examples are missing
    echo -e "${BLUE}ℹ️  Example Directories: ${skills_with_examples}/${total_skills} have examples${NC}"
    # Don't increment passed_checks - this is informational
}

check_6_token_analysis() {
    echo -n "Checking token analysis presence... "

    local major_skills=0
    local skills_with_analysis=0

    # Major skills are those with >300 lines
    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "$skill_md" ]; then
                continue
            fi

            # Check if it's a major skill (>300 lines)
            local lines=$(wc -l < "$skill_md" | tr -d ' ')
            if [ $lines -gt 300 ]; then
                ((major_skills++))

                # Check for token analysis section
                if grep -q "## Token Efficiency" "$skill_md" || grep -q "Token Savings" "$skill_md"; then
                    ((skills_with_analysis++))
                else
                    add_issue "Missing token analysis in major skill: $skill_name"
                fi
            fi
        fi
    done

    if [ $skills_with_analysis -eq $major_skills ]; then
        echo -e "${GREEN}✅ Token Analysis: ${skills_with_analysis}/${major_skills} major skills documented${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  Token Analysis: ${skills_with_analysis}/${major_skills} major skills documented${NC}"
    fi
}

check_7_activation_triggers() {
    echo -n "Checking activation triggers... "

    local total_skills=0
    local skills_with_triggers=0

    for skill_dir in "$SKILLS_DIR"/*/ ; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_md="${skill_dir}SKILL.md"

            # Skip hidden directories and skills without SKILL.md
            if [[ "$skill_name" == .* ]] || [ ! -f "$skill_md" ]; then
                continue
            fi

            ((total_skills++))

            # Check if description field includes trigger keywords
            if grep -A 3 "^description:" "$skill_md" | grep -qiE "auto-activates|activates when|automatically activates"; then
                ((skills_with_triggers++))
            else
                add_issue "Missing clear activation triggers in $skill_name description"
            fi
        fi
    done

    if [ $skills_with_triggers -eq $total_skills ]; then
        echo -e "${GREEN}✅ Activation Triggers: ${skills_with_triggers}/${total_skills} skills have trigger phrases${NC}"
        ((passed_checks++))
    else
        echo -e "${YELLOW}⚠️  Activation Triggers: ${skills_with_triggers}/${total_skills} skills have trigger phrases${NC}"
    fi
}

# Main execution

echo ""
echo -e "${CYAN}🏥 Skills Ecosystem Health Check${NC}"
echo ""

check_skills_dir

check_1_file_existence
check_2_yaml_validity
check_3_structure_completeness
check_4_cross_references
check_5_example_directories
check_6_token_analysis
check_7_activation_triggers

echo ""

# Calculate overall health percentage
# Note: check_5 is informational, so we use 6 checks for percentage
health_percentage=$(( (passed_checks * 100) / 6 ))

echo -e "${MAGENTA}Overall Health: ${health_percentage}%${NC}"

# Health status
if [ $health_percentage -ge 90 ]; then
    echo -e "${GREEN}Status: Excellent ✨${NC}"
elif [ $health_percentage -ge 70 ]; then
    echo -e "${YELLOW}Status: Good (room for improvement)${NC}"
elif [ $health_percentage -ge 50 ]; then
    echo -e "${YELLOW}Status: Fair (action recommended)${NC}"
else
    echo -e "${RED}Status: Needs Attention${NC}"
fi

echo ""

# Show recommendations if there are issues
if [ ${#issues[@]} -gt 0 ]; then
    echo -e "${YELLOW}Recommendations:${NC}"
    echo ""

    for issue in "${issues[@]}"; do
        echo -e "  ${YELLOW}•${NC} $issue"
    done

    echo ""

    # Suggest actions based on common issues
    if grep -q "Missing SKILL.md" <<< "${issues[@]}"; then
        echo -e "${CYAN}Quick Fix:${NC}"
        echo "  Complete incomplete skills:"
        for issue in "${issues[@]}"; do
            if [[ "$issue" =~ "Missing SKILL.md in "(.+) ]]; then
                skill_name="${BASH_REMATCH[1]}"
                echo "    - Create .claude/skills/${skill_name}/SKILL.md"
            fi
        done
        echo ""
    fi

    if grep -q "Empty examples" <<< "${issues[@]}"; then
        echo -e "${CYAN}Documentation Tip:${NC}"
        echo "  Add example queries to enhance skill discoverability"
        echo ""
    fi
fi

# Exit with success (don't fail CI/CD even if health is poor)
exit 0
