#!/bin/bash
# Python Outdated Package Checker with Security Guidance
#
# This script checks for outdated Python packages and provides guidance
# on safe update strategies.
#
# Usage:
#   ./check-outdated.sh              # Check with pip
#   ./check-outdated.sh --poetry     # Check with Poetry
#   ./check-outdated.sh --json       # Output JSON format
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

POETRY_MODE=false
OUTPUT_JSON=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --poetry)
      POETRY_MODE=true
      shift
      ;;
    --json)
      OUTPUT_JSON=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: ./check-outdated.sh [--poetry] [--json]"
      exit 1
      ;;
  esac
done

echo "📅 Checking for outdated packages..."
echo ""

if [ "$POETRY_MODE" == true ]; then
  # Poetry mode
  if ! command -v poetry &> /dev/null; then
    echo -e "${RED}❌ Poetry not found${NC}"
    exit 1
  fi

  echo "Using Poetry project..."
  echo ""

  if [ "$OUTPUT_JSON" == true ]; then
    poetry show --outdated --format=json
    exit $?
  fi

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📦 Outdated Packages Report (Poetry)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  poetry show --outdated || OUTDATED_EXIT=$?

  if [ -z "$OUTDATED_EXIT" ]; then
    echo ""
    echo -e "${GREEN}✅ All packages are up to date!${NC}"
    exit 0
  fi

else
  # pip mode
  if [ "$OUTPUT_JSON" == true ]; then
    pip list --outdated --format=json
    exit $?
  fi

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📦 Outdated Packages Report (pip)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  pip list --outdated || OUTDATED_EXIT=$?

  if [ -z "$OUTDATED_EXIT" ]; then
    echo ""
    echo -e "${GREEN}✅ All packages are up to date!${NC}"
    exit 0
  fi
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

if [ "$POETRY_MODE" == true ]; then
  echo "${GREEN}Poetry Update Commands:${NC}"
  echo ""
  echo "1. Update patch versions only (safest):"
  echo "   ${BLUE}poetry update --dry-run${NC}  # Preview changes"
  echo "   ${BLUE}poetry update${NC}             # Apply updates"
  echo ""
  echo "2. Update specific package:"
  echo "   ${YELLOW}poetry update package-name${NC}"
  echo ""
  echo "3. Update to latest (including major - risky!):"
  echo "   ${RED}poetry add package-name@latest${NC}"
  echo ""
  echo "4. Check what would change:"
  echo "   ${CYAN}poetry show --outdated${NC}"
  echo ""
else
  echo "${GREEN}pip Update Commands:${NC}"
  echo ""
  echo "1. Update specific package:"
  echo "   ${BLUE}pip install --upgrade package-name${NC}"
  echo ""
  echo "2. Update to exact version:"
  echo "   ${YELLOW}pip install package-name==2.5.3${NC}"
  echo ""
  echo "3. Update all packages (risky!):"
  echo "   ${RED}pip list --outdated --format=json | jq -r '.[] | .name' | xargs -n1 pip install -U${NC}"
  echo ""
  echo "4. Check package info before update:"
  echo "   ${CYAN}pip show package-name${NC}"
  echo "   Visit https://pypi.org/project/package-name/"
  echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🛡️ Security-First Update Workflow"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Step 1: Run security audit FIRST"
if [ "$POETRY_MODE" == true ]; then
  echo "  ${CYAN}poetry export -f requirements.txt | pip-audit -r /dev/stdin${NC}"
else
  echo "  ${CYAN}pip-audit${NC}"
  echo "  # Or: safety check"
fi
echo ""

echo "Step 2: Review changelogs for major packages"
echo "  Visit PyPI project page"
echo "  Check GitHub releases"
echo "  Look for breaking changes"
echo ""

echo "Step 3: Update in development first"
echo "  ${CYAN}git checkout -b update-dependencies${NC}"
if [ "$POETRY_MODE" == true ]; then
  echo "  ${CYAN}poetry update${NC}"
else
  echo "  ${CYAN}pip install --upgrade package-name${NC}"
  echo "  ${CYAN}pip freeze > requirements.txt${NC}"
fi
echo "  ${CYAN}pytest${NC}  # Run tests!"
echo ""

echo "Step 4: Commit with lockfile"
if [ "$POETRY_MODE" == true ]; then
  echo "  ${CYAN}git add poetry.lock pyproject.toml${NC}"
else
  echo "  ${CYAN}git add requirements.txt${NC}"
fi
echo "  ${CYAN}git commit -m \"Update dependencies\"${NC}"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ Quick Commands"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$POETRY_MODE" == true ]; then
  echo "Check outdated (Poetry):"
  echo "  ${GREEN}poetry show --outdated${NC}"
  echo ""
  echo "Update all (Poetry):"
  echo "  ${YELLOW}poetry update${NC}"
  echo ""
  echo "Update specific package (Poetry):"
  echo "  ${YELLOW}poetry update package-name${NC}"
  echo ""
else
  echo "Check outdated (pip):"
  echo "  ${GREEN}pip list --outdated${NC}"
  echo ""
  echo "Update specific package (pip):"
  echo "  ${YELLOW}pip install --upgrade package-name${NC}"
  echo ""
  echo "Update with constraints:"
  echo "  ${YELLOW}pip install 'package-name>=1.2,<2.0'${NC}"
  echo ""
fi

echo "💡 Pro tip: Always audit before and after updates!"
echo ""
