# Claude Code Template - Quick Setup

## For New Projects:

1. **Copy configuration to your project**:
   ```bash
   cd /path/to/your/new/project
   cp -r ~/Developer/claude-config-template/.claude .
   cp ~/Developer/claude-config-template/CLAUDE.md .
   ```

2. **Customize CLAUDE.md**:
   - Replace [PROJECT NAME] with actual name
   - Fill in your tech stack
   - Add your coding conventions
   - Document common commands

3. **Adjust .claude/settings.json**:
   - Add/remove commands from excludedCommands based on your tech stack

4. **Start using Claude Code**:
   ```bash
   claude
   ```

## For Team Members:

1. **Set up global config** (first time only):
   - Follow Part 1 of IMPLEMENTATION_GUIDE.md
   - Add environment variables to ~/.zshrc
   - Create ~/.claude.json

2. **Clone project** (configs already included):
   ```bash
   git clone <repo>
   cd <project>
   # .claude/ and CLAUDE.md should already be there
   claude  # Start using immediately!
   ```

## Customizing for Your Organization:

- Edit `.claude/settings.json` to add your common tools
- Update `CLAUDE.md` template with your standards
- Add company-specific conventions
- Share this template with your team

## Advanced Guides (Included in Template):

### 📚 Complete Documentation Set:

1. **AGENT_COORDINATION_GUIDE.md** - How subagents work and token optimization
   - Prompt caching strategies
   - Agent coordination best practices
   - Real-world examples with token savings

2. **PROMPT_OPTIMIZATION_GUIDE.md** - Master prompt writing for maximum efficiency
   - 5 golden rules of effective prompts
   - 50-80% token savings techniques
   - Workflow integration examples
   - Before/after comparisons

3. **IMPLEMENTATION_GUIDE.md** - Step-by-step setup instructions
   - Global and project configuration
   - Environment variables
   - Verification and testing

4. **TEAM_ONBOARDING.md** - Quick start for team members
   - 15-minute setup guide
   - Essential commands
   - Troubleshooting

### Quick Reference:

### Essential Claude Code Commands:
- `/cost` - Check token usage
- `/compact` - Reduce conversation size
- `/clear` - Start fresh context
- `/model sonnet` - Switch to Sonnet
- `/model opus` - Switch to Opus for complex tasks
- `/doctor` - Check system health

### Environment Variables (add to ~/.zshrc):
```bash
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=4000
export MAX_MCP_OUTPUT_TOKENS=50000
export DISABLE_PROMPT_CACHING=false
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export CLAUDE_CODE_METRICS_EXPORTER=console
export BASH_DEFAULT_TIMEOUT_MS=30000
export BASH_MAX_TIMEOUT_MS=120000
```

### Global Settings (create ~/.claude.json):
```json
{
  "model": "sonnet",
  "alwaysThinkingEnabled": true,
  "outputStyle": "concise"
}
```
