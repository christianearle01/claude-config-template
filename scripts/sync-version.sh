#!/bin/bash
# Sync version from version.json to all documentation files
# Usage: ./scripts/sync-version.sh

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Paths
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$TEMPLATE_DIR/version.json"

# Check if version.json exists
if [ ! -f "$VERSION_FILE" ]; then
    echo "❌ Error: version.json not found at $VERSION_FILE"
    exit 1
fi

# Extract version from version.json
echo -e "${CYAN}🔍 Reading version from version.json...${NC}"
if command -v jq &> /dev/null; then
    VERSION=$(jq -r '.version' "$VERSION_FILE")
else
    # Fallback if jq not installed
    VERSION=$(grep -o '"version": *"[^"]*"' "$VERSION_FILE" | sed 's/"version": *"\([^"]*\)"/\1/')
fi

if [ -z "$VERSION" ] || [ "$VERSION" = "null" ]; then
    echo "❌ Error: Could not extract version from version.json"
    exit 1
fi

echo -e "${GREEN}✓ Found version: v$VERSION${NC}"
echo ""

# Function to update file with version
update_version_in_file() {
    local file=$1
    local line_num=$2
    local pattern=$3

    if [ ! -f "$file" ]; then
        echo -e "${YELLOW}⚠️  File not found: $file${NC}"
        return 1
    fi

    # Use sed to replace version on specific line
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - use -E for extended regex
        sed -i '' -E "${line_num}s/v[0-9]+\.[0-9]+\.[0-9]+/v${VERSION}/" "$file"
    else
        # Linux - use -E for extended regex
        sed -i -E "${line_num}s/v[0-9]+\.[0-9]+\.[0-9]+/v${VERSION}/" "$file"
    fi

    echo -e "${GREEN}✓ Updated $file:$line_num${NC}"
}

# Update all files
echo -e "${CYAN}📝 Updating documentation files...${NC}"
echo ""

update_version_in_file "$TEMPLATE_DIR/CLAUDE.md" 4 "Version"
update_version_in_file "$TEMPLATE_DIR/README.md" 349 "Current version"
update_version_in_file "$TEMPLATE_DIR/README.md" 467 "Template Version"
update_version_in_file "$TEMPLATE_DIR/.claude/SETUP_CONTEXT.md" 21 "Current Version"
update_version_in_file "$TEMPLATE_DIR/.claude/SETUP_CONTEXT.md" 437 "Current:"

echo ""
echo -e "${GREEN}✅ Version sync complete!${NC}"
echo ""
echo -e "${CYAN}Version v$VERSION is now consistent across all files.${NC}"
echo ""
echo "Files updated:"
echo "  • CLAUDE.md"
echo "  • README.md (3 locations)"
echo "  • .claude/SETUP_CONTEXT.md (2 locations)"
echo ""
echo "Next steps:"
echo "  1. Review changes: git diff"
echo "  2. Commit changes: git commit -am 'Bump version to v$VERSION'"
echo "  3. Tag release: git tag v$VERSION"
echo ""
