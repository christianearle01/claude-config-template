#!/bin/bash
# Python Pre-Commit Security Hook
#
# This script runs security checks before allowing a git commit.
# Install as a git hook to ensure lockfile and dependencies are secure.
#
# Installation:
#   cp pre-commit-py-check.sh .git/hooks/pre-commit
#   chmod +x .git/hooks/pre-commit
#
# Optional: Use pre-commit framework:
#   pip install pre-commit
#   # Add to .pre-commit-config.yaml
#   pre-commit install
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "🔍 Running pre-commit security checks (Python)..."
echo ""

# Detect project type
POETRY_PROJECT=false
PIP_PROJECT=false

if [ -f "pyproject.toml" ] && grep -q "\[tool.poetry\]" pyproject.toml 2>/dev/null; then
  POETRY_PROJECT=true
elif [ -f "requirements.txt" ] || [ -f "requirements.in" ]; then
  PIP_PROJECT=true
else
  echo -e "${BLUE}ℹ️  No Python dependency files found - skipping${NC}"
  exit 0
fi

# Check if relevant files changed
PYTHON_FILES_CHANGED=$(git diff --cached --name-only | grep -E "(requirements\.txt|requirements\.in|pyproject\.toml|poetry\.lock)" || true)

if [ -z "$PYTHON_FILES_CHANGED" ]; then
  echo -e "${GREEN}✅ No Python dependency files changed - skipping${NC}"
  exit 0
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Python Files Changed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "$PYTHON_FILES_CHANGED"
echo ""

# ===== POETRY PROJECT =====
if [ "$POETRY_PROJECT" == true ]; then

  echo "Detected Poetry project"
  echo ""

  # Check 1: Verify poetry.lock is included if pyproject.toml changed
  if echo "$PYTHON_FILES_CHANGED" | grep -q "pyproject.toml"; then
    if ! echo "$PYTHON_FILES_CHANGED" | grep -q "poetry.lock"; then
      echo -e "${RED}❌ pyproject.toml changed but poetry.lock not updated${NC}"
      echo ""
      echo "Lockfile must be updated when pyproject.toml changes!"
      echo ""
      echo "Run: poetry lock"
      echo "Then: git add poetry.lock"
      exit 1
    fi
    echo -e "${GREEN}✅ Both pyproject.toml and poetry.lock updated${NC}"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "⚖️  Lockfile Integrity Check"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 2: Verify lockfile is in sync
  if command -v poetry &> /dev/null; then
    if poetry lock --check &> /dev/null; then
      echo -e "${GREEN}✅ poetry.lock is in sync${NC}"
    else
      echo -e "${YELLOW}⚠️  poetry.lock may be out of sync${NC}"
      echo ""
      echo "Run: poetry lock"
      echo ""
    fi
  else
    echo -e "${YELLOW}⚠️  Poetry not found - skipping lockfile check${NC}"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔐 Running Security Audit"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 3: Run pip-audit on exported requirements
  if command -v pip-audit &> /dev/null; then
    if poetry export -f requirements.txt 2>/dev/null | pip-audit -r /dev/stdin 2>&1; then
      echo -e "${GREEN}✅ No vulnerabilities found${NC}"
    else
      echo ""
      echo -e "${RED}❌ Security vulnerabilities detected${NC}"
      echo ""
      echo "Fix vulnerabilities:"
      echo "  poetry update package-name"
      echo ""
      echo "Or override (not recommended):"
      echo "  git commit --no-verify"
      exit 1
    fi
  else
    echo -e "${YELLOW}⚠️  pip-audit not found - skipping security audit${NC}"
    echo "Install: pip install pip-audit"
  fi

# ===== PIP PROJECT =====
elif [ "$PIP_PROJECT" == true ]; then

  echo "Detected pip project"
  echo ""

  # Check 1: Verify requirements.txt exists
  if [ ! -f "requirements.txt" ]; then
    echo -e "${YELLOW}⚠️  requirements.txt not found${NC}"
    echo ""
    echo "Create lockfile:"
    echo "  pip freeze > requirements.txt"
    echo "  git add requirements.txt"
    echo ""
  fi

  # Check 2: Verify requirements.txt is staged if requirements.in changed
  if echo "$PYTHON_FILES_CHANGED" | grep -q "requirements.in"; then
    if ! echo "$PYTHON_FILES_CHANGED" | grep -q "requirements.txt"; then
      echo -e "${YELLOW}⚠️  requirements.in changed but requirements.txt not updated${NC}"
      echo ""
      echo "Regenerate requirements.txt:"
      echo "  pip-compile requirements.in"
      echo "  # Or with hashes: pip-compile --generate-hashes requirements.in"
      echo "  git add requirements.txt"
      echo ""
    fi
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔐 Running Security Audit"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 3: Run pip-audit
  if command -v pip-audit &> /dev/null; then
    if [ -f "requirements.txt" ]; then
      if pip-audit -r requirements.txt 2>&1; then
        echo -e "${GREEN}✅ No vulnerabilities found${NC}"
      else
        echo ""
        echo -e "${RED}❌ Security vulnerabilities detected${NC}"
        echo ""
        echo "Fix vulnerabilities:"
        echo "  pip install --upgrade vulnerable-package"
        echo "  pip freeze > requirements.txt"
        echo ""
        echo "Or run: pip-audit --fix"
        echo ""
        echo "Override (not recommended):"
        echo "  git commit --no-verify"
        exit 1
      fi
    fi
  else
    echo -e "${YELLOW}⚠️  pip-audit not found - skipping security audit${NC}"
    echo "Install: pip install pip-audit"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🔐 Hash Verification"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check 4: Warn if no hashes
  if [ -f "requirements.txt" ]; then
    if ! grep -q "--hash=sha256:" requirements.txt; then
      echo -e "${YELLOW}⚠️  requirements.txt has no integrity hashes${NC}"
      echo ""
      echo "For maximum security, use hashes:"
      echo "  pip install pip-tools"
      echo "  pip-compile --generate-hashes requirements.in"
      echo ""
      # Don't fail on this - it's a warning
    else
      echo -e "${GREEN}✅ requirements.txt includes hashes${NC}"
    fi
  fi

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
