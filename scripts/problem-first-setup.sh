#!/bin/bash
# Problem-First Setup Wizard - v5.0.0 Alpha
# Implements Gabriel Petersson's "pressure-driven learning" methodology
# Start with a REAL problem, deliver understanding just-in-time

set -e

# Colors for output
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

# Source progress bar if available
if [ -f "$SCRIPT_DIR/progress-bar-config.sh" ]; then
    source "$SCRIPT_DIR/progress-bar-config.sh"
fi

# Banner
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Problem-First Setup${NC} - v5.0.0 Alpha                            ${CYAN}║${NC}"
echo -e "${CYAN}║${NC}  Learn by DOING. Configure by NEEDING. Understand by SOLVING.   ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Welcome to a new way of learning Claude Code.${NC}"
echo ""
echo -e "Instead of configuring FIRST and solving problems LATER,"
echo -e "you'll ${BOLD}solve a real problem RIGHT NOW${NC} and learn configuration"
echo -e "only when you hit walls that make you NEED it."
echo ""
echo -e "${CYAN}This is based on Gabriel Petersson's research:${NC}"
echo -e "\"Pressure from real problems accelerates learning.\""
echo ""
read -p "Ready to try? (yes/no): " ready
if [[ ! "$ready" =~ ^[Yy](es)?$ ]]; then
    echo ""
    echo -e "${YELLOW}No problem! You can use traditional setup instead:${NC}"
    echo -e "  ${CYAN}./scripts/claude-wizard.sh${NC}  (Full persona-based setup)"
    echo -e "  ${CYAN}docs/00-start-here/03_instant-setup.md${NC}  (5-minute setup)"
    echo ""
    exit 0
fi

# ============================================================================
# STEP 1: What's YOUR problem? (Create pressure)
# ============================================================================
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Step 1: What's YOUR Problem?${NC}                                  ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Think of a REAL problem you need to solve.${NC}"
echo -e "Not \"I want to learn Claude Code\" - that's not a problem."
echo -e "But \"I need to fix a security bug\" or \"I need to add an API endpoint\" - those ARE problems."
echo ""
echo -e "${BOLD}What problem do you need to solve RIGHT NOW?${NC}"
echo -e "${CYAN}(Be specific. What are you working on today? This hour?)${NC}"
echo ""
echo -e "Examples:"
echo -e "  • Fix a security vulnerability in my API"
echo -e "  • Add a new feature to my app"
echo -e "  • Refactor messy code"
echo -e "  • Debug a failing test"
echo -e "  • Optimize slow performance"
echo ""
read -p "Your problem: " user_problem

if [ -z "$user_problem" ]; then
    echo ""
    echo -e "${RED}No problem entered. This setup requires a real problem to solve.${NC}"
    echo -e "Come back when you have something concrete to work on!"
    exit 1
fi

echo ""
echo -e "${GREEN}✓ Problem captured:${NC} $user_problem"
sleep 1

# ============================================================================
# STEP 2: Classify problem type (route to relevant demo)
# ============================================================================
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Step 2: Problem Classification${NC}                               ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Let me understand your problem type..."
echo ""
echo -e "${YELLOW}Which category fits best?${NC}"
echo ""
echo -e "  ${BOLD}1)${NC} Bug Fix / Security Issue"
echo -e "     ${CYAN}→ Finding and fixing vulnerabilities, errors, or failures${NC}"
echo ""
echo -e "  ${BOLD}2)${NC} Feature Addition"
echo -e "     ${CYAN}→ Adding new functionality, API endpoints, or capabilities${NC}"
echo ""
echo -e "  ${BOLD}3)${NC} Refactoring / Code Quality"
echo -e "     ${CYAN}→ Improving existing code structure, readability, or maintainability${NC}"
echo ""
echo -e "  ${BOLD}4)${NC} Other / Not Sure"
echo -e "     ${CYAN}→ Something else or combination of above${NC}"
echo ""
read -p "Choose (1-4): " problem_type

