#!/bin/bash

################################################################################
# First-Time Learner Wizard
# Version: 2.1
# Time: 60-90 minutes
# Purpose: Complete onboarding for Claude Code beginners
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
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}║         🆕 First-Time Learner (60-90 minutes)             ║${NC}"
echo -e "${GREEN}║                                                            ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Welcome to Claude Code!${NC}"
echo ""
echo "This wizard will teach you everything you need to know (3 phases):"
echo ""
echo "  ${MAGENTA}Phase 1: Learning${NC}"
echo "    • Install Claude Code globally (20 min)"
echo "    • Learn core concepts (15 min)"
echo ""
echo "  ${MAGENTA}Phase 2: Optimization${NC}"
echo "    • Understand model switching (10 min) - Save 92%!"
echo ""
echo "  ${MAGENTA}Phase 3: Application${NC}"
echo "    • Set up your first project (30 min)"
echo ""

show_tip "Take your time. We'll validate your understanding at each step."

pause

################################################################################
# Phase 1: Learning - Task 1 (Installation - 20 minutes)
################################################################################

clear
show_phase_progress 1 3 "Learning"
show_task_progress 1 2 "Installation"
echo ""

echo -e "${CYAN}Part 1: Installing Claude Code (20 minutes)${NC}"
echo ""

# Check if Claude Code is already installed
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "unknown")
    echo -e "${GREEN}✅ Claude Code is already installed!${NC}"
    echo -e "${CYAN}Version: $CLAUDE_VERSION${NC}"
    echo ""

    if ask_yes_no "Skip installation and proceed to concepts?"; then
        echo ""
        echo -e "${CYAN}Great! Moving to Part 2...${NC}"
        sleep 1
    else
        echo ""
        echo -e "${CYAN}You can reinstall to get the latest version.${NC}"
    fi
else
    echo -e "${YELLOW}Claude Code is not installed yet.${NC}"
    echo ""
    echo -e "${CYAN}Installation command:${NC}"
    echo "  ${GREEN}npm install -g @anthropic-ai/claude-code${NC}"
    echo ""
    echo -e "${YELLOW}Note: You may need sudo/admin permissions.${NC}"
    echo ""

    if ask_yes_no "Install Claude Code now?"; then
        echo ""
        echo "Installing Claude Code..."
        npm install -g @anthropic-ai/claude-code || {
            echo ""
            echo -e "${YELLOW}Installation failed. You may need sudo:${NC}"
            echo "  ${GREEN}sudo npm install -g @anthropic-ai/claude-code${NC}"
            echo ""
            pause "Press Enter after installing manually..."
        }
    else
        echo ""
        echo -e "${YELLOW}Please install Claude Code before continuing:${NC}"
        echo "  npm install -g @anthropic-ai/claude-code"
        echo ""
        exit 1
    fi
fi

checkpoint 1 "Claude Code installed"

################################################################################
# Knowledge Check: Installation
################################################################################

quiz \
    "Where is Claude Code installed?" \
    "A" \
    "Globally (works in any directory)" \
    "Per project (need to install in each project)" \
    "Only in the template directory"

pause

################################################################################
# Part 2: Core Concepts (15 minutes)
################################################################################

clear
show_phase_progress 1 3 "Learning"
show_task_progress 2 2 "Core Concepts"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 2: Core Concepts (15 minutes)${NC}"
echo ""

echo -e "${MAGENTA}Concept 1: CLAUDE.md${NC}"
echo "─────────────────────────────────────"
echo "CLAUDE.md is your project's memory card. It tells Claude:"
echo "  • WHAT your app does (business purpose)"
echo "  • WHY you use each external API"
echo "  • Key features from user perspective"
echo ""
echo -e "${GREEN}Why it matters:${NC} Saves 50-95% on tokens!"
echo "Claude reads CLAUDE.md once instead of exploring files repeatedly."
echo ""
pause "Press Enter to continue..."

clear
echo -e "${MAGENTA}Concept 2: Model Switching${NC}"
echo "─────────────────────────────────────"
echo ""
echo "Claude Code has 3 models:"
echo ""
echo -e "${CYAN}1. Opus${NC} - Most capable, $15/M tokens"
echo "   Use for: Complex architectural decisions"
echo ""
echo -e "${BLUE}2. Sonnet${NC} - Balanced, $3/M tokens (default)"
echo "   Use for: Planning, designing, reviewing"
echo ""
echo -e "${GREEN}3. Haiku${NC} - Fast & cheap, $0.25/M tokens"
echo "   Use for: Implementation, simple tasks"
echo ""
echo -e "${YELLOW}💰 The Secret:${NC} Plan with Sonnet, implement with Haiku"
echo "   This saves 92% on implementation costs!"
echo ""
pause "Press Enter to continue..."

