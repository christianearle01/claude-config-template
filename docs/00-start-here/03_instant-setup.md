# ⚡ Instant Setup (5 Minutes)

**For:** New users who want to start immediately
**Prerequisites:** Claude Code installed, basic git knowledge
**Learning Model:** Setup first, understand as you go
**Time:** 5-10 minutes

---

## The 4-Step Flow

### Step 1: Clone and Navigate

```bash
git clone https://github.com/christianearle01/claude-config-template
cd your-project-root
```

**What this does:** Downloads the template to reference during setup.

---

### Step 2: Feed Setup Context to Claude

**In your Claude Code session:**

Paste this prompt:
```
Read /path/to/claude-config-template/.claude/SETUP_CONTEXT.md

This file contains comprehensive setup documentation for the claude-config-template.
Use it to understand what global and project-level configurations are needed.
```

**Replace `/path/to/` with your actual path to the cloned template.**

**What this does:** Gives Claude the complete template knowledge in one shot.

---

### Step 3: Global Setup

**Prompt:**
```
Setup my global Claude Code configuration based on SETUP_CONTEXT.md.

Please:
1. Configure recommended settings in ~/.claude/settings.json
2. Install and configure these MCP servers:
   - filesystem (for file operations)
   - memory (for knowledge graph)
3. Explain what you're configuring and WHY each setting matters

Show me the configuration changes and explain the rationale.
```

**What this does:**
- Creates `~/.claude/settings.json` with optimized settings
- Installs recommended MCP servers (filesystem, memory)
- Claude explains each configuration choice

**Expected duration:** 2-3 minutes

---

### Step 4: Project Setup

**Prompt:**
```
Setup project-based Claude Code configuration for this [PROJECT_TYPE] project.

Please:
1. Create .claude/settings.json with project-specific settings
2. Create CLAUDE.md from template (customize for my project)
3. Setup relevant agents from template (don't copy all docs)
4. Show me what you configured

Important: Don't copy unnecessary documentation files to my project.
```

**Replace `[PROJECT_TYPE]` with:** JavaScript, Python, React, etc.

**What this does:**
- Creates `.claude/settings.json` in your project
- Creates `CLAUDE.md` (your project memory file)
- Sets up recommended agents for your project type
- Claude shows you what was configured

**Expected duration:** 2-3 minutes

---

## ✓ Understanding Checkpoint

**After setup, Claude will explain:**

### What Settings Were Configured

**Global settings (~/.claude/settings.json):**
- `respectGitignore: true` - Prevents accidental exposure of secrets
- `alwaysThinkingEnabled: true` - Better code quality with minimal token cost
- `outputStyle: "concise"` - Brief, focused responses
- `permissions.defaultMode: "plan"` - Review changes before applying (learning mode)

**Project settings (.claude/settings.json):**
- Project-specific overrides (if needed)
- Custom sandbox exclusions for your tech stack

### Which MCP Servers Were Installed

**Filesystem MCP:**
- Fast file operations without bloating context
- Reduces token usage by 60-80% on file operations
- Auto-enabled for all file reads/writes

**Memory MCP:**
- Knowledge graph for project context
- Remembers entities, relationships across sessions
- Ask: "What do you remember about this project?" to test

### What Project Files Were Created

**CLAUDE.md** (Project root):
- Your project memory - evolves as you work
- Tells Claude your business purpose, tech stack, conventions
- Saves 95% tokens on context queries (20K → 200 tokens)

**.claude/settings.json**:
- Project-specific overrides
- Technology-specific configurations