case $problem_type in
    1)
        problem_category="bug-fix"
        problem_label="Bug Fix / Security"
        demo_script="$TEMPLATE_DIR/demos/bug-fix-security/demo.sh"
        ;;
    2)
        problem_category="feature-addition"
        problem_label="Feature Addition"
        demo_script="$TEMPLATE_DIR/demos/feature-addition/demo.sh"
        ;;
    3)
        problem_category="refactoring"
        problem_label="Refactoring"
        demo_script="$TEMPLATE_DIR/demos/refactoring/demo.sh"
        ;;
    4)
        problem_category="other"
        problem_label="Other"
        demo_script=""
        ;;
    *)
        echo -e "${RED}Invalid choice. Defaulting to 'Other'.${NC}"
        problem_category="other"
        problem_label="Other"
        demo_script=""
        ;;
esac

echo ""
echo -e "${GREEN}✓ Category:${NC} $problem_label"
sleep 1

# ============================================================================
# STEP 3: Show 3-second demo (Proof of value)
# ============================================================================
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Step 3: See Claude Code in Action (3 seconds)${NC}                ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Before we start, let me show you Claude Code solving a similar problem.${NC}"
echo ""

if [ -n "$demo_script" ] && [ -f "$demo_script" ]; then
    echo -e "${CYAN}Running $problem_label demo...${NC}"
    echo ""

    # Run the demo script
    bash "$demo_script"

    echo ""
    echo -e "${GREEN}✓ Demo complete!${NC}"
    echo ""
    echo -e "${BOLD}That's what Claude Code can do for your problem.${NC}"
    echo ""
else
    echo -e "${YELLOW}Demo for your problem type is coming soon!${NC}"
    echo -e "For now, here's what Claude Code does:"
    echo ""
    echo -e "  ${BOLD}Traditional Approach:${NC}"
    echo -e "  • Manually search documentation"
    echo -e "  • Trial and error"
    echo -e "  • Copy-paste from Stack Overflow"
    echo -e "  • Hope it works"
    echo ""
    echo -e "  ${BOLD}Claude Code Approach:${NC}"
    echo -e "  • Understand your codebase automatically"
    echo -e "  • Propose solution with explanation"
    echo -e "  • Generate tests"
    echo -e "  • Validate security and quality"
    echo ""
fi

read -p "Want Claude to help with YOUR problem? (yes/no): " want_help
if [[ ! "$want_help" =~ ^[Yy](es)?$ ]]; then
    echo ""
    echo -e "${YELLOW}No worries! Come back when you're ready.${NC}"
    exit 0
fi

# ============================================================================
# STEP 4: Minimal config (Zero-friction start)
# ============================================================================
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}Step 4: Minimal Configuration${NC}                                ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Setting up minimal configuration to start working...${NC}"
echo ""

# Create .claude directory if it doesn't exist
if [ ! -d ".claude" ]; then
    echo -e "  ${CYAN}→${NC} Creating .claude/ directory..."
    mkdir -p .claude
fi

# Copy default settings if none exist
if [ ! -f ".claude/settings.json" ]; then
    echo -e "  ${CYAN}→${NC} Installing default settings..."
    if [ -f "$TEMPLATE_DIR/.claude/settings.json" ]; then
        cp "$TEMPLATE_DIR/.claude/settings.json" .claude/settings.json
    fi
fi

# Create minimal CLAUDE.md if none exists
if [ ! -f "CLAUDE.md" ]; then
    echo -e "  ${CYAN}→${NC} Creating minimal CLAUDE.md..."
    cat > CLAUDE.md << 'EOF'
# Project Memory

**Current Problem:** $USER_PROBLEM

## What I'm Working On

$USER_PROBLEM_DETAILED

## Project Context

(Claude will help you fill this in as you work)

---

**Note:** This is a minimal configuration. Claude will help you expand this as you encounter walls that require more context.
EOF
    # Replace placeholder
    sed -i.bak "s/\$USER_PROBLEM/$user_problem/g" CLAUDE.md
    sed -i.bak "s/\$USER_PROBLEM_DETAILED/$user_problem/g" CLAUDE.md
    rm -f CLAUDE.md.bak
