#!/bin/bash

################################################################################
# Advanced Optimizer Wizard
# Version: 2.1
# Time: 20-40 minutes
# Purpose: Advanced features for power users (hooks, agents, MCP)
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
echo -e "${MAGENTA}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║                                                            ║${NC}"
echo -e "${MAGENTA}║         🚀 Advanced Optimizer (20-40 minutes)             ║${NC}"
echo -e "${MAGENTA}║                                                            ║${NC}"
echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Advanced features we'll set up (3 phases):${NC}"
echo ""
echo "  ${MAGENTA}Phase 1: Security & Automation${NC}"
echo "    • Security hooks (prompt injection detection)"
echo "    • Custom agents (specialized workflows)"
echo ""
echo "  ${MAGENTA}Phase 2: Integration${NC}"
echo "    • MCP servers (database, GitHub, context7)"
echo ""
echo "  ${MAGENTA}Phase 3: Performance${NC}"
echo "    • Project-specific optimizations"
echo ""

show_tip "This assumes you're already familiar with Claude Code basics."

pause

################################################################################
# Part 1: Security Hooks (10 minutes)
################################################################################

clear
show_phase_progress 1 3 "Security & Automation"
show_task_progress 1 2 "Security Hooks"
echo ""

echo -e "${CYAN}Part 1: Security Hooks (10 minutes)${NC}"
echo ""

echo -e "${YELLOW}What are security hooks?${NC}"
echo "Hooks intercept tool calls to validate inputs and outputs."
echo ""
echo -e "${GREEN}Available hooks:${NC}"
echo "  • Prompt injection detection (WebFetch)"
echo "  • Response scanning (all LLM outputs)"
echo "  • Git safety checks (destructive commands)"
echo ""

if ask_yes_no "Install prompt injection detection hook?"; then
    echo ""
    echo "Installing prompt injection detection hook..."

    # Get project path
    echo -n -e "${GREEN}Project path (or press Enter for current directory): ${NC}"
    read -r PROJECT_PATH
    if [ -z "$PROJECT_PATH" ]; then
        PROJECT_PATH="."
    fi
    PROJECT_PATH=$(cd "$PROJECT_PATH" && pwd)

    # Create hooks directory
    mkdir -p "$PROJECT_PATH/.claude/hooks"

    # Copy hook script
    if [ -f "$TEMPLATE_ROOT/examples/hooks/detect-prompt-injection.js" ]; then
        cp "$TEMPLATE_ROOT/examples/hooks/detect-prompt-injection.js" "$PROJECT_PATH/.claude/hooks/"
        echo -e "${GREEN}✅ Copied prompt injection detection hook${NC}"
    else
        echo -e "${YELLOW}⚠️  Hook script not found in template${NC}"
    fi

    # Update settings.json
    echo ""
    echo -e "${CYAN}Updating .claude/settings.json...${NC}"

    if [ -f "$PROJECT_PATH/.claude/settings.json" ]; then
        # Backup existing settings
        cp "$PROJECT_PATH/.claude/settings.json" "$PROJECT_PATH/.claude/settings.json.backup"

        # Add hook configuration (manual step required)
        echo -e "${YELLOW}⚠️  Manual step required:${NC}"
        echo "Add this to your .claude/settings.json:"
        echo ""
        echo -e "${CYAN}"
        cat << 'EOF'
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "WebFetch(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/detect-prompt-injection.js",
            "timeout": 2
          }
        ]
      }
    ]
  }
}
EOF
        echo -e "${NC}"
        echo ""
        pause "Press Enter after updating settings.json..."
    else
        echo -e "${RED}❌ .claude/settings.json not found${NC}"
    fi

    # Validate hook installation
    echo ""
    echo -e "${CYAN}Testing hook installation...${NC}"
    if [ -f "$PROJECT_PATH/.claude/hooks/detect-prompt-injection.js" ]; then
        node "$PROJECT_PATH/.claude/hooks/detect-prompt-injection.js" "Test prompt" > /dev/null 2>&1 && {
            echo -e "${GREEN}✅ Hook script is executable${NC}"
        } || {
            echo -e "${YELLOW}⚠️  Hook script needs Node.js${NC}"
        }
    fi

    checkpoint 1 "Security hooks installed"
else
    echo ""
    echo -e "${CYAN}Skipping security hooks installation.${NC}"
fi

pause

