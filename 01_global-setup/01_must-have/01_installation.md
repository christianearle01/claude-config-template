# First-Time Claude Code Setup

**Who is this for?** Developers using Claude Code for the first time who want to maximize their workflow globally across ALL projects.

**Time Required:** 45-60 minutes (one-time setup)

**What you'll learn:**
- Install and configure Claude Code
- Set up global MCP servers (documentation, memory, etc.)
- Create global coding standards
- Understand workflow optimization (Sonnet → Haiku, plan mode, etc.)
- Master key commands and features

---

## Why This Matters

**Without proper Claude Code setup:**
- Waste 50-90% more tokens re-explaining context every session
- Pay $3/million tokens (Sonnet) for tasks that could use $0.25/million (Haiku)
- Spend 10-20 minutes per session remembering commands and patterns
- Lack consistent coding standards across projects

**With this one-time setup:**
- Save 50-95% on token costs through model switching (Sonnet → Haiku workflow)
- Persistent context via global standards and MCP servers
- Consistent workflow across ALL projects (one-time effort, permanent benefits)
- Access to advanced capabilities (memory, sequential thinking, GitHub integration)

**Time investment:** 45-60 minutes now
**Projected savings:** $50-200/month in token costs + 2-4 hours/month in setup time

---

## Prerequisites

- [ ] macOS, Linux, or Windows
- [ ] Node.js installed (for MCP servers)
- [ ] Basic familiarity with terminal/command line
- [ ] (Optional) GitHub account for GitHub MCP

---

## Step 1: Install Claude Code (10 minutes)

### Download and Install

Claude Code is available in **two interfaces** with identical functionality:

#### Option 1: Claude Code CLI (Command-Line Interface)

Best for terminal-centric workflows.

**Installation:**
```bash
# macOS/Linux
curl -fsSL https://code.claude.com/install.sh | sh

# Verify installation
claude --version
```

**Usage:**
```bash
cd /path/to/your/project
claude  # Starts Claude Code in terminal
```

#### Option 2: Claude Code VS Code Extension

Best for IDE-integrated workflows.

**Installation:**
1. Open VS Code
2. Go to Extensions (Cmd+Shift+X / Ctrl+Shift+X)
3. Search for "Claude Code"
4. Click Install

**Usage:**
- Open any project in VS Code
- Claude Code panel appears automatically
- Same commands, same CLAUDE.md, same .claude/ configuration

---

**VS Code Extension Advanced Features** (v2.0+):

**Layout Customization:**
- **Secondary Sidebar** (VS Code 1.97+): Display Claude in right sidebar while keeping file explorer on left
  - Set "sidebar" as Preferred Location in settings
- **Preferred Location**: Choose where Claude opens by default
  - `sidebar` = Vertical panel (better for long conversations, file mentions)
  - `panel` = Bottom panel (better for quick questions, terminal-centric workflows)

**Keyboard Shortcuts:**
- `Cmd+N` / `Ctrl+N` → Start new conversation
- `Tab` → Toggle thinking display
- `Esc Esc` (twice) → Rewind changes

**Quality of Life:**
- Auto-submit single-select questions (no extra review screen)
- Terminal progress bar toggle (OSC 9;4 support)
- Real-time diffs (see changes before accepting)

---

**💡 Choose based on preference** - Both interfaces use the same configuration files (CLAUDE.md and .claude/). You can switch between them anytime without reconfiguration.

### Initial Configuration

```bash
# Start Claude Code for the first time
claude

# This will:
# - Create ~/.claude/ directory for global settings
# - Prompt for API key (if needed)
# - Set up initial configuration
```

---

## Step 2: Understand the Configuration Hierarchy (5 minutes)

Claude Code loads settings in this order:

**1. Global Settings** (`~/.claude/settings.json`)
- Applies to ALL projects
- Machine-wide defaults
- Global MCP servers

**2. User Settings** (varies by OS)
- User-specific preferences
- Rarely needed

**3. Project Settings** (`./.claude/settings.json` in project root)
- Project-specific overrides
- Per-project MCP servers
- Takes precedence over global

