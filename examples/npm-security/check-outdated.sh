#!/bin/bash
# NPM Outdated Package Checker with Security Guidance
#
# This script checks for outdated packages and provides guidance on
# safe update strategies based on semantic versioning.
#
# Usage:
#   ./check-outdated.sh
#   ./check-outdated.sh --json     # Output JSON format
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

OUTPUT_JSON=false
if [ "$1" == "--json" ]; then
  OUTPUT_JSON=true
fi

if [ ! -f "package.json" ]; then
  echo -e "${RED}❌ No package.json found${NC}"
  exit 1
fi

echo "📅 Checking for outdated packages..."
echo ""

# Run npm outdated
if [ "$OUTPUT_JSON" == true ]; then
  npm outdated --json
  exit $?
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Outdated Packages Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

npm outdated || OUTDATED_EXIT=$?

# If no outdated packages (exit code 0), we're done
if [ -z "$OUTDATED_EXIT" ]; then
  echo ""
  echo -e "${GREEN}✅ All packages are up to date!${NC}"
  exit 0
fi

# Outdated packages found
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💡 Update Strategy Guide"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo -e "${CYAN}Semantic Versioning (SemVer) Cheat Sheet:${NC}"
echo ""
echo "  MAJOR.MINOR.PATCH (e.g., 2.5.3)"
echo ""
echo "  ${RED}MAJOR${NC} (e.g., 1.0.0 → 2.0.0)"
echo "    - Breaking changes"
echo "    - May require code changes"
echo "    - ${YELLOW}⚠️  Test thoroughly before updating${NC}"
echo ""
echo "  ${YELLOW}MINOR${NC} (e.g., 1.4.0 → 1.5.0)"
echo "    - New features (backwards-compatible)"
echo "    - Usually safe to update"
echo "    - ${BLUE}ℹ️  Review changelog before updating${NC}"
echo ""
echo "  ${GREEN}PATCH${NC} (e.g., 1.4.2 → 1.4.3)"
echo "    - Bug fixes only"
echo "    - Safe to update"
echo "    - ${GREEN}✅ Generally safe to auto-update${NC}"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 Safe Update Process"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "1. ${GREEN}Patch updates${NC} (safe):"
echo "   npm update              # Updates to latest patch version"
echo ""

echo "2. ${YELLOW}Minor updates${NC} (review first):"
echo "   npm outdated            # Check what would change"
echo "   npm view pkg@version    # Read changelog"
echo "   npm update pkg --save   # Update specific package"
echo ""

echo "3. ${RED}Major updates${NC} (test thoroughly):"
echo "   npm view pkg versions   # See all versions"
echo "   npm view pkg@next       # Check next major version"
echo "   npm install pkg@latest  # Update to latest (risky!)"
echo "   # Run tests!"
echo "   # Check for breaking changes!"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🛡️ Security-First Update Workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Step 1: Check for security vulnerabilities"
echo "  ${CYAN}npm audit${NC}"
echo ""

echo "Step 2: Auto-fix security issues"
echo "  ${CYAN}npm audit fix${NC}"
echo ""

echo "Step 3: Review changelogs for major packages"
echo "  ${CYAN}npm view package-name versions${NC}"
echo "  Visit GitHub releases page"
echo ""

echo "Step 4: Update in development first"
echo "  ${CYAN}git checkout -b update-dependencies${NC}"
echo "  ${CYAN}npm update${NC}"
echo "  ${CYAN}npm test${NC}"
echo ""

echo "Step 5: Commit with lockfile"
echo "  ${CYAN}git add package.json package-lock.json${NC}"
echo "  ${CYAN}git commit -m \"Update dependencies\"${NC}"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ Quick Commands"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Update patch versions only (safest):"
echo "  ${GREEN}npm update${NC}"
echo ""

echo "Update specific package:"
echo "  ${YELLOW}npm update package-name${NC}"
echo ""

echo "Update to latest (including major - risky!):"
echo "  ${RED}npm install package-name@latest${NC}"
echo ""

echo "Check what would be updated (dry run):"
echo "  ${CYAN}npm outdated${NC}"
echo ""

echo "💡 Pro tip: Use npm-check-updates for interactive updates"
echo "  npm install -g npm-check-updates"
echo "  ncu --interactive"
echo ""
