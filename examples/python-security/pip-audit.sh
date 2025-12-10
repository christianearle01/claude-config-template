#!/bin/bash
# Python Security Audit with pip-audit
#
# This script runs pip-audit and optionally applies automatic fixes.
# Use this as part of your weekly security maintenance routine.
#
# Usage:
#   ./pip-audit.sh                    # Audit current environment
#   ./pip-audit.sh -r requirements.txt # Audit requirements file
#   ./pip-audit.sh --fix              # Auto-fix vulnerabilities
#   ./pip-audit.sh --poetry           # Audit Poetry project
#
# Last Updated: 2025-12-09

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "🔍 Running Python security audit..."
echo ""

# Check if pip-audit is installed
if ! command -v pip-audit &> /dev/null; then
  echo -e "${YELLOW}⚠️  pip-audit not found${NC}"
  echo ""
  echo "Installing pip-audit..."
  pip install pip-audit
  echo ""
fi

# Parse arguments
POETRY_MODE=false
FIX_MODE=false
REQUIREMENTS_FILE=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --poetry)
      POETRY_MODE=true
      shift
      ;;
    --fix)
      FIX_MODE=true
      shift
      ;;
    -r)
      REQUIREMENTS_FILE="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: ./pip-audit.sh [-r requirements.txt] [--fix] [--poetry]"
      exit 1
      ;;
  esac
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Security Audit Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Poetry mode
if [ "$POETRY_MODE" == true ]; then
  if ! command -v poetry &> /dev/null; then
    echo -e "${RED}❌ Poetry not found${NC}"
    exit 1
  fi

  echo "Using Poetry project..."
  echo ""

  # Export requirements and audit
  poetry export -f requirements.txt | pip-audit -r /dev/stdin

  AUDIT_EXIT_CODE=$?
else
  # pip mode
  if [ -n "$REQUIREMENTS_FILE" ]; then
    if [ ! -f "$REQUIREMENTS_FILE" ]; then
      echo -e "${RED}❌ File not found: $REQUIREMENTS_FILE${NC}"
      exit 1
    fi

    echo "Auditing requirements file: $REQUIREMENTS_FILE"
    echo ""

    if [ "$FIX_MODE" == true ]; then
      pip-audit -r "$REQUIREMENTS_FILE" --fix
    else
      pip-audit -r "$REQUIREMENTS_FILE"
    fi

    AUDIT_EXIT_CODE=$?
  else
    echo "Auditing current environment..."
    echo ""

    if [ "$FIX_MODE" == true ]; then
      pip-audit --fix
    else
      pip-audit
    fi

    AUDIT_EXIT_CODE=$?
  fi
fi

echo ""

# Check result
if [ $AUDIT_EXIT_CODE -eq 0 ]; then
  echo -e "${GREEN}✅ No vulnerabilities found!${NC}"
  exit 0
fi

# Vulnerabilities found
echo -e "${YELLOW}⚠️  Vulnerabilities detected${NC}"
echo ""

if [ "$FIX_MODE" != true ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "💡 Remediation Options"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  echo "1. Auto-fix (recommended):"
  echo "   ${BLUE}./pip-audit.sh --fix${NC}"
  echo ""

  echo "2. Manual fix:"
  echo "   ${BLUE}pip install package-name==fixed-version${NC}"
  echo ""

  echo "3. For Poetry projects:"
  echo "   ${BLUE}poetry update package-name${NC}"
  echo ""

  echo "4. Generate JSON report:"
  echo "   ${BLUE}pip-audit --format=json > audit-report.json${NC}"
  echo ""
fi

exit $AUDIT_EXIT_CODE
