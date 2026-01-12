#!/bin/bash
# Demo 2: Feature Addition - API Endpoint with Tests
# Shows Claude Code building a complete feature with tests

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}Problem:${NC} Need to add a new API endpoint for user search"
echo ""
echo -e "${YELLOW}${BOLD}Traditional Approach:${NC}"
echo -e "  1. Write endpoint code (15 min)"
echo -e "  2. Debug why it doesn't work (20 min)"
echo -e "  3. Remember to add tests (10 min)"
echo -e "  4. Fix test failures (15 min)"
echo -e "  ${YELLOW}Total: ~60 minutes${NC}"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Claude Code Approach:${NC}"
echo -e "  ${CYAN}1.${NC} Generates endpoint with error handling"
echo -e "  ${CYAN}2.${NC} Adds validation automatically"
echo -e "  ${CYAN}3.${NC} Creates comprehensive tests"
echo -e "  ${CYAN}4.${NC} Tests pass on first run"
echo -e "  ${GREEN}Total: ~10 minutes${NC}"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Generated:${NC}"
echo -e "${GREEN}┌──────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│${NC} app.get('/api/users/search', async ...  ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ✓ Input validation                    ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ✓ Error handling                      ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ✓ Response formatting                 ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ✓ Security headers                    ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ✓ Rate limiting                       ${GREEN}│${NC}"
echo -e "${GREEN}└──────────────────────────────────────────┘${NC}"
echo ""
echo -e "${CYAN}${BOLD}+ Tests:${NC} 5 test cases covering edge cases"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Result:${NC} Production-ready feature in ${GREEN}10 minutes${NC}"
echo -e "${BOLD}Time saved:${NC} ${GREEN}50 minutes${NC}"
echo ""
