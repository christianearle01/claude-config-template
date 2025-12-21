#!/bin/bash

################################################################################
# Quick Setup User Wizard
# Version: 2.1
# Time: 15-30 minutes
# Purpose: Fast project setup for experienced Claude Code users
################################################################################

set -e

TEMPLATE_ROOT=$1

# Source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/wizard-helpers.sh"

# Start timer
start_timer

################################################################################
# Introduction
################################################################################

clear
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                            ║${NC}"
echo -e "${BLUE}║         ⚡ Quick Setup User (15-30 minutes)               ║${NC}"
echo -e "${BLUE}║                                                            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}What we'll do (3 phases):${NC}"
echo ""
echo "  ${MAGENTA}Phase 1: Setup${NC}"
echo "    • Get your project path"
echo "    • Copy .claude/ configuration files"
echo ""
echo "  ${MAGENTA}Phase 2: Configuration${NC}"
echo "    • Create CLAUDE.md from template"
echo "    • Document business purpose (the key step!)"
echo ""
echo "  ${MAGENTA}Phase 3: Validation${NC}"
echo "    • Test setup"
echo ""

show_tip "This assumes you already have Claude Code installed globally."

pause

################################################################################
# Phase 1: Setup - Task 1 (Get Project Path)
################################################################################

clear
show_phase_progress 1 3 "Setup"
show_task_progress 1 2 "Get Project Path"
echo ""

echo -e "${CYAN}Step 1: Specify Your Project${NC}"
echo ""
echo "Where is the project you want to set up Claude Code for?"
echo ""
echo -n -e "${GREEN}Project path (or press Enter for current directory): ${NC}"
read -r PROJECT_PATH

# Default to current directory if empty
if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH="."
fi

# Convert to absolute path
PROJECT_PATH=$(cd "$PROJECT_PATH" && pwd)

echo ""
echo -e "${GREEN}✅ Project path: $PROJECT_PATH${NC}"

# Detect project type
PROJECT_TYPE=$(detect_project_type "$PROJECT_PATH")
echo -e "${CYAN}Detected project type: ${PROJECT_TYPE}${NC}"

pause

################################################################################
# Phase 1: Setup - Task 2 (Copy Configuration Files)
################################################################################

clear
show_phase_progress 1 3 "Setup"
show_task_progress 2 2 "Copy Configuration Files"
echo ""

echo -e "${CYAN}Step 2: Copying Configuration Files${NC}"
echo ""

# Create .claude directory structure
create_claude_structure "$PROJECT_PATH"

# Copy .claude contents
echo "Copying .claude/ configuration..."
if [ -d "$TEMPLATE_ROOT/.claude" ]; then
    cp -r "$TEMPLATE_ROOT/.claude/"* "$PROJECT_PATH/.claude/" 2>/dev/null || true
    echo -e "${GREEN}✅ Copied .claude/ configuration${NC}"
else
    echo -e "${YELLOW}⚠️  Warning: .claude/ directory not found in template${NC}"
fi

echo ""
checkpoint 1 "Configuration files copied"

pause

################################################################################
# Phase 2: Configuration - Task 1 (Create CLAUDE.md)
################################################################################

clear
show_phase_progress 2 3 "Configuration"
show_task_progress 1 2 "Create CLAUDE.md"
echo ""

echo -e "${CYAN}Step 3: Creating CLAUDE.md${NC}"
echo ""

if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
    if ask_yes_no "CLAUDE.md already exists. Overwrite?"; then
        cp "$TEMPLATE_ROOT/templates/CLAUDE.md.template" "$PROJECT_PATH/CLAUDE.md"
        echo -e "${GREEN}✅ Overwritten CLAUDE.md${NC}"
    else
        echo -e "${YELLOW}⚠️  Keeping existing CLAUDE.md${NC}"
    fi
else
    cp "$TEMPLATE_ROOT/templates/CLAUDE.md.template" "$PROJECT_PATH/CLAUDE.md"
    echo -e "${GREEN}✅ Created CLAUDE.md from template${NC}"
fi

echo ""
checkpoint 2 "CLAUDE.md created"

# v4.22.0: Add understanding checkpoint
understanding_checkpoint "CLAUDE.md Creation" "What's the #1 thing you put in CLAUDE.md for this project?"

pause

################################################################################
# Phase 2: Configuration - Task 2 (Document Business Purpose - CRITICAL STEP)
################################################################################

clear
show_phase_progress 2 3 "Configuration"
show_task_progress 2 2 "Document Business Purpose"
echo ""

echo -e "${CYAN}Step 4: Document Your Project's Business Purpose${NC}"
echo ""
echo -e "${YELLOW}⚠️  THIS IS THE MOST IMPORTANT STEP ⚠️${NC}"
echo ""
echo "CLAUDE.md tells Claude Code WHAT your app does (not HOW)."
echo "This saves 50-95% on tokens by giving Claude context upfront."
echo ""
echo -e "${MAGENTA}Example of good documentation:${NC}"
echo "  ✅ 'This app helps remote teams coordinate work with real-time collaboration'"
echo "  ✅ 'Core features: Document editing, notifications, time tracking'"
echo "  ✅ 'Uses Twilio to send urgent task SMS notifications'"
echo ""
echo -e "${RED}Example of bad documentation:${NC}"
echo "  ❌ 'This is a Node.js app with Express and MongoDB'"
echo "  ❌ 'We have a user authentication system'"
echo "  ❌ 'See package.json for dependencies'"
echo ""

pause "Press Enter to edit CLAUDE.md..."

