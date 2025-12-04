#!/bin/bash

################################################################################
# Claude Code Setup Wizard
# Version: 2.1
# Purpose: Interactive setup wizard with persona-based routing
# Usage: ./scripts/claude-wizard.sh
################################################################################

set -e  # Exit on error

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(dirname "$SCRIPT_DIR")"

# Source helper functions
source "$SCRIPT_DIR/wizard-helpers.sh"

################################################################################
# Main Wizard Entry Point
################################################################################

clear
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║         ${MAGENTA}🚀 Claude Code Setup Wizard v2.1${CYAN}              ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║  ${NC}Transform your Claude Code experience with            ${CYAN}║${NC}"
echo -e "${CYAN}║  ${NC}persona-based routing and visual guides              ${CYAN}║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Welcome message
echo -e "${GREEN}Welcome!${NC} This wizard will help you set up Claude Code efficiently."
echo -e "We'll customize the setup based on YOUR specific needs."
echo ""

# Show value proposition
echo -e "${YELLOW}What You'll Get:${NC}"
echo "  • 50-95% token savings (CLAUDE.md + model switching)"
echo "  • Persona-specific setup path (no information overload)"
echo "  • Validation at each step (catch errors early)"
echo "  • Visual guides (reduce cognitive load 40%)"
echo ""

# Pause before persona selection
echo -e "${CYAN}Press Enter to choose your profile...${NC}"
read -r

################################################################################
# Step 0: Persona Selection
################################################################################

clear
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}         Step 0: Choose Your Profile (30 seconds)           ${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════${NC}"
echo ""

echo "Select the profile that best matches your situation:"
echo ""
echo -e "${GREEN}1) 🆕 First-Time Learner${NC}"
echo "   • You are: New to Claude Code, want to learn fundamentals"
echo "   • Time: 60-90 minutes"
echo "   • You'll get: Complete understanding + working setup"
echo ""
echo -e "${BLUE}2) ⚡ Quick Setup User${NC}"
echo "   • You are: Already use Claude Code, just need project setup"
echo "   • Time: 15-30 minutes"
echo "   • You'll get: Configured project, ready to code"
echo ""
echo -e "${MAGENTA}3) 🚀 Advanced Optimizer${NC}"
echo "   • You are: Want security hooks, custom agents, MCP servers"
echo "   • Time: 20-40 minutes"
echo "   • You'll get: Production-grade advanced features"
echo ""
echo -e "${YELLOW}4) 👥 Team Lead${NC}"
echo "   • You are: Setting up Claude Code for your entire team"
echo "   • Time: 90-120 minutes (one-time investment)"
echo "   • You'll get: Repeatable process, team documentation"
echo ""
echo -e "${CYAN}5) 🔄 Returning User${NC}"
echo "   • You are: Used Claude Code before, need a quick refresher"
echo "   • Time: 10-20 minutes"
echo "   • You'll get: Memory refreshed, back to productivity"
echo ""
echo -e "${RED}6) ❌ Exit${NC}"
echo "   • Exit wizard and set up manually"
echo ""

# Get user choice
while true; do
    echo -n -e "${GREEN}Select your profile (1-6): ${NC}"
    read -r PROFILE_CHOICE

    case $PROFILE_CHOICE in
        1)
            PERSONA="first-time"
            PERSONA_NAME="First-Time Learner"
            PERSONA_EMOJI="🆕"
            PERSONA_TIME="60-90 minutes"
            break
            ;;
        2)
            PERSONA="quick-setup"
            PERSONA_NAME="Quick Setup User"
            PERSONA_EMOJI="⚡"
            PERSONA_TIME="15-30 minutes"
            break
            ;;
        3)
            PERSONA="advanced"
            PERSONA_NAME="Advanced Optimizer"
            PERSONA_EMOJI="🚀"
            PERSONA_TIME="20-40 minutes"
            break
            ;;
        4)
            PERSONA="team-lead"
            PERSONA_NAME="Team Lead"
            PERSONA_EMOJI="👥"
            PERSONA_TIME="90-120 minutes"
            break
            ;;
        5)
            PERSONA="returning"
            PERSONA_NAME="Returning User"
            PERSONA_EMOJI="🔄"
            PERSONA_TIME="10-20 minutes"
            break
            ;;
        6)
            echo ""
            echo -e "${YELLOW}Exiting wizard. You can set up manually using:${NC}"
            echo "  • START_HERE.md - Choose your profile and follow the path"
            echo "  • VISUAL_GUIDES.md - Visual learning aids"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please select 1-6.${NC}"
            ;;
    esac