clear
echo -e "${MAGENTA}Concept 3: Token Optimization${NC}"
echo "─────────────────────────────────────"
echo ""
echo "Every message costs tokens. Optimize by:"
echo ""
echo -e "${GREEN}✅ Good practices:${NC}"
echo "  • 'Follow pattern in app/auth.py:127'"
echo "  • 'Skip: tests/, node_modules/, dist/'"
echo "  • 'Reference the design we discussed earlier'"
echo ""
echo -e "${RED}❌ Bad practices:${NC}"
echo "  • 'Fix the bug' (too vague, Claude explores everything)"
echo "  • 'Review all code' (wastes tokens on irrelevant files)"
echo "  • Repeating full context every message"
echo ""
pause "Press Enter to continue..."

checkpoint 2 "Core concepts learned"

################################################################################
# Knowledge Check: Core Concepts
################################################################################

quiz \
    "What's the PRIMARY purpose of CLAUDE.md?" \
    "C" \
    "List all dependencies and technical details" \
    "Document every function in the codebase" \
    "Explain business purpose so Claude has context"

quiz \
    "Which model should you use for implementation?" \
    "B" \
    "Always use Opus (most capable)" \
    "Use Haiku (92% cheaper, good for implementation)" \
    "Always use Sonnet (safest choice)"

pause

################################################################################
# Part 3: Model Switching Practice (10 minutes)
################################################################################

clear
show_phase_progress 2 3 "Optimization"
show_task_progress 1 1 "Model Switching"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 3: Model Switching Practice (10 minutes)${NC}"
echo ""

echo "Let's practice switching models!"
echo ""
echo -e "${YELLOW}Commands to know:${NC}"
echo "  ${GREEN}/model${NC} - Show current model"
echo "  ${GREEN}/model haiku${NC} - Switch to Haiku (cheap!)"
echo "  ${GREEN}/model sonnet${NC} - Switch to Sonnet (balanced)"
echo "  ${GREEN}/model opus${NC} - Switch to Opus (powerful)"
echo "  ${GREEN}/usage${NC} - Check your plan limits"
echo ""

show_tip "Switching models takes effect immediately for next message."

echo ""
echo -e "${MAGENTA}Example workflow:${NC}"
echo ""
echo "  User: 'Plan how to add OAuth authentication'"
echo "  Claude (Sonnet): [Creates detailed plan]"
echo ""
echo "  User: '/model haiku'"
echo "  User: 'Implement the plan you just created'"
echo "  Claude (Haiku): [Implements at 92% lower cost!]"
echo ""

pause

checkpoint 3 "Model switching understood"

################################################################################
# Knowledge Check: Model Switching
################################################################################

quiz \
    "What's the recommended workflow?" \
    "B" \
    "Use Opus for everything (always best quality)" \
    "Plan with Sonnet, implement with Haiku (92% savings)" \
    "Use Haiku for everything (maximize savings)"

pause

################################################################################
# Part 4: First Project Setup (30 minutes)
################################################################################

clear
show_phase_progress 3 3 "Application"
show_task_progress 1 1 "First Project Setup"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 4: Setting Up Your First Project (30 minutes)${NC}"
echo ""

echo "Now let's apply what you learned!"
echo ""

pause "Press Enter to start project setup..."

################################################################################
# Get Project Path
################################################################################

clear
echo -e "${CYAN}Step 1: Specify Your Project${NC}"
echo ""
echo "Where is your project located?"
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
# Copy Configuration Files
################################################################################

clear
echo -e "${CYAN}Step 2: Copying Configuration Files${NC}"
echo ""

# Create .claude directory structure
create_claude_structure "$PROJECT_PATH"

# Copy .claude contents
if [ -d "$TEMPLATE_ROOT/.claude" ]; then
    cp -r "$TEMPLATE_ROOT/.claude/"* "$PROJECT_PATH/.claude/" 2>/dev/null || true
    echo -e "${GREEN}✅ Copied .claude/ configuration${NC}"
fi

echo ""
show_tip "The .claude/ folder contains agents, commands, and hooks."

pause

################################################################################
# Create CLAUDE.md
################################################################################

clear
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

pause

################################################################################
# Edit CLAUDE.md (Critical Step)
################################################################################

clear
echo -e "${CYAN}Step 4: Document Your Project (MOST IMPORTANT!)${NC}"
echo ""
echo -e "${YELLOW}⚠️  This step determines how well Claude understands your project ⚠️${NC}"
echo ""
echo "Edit CLAUDE.md to document:"
echo ""
echo -e "${GREEN}1. Business Purpose${NC} (WHAT the app does)"
echo "   Example: 'Helps remote teams coordinate work'"
echo ""
echo -e "${GREEN}2. Key Features${NC} (from user perspective)"
echo "   Example: 'Real-time document editing, smart notifications'"
echo ""
echo -e "${GREEN}3. External APIs${NC} (WHY each is used)"
echo "   Example: 'Twilio - Send urgent task SMS notifications'"
echo ""
echo -e "${RED}DON'T document:${NC}"
echo "  ❌ Full dependency list (Claude reads package.json)"
echo "  ❌ Implementation details (Claude reads code)"
echo "  ❌ Technical stack (Claude can detect it)"
echo ""

pause "Press Enter to edit CLAUDE.md..."