# Detect default editor
if [ -n "$EDITOR" ]; then
    $EDITOR "$PROJECT_PATH/CLAUDE.md"
elif command -v code &> /dev/null; then
    code "$PROJECT_PATH/CLAUDE.md"
    echo ""
    echo -e "${CYAN}Opened CLAUDE.md in VS Code.${NC}"
    echo "Edit the file and save it, then return here."
    pause "Press Enter when you've saved CLAUDE.md..."
elif command -v nano &> /dev/null; then
    nano "$PROJECT_PATH/CLAUDE.md"
else
    echo -e "${YELLOW}No editor found. Please edit manually:${NC}"
    echo "  File: $PROJECT_PATH/CLAUDE.md"
    pause "Press Enter after editing..."
fi

echo ""
echo -e "${CYAN}Let's validate your CLAUDE.md...${NC}"
validate_claude_md "$PROJECT_PATH/CLAUDE.md"

echo ""
checkpoint 3 "Business purpose documented"

################################################################################
# Knowledge Check: CLAUDE.md Understanding
################################################################################

quiz \
    "What should you document in CLAUDE.md?" \
    "B" \
    "Full dependency list from package.json" \
    "Business purpose and why each API is used" \
    "Implementation details of every function"

pause

################################################################################
# Phase 3: Validation - Task 1 (Test Setup)
################################################################################

clear
show_phase_progress 3 3 "Validation"
show_task_progress 1 1 "Test Setup"
echo ""

echo -e "${CYAN}Step 5: Testing Your Setup${NC}"
echo ""

# Check if Claude Code is installed
if check_command claude "npm install -g @anthropic-ai/claude-code"; then
    echo ""
    echo -e "${GREEN}Claude Code is installed!${NC}"
    echo ""
    echo -e "${CYAN}Final Test:${NC}"
    echo "We'll start Claude Code and you can ask:"
    echo -e "  ${MAGENTA}\"What does this project do?\"${NC}"
    echo ""
    echo "If Claude explains your project without exploring files,"
    echo "your CLAUDE.md is working perfectly! 🎉"
    echo ""

    if ask_yes_no "Start Claude Code now for testing?"; then
        echo ""
        echo -e "${YELLOW}Starting Claude Code...${NC}"
        echo ""
        cd "$PROJECT_PATH"
        claude
    else
        echo ""
        echo -e "${CYAN}You can test later by running:${NC}"
        echo "  cd $PROJECT_PATH"
        echo "  claude"
        echo ""
    fi
else
    echo ""
    echo -e "${YELLOW}⚠️  Claude Code not found. Install it first:${NC}"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
fi

################################################################################
# Update .gitignore
################################################################################

echo ""
echo -e "${CYAN}Updating .gitignore...${NC}"

if [ -f "$PROJECT_PATH/.gitignore" ]; then
    # Check if Claude Code patterns already exist
    if ! grep -q ".claude/memory.json" "$PROJECT_PATH/.gitignore" 2>/dev/null; then
        echo "" >> "$PROJECT_PATH/.gitignore"
        echo "# Claude Code sensitive files (DO NOT COMMIT)" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/memory.json" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/plans/*" >> "$PROJECT_PATH/.gitignore"
        echo "!.claude/plans/.gitkeep" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/config.json" >> "$PROJECT_PATH/.gitignore"
        echo -e "${GREEN}✅ Updated .gitignore with Claude Code patterns${NC}"
    else
        echo -e "${CYAN}ℹ️  .gitignore already includes Claude Code patterns${NC}"
    fi
else
    cp "$TEMPLATE_ROOT/.gitignore" "$PROJECT_PATH/.gitignore"
    echo -e "${GREEN}✅ Created .gitignore from template${NC}"
fi

checkpoint 4 "Setup tested successfully"

# v4.22.0: Add final understanding checkpoint
understanding_checkpoint "Project Improvement" "What will you do differently in this project compared to your last one?"

################################################################################
# Final Summary
################################################################################

clear
check_timer "Total setup time"
echo ""

success_banner "Quick Setup"

echo -e "${CYAN}What You Just Accomplished:${NC}"
echo "  ✅ Copied .claude/ configuration to your project"
echo "  ✅ Created CLAUDE.md with business context"
echo "  ✅ Protected sensitive files in .gitignore"
echo "  ✅ Ready to use Claude Code efficiently"
echo ""

echo -e "${YELLOW}Token Savings Unlocked:${NC}"
echo "  • 50-95% reduction in context tokens (thanks to CLAUDE.md!)"
echo "  • Claude knows your project without exploring files"
echo "  • Consistent context across all sessions"
echo ""

echo -e "${MAGENTA}Next Steps:${NC}"
echo "  1. Start Claude Code: ${GREEN}cd $PROJECT_PATH && claude${NC}"
echo "  2. Test it: Ask ${CYAN}\"What does this project do?\"${NC}"
echo "  3. Save more: Use ${GREEN}/model haiku${NC} for implementation (92% cheaper!)"
echo ""

show_tip "Update CLAUDE.md as your project evolves. Keep it current!"

echo ""
echo -e "${CYAN}Want to learn more?${NC}"
echo "  • Model switching strategy: ${BLUE}$TEMPLATE_ROOT/01_global-setup/good-to-have/01_model-switching.md${NC}"
echo "  • Prompt optimization: ${BLUE}$TEMPLATE_ROOT/02_project-onboarding/good-to-have/01_prompt-optimization.md${NC}"
echo "  • Visual guides: ${MAGENTA}$TEMPLATE_ROOT/VISUAL_GUIDES.md${NC}"
echo ""

celebrate "You're saving tokens already"

exit 0
