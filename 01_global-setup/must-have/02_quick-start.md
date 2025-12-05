# Quick Start Guide - Claude Code Template

Get up and running with optimized Claude Code configuration in 15 minutes.

## 📋 Setup Progress Checklist

**Track your setup progress:** Check off items as you complete them. Claude can read this checklist to help you pick up where you left off.

### Essential Setup (Required)
- [ ] **Part 1.1:** Claude Code installed and authenticated
- [ ] **Part 1.2:** Permission mode set to "plan"
- [ ] **Part 2.1:** `.claude/` directory structure created
- [ ] **Part 2.2:** `settings.json` configured
- [ ] **Part 2.3:** `CLAUDE.md` customized with project details
- [ ] **Part 2.4:** `.gitignore` updated with Claude Code patterns
- [ ] **Part 3:** Verified setup with `/config` command

### Optional Enhancements (Choose What You Need)
- [ ] **MCP Servers:** Installed (Sequential Thinking, Memory, Filesystem, Fetch)
- [ ] **Security Hooks:** Decision made (install, skip, or defer)
  - [ ] If installed: `detect-prompt-injection.js` copied and configured
- [ ] **Custom Agents:** Prompt Polisher agent installed
- [ ] **Slash Commands:** Created custom commands for your workflow
- [ ] **Documentation:** Copied reference guides to project (optional)

### Team Setup (If Working with Team)
- [ ] **CLAUDE.md** committed to git for team consistency
- [ ] **Team onboarding:** Shared TEAM_ONBOARDING.md with team
- [ ] **Coding standards:** Global standards configured in `~/.claude/`

---

**💡 Tip for Claude:** If user says "continue the setup" or "where did we stop", read this checklist to see what's completed and what remains.

---

## 🎯 What You'll Achieve

By the end of this guide, you'll have:
- ✅ Claude Code configured for 70-90% token savings
- ✅ Project memory system (CLAUDE.md) set up
- ✅ Sonnet→Haiku workflow ready to use
- ✅ Optional: MCP servers, security hooks, custom agents

---

## ⚡ Quick Start: Top 3 Shortcuts

**Learn these first** - they'll save you time and prevent mistakes:

```
┌──────────────────────────────────────────────────────────┐
│  ESSENTIAL KEYBOARD SHORTCUTS (Claude Code 2.0+)         │
├──────────────────────────────────────────────────────────┤
│  Esc Esc (twice)     → Undo last changes (Rewind)       │
│  Ctrl-b              → Run command in background         │
│  Tab                 → Show/hide thinking process        │
├──────────────────────────────────────────────────────────┤
│  💡 These work in BOTH CLI and VS Code Extension        │
└──────────────────────────────────────────────────────────┘
```

**Why these matter:**
1. **Esc Esc** - Safety net for experiments (undo without git)
2. **Ctrl-b** - Keep working while tests/builds run
3. **Tab** - Learn Claude's reasoning process

