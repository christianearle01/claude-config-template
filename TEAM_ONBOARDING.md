# Claude Code Setup - Team Onboarding

## New Team Member Checklist:

### Part 1: One-Time Global Setup (15 minutes)

- [ ] Install Claude Code (if not already installed)
- [ ] Add environment variables to ~/.zshrc:
  ```bash
  nano ~/.zshrc
  # Scroll to bottom and add:

  # ===== Claude Code Performance Optimization =====
  export CLAUDE_CODE_MAX_OUTPUT_TOKENS=4000
  export MAX_MCP_OUTPUT_TOKENS=50000
  export DISABLE_PROMPT_CACHING=false
  export CLAUDE_CODE_ENABLE_TELEMETRY=1
  export CLAUDE_CODE_METRICS_EXPORTER=console
  export BASH_DEFAULT_TIMEOUT_MS=30000
  export BASH_MAX_TIMEOUT_MS=120000

  # Save and exit (Ctrl+X, Y, Enter)
  source ~/.zshrc
  ```
- [ ] Create ~/.claude.json:
  ```bash
  nano ~/.claude.json
  # Paste this JSON:

  {
    "model": "sonnet",
    "alwaysThinkingEnabled": true,
    "outputStyle": "concise"
  }

  # Save and exit (Ctrl+X, Y, Enter)
  ```
- [ ] Verify setup:
  ```bash
  echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS  # Should output: 4000
  cat ~/.claude.json  # Should show your settings
  ```

### Part 2: Use Existing Project (2 minutes)

- [ ] Clone project repository:
  ```bash
  git clone <repo-url>
  cd <project-name>
  ```
- [ ] Verify project configs exist:
  ```bash
  ls .claude/settings.json  # Should exist
  ls CLAUDE.md  # Should exist
  ```
- [ ] Read project conventions:
  ```bash
  cat CLAUDE.md
  ```
- [ ] Start using Claude Code:
  ```bash
  claude
  ```

### Part 3: Start New Project (5 minutes)

- [ ] Copy template to new project:
  ```bash
  cd /path/to/new/project
  cp -r ~/Developer/claude-config-template/.claude .
  cp ~/Developer/claude-config-template/CLAUDE.md .
  ```
- [ ] Customize CLAUDE.md for the project
- [ ] Adjust .claude/settings.json if needed
- [ ] Commit configs to git:
  ```bash
  git add .claude/ CLAUDE.md
  git commit -m "Add Claude Code configuration"
  ```

## Essential Commands:

| Command | Purpose |
|---------|---------|
| `/cost` | Check token usage and costs |
| `/compact` | Reduce conversation size (saves tokens) |
| `/clear` | Start fresh context between tasks |
| `/model opus` | Switch to Opus for complex problems |
| `/model sonnet` | Switch to Sonnet for regular work |
| `/doctor` | Diagnose installation issues |

## Expected Benefits:

- **30-50% cost reduction** from optimizations
- **90% faster project setup** (2-3 minutes)
- **Consistent behavior** across team
- **Better code quality** from documented standards

## Troubleshooting:

### Environment variables not loading:
```bash
# Check which shell you're using:
echo $SHELL

# If zsh: edit ~/.zshrc
# If bash: edit ~/.bashrc

# Reload after editing:
source ~/.zshrc  # or source ~/.bashrc
```

### Claude not following project conventions:
```bash
# Verify CLAUDE.md exists in project root:
ls -la CLAUDE.md

# Start fresh session:
claude
/clear
```

### Settings not applying:
```bash
# Verify JSON is valid:
cat ~/.claude.json | python -m json.tool
cat .claude/settings.json | python -m json.tool
```

## Need Help?

- **Full guide**: Check IMPLEMENTATION_GUIDE.md in any project's `.claude/` folder
- **Template**: `~/Developer/claude-config-template/`
- **Team contact**: [Add your team lead contact here]

---

**Quick Start**: If you just want to get going fast:
1. Run the environment variable setup (Part 1 above)
2. Clone the project (it has configs already)
3. Start coding with `claude`