# Detect editor and open CLAUDE.md
if [ -n "$EDITOR" ]; then
    $EDITOR "$PROJECT_PATH/CLAUDE.md"
elif command -v code &> /dev/null; then
    code "$PROJECT_PATH/CLAUDE.md"
    echo ""
    echo -e "${CYAN}Opened CLAUDE.md in VS Code.${NC}"
    pause "Press Enter when you've saved CLAUDE.md..."
elif command -v nano &> /dev/null; then
    nano "$PROJECT_PATH/CLAUDE.md"
else
    echo -e "${YELLOW}No editor found. Please edit manually:${NC}"
    echo "  File: $PROJECT_PATH/CLAUDE.md"
    pause "Press Enter after editing..."
fi

# Validate CLAUDE.md
echo ""
echo -e "${CYAN}Validating your CLAUDE.md...${NC}"
validate_claude_md "$PROJECT_PATH/CLAUDE.md"

pause

################################################################################
# Update .gitignore
################################################################################

clear
echo -e "${CYAN}Step 5: Protecting Sensitive Files${NC}"
echo ""

if [ -f "$PROJECT_PATH/.gitignore" ]; then
    if ! grep -q ".claude/memory.json" "$PROJECT_PATH/.gitignore" 2>/dev/null; then
        echo "" >> "$PROJECT_PATH/.gitignore"
        echo "# Claude Code sensitive files (DO NOT COMMIT)" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/memory.json" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/plans/*" >> "$PROJECT_PATH/.gitignore"
        echo "!.claude/plans/.gitkeep" >> "$PROJECT_PATH/.gitignore"
        echo ".claude/config.json" >> "$PROJECT_PATH/.gitignore"
        echo -e "${GREEN}✅ Updated .gitignore${NC}"
    fi
else
    cp "$TEMPLATE_ROOT/.gitignore" "$PROJECT_PATH/.gitignore"
    echo -e "${GREEN}✅ Created .gitignore${NC}"
fi

echo ""
show_tip "Never commit .claude/memory.json or .env files!"

pause

################################################################################
# Final Test
################################################################################

clear
echo -e "${CYAN}Step 6: Testing Your Setup${NC}"
echo ""

echo "Let's test if everything works!"
echo ""
echo -e "${YELLOW}Test checklist:${NC}"
echo "  1. Start Claude Code in your project"
echo "  2. Ask: 'What does this project do?'"
echo "  3. Claude should explain without exploring files"
echo ""

if ask_yes_no "Start Claude Code now?"; then
    echo ""
    echo -e "${GREEN}Starting Claude Code...${NC}"
    echo ""
    cd "$PROJECT_PATH"
    claude
else
    echo ""
    echo -e "${CYAN}Test later with:${NC}"
    echo "  cd $PROJECT_PATH"
    echo "  claude"
    echo ""
fi

checkpoint 4 "First project setup complete"

################################################################################
# Final Summary & Celebration
################################################################################

clear
check_timer "Total learning time"
echo ""

success_banner "First-Time Learner"

celebrate "You've completed Claude Code onboarding"

echo -e "${CYAN}What You've Learned:${NC}"
echo "  ✅ Installed Claude Code globally"
echo "  ✅ Understand CLAUDE.md purpose (token savings!)"
echo "  ✅ Know model switching (Sonnet → Haiku = 92% savings)"
echo "  ✅ Set up your first project successfully"
echo ""

echo -e "${MAGENTA}Your Next Steps:${NC}"
echo ""
echo -e "${GREEN}1. Practice model switching:${NC}"
echo "   • Start with ${BLUE}/model sonnet${NC} for planning"
echo "   • Switch to ${GREEN}/model haiku${NC} for implementation"
echo "   • Check costs with ${YELLOW}/usage${NC}"
echo ""
echo -e "${GREEN}2. Keep CLAUDE.md updated:${NC}"
echo "   • Add new features as you build"
echo "   • Document new API integrations"
echo "   • Update business purpose if it changes"
echo ""
echo -e "${GREEN}3. Learn more:${NC}"
echo "   • Prompt optimization: ${BLUE}$TEMPLATE_ROOT/02_project-onboarding/good-to-have/01_prompt-optimization.md${NC}"
echo "   • Visual guides: ${MAGENTA}$TEMPLATE_ROOT/VISUAL_GUIDES.md${NC}"
echo "   • Advanced features: ${CYAN}$TEMPLATE_ROOT/01_global-setup/nice-to-have/01_security-guide.md${NC}"
echo ""

show_tip "You can run this wizard again for new projects!"

echo ""
echo -e "${YELLOW}Quick Reference Card:${NC}"
echo "  ${GREEN}/model haiku${NC}   - Switch to cheap model (92% savings)"
echo "  ${GREEN}/model sonnet${NC}  - Switch to balanced model"
echo "  ${GREEN}/usage${NC}         - Check your plan limits"
echo "  ${GREEN}/clear${NC}         - Start fresh context"
echo "  ${GREEN}/doctor${NC}        - Diagnose issues"
echo ""

celebrate "Happy coding with Claude Code"

exit 0
