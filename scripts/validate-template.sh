#!/bin/bash

################################################################################
# Template Validator Script
# Version: 1.0.0
# Purpose: Validate Claude preferences export template JSON files
# Usage: ./validate-template.sh <file_or_directory> [--catalog]
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
INFO_COUNT=0
VALIDATED=0
PASSED=0
FAILED=0

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Claude Template Validator v1.0.0${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_usage() {
    echo "Usage: $0 <file_or_directory> [--catalog]"
    echo ""
    echo "Options:"
    echo "  <file>        Validate a single template JSON file"
    echo "  <directory>   Validate all .json files in directory"
    echo "  --catalog     Validate as catalog file (different schema)"
    echo ""
    echo "Examples:"
    echo "  $0 examples/team-templates/gallery-frontend-react.json"
    echo "  $0 examples/team-templates/"
    echo "  $0 --catalog examples/team-templates/catalog.json"
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
    keys = '$path'.replace('.', ' ').split()
    for k in keys:
        if k and k != '':
            data = data.get(k, {})
    print(data if data else '')
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

# Print validation result
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

################################################################################
# Template Validation
################################################################################

validate_template() {
    local file=$1
    local filename=$(basename "$file")

    # Reset counters for this file
    ERRORS=0
    WARNINGS=0
    INFO_COUNT=0

    echo -e "${CYAN}🔍 Validating:${NC} $filename"
    echo ""

    # Level 1: Critical Checks (Errors)

    # 1. JSON Syntax
    if validate_json_syntax "$file"; then
        print_check "pass" "JSON syntax valid"
    else
        print_check "fail" "Invalid JSON syntax"
        echo ""
        echo -e "${RED}────────────────────────────────────────${NC}"
        echo -e "${RED}Result: FAILED (JSON parse error)${NC}"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi

    # 2. Schema field
    local schema=$(get_json_value "$file" '."$schema"')
    if [ "$schema" = "claude-preferences-export-v1" ]; then
        print_check "pass" "Schema: claude-preferences-export-v1"
    else
        print_check "fail" "Schema must be 'claude-preferences-export-v1' (got: '$schema')"
    fi

    # 3. Export type
    local export_type=$(get_json_value "$file" '.exportType')
    if [ "$export_type" = "template" ]; then
        print_check "pass" "Export type: template"
    else
        print_check "fail" "Export type must be 'template' (got: '$export_type')"
    fi

    # 4. Template ID
    local template_id=$(get_json_value "$file" '.templateMetadata.id')
    if [ -n "$template_id" ]; then
        # Validate ID format (lowercase, hyphens allowed)
        if [[ "$template_id" =~ ^[a-z0-9-]+$ ]]; then
            print_check "pass" "Template ID: $template_id"
        else
            print_check "fail" "Template ID must be lowercase with hyphens only (got: '$template_id')"
        fi
    else
        print_check "fail" "Missing required: templateMetadata.id"
    fi

    # 5. Template name
    local template_name=$(get_json_value "$file" '.templateMetadata.name')
    if [ -n "$template_name" ]; then
        print_check "pass" "Template name: $template_name"
    else
        print_check "fail" "Missing required: templateMetadata.name"
    fi

    # 6. Compatibility minVersion
    local min_version=$(get_json_value "$file" '.compatibility.minVersion')
    if [ -n "$min_version" ]; then
        print_check "pass" "Min version: $min_version"
    else
        print_check "fail" "Missing required: compatibility.minVersion"
    fi

    # Level 2: Important Checks (Warnings)

    # Description
    local description=$(get_json_value "$file" '.templateMetadata.description')
    if [ -n "$description" ]; then
        local desc_len=${#description}
        if [ $desc_len -gt 100 ]; then
            print_check "warn" "Description > 100 chars ($desc_len) - may truncate in catalog"
        else
            print_check "pass" "Description present ($desc_len chars)"
        fi
    else
        print_check "warn" "Missing: templateMetadata.description"
    fi

    # Category validation
    local category=$(get_json_value "$file" '.templateMetadata.category')
    local valid_categories="frontend backend fullstack data-science devops mobile security team"
    if [ -n "$category" ]; then
        if echo "$valid_categories" | grep -qw "$category"; then
            print_check "pass" "Category: $category"
        else
            print_check "warn" "Unknown category: '$category' (valid: $valid_categories)"
        fi
    else
        print_check "warn" "Missing: templateMetadata.category"
    fi

    # Version format
    local version=$(get_json_value "$file" '.templateMetadata.version')
    if [ -n "$version" ]; then
        if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            print_check "pass" "Version: $version (semver)"
        else
            print_check "warn" "Version '$version' is not semantic version (x.y.z)"
        fi
    else
        print_check "warn" "Missing: templateMetadata.version"
    fi

    # Contents object
    local has_contents=$(get_json_value "$file" '.contents')
    if [ -n "$has_contents" ] && [ "$has_contents" != "{}" ]; then
        print_check "pass" "Contents object present"
    else
        print_check "warn" "Contents object is empty or missing"
    fi

    # Checksum
    local checksum=$(get_json_value "$file" '.metadata.checksum')
    if [ -n "$checksum" ]; then
        print_check "pass" "Checksum: $checksum"
    else
        print_check "warn" "Missing: metadata.checksum"
    fi

    # Level 3: Info Checks

    # Extends inheritance
    local extends=$(get_json_value "$file" '.templateMetadata.extends')
    if [ -n "$extends" ]; then
        print_check "info" "Extends: $extends (inheritance enabled)"
    fi

    # Parameters
    local has_params=$(get_json_value "$file" '.templateMetadata.parameters')
    if [ -n "$has_params" ] && [ "$has_params" != "{}" ] && [ "$has_params" != "null" ]; then
        print_check "info" "Parameterized template (has parameters)"
    fi

    # recommendedFor
    local recommended=$(get_json_value "$file" '.templateMetadata.recommendedFor')
    if [ -n "$recommended" ] && [ "$recommended" != "[]" ] && [ "$recommended" != "null" ]; then
        print_check "info" "Recommended for: $recommended"
    fi

    # Print result
    echo ""
    echo -e "${BLUE}────────────────────────────────────────${NC}"

    if [ $ERRORS -gt 0 ]; then
        echo -e "${RED}Result: FAILED${NC} ($ERRORS errors, $WARNINGS warnings)"
        FAILED=$((FAILED + 1))
        return 1
    else
        if [ $WARNINGS -gt 0 ]; then
            echo -e "${GREEN}Result: PASSED${NC} ($WARNINGS warnings)"
        else
            echo -e "${GREEN}Result: PASSED${NC}"
        fi
        PASSED=$((PASSED + 1))
        return 0
    fi
}

################################################################################
# Catalog Validation
################################################################################

validate_catalog() {
    local file=$1
    local filename=$(basename "$file")

    ERRORS=0
    WARNINGS=0
    INFO_COUNT=0

    echo -e "${CYAN}🔍 Validating Catalog:${NC} $filename"
    echo ""

    # JSON Syntax
    if validate_json_syntax "$file"; then
        print_check "pass" "JSON syntax valid"
    else
        print_check "fail" "Invalid JSON syntax"
        echo ""
        echo -e "${RED}Result: FAILED (JSON parse error)${NC}"
        return 1
    fi

    # Schema
    local schema=$(get_json_value "$file" '."$schema"')
    if [ "$schema" = "claude-template-catalog-v1" ]; then
        print_check "pass" "Schema: claude-template-catalog-v1"
    else
        print_check "fail" "Schema must be 'claude-template-catalog-v1' (got: '$schema')"
    fi

    # Catalog name (top-level field)
    local name=$(get_json_value "$file" '.name')
    if [ -n "$name" ]; then
        print_check "pass" "Catalog name: $name"
    else
        print_check "fail" "Missing: name"
    fi

    # Total templates count (in metadata)
    local total_templates=$(get_json_value "$file" '.metadata.totalTemplates')
    if [ -n "$total_templates" ]; then
        print_check "pass" "Total templates: $total_templates"
    else
        print_check "warn" "Missing: metadata.totalTemplates"
    fi

    # Templates array
    if command -v jq &> /dev/null; then
        local template_count=$(jq '.templates | length' "$file" 2>/dev/null)
        if [ -n "$template_count" ] && [ "$template_count" -gt 0 ]; then
            print_check "pass" "Templates array has $template_count entries"

            # Verify count matches
            if [ -n "$total_templates" ] && [ "$template_count" != "$total_templates" ]; then
                print_check "warn" "totalTemplates ($total_templates) doesn't match actual count ($template_count)"
            fi

            # Check for duplicate IDs
            local unique_ids=$(jq '[.templates[].id] | unique | length' "$file" 2>/dev/null)
            if [ "$unique_ids" != "$template_count" ]; then
                print_check "fail" "Duplicate template IDs found"
            else
                print_check "pass" "All template IDs are unique"
            fi
        else
            print_check "warn" "Templates array is empty"
        fi
    fi

    # Print result
    echo ""
    echo -e "${BLUE}────────────────────────────────────────${NC}"

    if [ $ERRORS -gt 0 ]; then
        echo -e "${RED}Result: FAILED${NC} ($ERRORS errors, $WARNINGS warnings)"
        return 1
    else
        if [ $WARNINGS -gt 0 ]; then
            echo -e "${GREEN}Result: PASSED${NC} ($WARNINGS warnings)"
        else
            echo -e "${GREEN}Result: PASSED${NC}"
        fi
        return 0
    fi
}

################################################################################
# Main
################################################################################

main() {
    print_header

    # Parse arguments
    local target=""
    local catalog_mode=false

    for arg in "$@"; do
        case $arg in
            --catalog)
                catalog_mode=true
                ;;
            --help|-h)
                print_usage
                exit 0
                ;;
            *)
                target="$arg"
                ;;
        esac
    done

    # Check target provided
    if [ -z "$target" ]; then
        print_usage
        exit 1
    fi

    # Check target exists
    if [ ! -e "$target" ]; then
        echo -e "${RED}Error: '$target' not found${NC}"
        exit 1
    fi

    # Validate
    if [ "$catalog_mode" = true ]; then
        validate_catalog "$target"
    elif [ -f "$target" ]; then
        validate_template "$target"
    elif [ -d "$target" ]; then
        echo -e "${CYAN}Validating all templates in:${NC} $target"
        echo ""

        local files=$(find "$target" -maxdepth 1 -name "*.json" -type f | sort)

        for file in $files; do
            local filename=$(basename "$file")

            # Skip catalog.json in directory mode
            if [ "$filename" = "catalog.json" ]; then
                echo -e "${YELLOW}Skipping catalog.json (use --catalog flag)${NC}"
                echo ""
                continue
            fi

            validate_template "$file"
            echo ""
            VALIDATED=$((VALIDATED + 1))
        done

        # Print summary
        echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
        echo -e "${BLUE}  Summary${NC}"
        echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
        echo ""
        echo -e "  Templates validated: ${CYAN}$VALIDATED${NC}"
        echo -e "  Passed: ${GREEN}$PASSED${NC}"
        echo -e "  Failed: ${RED}$FAILED${NC}"
        echo ""

        if [ $FAILED -gt 0 ]; then
            exit 1
        fi
    fi
}

main "$@"
