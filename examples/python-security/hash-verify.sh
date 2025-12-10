#!/bin/bash
# Python Hash Verification and Lockfile Integrity Checker
#
# This script verifies that requirements.txt or poetry.lock:
# 1. Exists (critical for security)
# 2. Contains integrity hashes (for pip)
# 3. Is in sync with installed packages
# 4. Is committed to git
#
# Usage:
#   ./hash-verify.sh              # Check requirements.txt (pip)
#   ./hash-verify.sh --poetry     # Check poetry.lock
#   ./hash-verify.sh --generate   # Generate hashed requirements.txt
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

POETRY_MODE=false
GENERATE_MODE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --poetry)
      POETRY_MODE=true
      shift
      ;;
    --generate)
      GENERATE_MODE=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: ./hash-verify.sh [--poetry] [--generate]"
      exit 1
      ;;
  esac
done

echo "🔒 Verifying lockfile integrity..."
echo ""

if [ "$POETRY_MODE" == true ]; then
  # ===== POETRY MODE =====

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📋 Poetry Lockfile Check"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  if ! command -v poetry &> /dev/null; then
    echo -e "${RED}❌ Poetry not found${NC}"
    exit 1
  fi

  # Check 1: poetry.lock exists
  if [ ! -f "poetry.lock" ]; then
    echo -e "${RED}❌ No poetry.lock found${NC}"
    echo ""
    echo "Lockfile is CRITICAL for security!"
    echo ""
    echo "To create lockfile:"
    echo "  ${BLUE}poetry lock${NC}"
    exit 1
  fi

  echo -e "${GREEN}✅ poetry.lock exists${NC}"

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⚖️  Lockfile Sync Check"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 2: Verify lockfile is in sync
  if poetry lock --check &> /dev/null; then
    echo -e "${GREEN}✅ poetry.lock is in sync with pyproject.toml${NC}"
  else
    echo -e "${YELLOW}⚠️  Lockfile out of sync${NC}"
    echo ""
    echo "To fix:"
    echo "  ${BLUE}poetry lock${NC}"
    echo ""
    exit 1
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔐 Hash Verification"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 3: Verify hashes are present
  if grep -q "sha256:" poetry.lock; then
    echo -e "${GREEN}✅ poetry.lock includes SHA-256 hashes${NC}"

    HASH_COUNT=$(grep -c "sha256:" poetry.lock || true)
    echo "   Packages with hashes: $HASH_COUNT"
  else
    echo -e "${YELLOW}⚠️  No hashes found in poetry.lock${NC}"
  fi

