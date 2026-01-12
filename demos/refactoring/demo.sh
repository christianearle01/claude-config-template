#!/bin/bash
# Demo 3: Refactoring - Code Quality Improvement
# Shows Claude Code improving code structure and maintainability

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}Problem:${NC} Messy code that's hard to maintain"
echo ""
echo -e "${YELLOW}${BOLD}Before:${NC} 150-line function doing everything"
echo -e "${YELLOW}┌─────────────────────────────────────┐${NC}"
echo -e "${YELLOW}│${NC} function processUserData(...) {     ${YELLOW}│${NC}"
echo -e "${YELLOW}│${NC}   // 150 lines of mixed logic      ${YELLOW}│${NC}"
echo -e "${YELLOW}│${NC}   // Validation, transformation,   ${YELLOW}│${NC}"
echo -e "${YELLOW}│${NC}   // database calls, email         ${YELLOW}│${NC}"
echo -e "${YELLOW}│${NC}   // All in one place!             ${YELLOW}│${NC}"
echo -e "${YELLOW}└─────────────────────────────────────┘${NC}"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}After Claude's Refactoring:${NC}"
echo -e "${GREEN}┌─────────────────────────────────────┐${NC}"
echo -e "${GREEN}│${NC} validateUser(data)  ${CYAN}// 20 lines${NC}   ${GREEN}│${NC}"
echo -e "${GREEN}│${NC} transformUser(data) ${CYAN}// 15 lines${NC}   ${GREEN}│${NC}"
echo -e "${GREEN}│${NC} saveUser(data)      ${CYAN}// 10 lines${NC}   ${GREEN}│${NC}"
echo -e "${GREEN}│${NC} notifyUser(data)    ${CYAN}// 10 lines${NC}   ${GREEN}│${NC}"
echo -e "${GREEN}└─────────────────────────────────────┘${NC}"
echo ""
echo -e "  ${GREEN}✓${NC} Single Responsibility Principle"
echo -e "  ${GREEN}✓${NC} Testable functions"
echo -e "  ${GREEN}✓${NC} Clear naming"
echo -e "  ${GREEN}✓${NC} Reduced complexity"
sleep 1

echo ""
echo -e "${CYAN}${BOLD}+ Bonus:${NC} Tests for each function"
echo ""
echo -e "${GREEN}${BOLD}Result:${NC} Maintainable code in ${GREEN}15 minutes${NC}"
echo -e "${BOLD}Time saved:${NC} ${GREEN}Hours of future debugging${NC}"
echo ""