################################################################################
# Part 2: Custom Agents (15 minutes)
################################################################################

clear
show_phase_progress 1 3 "Security & Automation"
show_task_progress 2 2 "Custom Agents"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 2: Custom Agents (15 minutes)${NC}"
echo ""

echo -e "${YELLOW}What are custom agents?${NC}"
echo "Agents are specialized AI assistants for specific tasks:"
echo "  • code-reviewer: Review code against standards"
echo "  • test-runner: Run tests and analyze failures"
echo "  • documentation-writer: Generate docs from code"
echo ""

echo -e "${GREEN}Example agent use cases:${NC}"
echo "  • Run comprehensive test suite after feature completion"
echo "  • Review pull requests for security vulnerabilities"
echo "  • Generate API documentation from TypeScript types"
echo ""

if ask_yes_no "Create a custom agent?"; then
    echo ""
    echo -e "${CYAN}Let's create a code reviewer agent!${NC}"
    echo ""

    # Get project path
    if [ -z "$PROJECT_PATH" ]; then
        echo -n -e "${GREEN}Project path (or press Enter for current directory): ${NC}"
        read -r PROJECT_PATH
        if [ -z "$PROJECT_PATH" ]; then
            PROJECT_PATH="."
        fi
        PROJECT_PATH=$(cd "$PROJECT_PATH" && pwd)
    fi

    # Create agents directory
    mkdir -p "$PROJECT_PATH/.claude/agents"

    # Create code reviewer agent
    cat > "$PROJECT_PATH/.claude/agents/code-reviewer.md" << 'EOF'
# Code Reviewer Agent

You are a code review specialist. Your task is to:

1. **Review code against project standards**
   - Check CLAUDE.md for project-specific conventions
   - Verify coding style consistency
   - Identify potential bugs or security issues

2. **Focus areas**
   - Big O complexity (avoid O(n²) or worse)
   - Security vulnerabilities (SQL injection, XSS, etc.)
   - Error handling and edge cases
   - Code duplication (DRY principle)

3. **Output format**
   - List issues by severity (Critical, Warning, Suggestion)
   - Provide specific line numbers
   - Suggest fixes with code examples

## Example Usage

Ask me to review specific files:
```
@code-reviewer Please review src/auth/login.ts for security issues
```

Or review a pull request:
```
@code-reviewer Review the changes in PR #123
```

## Configuration

- Read project standards from: CLAUDE.md, .eslintrc, .prettierrc
- Use project-specific test framework
- Follow existing code conventions
EOF

    echo -e "${GREEN}✅ Created code-reviewer agent${NC}"
    echo ""
    echo -e "${CYAN}Usage:${NC}"
    echo "  @code-reviewer Review src/auth/login.ts"
    echo ""

    checkpoint 2 "Custom agents created"
else
    echo ""
    echo -e "${CYAN}Skipping custom agent creation.${NC}"
fi

pause

################################################################################
# Part 3: MCP Servers (10 minutes)
################################################################################

clear
show_phase_progress 2 3 "Integration"
show_task_progress 1 1 "MCP Servers"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 3: MCP Servers (10 minutes)${NC}"
echo ""

echo -e "${YELLOW}What are MCP servers?${NC}"
echo "Model Context Protocol servers extend Claude with tools:"
echo "  • Database queries (PostgreSQL, MySQL)"
echo "  • GitHub integration (issues, PRs)"
echo "  • Context7 (codebase RAG search)"
echo "  • File system operations"
echo ""

echo -e "${GREEN}Recommended MCP servers:${NC}"
echo "  1. @modelcontextprotocol/server-postgres - Database queries"
echo "  2. @modelcontextprotocol/server-github - GitHub integration"
echo "  3. context7 - AI-powered codebase search"
echo ""

if ask_yes_no "Install MCP servers?"; then
    echo ""
    echo -e "${CYAN}Installing MCP servers...${NC}"
    echo ""

    # Install MCP servers globally
    echo "Installing PostgreSQL MCP server..."
    npx @modelcontextprotocol/create-server postgres && {
        echo -e "${GREEN}✅ PostgreSQL MCP server installed${NC}"
    } || {
        echo -e "${YELLOW}⚠️  Installation requires configuration${NC}"
    }

    echo ""
    echo "Installing GitHub MCP server..."
    npx @modelcontextprotocol/create-server github && {
        echo -e "${GREEN}✅ GitHub MCP server installed${NC}"
    } || {
        echo -e "${YELLOW}⚠️  Installation requires GitHub token${NC}"
    }

    echo ""
    show_tip "Configure MCP servers in ~/.claude.json or .claude/settings.json"

    checkpoint 3 "MCP servers installed"
