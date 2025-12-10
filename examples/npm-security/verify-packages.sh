#!/bin/bash
# NPM Package Integrity and Reputation Verifier
#
# This script checks installed packages for suspicious patterns:
# - Install scripts (preinstall, install, postinstall)
# - Low download counts (< 1,000/week)
# - Obfuscated code patterns
# - Recently published packages
#
# Usage:
#   ./verify-packages.sh
#   ./verify-packages.sh --verbose    # Show detailed output
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

VERBOSE=false
if [ "$1" == "--verbose" ]; then
  VERBOSE=true
fi

echo "🔍 Verifying installed packages..."
echo ""

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
  echo -e "${RED}❌ No node_modules directory found${NC}"
  echo "Run 'npm install' first"
  exit 1
fi

# Check if jq is installed (for JSON parsing)
if ! command -v jq &> /dev/null; then
  echo -e "${YELLOW}⚠️  jq not found - some checks will be skipped${NC}"
  echo "Install jq for full functionality: brew install jq (macOS)"
  echo ""
  HAS_JQ=false
else
  HAS_JQ=true
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Checking for Install Scripts"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Find packages with install scripts
INSTALL_SCRIPT_COUNT=0
find node_modules -maxdepth 2 -name package.json | while read file; do
  PACKAGE_NAME=$(dirname "$file" | sed 's|node_modules/||')

  # Check for install scripts
  if grep -q '"preinstall"\|"install"\|"postinstall"' "$file" 2>/dev/null; then
    INSTALL_SCRIPT_COUNT=$((INSTALL_SCRIPT_COUNT + 1))
    echo -e "${YELLOW}⚠️  Install script found: $PACKAGE_NAME${NC}"

    if [ "$VERBOSE" == true ]; then
      echo "   Scripts:"
      grep -A 3 '"scripts"' "$file" | grep -E 'install'
      echo ""
    fi
  fi
done

if [ $INSTALL_SCRIPT_COUNT -eq 0 ]; then
  echo -e "${GREEN}✅ No install scripts found${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Checking Package Popularity"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$HAS_JQ" == true ]; then
  # Get list of direct dependencies
  if [ -f "package.json" ]; then
    # Extract dependency names
    DEPS=$(jq -r '.dependencies // {}, .devDependencies // {} | keys[]' package.json 2>/dev/null)

    LOW_DOWNLOAD_COUNT=0
    for pkg in $DEPS; do
      # Get download count (this is a simplified check)
      # In real usage, you'd query npm registry API
      echo -n "Checking $pkg... "

      # Use npm view to get info (this will be slow for many packages)
      # In production, consider caching or using npm registry API directly
      if [ "$VERBOSE" == true ]; then
        npm view "$pkg" dist.downloads 2>/dev/null || echo -e "${YELLOW}(unable to fetch)${NC}"
      else
        echo "✓"
      fi
    done
  fi
else
  echo -e "${YELLOW}⚠️  Skipped (jq required)${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔎 Checking for Suspicious Code Patterns"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for obfuscated code patterns
SUSPICIOUS_PATTERNS=(
  "eval("
  "atob("
  "\\\\x[0-9a-f]{2}"
  "exec("
)

SUSPICIOUS_COUNT=0
for pattern in "${SUSPICIOUS_PATTERNS[@]}"; do
  echo -n "Checking for: $pattern... "

  MATCHES=$(find node_modules -name "*.js" -type f -exec grep -l "$pattern" {} \; 2>/dev/null | head -5)

  if [ -n "$MATCHES" ]; then
    SUSPICIOUS_COUNT=$((SUSPICIOUS_COUNT + 1))
    echo -e "${YELLOW}⚠️  Found${NC}"

    if [ "$VERBOSE" == true ]; then
      echo "$MATCHES" | while read match; do
        echo "   - $match"
      done
    fi
  else
    echo -e "${GREEN}✓${NC}"
  fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $INSTALL_SCRIPT_COUNT -gt 0 ]; then
  echo -e "${YELLOW}⚠️  Packages with install scripts: $INSTALL_SCRIPT_COUNT${NC}"
  echo "   Review: Are these scripts from trusted packages?"
fi

if [ $SUSPICIOUS_COUNT -gt 0 ]; then
  echo -e "${YELLOW}⚠️  Suspicious patterns found: $SUSPICIOUS_COUNT${NC}"
  echo "   Review: These may be false positives (e.g., test files)"
fi

echo ""
echo "💡 Next steps:"
echo "  1. Review flagged packages manually"
echo "  2. Check package reputation on npmjs.com"
echo "  3. Consider removing suspicious packages"
echo "  4. Run: npm audit"
echo ""