else
  # ===== PIP MODE =====

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📋 Requirements File Check"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check if pip-tools is installed (for hash generation)
  if [ "$GENERATE_MODE" == true ]; then
    if ! command -v pip-compile &> /dev/null; then
      echo -e "${YELLOW}⚠️  pip-tools not found${NC}"
      echo "Installing pip-tools..."
      pip install pip-tools
      echo ""
    fi
  fi

  # Check 1: requirements.txt exists
  if [ ! -f "requirements.txt" ]; then
    echo -e "${RED}❌ No requirements.txt found${NC}"
    echo ""

    if [ "$GENERATE_MODE" == true ]; then
      if [ -f "requirements.in" ]; then
        echo "Generating requirements.txt from requirements.in..."
        pip-compile --generate-hashes requirements.in
        echo -e "${GREEN}✅ requirements.txt created with hashes${NC}"
        echo ""
        echo "Next steps:"
        echo "  1. Review requirements.txt"
        echo "  2. Install: pip install -r requirements.txt --require-hashes"
        echo "  3. Commit: git add requirements.txt"
        exit 0
      else
        echo "To create requirements.txt:"
        echo "  ${BLUE}pip freeze > requirements.txt${NC}"
        echo ""
        echo "Or with hashes (recommended):"
        echo "  1. Create requirements.in (list dependencies)"
        echo "  2. pip install pip-tools"
        echo "  3. pip-compile --generate-hashes requirements.in"
        exit 1
      fi
    else
      echo "Run with --generate to create hashed requirements.txt"
      exit 1
    fi
  fi

  echo -e "${GREEN}✅ requirements.txt exists${NC}"

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔐 Hash Verification"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 2: Check for hashes
  if grep -q "--hash=sha256:" requirements.txt; then
    echo -e "${GREEN}✅ requirements.txt includes SHA-256 hashes${NC}"

    HASH_COUNT=$(grep -c "--hash=sha256:" requirements.txt || true)
    echo "   Packages with hashes: $HASH_COUNT"

    echo ""
    echo "To install with hash verification (CRITICAL for security):"
    echo "  ${BLUE}pip install -r requirements.txt --require-hashes${NC}"

  else
    echo -e "${YELLOW}⚠️  No hashes found in requirements.txt${NC}"
    echo ""
    echo "Hashes ensure package integrity and prevent tampering!"
    echo ""

    if [ "$GENERATE_MODE" == true ]; then
      echo "Generating requirements.txt with hashes..."

      # Create requirements.in from current requirements.txt
      grep -v "^#" requirements.txt | grep -v "^$" > requirements.in

      # Generate with hashes
      pip-compile --generate-hashes requirements.in

      echo -e "${GREEN}✅ requirements.txt regenerated with hashes${NC}"
    else
      echo "To add hashes:"
      echo "  1. pip install pip-tools"
      echo "  2. Create requirements.in (copy from requirements.txt)"
      echo "  3. pip-compile --generate-hashes requirements.in"
      echo ""
      echo "Or run: ${BLUE}./hash-verify.sh --generate${NC}"
    fi
  fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Git Tracking Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check git tracking
if [ -d ".git" ]; then
  if [ "$POETRY_MODE" == true ]; then
    LOCKFILE="poetry.lock"
  else
    LOCKFILE="requirements.txt"
  fi

  # Check if tracked
  if git ls-files --error-unmatch "$LOCKFILE" &> /dev/null; then
    echo -e "${GREEN}✅ $LOCKFILE is tracked by git${NC}"

    # Check for uncommitted changes
    if git diff --name-only | grep -q "$LOCKFILE"; then
      echo -e "${YELLOW}⚠️  $LOCKFILE has uncommitted changes${NC}"
      echo ""
      echo "Commit lockfile changes:"
      echo "  ${BLUE}git add $LOCKFILE${NC}"
      echo "  ${BLUE}git commit -m \"Update dependencies\"${NC}"
    fi
  else
    echo -e "${RED}❌ $LOCKFILE is not tracked by git${NC}"
    echo ""
    echo "CRITICAL: Lockfile must be committed!"
    echo ""
    echo "To track:"
    echo "  ${BLUE}git add $LOCKFILE${NC}"
    echo "  ${BLUE}git commit -m \"Add lockfile for security\"${NC}"
  fi

  # Check .gitignore
  if [ -f ".gitignore" ]; then
    if grep -q "$LOCKFILE" .gitignore; then
      echo -e "${RED}❌ CRITICAL: $LOCKFILE is in .gitignore!${NC}"
      echo ""
      echo "Remove it immediately!"
      echo "Lockfiles MUST be committed."
    fi
  fi
else
  echo -e "${BLUE}ℹ️  Not a git repository (skipped)${NC}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$POETRY_MODE" == true ]; then
  echo "💡 Poetry Best Practices:"
  echo ""
  echo "  ✅ Always commit poetry.lock"
  echo "  ✅ Use: poetry install (uses lockfile)"
  echo "  ✅ Update: poetry update (updates lockfile)"
  echo "  ✅ Verify: poetry lock --check"
else
  echo "💡 pip Best Practices:"
  echo ""
  echo "  ✅ Generate with hashes: pip-compile --generate-hashes"
  echo "  ✅ Install with hashes: pip install -r requirements.txt --require-hashes"
  echo "  ✅ Always commit requirements.txt (and requirements.in)"
  echo "  ✅ Never add requirements.txt to .gitignore"
fi
echo ""
