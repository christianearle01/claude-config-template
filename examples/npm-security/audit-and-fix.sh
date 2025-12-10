#!/bin/bash
# NPM Security Audit with Auto-Fix
#
# This script runs npm audit and optionally applies automatic fixes.
# Use this as part of your weekly security maintenance routine.
#
# Usage:
#   ./audit-and-fix.sh           # Run audit only
#   ./audit-and-fix.sh --fix     # Run audit and auto-fix
#   ./audit-and-fix.sh --force   # Auto-fix without prompting
#
# Last Updated: 2025-12-09

set -e  # Exit on errors

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔍 Running npm security audit..."

# Check if package.json exists
if [ ! -f "package.json" ]; then
  echo -e "${RED}❌ No package.json found${NC}"
  echo "This script must be run in a Node.js project directory"
  exit 1
fi

# Run audit
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Security Audit Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

npm audit --audit-level=moderate

AUDIT_EXIT_CODE=$?

if [ $AUDIT_EXIT_CODE -eq 0 ]; then
  echo ""
  echo -e "${GREEN}✅ No vulnerabilities found!${NC}"
  exit 0
fi

# Vulnerabilities found
echo ""
echo -e "${YELLOW}⚠️  Vulnerabilities detected${NC}"
echo ""

# Check for --fix or --force flags
if [ "$1" == "--force" ]; then
  echo "🔧 Applying automatic fixes (force mode)..."
  npm audit fix
  echo ""
  echo -e "${GREEN}✅ Fixes applied${NC}"
  exit 0
fi

if [ "$1" == "--fix" ]; then
  # Ask to auto-fix
  read -p "Apply automatic fixes? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔧 Applying automatic fixes..."
    npm audit fix
    echo ""
    echo -e "${GREEN}✅ Fixes applied${NC}"
  else
    echo "⏭️  Skipped auto-fix"
    echo ""
    echo "Manual fix options:"
    echo "  1. Run: npm audit fix"
    echo "  2. Run: npm audit fix --force (for breaking changes)"
    echo "  3. Review each vulnerability manually"
  fi
else
  echo "Re-run with --fix to apply automatic fixes:"
  echo "  ./audit-and-fix.sh --fix"
  echo ""
  echo "Or run manually:"
  echo "  npm audit fix"
  exit $AUDIT_EXIT_CODE
fi
