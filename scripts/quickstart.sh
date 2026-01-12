#!/bin/bash
# Quick Start - Smart Detection Script
# Version: 5.0.0-alpha.2
# Purpose: Ask 2-3 questions, route to optimal setup path automatically
# Eliminates decision paralysis from having 7 different entry points

set -e  # Exit on error

################################################################################
# Colors and Setup
################################################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(dirname "$SCRIPT_DIR")"

################################################################################
# Banner
################################################################################

clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Claude Code Quick Start${NC} - v5.0.0 Alpha                       ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  Answer 2-3 questions. We'll find your perfect path.           ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}Welcome!${NC} Let's get you set up with the ${BOLD}right${NC} path for ${BOLD}you${NC}."
echo ""
echo -e "${YELLOW}No decision paralysis.${NC} Just answer honestly, and we'll route you automatically."
echo ""
read -p "Press Enter to start..."

################################################################################
# Question 1: Problem-First Detection
################################################################################

clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Question 1 of 3: Do You Have a Problem RIGHT NOW?${NC}            ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Do you have a SPECIFIC problem you need to solve today?${NC}"
echo ""
echo -e "Examples of specific problems:"
echo -e "  • ${GREEN}✓${NC} Fix a security vulnerability in my API"
echo -e "  • ${GREEN}✓${NC} Add a new feature to my app"
echo -e "  • ${GREEN}✓${NC} Refactor messy code in a module"
echo -e "  • ${GREEN}✓${NC} Debug a failing test"
echo -e "  • ${GREEN}✓${NC} Optimize slow database queries"
echo ""
echo -e "NOT specific problems:"
echo -e "  • ${RED}✗${NC} \"I want to learn Claude Code\" (that's a goal, not a problem)"
echo -e "  • ${RED}✗${NC} \"I might need this later\" (no immediate pressure)"
echo ""
echo -e "${BOLD}Do you have a concrete problem to solve RIGHT NOW?${NC}"
echo ""
echo -e "  ${BOLD}1)${NC} Yes - I have a specific problem to solve today"
echo -e "  ${BOLD}2)${NC} No - I'm just exploring or setting up for future use"
echo ""
read -p "Choose (1 or 2): " has_problem

if [[ "$has_problem" == "1" ]]; then
    # Route to Problem-First Setup
    clear
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}✓ Perfect! Problem-First Setup is ideal for you.${NC}             ${GREEN}║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}What happens next:${NC}"
    echo -e "  1. You'll describe your specific problem"
    echo -e "  2. We'll show you a 3-second demo of Claude solving it"
    echo -e "  3. You'll get minimal config (just enough to start)"
    echo -e "  4. You'll learn configuration ${BOLD}only when you hit walls${NC}"
    echo ""
    echo -e "${CYAN}This is based on Gabriel Petersson's research:${NC}"
    echo -e "\"Pressure from real problems accelerates learning.\""
    echo ""
    echo -e "${BOLD}Time: 60 seconds to start working${NC}"
    echo ""
    read -p "Press Enter to launch Problem-First Setup..."

    # Launch problem-first setup
    exec "$SCRIPT_DIR/problem-first-setup.sh"
fi

################################################################################
# Question 2: Time Available
################################################################################

clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Question 2 of 3: How Much Time Do You Have?${NC}                  ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}How much time can you dedicate to setup right now?${NC}"
echo ""
echo -e "  ${BOLD}1)${NC} Less than 5 minutes"
echo -e "     ${CYAN}→ Ultra-quick instant setup (copy 3 files, done)${NC}"
echo ""
echo -e "  ${BOLD}2)${NC} 15-30 minutes"
echo -e "     ${CYAN}→ Quick setup with understanding (efficient but thorough)${NC}"
echo ""
echo -e "  ${BOLD}3)${NC} 60-90 minutes"
echo -e "     ${CYAN}→ Full learning path (deep understanding + mastery)${NC}"
echo ""
read -p "Choose (1, 2, or 3): " time_available

################################################################################
# Question 3: Team Setup (Only if enough time)
################################################################################

setup_for_team="no"

if [[ "$time_available" == "3" ]]; then
    clear
    echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}  ${BOLD}Question 3 of 3: Setting Up for a Team?${NC}                      ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Are you setting this up for an entire team?${NC}"
    echo ""
    echo -e "  ${BOLD}1)${NC} Yes - I'm a team lead setting up for multiple people"
    echo -e "     ${CYAN}→ Team Lead path (includes documentation, repeatability)${NC}"
    echo ""
    echo -e "  ${BOLD}2)${NC} No - This is just for me"
    echo -e "     ${CYAN}→ Individual learning path${NC}"
    echo ""
    read -p "Choose (1 or 2): " team_choice

    if [[ "$team_choice" == "1" ]]; then
        setup_for_team="yes"
    fi
fi

################################################################################
# Routing Logic
################################################################################