**.claude/agents/** (optional):
- Custom agents for your workflow
- Only essential ones copied (not all documentation)

### How to Verify Everything Works

```bash
# Test 1: File operations
claude "List all .md files in this project"
# Should list files without errors

# Test 2: Memory MCP
claude "What do you remember about this project?"
# Should recall CLAUDE.md content

# Test 3: Settings validation
cat ~/.claude/settings.json
# Should show valid JSON with configured settings
```

---

## Next Steps

**Now that setup is complete, learn the fundamentals:**

### 1. ⚠️ [Anti-Patterns Guide](05_anti-patterns.md) - READ THIS FIRST
   - **#1 priority guide** (saves hours of frustration)
   - Common mistakes that cause 80-day disasters
   - How to avoid $150/session token costs
   - **Time:** 10 minutes
   - **Why:** Prevents project failure before it starts

### 2. 🚀 [Skills Paradigm](../01-fundamentals/02_skills-paradigm.md)
   - The future of Claude Code (Commands → Agents → Skills)
   - Understanding the paradigm shift
   - **Time:** 15 minutes
   - **Why:** Core mental model for AI-augmented coding

### 3. 📚 [Prompting Fundamentals](../01-fundamentals/07_prompting-fundamentals.md)
   - How AI actually works and why it matters
   - Meta-skill of clarity (applies to all AI tools)
   - **Time:** 15 minutes
   - **Why:** Better prompts = better results (10x improvement)

### 4. 📋 [Prompt Patterns](../01-fundamentals/08_prompt-patterns.md)
   - 10 copy-paste templates for common tasks
   - Context-Rich Request, Permission to Fail, Chain of Thought
   - **Time:** 10 minutes
   - **Why:** Immediate productivity boost with proven patterns

---

## Optional Deep Dives

**When you're ready to optimize further:**

- **[Settings Deep Dive](../../.claude/settings-explained.json)** - Every setting explained
- **[MCP Workflows](../03-advanced/04_advanced-mcp-workflows.md)** - Multi-tool orchestration
- **[Rules Directory](../01-fundamentals/05_rules-directory-guide.md)** - Modular rule management
- **[Environment Variables](../02-optimization/06_environment-variables.md)** - Runtime configuration
- **[Model Selection Strategy](../02-optimization/01_model-selection-strategy.md)** - When to use Opus/Sonnet/Haiku

---

## Troubleshooting

### "Setup failed with permission error"

**Problem:** Can't write to `~/.claude/` directory

**Check:**
```bash
ls -ld ~/.claude
```

**Solution:**
```bash
mkdir -p ~/.claude
chmod 755 ~/.claude
```

---

### "MCP server installation failed"

**Problem:** npm or python not found

**Check:**
```bash
which npm
which python3
```

**Solution:**
- **macOS:** `brew install node python`
- **Linux:** `apt-get install nodejs python3` or `yum install nodejs python3`
- **Windows:** Install from nodejs.org and python.org

**Verify:**
```bash
npm --version
python3 --version
```

---

### "Claude can't read SETUP_CONTEXT.md"

**Problem:** File path incorrect or permissions issue

**Check path:**
```bash
# Your command should look like:
# Read /Users/yourname/path/to/claude-config-template/.claude/SETUP_CONTEXT.md

# Verify file exists:
ls -l /path/to/claude-config-template/.claude/SETUP_CONTEXT.md
```

**Solution:** Use absolute path, not relative (~/... or full /Users/... path)

---

### "I want to understand settings better"

**This is normal!** Instant setup gets you productive fast, but understanding deepens with use.

**Options:**
1. **Read explanations:** `.claude/settings-explained.json` in the template
2. **Explore gradually:** Each time you use Claude, you'll understand one more setting
3. **Detailed path:** Continue with [Persona-Based Navigation](01_entry-points.md)

**Philosophy:** Learn by DOING (not by reading 40 guides first). Understanding comes from experience.

---

### "Setup worked but I'm not sure what to do next"

**Start with a simple task:**
```bash
claude "Create a simple Hello World program in [your language]"
```

**Then read Anti-Patterns:**
- Go to [Anti-Patterns Guide](05_anti-patterns.md)
- Spend 10 minutes learning what NOT to do
- This prevents 90% of common mistakes

**Build your first feature:**
- Pick a small task in your project
- Ask Claude to help
- Use Ctrl+O to review changes
- Commit when satisfied

---

## Why This Works

### Pedagogical Design

**Traditional approach (template before v4.27.0):**
- Read 40+ documentation files
- Choose between 5 persona paths
- Decision paralysis → abandonment
- Time: 28-52 minutes (if completed)

**Instant setup approach:**
- 4 simple steps
- Claude guides you through
- Understanding Checkpoint explains choices
- Time: 5-10 minutes
- **Learn by DOING, not by READING**

### Understanding Over Speed (Jake Nations Test)

**Instant setup is not "easy" (which bypasses learning).**

It's **"simple"** (one-fold, no entanglement):
- 4 steps, each with clear purpose
- Understanding Checkpoint teaches WHY
- Next steps guide prioritizes learning
- Optional deep dives available when needed

**You'll understand the setup BECAUSE you used it, not before.**

---

## Comparison with Persona-Based Setup

| Aspect | Instant Setup | Persona-Based |
|--------|---------------|---------------|
| **Time** | 5-10 minutes | 28-52 minutes |
| **Files to read** | 1 (this guide) | 5-10 guides |
| **Decision points** | 0 (automated) | 10+ (choose path) |
| **Learning model** | Do first, understand as you go | Understand first, then do |
| **Best for** | Immediate productivity | Deep comprehension |
| **Cognitive load** | Low (4 steps) | High (40+ files) |
| **Understanding** | Via checkpoint | Via detailed reading |

**Both paths are valid!** Choose based on your goal:
- **Instant setup:** "I need to start NOW"
- **Persona-based:** "I want to deeply understand first"

---

## Remember

**This instant setup gets you productive in 5 minutes.**

**Understanding deepens as you use the system.**

**The template's 40+ guides are available when you need them, not blocking you from starting.**

**Most users report:** "I learned more in 30 minutes of USING Claude Code than I did reading documentation for 2 hours."

---

**Next:** [Anti-Patterns Guide](05_anti-patterns.md) ← Read this next!
**Alternative:** [Entry Points Guide](01_entry-points.md) - Persona-based navigation