**Example:**
```
~/.claude/settings.json (global)
  ├─ MCP: memory, filesystem (available everywhere)
  └─ Model: sonnet, permissions: plan mode

./my-project/.claude/settings.json (project)
  ├─ MCP: project-specific database, Context7 with project API key
  └─ Inherits: memory, filesystem from global
```

---

## Step 3: Set Up Global Coding Standards (10 minutes)

Create a global coding standards file that applies to ALL your projects:

```bash
# Create global standards file
mkdir -p ~/.claude
touch ~/.claude/coding-standards.md
```

**Edit `~/.claude/coding-standards.md`:**

```markdown
# Global Coding Standards

These standards apply to ALL projects unless overridden by project-specific CLAUDE.md.

## Universal Rules

### Indentation
- **Always use 4 spaces** (never tabs)
- Consistency is critical for readability

### Algorithm Thinking
- **Apply Big O notation** to all logic
- Target: O(1), O(log n), O(n), or O(n log n)
- **Avoid O(n²) or worse** unless explicitly required
- Use efficient data structures:
  - HashMap/Set for O(1) lookups
  - Avoid nested iterations on same dataset

### Code Quality
- **Edge cases:** Handle n=0, very large n, null/undefined/None
- **Clear naming:** Variables and functions should explain themselves
- **Comments:** Only where logic is non-obvious
- **No magic numbers:** Use named constants

### Security (Universal)
- **Never commit:** .env, credentials, API keys, passwords
- **SQL Safety:** Use parameterized queries ONLY (never string concatenation)
- **Input Validation:** Validate all user input
- **Error Messages:** Don't expose internal details to users

## Language-Specific Conventions

### TypeScript/JavaScript
- Use `const` by default, `let` only when reassignment needed
- Avoid `var`
- Prefer arrow functions for callbacks
- Use async/await over .then() chains

### Python
- Follow PEP 8
- Use type hints for function signatures
- Prefer list comprehensions for simple transformations

### Go
- Follow `gofmt` formatting
- Handle errors explicitly (don't ignore)
- Use meaningful error messages

## Testing Standards
- **Minimum coverage:** 80%
- **Test edge cases:** Empty input, null, very large values
- **Test error cases:** What happens when things go wrong?
- **Meaningful tests:** Test behavior, not implementation

## Documentation
- **Self-documenting code:** Clear names, obvious logic
- **Comments:** Explain WHY, not WHAT
- **TSDoc/JSDoc/docstrings:** For public APIs only

---

**Last Updated:** 2025-12-04
**Note:** Individual projects can override these in their CLAUDE.md files.
```

**Why This Matters:**
- Every project you work on will automatically follow these standards
- Claude Code reads this file automatically
- Saves you from documenting the same rules in every project
- Project-specific CLAUDE.md files can override when needed

---

## Step 4: Install Global MCP Servers (20 minutes)

MCP servers extend Claude Code's capabilities. Install these globally to use across ALL projects.

### Recommended Global MCP Servers

**Tier 1 (Core - Already Included):**
1. **Memory MCP** - Context persistence across sessions
2. **Sequential Thinking MCP** - Better reasoning for complex problems
3. **Filesystem MCP** - Advanced file operations

**Tier 2 (Optional Workflow Enhancement):**
4. **GitHub MCP** - PR and issue management (requires GitHub token) - **Optional**, see note below
5. **Brave Search MCP** - Web search for documentation
6. **Fetch MCP** - Fetch and read web content

**Note on GitHub MCP:** Optional. Template author uses manual git workflow. Only install if you want Claude to create PRs/issues directly.

### Installation

**Create global MCP configuration:**
```bash
# Edit global Claude Code settings
nano ~/.claude.json
```

**Add MCP servers:**
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Set up environment variables:**
```bash
# Add to ~/.zshrc or ~/.bashrc
export GITHUB_TOKEN="your_github_token_here"
```

**Test MCP servers:**
```bash
claude

# In Claude Code, type:
/mcp

# You should see your installed MCP servers listed
```

**Detailed MCP Setup Guide:**
See [02_mcp-setup.md](../02_good-to-have/02_mcp-setup.md) for comprehensive installation instructions, including:
- Context7 MCP (documentation lookup - project-specific)
- Database MCPs (project-specific)
- Custom MCP servers

---

## Step 5: Understand Workflow Optimization (10 minutes)