clear
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}  ${BOLD}✓ Got it! Here's your optimal path...${NC}                        ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Route based on answers
if [[ "$time_available" == "1" ]]; then
    # Ultra-quick: < 5 minutes
    echo -e "${YELLOW}Your Path:${NC} ${BOLD}Instant Setup (5 minutes)${NC}"
    echo ""
    echo -e "${CYAN}What you'll do:${NC}"
    echo -e "  1. Copy CLAUDE.md template to your project"
    echo -e "  2. Copy settings.json to .claude/ directory"
    echo -e "  3. Start using Claude Code immediately"
    echo ""
    echo -e "${YELLOW}Trade-off:${NC} Fast but minimal understanding (good for urgent work)."
    echo -e "You can always come back later for deeper learning."
    echo ""
    echo -e "${BOLD}Follow this guide:${NC}"
    echo -e "  ${CYAN}docs/00-start-here/03_instant-setup.md${NC}"
    echo ""
    echo -e "${GREEN}Opening documentation...${NC}"
    echo ""

    # Check if we can open the file
    if command -v open >/dev/null 2>&1; then
        open "$TEMPLATE_DIR/docs/00-start-here/03_instant-setup.md" 2>/dev/null || true
    fi

    echo -e "Path: ${CYAN}$TEMPLATE_DIR/docs/00-start-here/03_instant-setup.md${NC}"
    echo ""

elif [[ "$setup_for_team" == "yes" ]]; then
    # Team lead path: 90-120 minutes
    echo -e "${YELLOW}Your Path:${NC} ${BOLD}Team Lead Setup (90-120 minutes)${NC}"
    echo ""
    echo -e "${CYAN}What you'll do:${NC}"
    echo -e "  1. Learn Claude Code fundamentals deeply"
    echo -e "  2. Set up repeatable processes for your team"
    echo -e "  3. Create team documentation and standards"
    echo -e "  4. Configure team-wide best practices"
    echo ""
    echo -e "${YELLOW}Why this path:${NC} You need deep understanding to lead others."
    echo -e "This is a one-time investment that pays off across your entire team."
    echo ""
    echo -e "${BOLD}Launching Team Lead wizard...${NC}"
    echo ""
    read -p "Press Enter to continue..."

    # Launch team lead wizard
    exec "$SCRIPT_DIR/wizard-team-lead.sh"

elif [[ "$time_available" == "3" ]]; then
    # Full learning: 60-90 minutes (individual)
    echo -e "${YELLOW}Your Path:${NC} ${BOLD}First-Time Learner (60-90 minutes)${NC}"
    echo ""
    echo -e "${CYAN}What you'll do:${NC}"
    echo -e "  1. Learn fundamentals: how Claude Code actually works"
    echo -e "  2. Understand token optimization (50-95% savings)"
    echo -e "  3. Master CLAUDE.md (project memory that persists)"
    echo -e "  4. Set up with full comprehension (no mystery configs)"
    echo ""
    echo -e "${YELLOW}Why this path:${NC} Deep understanding beats fast setup."
    echo -e "You'll ship code you can explain, maintain, and debug with confidence."
    echo ""
    echo -e "${GREEN}Jake Nations Test: \"Smarter over faster\"${NC}"
    echo ""
    echo -e "${BOLD}Launching First-Time Learner wizard...${NC}"
    echo ""
    read -p "Press Enter to continue..."

    # Launch first-time wizard
    exec "$SCRIPT_DIR/wizard-first-time.sh"

elif [[ "$time_available" == "2" ]]; then
    # Quick setup: 15-30 minutes
    echo -e "${YELLOW}Your Path:${NC} ${BOLD}Quick Setup (15-30 minutes)${NC}"
    echo ""
    echo -e "${CYAN}What you'll do:${NC}"
    echo -e "  1. Set up essential project configuration"
    echo -e "  2. Get key concepts (enough to be productive)"
    echo -e "  3. Configure CLAUDE.md and settings.json"
    echo -e "  4. Start coding with solid foundation"
    echo ""
    echo -e "${YELLOW}Why this path:${NC} Balanced - efficient but thorough."
    echo -e "You'll understand what you're doing without spending hours."
    echo ""
    echo -e "${BOLD}Launching Quick Setup wizard...${NC}"
    echo ""
    read -p "Press Enter to continue..."

    # Launch quick setup wizard
    exec "$SCRIPT_DIR/wizard-quick-setup.sh"

else
    # Fallback: Show all options
    echo -e "${RED}Invalid selection detected.${NC}"
    echo ""
    echo -e "${YELLOW}Let's use the full wizard instead:${NC}"
    echo ""
    read -p "Press Enter to launch main wizard..."

    exec "$SCRIPT_DIR/claude-wizard.sh"
fi

################################################################################
# Fallback (should never reach here due to exec)
################################################################################

echo ""
echo -e "${GREEN}Setup path determined!${NC}"
echo ""
