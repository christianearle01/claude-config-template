#!/bin/bash

# find-dependencies.sh
# Finds common dependency/environment directories in ~/Developer/ to help free up storage

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default search path
SEARCH_PATH="${1:-$HOME/Developer}"

# Output file for results (same directory as script)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_FILE="$SCRIPT_DIR/dependency-scan-results.txt"

echo -e "${BLUE}🔍 Searching for dependency directories in: ${SEARCH_PATH}${NC}\n"

# Array of directory patterns to search for
PATTERNS=(
    "node_modules"
    "venv"
    ".venv"
    "vendor"
    ".bundle"
    "target"
    "build"
    "dist"
    "__pycache__"
    ".pytest_cache"
    ".tox"
    "env"
)

# Temporary file to store results
RESULTS_FILE=$(mktemp)
trap 'rm -f $RESULTS_FILE' EXIT

# Function to get size in bytes
get_size_bytes() {
    local path="$1"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - use -k for kilobytes, then convert to bytes
        du -sk "$path" 2>/dev/null | awk '{print $1 * 1024}'
    else
        # Linux
        du -sb "$path" 2>/dev/null | cut -f1
    fi
}

# Function to convert bytes to human-readable format
bytes_to_human() {
    local bytes="$1"
    if [[ -z "$bytes" || "$bytes" -eq 0 ]]; then
        echo "0B"
        return
    fi

    awk -v bytes="$bytes" 'BEGIN {
        units[0] = "B"
        units[1] = "K"
        units[2] = "M"
        units[3] = "G"
        units[4] = "T"

        size = bytes
        unit = 0

        while (size >= 1024 && unit < 4) {
            size = size / 1024
            unit++
        }

        printf "%.1f%s", size, units[unit]
    }'
}

# Check if a directory is nested inside another dependency directory
# Returns 0 (true) if nested, 1 (false) if first-level
is_nested_dependency() {
    local dir="$1"
    local dirname=$(basename "$dir")

    # Get parent path (remove the last directory component)
    local parent_path=$(dirname "$dir")

    # Check if any dependency pattern appears in the parent path
    for pattern in "${PATTERNS[@]}"; do
        # Use grep to check if pattern appears in parent path as a directory name
        # Match pattern as a complete directory name (between / or at start/end)
        if echo "$parent_path" | grep -qE "(^|/)$pattern(/|$)"; then
            return 0  # Is nested
        fi
    done

    return 1  # Is first-level
}

# Function to scan for a pattern
scan_pattern() {
    local pattern="$1"
    echo -e "${YELLOW}Scanning for: ${pattern}${NC}"

    # Find directories matching pattern, exclude .git and other hidden dirs at top level
    find "$SEARCH_PATH" -type d -name "$pattern" -not -path "*/.*/*" 2>/dev/null | while read -r dir; do
        # Check if this is a nested dependency directory
        if is_nested_dependency "$dir"; then
            continue  # Skip nested directories
        fi

        size_bytes=$(get_size_bytes "$dir")

        # Skip 0B directories
        if [[ -z "$size_bytes" || "$size_bytes" -eq 0 ]]; then
            continue  # Skip empty directories
        fi

        size_human=$(bytes_to_human "$size_bytes")
        # Format: bytes|human_readable|path|pattern
        echo "$size_bytes|$size_human|$dir|$pattern" >> "$RESULTS_FILE"
    done
}

# Scan for all patterns
for pattern in "${PATTERNS[@]}"; do
    scan_pattern "$pattern"
done

echo ""

# Check if we found anything
if [[ ! -s "$RESULTS_FILE" ]]; then
    echo -e "${GREEN}✅ No dependency directories found!${NC}"
    exit 0
fi

# Sort results by size (bytes) in descending order and save to output file
echo -e "${BLUE}📊 Results (first-level directories only, excluding 0B, sorted by size):${NC}\n"

# Clear/create output file with header
{
    echo "======================================"
    echo "Dependency Scan Results"
    echo "Date: $(date)"
    echo "Search Path: $SEARCH_PATH"
    echo "Filter: First-level directories only (excluding nested and 0B)"
    echo "======================================"
    echo ""
    printf "%-12s %s\n" "SIZE" "PATH"
    printf "%s\n" "$(printf '%.0s-' {1..100})"
} > "$OUTPUT_FILE"

total_bytes=0
count=0

# Display header
printf "${BLUE}%-12s %s${NC}\n" "SIZE" "PATH"
printf "%s\n" "$(printf '%.0s-' {1..100})"

# Sort by bytes (first field) in descending order (largest first)
while IFS='|' read -r bytes size_human path pattern; do
    ((count++))
    total_bytes=$((total_bytes + bytes))

    # Display to terminal with colors
    printf "${YELLOW}%-12s${NC} %s\n" "$size_human" "$path"

    # Write to output file (no colors)
    printf "%-12s %s\n" "$size_human" "$path" >> "$OUTPUT_FILE"
done < <(sort -t'|' -k1 -rn "$RESULTS_FILE")

# Write summary to output file and display
echo ""
echo -e "${BLUE}📈 Summary:${NC}"
echo -e "   Found ${GREEN}${count}${NC} dependency directories"

# Convert total bytes to human-readable
total_human=$(bytes_to_human "$total_bytes")
echo -e "   Total size: ${RED}${total_human}${NC}"

# Write summary to output file
{
    echo ""
    echo "======================================"
    echo "Summary"
    echo "======================================"
    echo "Found: $count directories"
    echo "Total size: $total_human"
} >> "$OUTPUT_FILE"

echo ""
echo -e "${GREEN}✅ Results saved to: ${OUTPUT_FILE}${NC}"

# Provide removal options
echo ""
echo -e "${YELLOW}🗑️  Removal Options:${NC}"
echo ""
echo -e "${GREEN}✨ Recommended: Use the interactive removal script${NC}"
echo -e "   ${BLUE}./scripts/dependency-manager/remove-dependencies.sh${NC}"
echo ""
echo "   Features:"
echo "   • Dry run mode (preview before deleting)"
echo "   • Delete by type (node_modules, venv, build, etc.)"
echo "   • Interactive confirmation for each directory"
echo "   • Automatic backup list of deleted directories"
echo ""
echo -e "${CYAN}Alternative: Manual removal${NC}"
echo ""
echo "1. Copy paths from above and run:"
echo -e "   ${BLUE}rm -rf /path/to/dependency_folder${NC}"
echo ""
echo "2. Remove all node_modules (CAREFUL!):"
echo -e "   ${BLUE}find $SEARCH_PATH -type d -name 'node_modules' -not -path '*/.*/*' -exec rm -rf {} +${NC}"
echo ""
echo "3. Remove all Python virtual environments (CAREFUL!):"
echo -e "   ${BLUE}find $SEARCH_PATH -type d \\( -name 'venv' -o -name '.venv' -o -name 'env' \\) -not -path '*/.*/*' -exec rm -rf {} +${NC}"
echo ""
echo -e "${RED}⚠️  WARNING: Always verify paths before bulk deletion!${NC}"
echo ""
echo "💡 TIP: You can regenerate these directories:"
echo "   - node_modules: npm install (or yarn/pnpm install)"
echo "   - venv: python -m venv venv && source venv/bin/activate && pip install -r requirements.txt"
echo ""
