#!/bin/bash
set -e

# Remove Commands Script
# Purpose: Remove /onboarding and /standards commands for advanced users
# Version: 3.4.0
#
# This script helps users graduate from beginner scaffolding to advanced fluency.
# See: docs/00-start-here/LEARNING_STAGES.md

echo "🎓 Claude Code Learning Stages - Command Graduation"
echo ""
echo "This script removes commands you've outgrown:"
echo "  - /onboarding (one-time use)"
echo "  - /standards (internalized by advanced users)"
echo ""
echo "Keeping essential commands:"
echo "  ✅ /build (always useful)"
echo "  ✅ /test (always useful)"
echo "  ✅ /review (educational value)"
echo ""

# Confirmation
read -p "Proceed with removal? (y/n): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Check if commands directory exists
COMMANDS_DIR=".claude/commands"
if [[ ! -d "$COMMANDS_DIR" ]]; then
    echo "❌ Error: .claude/commands/ directory not found"
    echo "Are you in a project root with Claude Code setup?"
    exit 1
fi

# Remove /onboarding
if [[ -f "$COMMANDS_DIR/onboarding.md" ]]; then
    rm "$COMMANDS_DIR/onboarding.md"
    echo "✅ Removed /onboarding command"
else
    echo "⚠️  /onboarding not found (already removed?)"
fi

# Remove /standards
if [[ -f "$COMMANDS_DIR/standards.md" ]]; then
    rm "$COMMANDS_DIR/standards.md"
    echo "✅ Removed /standards command"
else
    echo "⚠️  /standards not found (already removed?)"
fi

echo ""
echo "🎉 Graduation complete!"
echo ""
echo "You now have 3 essential commands:"
echo "  /build  - Build & report errors"
echo "  /test   - Run test suite"
echo "  /review - Code review"
echo ""
echo "For everything else, use natural language + Skills! 🚀"
echo ""
echo "Learn more: docs/00-start-here/LEARNING_STAGES.md"
