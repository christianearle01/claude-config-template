#!/bin/bash
# Demo 1: Bug Fix - Security Vulnerability Detection
# Shows Claude Code detecting and fixing SQL injection vulnerability
# Target time: 3-5 seconds (quick proof of value)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}Problem:${NC} API endpoint has SQL injection vulnerability"
echo ""
echo -e "${RED}${BOLD}Vulnerable Code:${NC}"
echo -e "${RED}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${RED}│${NC} async function getUser(userId) {                      ${RED}│${NC}"
echo -e "${RED}│${NC}   const query = ${RED}\"SELECT * FROM users WHERE id=\"   ${RED}│${NC}"
echo -e "${RED}│${NC}                 + ${RED}userId${NC};  ${YELLOW}← User input directly in SQL!${NC}  ${RED}│${NC}"
echo -e "${RED}│${NC}   return await db.query(query);                      ${RED}│${NC}"
echo -e "${RED}│${NC} }                                                     ${RED}│${NC}"
echo -e "${RED}└────────────────────────────────────────────────────────┘${NC}"
sleep 1

echo ""
echo -e "${CYAN}${BOLD}Claude's Analysis (< 2 seconds):${NC}"
echo -e "  ${CYAN}🔍${NC} Detecting security patterns..."
echo -e "  ${YELLOW}⚠️  Found SQL injection vulnerability (OWASP A03:2021)${NC}"
echo -e "  ${CYAN}💡${NC} Risk: Attacker can execute arbitrary SQL"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Claude's Solution:${NC}"
echo -e "${GREEN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│${NC} async function getUser(userId) {                      ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   const query = ${GREEN}\"SELECT * FROM users WHERE id=?\"${NC};  ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   return await db.query(query, ${GREEN}[userId]${NC});          ${GREEN}│${NC}"
echo -e "${GREEN}│${NC}   ${CYAN}// Parameterized query prevents injection${NC}         ${GREEN}│${NC}"
echo -e "${GREEN}│${NC} }                                                     ${GREEN}│${NC}"
echo -e "${GREEN}└────────────────────────────────────────────────────────┘${NC}"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Bonus: Security Test Added${NC}"
echo -e "${CYAN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC} test('blocks SQL injection attempts', async () => {  ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}   const maliciousInput = \"1 OR 1=1\";                 ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}   const result = await getUser(maliciousInput);      ${CYAN}│${NC}"
echo -e "${CYAN}│${NC}   expect(result).toEqual([]);  ${GREEN}// ✓ Safe!${NC}             ${CYAN}│${NC}"
echo -e "${CYAN}│${NC} });                                                   ${CYAN}│${NC}"
echo -e "${CYAN}└────────────────────────────────────────────────────────┘${NC}"
sleep 1

echo ""
echo -e "${GREEN}${BOLD}Result:${NC}"
echo -e "  ${GREEN}✓${NC} Vulnerability fixed"
echo -e "  ${GREEN}✓${NC} Security test added"
echo -e "  ${GREEN}✓${NC} Code is production-ready"
echo ""
echo -e "${BOLD}Time saved:${NC} ${GREEN}~30 minutes${NC} of research and testing"
echo ""