### Model Switching Strategy

**Save 50-90% on token costs** by switching models strategically:

**Sonnet 4.5** ($3 per million tokens)
- Use for: Planning, architecture, complex reasoning
- When: Start of tasks, design decisions, understanding requirements

**Haiku 4.5** ($0.25 per million tokens - 92% cheaper!)
- Use for: Implementation, repetitive tasks, simple changes
- When: After plan is approved, routine coding

**Opus 4.5** ($15 per million tokens)
- Use for: Very complex reasoning, critical decisions
- When: Rarely - only for hardest problems

**How to Switch:**
```bash
# In Claude Code
/model sonnet    # For planning
/model haiku     # For implementation
/model opus      # For complex reasoning
```

**Example Workflow:**
```
1. Start with Sonnet: "Plan how to add user authentication"
2. Review plan, approve
3. Switch to Haiku: /model haiku
4. Implement: "Implement the authentication plan"
5. Save 92% on implementation tokens!
```

### Permission Modes

**Plan Mode** (Default - Recommended)
- Claude explores and plans FIRST
- No code changes without your approval
- Safer for complex tasks
- Set as default in settings

**Allow Mode**
- Claude can make changes immediately
- Faster for simple, trusted tasks
- Use when you're confident about the request

**Ask Mode**
- Claude asks before every action
- Most cautious, slower
- Good for learning

**How to Switch:**
```bash
/permissions plan   # Plan first, then execute
/permissions allow  # Execute immediately
/permissions ask    # Ask before every action
```

### Key Commands Reference

```bash
# Model management
/model [sonnet|haiku|opus]   # Switch models
/usage                        # Check plan limits

# Permission modes
/permissions [plan|allow|ask] # Change mode

# Utilities
/doctor                       # System health check
/mcp                          # List MCP servers
/help                         # Full command reference

# Custom commands (project-specific)
/standards                    # View coding standards
/test                         # Run tests
/build                        # Build project
/review                       # Code review
/onboarding                   # Project onboarding
```

---

## Step 6: Configure Global Settings (5 minutes)

**Edit global settings:**
```bash
nano ~/.claude/settings.json
```

**Recommended global configuration:**
```json
{
  "model": "sonnet",
  "alwaysThinkingEnabled": true,
  "outputStyle": "concise",
  "permissions": {
    "defaultMode": "plan"
  },
  "sandbox": {
    "enabled": true,
    "excludedCommands": ["git", "docker", "npm", "python", "pytest", "pip"]
  }
}
```

**Explanation:**
- `model: sonnet` - Start with Sonnet for planning
- `alwaysThinkingEnabled: true` - Better reasoning quality
- `outputStyle: concise` - Less verbose responses
- `defaultMode: plan` - Always plan before executing
- `sandbox.enabled: true` - Security (can disable per command if needed)

---

## Step 7: Learn Best Practices (5 minutes)

### Token Optimization

**❌ Don't:**
```
"Can you look at my code and make it better?"
```
*Result: Claude reads entire codebase, 50K+ tokens*

**✅ Do:**
```
"Review src/services/auth.service.ts for security issues.
Focus on SQL injection and input validation.
Skip reading other files."
```
*Result: Claude reads 1 file, 2K tokens - 96% savings!*

### Project Memory (CLAUDE.md)

**Every project should have a CLAUDE.md file:**
- Documents what the project does (business purpose)
- Coding conventions
- Architecture patterns
- External API purposes

**Why:**
- Claude maintains context across sessions
- No need to re-explain every time
- 70-85% token savings per request

**You'll set this up per-project** (see next: [01_onboarding-guide.md](../../../02_project-onboarding/01_must-have/01_onboarding-guide.md))

### Prompt Efficiency

**Be specific:**
- ❌ "Add authentication"
- ✅ "Add JWT authentication to /api/users endpoint, following the pattern in auth.service.ts"

**Provide context:**
- ❌ "Fix the bug"
- ✅ "Fix SQL injection in UserModel.findById() at line 45. Use parameterized queries with ? placeholders."

**Tell Claude what to skip:**
- ❌ (Claude reads node_modules/, dist/, etc.)
- ✅ "Skip node_modules/, dist/, coverage/ - focus only on src/"

