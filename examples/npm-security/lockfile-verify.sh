#!/bin/bash
# NPM Lockfile Integrity Verifier
#
# This script verifies that package-lock.json is:
# 1. Present (critical for security)
# 2. In sync with package.json
# 3. Committed to git
# 4. Valid JSON
#
# Usage:
#   ./lockfile-verify.sh
#   ./lockfile-verify.sh --fix    # Auto-generate lockfile if missing
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

AUTO_FIX=false
if [ "$1" == "--fix" ]; then
  AUTO_FIX=true
fi

echo "🔒 Verifying lockfile integrity..."
echo ""

# Check 1: package.json exists
if [ ! -f "package.json" ]; then
  echo -e "${RED}❌ No package.json found${NC}"
  echo "This script must be run in a Node.js project directory"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Lockfile Presence Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 2: package-lock.json exists
if [ ! -f "package-lock.json" ]; then
  echo -e "${RED}❌ No package-lock.json found${NC}"
  echo ""
  echo "⚠️  Lockfile is CRITICAL for security!"
  echo "   - Ensures reproducible builds"
  echo "   - Verifies package integrity (SHA-512 hashes)"
  echo "   - Prevents unexpected version updates"
  echo ""

  if [ "$AUTO_FIX" == true ]; then
    echo "🔧 Generating lockfile..."
    npm install --package-lock-only
    echo -e "${GREEN}✅ Lockfile created${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Review package-lock.json"
    echo "  2. Commit to git: git add package-lock.json"
  else
    echo "To create lockfile, run:"
    echo "  ${BLUE}npm install --package-lock-only${NC}"
    echo ""
    echo "Or run this script with --fix:"
    echo "  ${BLUE}./lockfile-verify.sh --fix${NC}"
    exit 1
  fi
else
  echo -e "${GREEN}✅ package-lock.json exists${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Lockfile Validity Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 3: Valid JSON
if ! jq empty package-lock.json 2>/dev/null; then
  if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  jq not found - skipping JSON validation${NC}"
    echo "Install jq for validation: brew install jq (macOS)"
  else
    echo -e "${RED}❌ package-lock.json is not valid JSON${NC}"
    echo ""
    echo "Lockfile is corrupted. Regenerate:"
    echo "  rm package-lock.json"
    echo "  npm install"
    exit 1
  fi
else
  echo -e "${GREEN}✅ Valid JSON format${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚖️  Lockfile Sync Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 4: Lockfile in sync with package.json
echo "Checking if lockfile matches package.json..."

# Use npm ci --dry-run to test sync
if npm ci --dry-run &> /dev/null; then
  echo -e "${GREEN}✅ Lockfile is in sync with package.json${NC}"
else
  echo -e "${YELLOW}⚠️  Lockfile out of sync${NC}"
  echo ""
  echo "The lockfile doesn't match package.json"
  echo ""
  echo "To fix, run:"
  echo "  ${BLUE}npm install${NC}  # Updates lockfile"
  echo ""
  echo "Or to see differences:"
  echo "  ${BLUE}npm ci --dry-run${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Git Tracking Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 5: Lockfile committed to git
if [ -d ".git" ]; then
  # Check if lockfile is tracked
  if git ls-files --error-unmatch package-lock.json &> /dev/null; then
    echo -e "${GREEN}✅ Lockfile is tracked by git${NC}"

    # Check if there are uncommitted changes
    if git diff --name-only | grep -q "package-lock.json"; then
      echo -e "${YELLOW}⚠️  Lockfile has uncommitted changes${NC}"
      echo ""
      echo "Commit lockfile changes:"
      echo "  ${BLUE}git add package-lock.json${NC}"
      echo "  ${BLUE}git commit -m \"Update dependencies\"${NC}"
    fi
  else
    echo -e "${RED}❌ Lockfile is not tracked by git${NC}"
    echo ""
    echo "CRITICAL: Lockfile must be committed for security!"
    echo ""
    echo "To track lockfile:"
    echo "  ${BLUE}git add package-lock.json${NC}"
    echo "  ${BLUE}git commit -m \"Add lockfile for security integrity\"${NC}"
  fi

  # Check if lockfile is in .gitignore (it shouldn't be!)
  if [ -f ".gitignore" ]; then
    if grep -q "package-lock.json" .gitignore; then
      echo -e "${RED}❌ CRITICAL: package-lock.json is in .gitignore!${NC}"
      echo ""
      echo "Remove it from .gitignore immediately!"
      echo "Lockfiles MUST be committed for security."
    fi
  fi
else
  echo -e "${BLUE}ℹ️  Not a git repository (skipped)${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 Security Features Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check 6: Verify lockfile has integrity hashes
if command -v jq &> /dev/null; then
  PACKAGES_WITH_INTEGRITY=$(jq -r '.packages | to_entries[] | select(.value.integrity) | .key' package-lock.json 2>/dev/null | wc -l)

  if [ "$PACKAGES_WITH_INTEGRITY" -gt 0 ]; then
    echo -e "${GREEN}✅ Lockfile includes integrity hashes (SHA-512)${NC}"
    echo "   Packages with hashes: $PACKAGES_WITH_INTEGRITY"
  else
    echo -e "${YELLOW}⚠️  No integrity hashes found${NC}"
    echo "   Regenerate lockfile with newer npm version"
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "💡 Lockfile Best Practices:"
echo ""
echo "  ✅ ALWAYS commit package-lock.json to git"
echo "  ✅ NEVER add package-lock.json to .gitignore"
echo "  ✅ Use 'npm ci' in CI/CD (not 'npm install')"
echo "  ✅ Update lockfile after every package change"
echo "  ✅ Review lockfile diffs before committing"
echo ""

echo "📚 Learn more:"
echo "  https://docs.npmjs.com/cli/v9/configuring-npm/package-lock-json"
echo ""
