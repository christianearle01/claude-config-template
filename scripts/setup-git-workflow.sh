#!/bin/bash

# Git Workflow Configuration Wizard
# Interactive setup for git commit approval

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Claude Code - Git Workflow Configuration Wizard          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "This wizard will configure how Claude Code handles git operations."
echo ""

# Check if global settings exist
GLOBAL_SETTINGS="$HOME/.claude/settings.json"
BACKUP_FILE="$HOME/.claude/settings.json.backup"

if [ ! -f "$GLOBAL_SETTINGS" ]; then
    echo "📝 Creating new global settings file..."
    mkdir -p "$HOME/.claude"
    echo '{}' > "$GLOBAL_SETTINGS"
fi

# Backup existing settings
echo "💾 Backing up existing settings..."
cp "$GLOBAL_SETTINGS" "$BACKUP_FILE"
echo "   Backup saved to: $BACKUP_FILE"
echo ""

# Present options
echo "Choose your git workflow preference:"
echo ""
echo "1️⃣  Full Protection (Recommended)"
echo "   • Approval required for: commit, push, merge, rebase, reset"
echo "   • Permission mode: plan"
echo "   • Best for: Teams, learning, safety-critical work"
echo ""
echo "2️⃣  Commit-Only Protection"
echo "   • Approval required for: commit only"
echo "   • Permission mode: acceptEdits (fast for other operations)"
echo "   • Best for: Solo developers who want speed with commit safety"
echo ""
echo "3️⃣  Minimal Protection"
echo "   • Approval required for: commit and destructive operations only"
echo "   • Permission mode: acceptEdits"
echo "   • Best for: Experienced users who want maximum speed"
echo ""
echo "0️⃣  Cancel (no changes)"
echo ""
read -p "Enter your choice (0-3): " choice

case $choice in
    1)
        echo ""
        echo "✅ Installing Full Protection configuration..."

        # Create settings with full protection
        cat > "$GLOBAL_SETTINGS" << 'EOF'
{
  "model": "sonnet",
  "alwaysThinkingEnabled": true,
  "outputStyle": "concise",
  "sandbox": {
    "enabled": true,
    "excludedCommands": ["git", "docker", "npm", "python", "pytest", "pip"]
  },
  "permissions": {
    "defaultMode": "plan",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git push*)",
      "Bash(git merge*)",
      "Bash(git rebase*)",
      "Bash(git reset --hard*)",
      "Bash(git checkout -b*)"
    ]
  }
}
EOF

        echo "✅ Full Protection configured!"
        echo ""
        echo "Claude will now:"
        echo "  • Show commit messages for approval before committing"
        echo "  • Require approval for push, merge, rebase operations"
        echo "  • Display git push commands instead of executing"
        echo "  • Show plans before executing any changes"
        ;;

    2)
        echo ""
        echo "✅ Installing Commit-Only Protection configuration..."

        cat > "$GLOBAL_SETTINGS" << 'EOF'
{
  "model": "sonnet",
  "alwaysThinkingEnabled": true,
  "outputStyle": "concise",
  "sandbox": {
    "enabled": true,
    "excludedCommands": ["git", "docker", "npm", "python", "pytest", "pip"]
  },
  "permissions": {
    "defaultMode": "acceptEdits",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git push*)"
    ]
  }
}
EOF

        echo "✅ Commit-Only Protection configured!"
        echo ""
        echo "Claude will now:"
        echo "  • Show commit messages for approval before committing"
        echo "  • Display git push commands instead of executing"
        echo "  • Auto-apply other file changes (acceptEdits mode)"
        echo "  • Fast workflow with commit safety"
        ;;

    3)
        echo ""
        echo "✅ Installing Minimal Protection configuration..."

        cat > "$GLOBAL_SETTINGS" << 'EOF'
{
  "model": "sonnet",
  "alwaysThinkingEnabled": true,
  "outputStyle": "concise",
  "sandbox": {
    "enabled": true,
    "excludedCommands": ["git", "docker", "npm", "python", "pytest", "pip"]
  },
  "permissions": {
    "defaultMode": "acceptEdits",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git reset --hard*)",
      "Bash(rm -rf*)"
    ]
  }
}
EOF

        echo "✅ Minimal Protection configured!"
        echo ""
        echo "Claude will now:"
        echo "  • Show commit messages for approval before committing"
        echo "  • Protect against destructive operations (reset, rm -rf)"
        echo "  • Note: git push will display command (authentication limitation)"
        echo "  • Maximum speed with essential safety"
        ;;

    0)
        echo ""
        echo "❌ Configuration cancelled."
        echo "   Restoring backup..."
        cp "$BACKUP_FILE" "$GLOBAL_SETTINGS"
        echo "   No changes made."
        exit 0
        ;;

    *)
        echo ""
        echo "❌ Invalid choice. Restoring backup..."
        cp "$BACKUP_FILE" "$GLOBAL_SETTINGS"
        exit 1
        ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Configuration complete!"
echo ""
echo "📍 Settings saved to: $GLOBAL_SETTINGS"
echo "💾 Backup available at: $BACKUP_FILE"
echo ""
echo "🔄 To change this later:"
echo "   Run: ./scripts/setup-git-workflow.sh"
echo ""
echo "📚 For more information:"
echo "   • Git Approval Guide: 01_global-setup/good-to-have/04_git-approval-workflow.md"
echo "   • Git Push Guide: 01_global-setup/good-to-have/05_git-push-workaround.md"
echo ""
echo "🚀 You're ready to go! Start Claude Code and test with a commit."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
