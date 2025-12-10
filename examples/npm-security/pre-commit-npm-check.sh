#!/bin/bash
# NPM Pre-Commit Security Hook
#
# This script runs security checks before allowing a git commit.
# Install as a git hook to ensure lockfile and dependencies are secure.
#
# Installation:
#   cp pre-commit-npm-check.sh .git/hooks/pre-commit
#   chmod +x .git/hooks/pre-commit
#
# Optional: Use husky for automatic hook management:
#   npm install --save-dev husky
#   npx husky install
#   npx husky add .git/hooks/pre-commit "bash examples/npm-security/pre-commit-npm-check.sh"
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "🔍 Running pre-commit security checks..."
echo ""

# Check if package.json or package-lock.json changed
NPM_FILES_CHANGED=$(git diff --cached --name-only | grep -E "package(-lock)?\.json" || true)

if [ -z "$NPM_FILES_CHANGED" ]; then
  echo -e "${GREEN}✅ No npm files changed - skipping security checks${NC}"
  exit 0
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 NPM Files Changed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "$NPM_FILES_CHANGED"
echo ""

# Check 1: Verify package-lock.json is included if package.json changed
if echo "$NPM_FILES_CHANGED" | grep -q "package.json"; then
  if ! echo "$NPM_FILES_CHANGED" | grep -q "package-lock.json"; then
    echo -e "${RED}❌ package.json changed but package-lock.json not updated${NC}"
    echo ""
    echo "Lockfile must be updated when package.json changes!"
    echo ""
    echo "Run: npm install"
    echo "Then: git add package-lock.json"
    exit 1
  fi
  echo -e "${GREEN}✅ Both package.json and lockfile updated${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 Running Security Audit"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 2: Run npm audit
if ! npm audit --audit-level=moderate; then
  echo ""
  echo -e "${RED}❌ Security vulnerabilities detected${NC}"
  echo ""
  echo "Options:"
  echo "  1. Fix automatically: npm audit fix"
  echo "  2. Review manually: npm audit"
  echo "  3. Override (not recommended): git commit --no-verify"
  echo ""
  exit 1
fi

echo -e "${GREEN}✅ No vulnerabilities found${NC}"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚖️  Lockfile Integrity Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 3: Verify lockfile is in sync
if ! npm ci --dry-run &> /dev/null; then
  echo -e "${YELLOW}⚠️  Lockfile may be out of sync${NC}"
  echo ""
  echo "Run: npm install"
  echo "This will update the lockfile to match package.json"
  echo ""
  # Don't fail on this - it's a warning
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Security Checks Passed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo -e "${GREEN}✅ All pre-commit security checks passed${NC}"
echo ""
echo "Proceeding with commit..."
echo ""

exit 0