else
    echo ""
    echo -e "${CYAN}Skipping MCP server installation.${NC}"
fi

pause

################################################################################
# Part 4: Project-Specific Optimizations
################################################################################

clear
show_phase_progress 3 3 "Performance"
show_task_progress 1 1 "Project Optimizations"
check_timer "Progress check"
echo ""

echo -e "${CYAN}Part 4: Project-Specific Optimizations${NC}"
echo ""

echo -e "${YELLOW}Optimization checklist:${NC}"
echo ""

# Check if CLAUDE.md is optimized
if [ -n "$PROJECT_PATH" ] && [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
    echo -e "${CYAN}Checking CLAUDE.md optimization...${NC}"
    validate_claude_md "$PROJECT_PATH/CLAUDE.md"
    echo ""
fi

# Check .gitignore
echo -e "${CYAN}Checking .gitignore...${NC}"
if [ -n "$PROJECT_PATH" ] && [ -f "$PROJECT_PATH/.gitignore" ]; then
    if grep -q ".claude/memory.json" "$PROJECT_PATH/.gitignore" 2>/dev/null; then
        echo -e "${GREEN}✅ .gitignore includes Claude Code patterns${NC}"
    else
        echo -e "${YELLOW}⚠️  Add Claude Code patterns to .gitignore${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  No .gitignore found${NC}"
fi

echo ""

# Optimization recommendations
echo -e "${MAGENTA}Performance Recommendations:${NC}"
echo ""
echo -e "${GREEN}1. Skip unnecessary directories:${NC}"
echo "   Tell Claude: 'Skip: node_modules/, dist/, .git/'"
echo ""
echo -e "${GREEN}2. Use file references:${NC}"
echo "   Instead of: 'Add authentication'"
echo "   Say: 'Follow pattern in src/auth.ts:127'"
echo ""
echo -e "${GREEN}3. Leverage prompt caching:${NC}"
echo "   Keep CLAUDE.md updated (automatically cached)"
echo ""

checkpoint 4 "Advanced optimizations complete"

pause

################################################################################
# Knowledge Check
################################################################################

quiz \
    "When should you use security hooks?" \
    "B" \
    "Always, for every project" \
    "When fetching untrusted external content" \
    "Never, they slow down Claude Code"

quiz \
    "What's the main benefit of custom agents?" \
    "C" \
    "They're faster than regular Claude" \
    "They use less tokens" \
    "They specialize in specific tasks"

pause

################################################################################
# Final Summary
################################################################################

clear
check_timer "Total setup time"
echo ""

success_banner "Advanced Optimizer"

echo -e "${CYAN}Advanced Features Configured:${NC}"
if [ -f "$PROJECT_PATH/.claude/hooks/detect-prompt-injection.js" ]; then
    echo "  ✅ Security hooks (prompt injection detection)"
else
    echo "  ⏭️  Security hooks (skipped)"
fi

if [ -f "$PROJECT_PATH/.claude/agents/code-reviewer.md" ]; then
    echo "  ✅ Custom agents (code-reviewer)"
else
    echo "  ⏭️  Custom agents (skipped)"
fi

echo "  ✅ Project optimizations reviewed"
echo ""

echo -e "${MAGENTA}Next Steps:${NC}"
echo "  1. Test security hook: Try @WebFetch with suspicious URL"
echo "  2. Use custom agent: @code-reviewer Review <file>"
echo "  3. Configure MCP servers: Edit ~/.claude.json"
echo ""

echo -e "${YELLOW}Advanced Resources:${NC}"
echo "  • Security guide: ${CYAN}$TEMPLATE_ROOT/01_global-setup/nice-to-have/01_security-guide.md${NC}"
echo "  • Agent coordination: ${CYAN}$TEMPLATE_ROOT/01_global-setup/nice-to-have/03_agent-coordination.md${NC}"
echo "  • MCP pollution guide: ${CYAN}$TEMPLATE_ROOT/01_global-setup/good-to-have/03_mcp-pollution.md${NC}"
echo ""

celebrate "You're now a Claude Code power user"

exit 0