**More shortcuts available** in the [Keyboard Shortcuts & Productivity](#keyboard-shortcuts--productivity) section below.

---

## Part 1: First-Time Setup (One Time Only)

### Step 1: Verify Claude Code Installation

```bash
claude --version
# Should show: 2.0.58 or higher
```

**Don't have Claude Code?** Install from: https://claude.com/download

### Step 2: Check Your Authentication

```bash
claude
# Should start without asking for login
# If it asks for login, follow the OAuth flow
```

### Step 3: Configure Permission Mode (Important!)

**Before setting up your workspace, configure Claude Code to show you what it's doing:**

```bash
# Start Claude Code
claude

# Set permission mode to "plan" (recommended for setup)
# Press Shift+Tab until you see: ⏸ plan mode on
```

**Why this matters:**
- ✅ **Plan mode** = Claude shows you what it will do BEFORE making changes
- ✅ You can review and approve each step
- ✅ Perfect for learning and understanding the setup process
- ❌ **Avoid "acceptEdits" mode during setup** = Claude makes changes automatically without showing you

**How to toggle modes:**
```
Press Shift+Tab repeatedly to cycle through:
1. 🔓 acceptEdits mode (auto-applies changes) ← AVOID during setup
2. ⏸ plan mode (shows plan first) ← USE THIS
3. ❓ ask mode (asks permission for each tool) ← Alternative option
```

**Tip:** Your template already sets `"defaultMode": "plan"` in settings, so you're protected!

### Step 4: Set Up Context7 (Optional but Recommended)

Context7 provides up-to-date library documentation and eliminates API hallucinations.

```bash
# Add Context7 MCP server
claude mcp add context7 npx -- -y @upstash/context7-mcp

# Get your API key (free tier available)
# Visit: https://context7.com/dashboard

# The key will be added to your project's .claude.json automatically
```

---

## Part 2: Set Up a New Project (Per Project)

> **🎓 Learning Mode Reminder:**
> Before starting setup, make sure you're in **Plan Mode** (⏸) so you can see and understand every change.
> Press **Shift+Tab** to toggle modes. Avoid "acceptEdits mode" during initial setup!

### Step 1: Copy Template Files

```bash
# Navigate to your project
cd /path/to/your/project

# Copy Claude Code configuration
cp -r ~/Developer/claude-config-template/.claude .

# Copy CLAUDE.md template
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# Verify files copied
ls -la .claude/
ls -la CLAUDE.md
```

**What you just copied:**
- `.claude/settings.json` - Optimized Claude Code settings
- `.claude/agents/` - Custom subagents (optional)
- `.claude/commands/` - Custom slash commands (optional)
- `CLAUDE.md` - Project memory template

### Step 2: Customize CLAUDE.md

Open `CLAUDE.md` and fill in your project details:

```bash
# Use your favorite editor
code CLAUDE.md
# or
vim CLAUDE.md
# or
nano CLAUDE.md
```

**Required changes:**
1. Replace `[PROJECT NAME]` with your actual project name
2. Fill in **Tech Stack** section
3. Document **Code Style & Conventions**
4. Add **Common Commands** for your project
5. Update **Project Structure** paths

**Example:**
```markdown
# Project Memory - E-Commerce API

## Tech Stack
- Language: Python 3.11
- Framework: FastAPI
- Database: PostgreSQL 15
- Cache: Redis
- Queue: Celery

## Common Commands
- Start development: `uvicorn main:app --reload`
- Run tests: `pytest -v`
- Migrations: `alembic upgrade head`
```

### Step 3: Configure Context7 API Key (If Using)

If you set up Context7 in Part 1, add your API key to the project:

```bash
# The Context7 MCP server is already configured in .claude/settings.json
# Just need to add your API key to .claude.json (created automatically)

# When you first run Claude Code, it will prompt for the API key
# Or manually add it to your project's .claude.json:
```

The `.claude.json` file will be created in your project root with the Context7 configuration.

### Step 4: Commit Configuration to Git

```bash
# Add Claude Code configs to version control
git add .claude/ CLAUDE.md
git commit -m "Add Claude Code configuration

- Optimized settings for token efficiency
- Project memory system (CLAUDE.md)
- Context7 MCP integration for documentation
- Custom agents and commands

🤖 Generated with Claude Code"
```

**Important:** Make sure `.claude.json` is in your `.gitignore` (API keys should not be committed).

---

## Part 3: Start Using Claude Code

### Step 1: Launch Claude Code

```bash
cd /path/to/your/project
claude
```

You should see:
- Claude Code loads your project
- Reads CLAUDE.md for context
- Ready to code with optimized settings

**⚠️ IMPORTANT: Check Permission Mode**

Before doing anything, verify you're in the right mode:

```bash
# Look at the bottom of your Claude Code window
# You should see one of these indicators:

⏸ plan mode on      ← ✅ GOOD - Shows plans before executing
❓ ask mode on       ← ✅ OK - Asks permission for each action
🔓 acceptEdits mode  ← ⚠️ CAUTION - Auto-applies changes (use for speed, not learning)
```

**If you see "acceptEdits mode":**
- Press **Shift+Tab** to cycle to "plan mode"
- This ensures you see and understand every change
- Perfect for setup and learning

**When to use each mode:**
- **Plan mode** (⏸): Setup, learning, complex tasks
- **Ask mode** (❓): Maximum control, sensitive operations
- **AcceptEdits mode** (🔓): Speed, after you're comfortable

### Step 2: Verify Configuration

```bash
# Inside Claude Code, run:
/doctor

# Should show:
# ✅ Settings loaded
# ✅ CLAUDE.md found
# ✅ Context7 MCP connected (if configured)
```

### Step 3: Test Your Workflow

Try these commands to verify everything works:

**1. Test Context7 (if configured):**
```
You: "How do I use React Server Components? use context7"
Claude: [Fetches latest React docs from Context7]
```

**2. Test Model Switching:**
```
You: "/model haiku"
Claude: [Switches to Haiku - 92% cheaper!]

You: "/model sonnet"
Claude: [Back to Sonnet for planning]
```

**3. Check Usage:**
```
You: "/usage"
Claude: [Shows plan limits and usage]
```

**4. Test Plan Mode:**
```
Press: Shift+Tab
Result: Toggles Plan Mode (read-only exploration)
```

---

## Part 4: Optimize Your Workflow

### The Sonnet→Haiku Pattern (70-90% Savings)

**Planning Phase (Use Sonnet):**
```
You: "Plan how to add user authentication with OAuth"

Claude (Sonnet):
- Explores your codebase
- Analyzes existing patterns
- Creates comprehensive plan
- Presents options

Cost: ~10K tokens × $3 = $0.03
```

**Implementation Phase (Switch to Haiku):**
```
You: "/model haiku"
You: "Implement the OAuth plan"

Claude (Haiku):
- Follows the plan
- Writes code efficiently
- Makes targeted changes

Cost: ~50K tokens × $1.25 = $0.0625
vs
Cost with Sonnet: ~50K tokens × $15 = $0.75

SAVINGS: 88%
```

### Using Plan Mode

Press **Shift+Tab** to enable Plan Mode:
- Claude can only read files (no modifications)
- Perfect for exploration and planning
- Prevents accidental changes
- Switch back with **Shift+Tab** when ready to implement

---

## Part 4.5: Checkpointing & Rewind System

> **Available in:** Claude Code v2.0+
> **Interfaces:** CLI and VS Code Extension

### What is Checkpointing?

Claude Code automatically saves your code state before making changes, creating checkpoints that allow you to safely experiment and undo mistakes instantly.

**Think of it as:**
- ⏪ **Undo button for AI changes** - Press `Esc` twice to revert
- 🛡️ **Safety net for experiments** - Try risky refactors without fear
- ⚡ **Instant rollback** - No git commands needed for session-level undo

### How to Use

**Undo Changes (Rewind):**

```bash
# Method 1: Keyboard shortcut (fastest)
Press Esc twice → Reverts to last checkpoint

# Method 2: Command
/rewind → Same effect, uses command interface
```

**When Checkpoints are Automatically Created:**
- ✅ Before each file edit
- ✅ Before running potentially destructive commands
- ✅ Before major refactoring operations
- ✅ When Claude uses the Write or Edit tools

### Checkpoints vs Git Commits

**Important:** Checkpoints are NOT a replacement for git. Here's when to use each:

| Feature | Checkpoints | Git Commits |
|---------|-------------|-------------|
| **Purpose** | Session-level undo | Long-term version control |
| **Scope** | Current Claude session only | Permanent project history |
| **Speed** | Instant (Esc Esc) | Requires commit message |
| **Persistence** | Lost when session ends | Permanent |
| **Best for** | Experiments, quick undo | Milestones, team collaboration |
| **Team sharing** | ❌ Local only | ✅ Push to share |

**⚠️ Best Practice:** Use checkpoints for quick undo during a session, but always commit important changes to git for long-term safety and team collaboration.

### Best Practices

1. **Experiment freely** - Checkpoints make it safe to try new approaches without fear
   - "Try refactoring this function 3 different ways"
   - "What if we used a different architecture?"

2. **Review before accepting** - Use plan mode to preview changes first, then checkpoint auto-saves
   - Press `Shift+Tab` to enter plan mode
   - Review the proposed changes
   - Accept → checkpoint created automatically

3. **Combine with git** - Checkpoints for exploration, git for milestones
   - Checkpoint: Quick undo during experimentation
   - Git commit: When you've achieved something worth saving permanently

4. **Don't rely on checkpoints for team work** - Always commit to git for team visibility
   - Checkpoints = your personal undo buffer
   - Git commits = shared team history

### Example Workflow

**Scenario: Refactoring a complex function**

```bash
# 1. Ask Claude to refactor
You: "Refactor the calculateTotal function to use reduce"

# 2. Claude makes changes automatically
#    ✅ Checkpoint created before changes

# 3. You review the changes and don't like them
#    Press: Esc Esc

#    Result: Changes reverted instantly!

# 4. Try a different approach
You: "Actually, refactor it using a for loop instead"

# 5. This time it looks good!
#    Commit to git for permanent history
git add src/utils/calculator.ts
git commit -m "Refactor calculateTotal to use for loop"
```

### Try It Now: Practice Box

**Safe practice exercise** (won't harm your project):

1. Create a test file: `echo "function test() { return 'original'; }" > test-checkpoint.js`
2. Ask Claude: "Change the return value to 'modified'"
3. Verify the change: `cat test-checkpoint.js`
4. Undo it: Press `Esc` twice
5. Verify the revert: `cat test-checkpoint.js` (should show "original")
6. Clean up: `rm test-checkpoint.js`

**What you learned:**
- ✅ Checkpoints happen automatically
- ✅ `Esc Esc` instantly reverts changes
- ✅ No git commands needed for quick undo

### Troubleshooting

**Issue: Esc twice doesn't work**

Possible causes:
1. **Not in a Claude Code session** - Checkpoints only work during active Claude sessions
2. **No changes made yet** - Need at least one tool use to create a checkpoint
3. **Session restarted** - Checkpoints don't persist across sessions

**Fix:** Make a change first (any file edit), then try `Esc Esc` or `/rewind`

**Issue: Want to undo multiple changes**

Unfortunately, checkpoints only save the most recent state. For multi-level undo:
- Use git commits between major changes
- Create manual git checkpoints: `git add . && git commit -m "WIP checkpoint"`

### Knowledge Check

Test your understanding:

- [ ] **Can explain:** What's the difference between checkpoints and git commits?
- [ ] **Can demonstrate:** Press `Esc` twice to undo a change
- [ ] **Can describe:** When are checkpoints automatically created?
- [ ] **Know when to use:** Checkpoints for quick undo, git for permanent history

---

## Part 4.6: Keyboard Shortcuts & Productivity

> **Available in:** Claude Code v2.0+
> **Interfaces:** CLI and VS Code Extension

Master these shortcuts to work faster and smarter with Claude Code.

### Background Tasks (Ctrl-b)

Run long-running Bash commands without blocking Claude's work.

**How it works:**
```bash
# Instead of:
npm run test  # Blocks Claude until tests finish

# Use:
Ctrl-b npm run test  # Runs in background, Claude keeps working
```

**When to use background tasks:**
- 🧪 **Test suites** - Run tests while implementing new features
- 🏗️ **Build processes** - Start builds while continuing conversation
- 🚀 **Dev servers** - Launch server, keep coding
- 📊 **Log monitoring** - Tail logs without blocking Claude

**Practical examples:**

```bash
# Start dev server in background
Ctrl-b npm run dev

# Continue working immediately
You: "Now let's add the authentication feature"
Claude: [Works on auth while server runs in background]

# Run full test suite in background
Ctrl-b npm test

# Keep implementing while tests run
You: "Add error handling to the login function"
Claude: [Adds error handling, tests still running]
```

**How to check background task status:**
- Background tasks run in separate shell
- Check terminal output in separate window
- Or ask Claude: "What's the status of my background tasks?"

**How to stop a background task:**
- Find the process: `ps aux | grep [process-name]`
- Kill it: `kill [PID]`
- Or use Claude: "Stop the background dev server"

### Toggle Thinking (Tab)

Press `Tab` to show/hide Claude's reasoning process.

**When to show thinking:**
- 📚 **Learning complex concepts** - See how Claude approaches problems
- 🐛 **Debugging issues** - Understand the investigation process
- 🏗️ **Architectural decisions** - See the reasoning behind choices
- 🎓 **First-time users** - Educational value, learn best practices

**When to hide thinking:**
- ⚡ **Speed is priority** - Less visual clutter
- ✅ **Simple tasks** - You already know what Claude will do
- 📝 **Documentation focus** - Cleaner output for copy-paste

**How it works:**
```
Press Tab once  → Show thinking
Press Tab again → Hide thinking

Current state visible at bottom of window
```

### Educational Output Styles

Enable special output modes when learning new concepts or onboarding to complex codebases.

**Two modes available:**

#### 1. Explanatory Mode
Detailed explanations with context for every change.

**Best for:**
- Understanding complex algorithms
- Learning new frameworks
- Onboarding to unfamiliar codebases
- Team training sessions

**Example output:**
```
Instead of: "Added error handling"

You get: "Added error handling using try-catch blocks because:
- The API call can fail due to network issues
- We need to show user-friendly messages
- The application should gracefully degrade
- This follows the project's error handling pattern in auth.ts"
```

#### 2. Learning Mode
Step-by-step breakdown with educational notes.

**Best for:**
- First-time learners
- Junior developers
- Understanding new patterns
- Teaching moments

**Example output:**
```
Instead of: "Refactored to use async/await"

You get: "Let's refactor step by step:

Step 1: Convert .then() to async/await
Why: Async/await is more readable and handles errors better

Step 2: Add try-catch for error handling
Why: Async functions can throw, we need to catch them

Step 3: Update return type
Why: Async functions always return Promises

Learning note: Async/await is syntactic sugar for Promises.
It makes asynchronous code look synchronous and easier to reason about."
```

**How to enable:**
```bash
# Request explanatory mode
You: "Explain this refactoring in detail"

# Request learning mode
You: "Teach me how this works step by step"

# Or just ask for either mode by name
You: "Use explanatory mode for this task"
You: "Use learning mode to help me understand"
```

**When to use each mode:**

| Mode | Best For | Avoid When |
|------|----------|-----------|
| **Explanatory** | Complex logic, architectural decisions | Simple changes, bulk operations |
| **Learning** | New patterns, onboarding | Time-critical tasks, production |
| **Normal** | Daily development, speed | Learning opportunities |

### Try It Now: Background Tasks

**Safe practice exercise:**

```bash
# 1. Start a long-running process in background
Ctrl-b sleep 10

# 2. Immediately ask Claude a question (without waiting)
You: "What's the difference between let and const?"

# 3. Notice: Claude answers immediately while sleep runs!

Result: You've successfully used background tasks
```

### Try It Now: Toggle Thinking

**Practice exercise:**

```bash
# 1. Press Tab to show thinking
# 2. Ask: "What's the best way to handle errors in async functions?"
# 3. Observe Claude's thinking process (visible)
# 4. Press Tab again to hide thinking
# 5. Ask same question again
# 6. Notice: Cleaner output without thinking

Result: You control how much detail you see
```

### Advanced Tips

**Combine shortcuts for power workflows:**

```bash
# 1. Show thinking to understand approach
Press Tab (thinking visible)

# 2. Ask complex question
You: "Refactor this module for better testability"

# 3. Review Claude's reasoning

# 4. Start tests in background
Ctrl-b npm test

# 5. Continue with implementation
You: "Now add the unit tests"

# 6. Hide thinking for cleaner output
Press Tab (thinking hidden)

# 7. Check test results later
You: "Did the background tests pass?"
```

### Troubleshooting

**Issue: Ctrl-b doesn't work**

- **In VS Code Extension:** Use the built-in terminal, not Claude's output panel
- **In CLI:** Should work by default
- **Alternative:** Ask Claude to run the command: "Run npm test in the background"

**Issue: Tab doesn't toggle thinking**

- **Check:** You're in an active Claude session
- **Try:** Type `/thinking` command instead
- **Check settings:** Ensure thinking is enabled in `.claude/settings.json`

### Knowledge Check

Test your understanding:

- [ ] **Can use:** Ctrl-b to run a command in background
- [ ] **Can toggle:** Tab to show/hide thinking
- [ ] **Can explain:** When to use Explanatory vs Learning mode
- [ ] **Can demonstrate:** Run tests in background while coding

**All checked?** You've mastered Claude Code productivity shortcuts!

---

## Part 5: Team Member Setup

If someone else already set up the template in your project:

```bash
# 1. Clone the repository
git clone <repo-url>
cd <project>

# 2. That's it! Start coding
claude
```

The `.claude/` directory and `CLAUDE.md` are already configured.

**Just add your Context7 API key** (if the team uses it):
1. Get key from: https://context7.com/dashboard
2. Add to project `.claude.json` when prompted

---

## 🎓 Next Steps

Now that you're set up:

1. **Learn Optimization Techniques**: Read [02_optimization-guide.md](../../../02_project-onboarding/good-to-have/02_optimization-guide.md)
2. **Master Prompt Writing**: Read [01_prompt-optimization.md](../../../02_project-onboarding/good-to-have/01_prompt-optimization.md)
3. **Explore Custom Agents**: Check `.claude/agents/` directory
4. **Create Slash Commands**: Add `.md` files to `.claude/commands/`

---

## 🆘 Troubleshooting

### Issue: Settings Not Loading

**Check:**
```bash
# Verify settings.json syntax
cd .claude/
cat settings.json | python -m json.tool

# Run diagnostics
claude
/doctor
```

**Fix:** Ensure valid JSON syntax in `.claude/settings.json`

### Issue: Context7 Not Working

**Check:**
```bash
# List MCP servers
claude
/mcp

# Should show context7 as "connected"
```

**Fix:**
- Verify API key in project `.claude.json`
- Check internet connection
- Context7 falls back to WebSearch automatically

### Issue: CLAUDE.md Not Loading

**Check:**
```bash
# Verify file exists in project root
ls -la CLAUDE.md

# Check file permissions
cat CLAUDE.md
```

**Fix:** Ensure `CLAUDE.md` is in the project root directory (not `.claude/`).

### Issue: Plan Mode Not Working

**Try:**
- Press **Shift+Tab** to toggle
- Look for indicator in Claude Code UI
- Check `.claude/settings.json` has `"permissions": {"defaultMode": "plan"}`

---

## 📊 Verify Your Setup

**Checklist:**
- [ ] Claude Code 2.0+ installed
- [ ] `.claude/settings.json` in project
- [ ] `CLAUDE.md` in project root
- [ ] Context7 MCP configured (optional)
- [ ] Can switch models with `/model`
- [ ] Plan mode works (Shift+Tab)
- [ ] `/usage` shows plan limits

**All checked?** You're ready to code efficiently with Claude!

---

## 🎯 Permission Mode Best Practices

### Understanding the Three Modes

**1. Plan Mode (⏸) - RECOMMENDED for Setup & Learning**
```
What it does: Claude creates a plan and shows it to you BEFORE executing
When to use: Initial setup, learning, complex tasks, team environments
Benefits:
  ✅ See every change before it happens
  ✅ Learn how Claude approaches problems
  ✅ Review and refine plans before execution
  ✅ Perfect for understanding your codebase changes
```

**2. Ask Mode (❓) - Maximum Control**
```
What it does: Claude asks permission for EVERY tool use
When to use: Sensitive operations, production environments
Benefits:
  ✅ Granular control over every action
  ✅ Review each file read/write individually
  ⚠️ Can be slow for repetitive tasks
```

**3. AcceptEdits Mode (🔓) - Speed Mode**
```
What it does: Claude automatically applies changes without showing you first
When to use: ONLY after you're comfortable, repetitive tasks, speed is critical
Cautions:
  ⚠️ Changes happen automatically
  ⚠️ You might miss important modifications
  ❌ NOT recommended during setup or learning
  ❌ NOT recommended for team onboarding
```

### How to Switch Modes

**Method 1: Keyboard Shortcut (Fastest)**
```
Press Shift+Tab repeatedly to cycle through modes
Look at the bottom of Claude Code window for the indicator
```

**Method 2: Settings File (Permanent)**
```json
{
  "permissions": {
    "defaultMode": "plan"  // or "ask" or "acceptEdits"
  }
}
```

### Real-World Examples

**❌ BAD: Using acceptEdits during setup**
```
User: "Set up my new project"
Claude: *Automatically creates 20 files, modifies configs*
User: "Wait, what did you just do?"
Result: No visibility, hard to learn, might need to undo
```

**✅ GOOD: Using plan mode during setup**
```
User: "Set up my new project"
Claude: "I'll create these files: [shows list and contents]"
User: *Reviews plan* "Looks good, proceed"
Claude: *Executes with your approval*
Result: Full visibility, learning opportunity, confident changes
```

**✅ GOOD: Switching to acceptEdits for speed (when ready)**
```
User: "I understand the pattern now, switch to acceptEdits"
User: "Update all 50 test files with this new import"
Claude: *Quickly updates all files*
Result: Fast execution, you already know what will happen
```

### Recommendation by Task Type

| Task Type | Recommended Mode | Reason |
|-----------|------------------|--------|
| Initial project setup | **Plan** | Learn what's being configured |
| First time using feature | **Plan** | Understand the approach |
| Complex refactoring | **Plan** | Review architectural changes |
| Repetitive updates | **AcceptEdits** | Speed up known patterns |
| Production deployment | **Ask** | Maximum safety |
| Learning new patterns | **Plan** | Educational value |
| Debugging | **Plan** | Understand the investigation |
| Bulk file operations | **AcceptEdits** | After verifying pattern |

### Quick Reference Card

```
┌─────────────────────────────────────────────────────┐
│  PERMISSION MODE QUICK REFERENCE                    │
├─────────────────────────────────────────────────────┤
│  Shift+Tab          → Toggle modes                  │
│  ⏸ plan mode        → Shows plan first (SETUP)     │
│  ❓ ask mode         → Asks for each tool (SAFE)    │
│  🔓 acceptEdits mode → Auto-applies (SPEED)         │
├─────────────────────────────────────────────────────┤
│  During Setup:  Use "plan" mode                     │
│  After Learning: Switch to "acceptEdits" for speed │
│  For Production: Use "ask" mode for safety         │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Your First Optimized Session

Try this workflow to see the benefits:

```
1. Start Claude Code: claude

2. Give a complex task:
   "Plan a REST API for user management with authentication"

3. Review the plan (Sonnet creates it)

4. Switch to Haiku:
   /model haiku

5. Execute:
   "Implement the plan you created"

6. Verify success:
   /usage  # Check your token usage
```

You should see significant token savings using this pattern!

**💡 Want to learn more about model switching?**
See [01_model-switching.md](../good-to-have/01_model-switching.md) for:
- When to switch models (and when not to)
- Token costs and prompt caching explained
- How to avoid wasting money on context transfers
- OpusPlan mode for automatic optimization

---

**Questions?** Check the comprehensive guides in `docs/` directory.

**Need help?** Run `/doctor` for diagnostics or review [03_team-onboarding.md](../../../02_project-onboarding/good-to-have/03_team-onboarding.md).

Happy coding! 🎉