---

## Step 8: Test Your Setup (5 minutes)

**Verify everything works:**

```bash
# Start Claude Code
claude

# Test MCP servers
/mcp
# Should show: memory, filesystem, sequential-thinking, github, etc.

# Check settings
/doctor
# Should show: No issues found

# Test global standards
```

**Ask Claude:**
```
"What are the global coding standards I should follow?"
```

*Claude should reference ~/.claude/coding-standards.md*

**Test model switching:**
```bash
/model haiku
# Should confirm: "Switched to Haiku 4.5"

/model sonnet
# Should confirm: "Switched to Sonnet 4.5"
```

---

## You're All Set! 🎉

**What you've accomplished:**
- ✅ Installed Claude Code
- ✅ Set up global coding standards
- ✅ Installed essential MCP servers globally
- ✅ Configured optimal settings (Sonnet → Haiku workflow, plan mode)
- ✅ Learned key commands and best practices

---

## Next Steps

### For New Projects:
**→ Read [01_onboarding-guide.md](../../../02_project-onboarding/01_must-have/01_onboarding-guide.md)**

This shows you how to:
- Copy .claude/ configuration to a project
- Create project-specific CLAUDE.md
- Document business context
- Set up project-specific commands

### Keep Learning:

**Essential Reading:**
- [01_model-switching.md](../02_good-to-have/01_model-switching.md) - Deep dive on Sonnet → Haiku workflow
- [03_permission-modes.md](03_permission-modes.md) - When to use each mode
- [02_mcp-setup.md](../02_good-to-have/02_mcp-setup.md) - Advanced MCP configurations

**Advanced Topics:**
- [02_optimization-guide.md](../../../02_project-onboarding/02_good-to-have/02_optimization-guide.md) - Token optimization strategies
- [01_security-guide.md](../03_nice-to-have/01_security-guide.md) - Security best practices
- [03_mcp-pollution.md](../02_good-to-have/03_mcp-pollution.md) - Avoid API key conflicts

---

## Troubleshooting

**MCP servers not appearing?**
```bash
# Check ~/.claude.json syntax
cat ~/.claude.json | jq .

# Restart Claude Code
claude
/mcp
```

**Settings not applying?**
```bash
# Check settings file
cat ~/.claude/settings.json

# Run diagnostics
/doctor
```

**Need help?**
- Run `/help` in Claude Code
- Check: https://code.claude.com/docs
- Review template guides in this directory

---

## Summary: What's Global vs Project-Specific

### Global (One-Time Setup - You Just Did This!)
- ✅ Claude Code installation
- ✅ Global coding standards (~/.claude/coding-standards.md)
- ✅ Global MCP servers (memory, filesystem, GitHub)
- ✅ Global settings (~/.claude/settings.json)
- ✅ Understanding of workflow optimization

### Project-Specific (Do This for Each Project)
- ⏭️ Copy .claude/ directory to project
- ⏭️ Create project CLAUDE.md (business context!)
- ⏭️ Set up project-specific slash commands
- ⏭️ Add project-specific MCP servers (database, Context7)
- ⏭️ Document project conventions

---

## ✅ You've Completed: Global Claude Code Setup

**What you accomplished:**
- Installed Claude Code (CLI or VS Code Extension)
- Set up global coding standards (~/.claude/coding-standards.md)
- Installed essential MCP servers (memory, sequential-thinking, filesystem, GitHub)
- Configured optimal settings (Sonnet → Haiku workflow, plan mode)
- Learned key commands and workflow optimization

**Next logical step:**

**Option A: Set Up Your First Project (30 min) - Recommended Next**
→ [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md) - Create CLAUDE.md, copy configuration

**Option B: Deep Dive on Model Switching (10 min)**
→ [Model Switching Guide](../02_good-to-have/01_model-switching.md) - Master the Sonnet → Haiku workflow

**Option C: Learn Permission Modes (5 min)**
→ [Permission Modes Cheat Sheet](03_permission-modes.md) - Plan vs Ask vs AcceptEdits

**Having trouble?** Run `/doctor` in Claude Code or check troubleshooting section above.

---

**Estimated next step time:** 5-30 minutes (depending on choice)
**Last Updated:** 2025-12-04