done

# Confirm persona selection
clear
echo -e "${GREEN}✅ Profile Selected: ${PERSONA_EMOJI} ${PERSONA_NAME}${NC}"
echo -e "${CYAN}Estimated time: ${PERSONA_TIME}${NC}"
echo ""
echo -e "${YELLOW}This wizard will guide you through:${NC}"

case $PERSONA in
    "first-time")
        echo "  1. Installing Claude Code globally"
        echo "  2. Learning core concepts and commands"
        echo "  3. Understanding model switching (save 92%!)"
        echo "  4. Setting up your first project"
        ;;
    "quick-setup")
        echo "  1. Copying configuration files to your project"
        echo "  2. Creating CLAUDE.md from template"
        echo "  3. Documenting business purpose"
        echo "  4. Testing setup with Claude Code"
        ;;
    "advanced")
        echo "  1. Installing security hooks"
        echo "  2. Creating custom agents"
        echo "  3. Configuring MCP servers"
        echo "  4. Testing advanced features"
        ;;
    "team-lead")
        echo "  1. Planning team rollout strategy"
        echo "  2. Creating shared template repository"
        echo "  3. Documenting team-specific standards"
        echo "  4. Onboarding pilot users"
        ;;
    "returning")
        echo "  1. Reviewing essential commands"
        echo "  2. Refreshing model switching strategy"
        echo "  3. Checking what's new in v2.1"
        echo "  4. Quick reference card"
        ;;
esac

echo ""
echo -n -e "${CYAN}Ready to begin? (y/n): ${NC}"
read -r CONFIRM

if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "${YELLOW}Setup cancelled. Run this wizard again when you're ready!${NC}"
    exit 0
fi

################################################################################
# Route to Persona-Specific Wizard
################################################################################

clear
echo -e "${GREEN}🎉 Starting ${PERSONA_EMOJI} ${PERSONA_NAME} setup...${NC}"
echo ""

# Save persona preference for future sessions
mkdir -p "$HOME/.claude"
echo "$PERSONA" > "$HOME/.claude/last-persona"

# Route to appropriate wizard script
case $PERSONA in
    "first-time")
        bash "$SCRIPT_DIR/wizard-first-time.sh" "$TEMPLATE_ROOT"
        ;;
    "quick-setup")
        bash "$SCRIPT_DIR/wizard-quick-setup.sh" "$TEMPLATE_ROOT"
        ;;
    "advanced")
        bash "$SCRIPT_DIR/wizard-advanced.sh" "$TEMPLATE_ROOT"
        ;;
    "team-lead")
        bash "$SCRIPT_DIR/wizard-team-lead.sh" "$TEMPLATE_ROOT"
        ;;
    "returning")
        bash "$SCRIPT_DIR/wizard-returning.sh" "$TEMPLATE_ROOT"
        ;;
esac

WIZARD_EXIT_CODE=$?

################################################################################
# Final Summary
################################################################################

if [ $WIZARD_EXIT_CODE -eq 0 ]; then
    clear
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                            ║${NC}"
    echo -e "${GREEN}║         ✅ Setup Complete! You're ready to code!          ║${NC}"
    echo -e "${GREEN}║                                                            ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}What's Next:${NC}"
    echo "  • Start Claude Code: ${GREEN}claude${NC}"
    echo "  • View persona guide: ${BLUE}less START_HERE.md${NC}"
    echo "  • See visual guides: ${MAGENTA}less VISUAL_GUIDES.md${NC}"
    echo "  • Check usage: ${YELLOW}/usage${NC} (in Claude Code)"
    echo ""
    echo -e "${YELLOW}Pro Tips:${NC}"
    echo "  • Use ${GREEN}/model haiku${NC} for implementation (92% cheaper!)"
    echo "  • Update CLAUDE.md as your project evolves"
    echo "  • Run this wizard again for new projects"
    echo ""
    echo -e "${CYAN}Need help? Visit: https://code.claude.com/docs${NC}"
    echo ""
else
    echo -e "${RED}❌ Setup encountered an error (exit code: $WIZARD_EXIT_CODE)${NC}"
    echo -e "${YELLOW}Check the error messages above for details.${NC}"
    echo ""
    echo -e "${CYAN}Troubleshooting:${NC}"
    echo "  • Review START_HERE.md for manual setup"
    echo "  • Check ~/.claude/ directory permissions"
    echo "  • Run: ${GREEN}claude /doctor${NC} for diagnostics"
    echo ""
fi

exit $WIZARD_EXIT_CODE