fi

echo ""
echo -e "${GREEN}✓ Minimal configuration complete!${NC}"
echo ""
echo -e "${BOLD}Configuration Philosophy:${NC}"
echo -e "  You now have just enough to start working."
echo -e "  More configuration will come ${BOLD}just-in-time${NC} when you need it."
echo -e "  This prevents \"configuration paralysis\" - let's solve your problem first!"
echo ""
sleep 2

# ============================================================================
# STEP 5: Launch instructions + Understanding Checkpoint info
# ============================================================================
clear
echo -e "${CYAN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}  ${BOLD}🚀 Ready to Solve Your Problem!${NC}                              ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}${BOLD}Setup complete!${NC} You're ready to work on:"
echo -e "  ${CYAN}→${NC} $user_problem"
echo ""
echo -e "${YELLOW}What happens next:${NC}"
echo ""
echo -e "  ${BOLD}1) Start solving your problem${NC} with Claude Code"
echo -e "     → Ask Claude to help: ${CYAN}\"Help me $user_problem\"${NC}"
echo ""
echo -e "  ${BOLD}2) Hit a wall?${NC} That's when you'll learn!"
echo -e "     → ${CYAN}Understanding Checkpoints${NC} will trigger when you encounter"
echo -e "       configuration needs, explaining WHY you need each feature"
echo ""
echo -e "  ${BOLD}3) Configuration accumulates naturally${NC}"
echo -e "     → You'll only configure what you NEED, when you NEED it"
echo -e "     → No wasted time on unused features"
echo ""
echo -e "${YELLOW}${BOLD}Key Principle:${NC}"
echo -e "  \"${CYAN}Configuration is the TOOL to solve your problem,${NC}"
echo -e "   ${CYAN}not preparation for hypothetical future work.${NC}\""
echo ""
echo -e "  - Gabriel Petersson's Learning Methodology"
echo ""
echo ""
echo -e "${BOLD}To start Claude Code:${NC}"
echo -e "  ${CYAN}claude chat${NC}  (or open your Claude Code interface)"
echo ""
echo -e "${BOLD}Then say:${NC}"
echo -e "  ${CYAN}\"Help me $user_problem\"${NC}"
echo ""
echo ""
echo -e "${GREEN}${BOLD}Additional Resources:${NC}"
echo -e "  • Traditional setup: ${CYAN}./scripts/claude-wizard.sh${NC}"
echo -e "  • Quick reference: ${CYAN}docs/00-start-here/09_quick-reference.md${NC}"
echo -e "  • Understanding checkpoints: ${CYAN}.claude/skills/understanding-checkpoints/README.md${NC}"
echo ""
echo ""
read -p "Press Enter to finish setup..."

# ============================================================================
# STEP 6: Create .problem-first-setup file for checkpoint system
# ============================================================================
cat > .claude/.problem-first-setup << EOF
# Problem-First Setup Record
# This file helps the Adaptive Checkpoint System know you're using problem-first approach

setup_date=$(date +%Y-%m-%d)
user_problem=$user_problem
problem_category=$problem_category
first_session=true

# Checkpoints will monitor your progress and trigger understanding moments
# when you hit configuration walls
EOF

# ============================================================================
# Completion
# ============================================================================
clear
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${NC}  ${BOLD}✅ Problem-First Setup Complete!${NC}                            ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}Your Problem:${NC} $user_problem"
echo -e "${BOLD}Category:${NC} $problem_label"
echo ""
echo -e "${YELLOW}Now go solve it! 🚀${NC}"
echo ""
echo -e "${CYAN}Pro Tip:${NC} Don't worry about \"doing it right.\""
echo -e "The system will guide you when you need guidance."
echo -e "Just start solving your problem."
echo ""
echo -e "${GREEN}Good luck!${NC}"
echo ""
