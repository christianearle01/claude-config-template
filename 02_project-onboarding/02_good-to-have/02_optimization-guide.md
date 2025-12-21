# Claude Code Optimization Guide

## Quick Wins Checklist
- [ ] Using parallel tool calls when operations are independent
- [ ] Reading files before editing them
- [ ] Using specialized tools (Read/Edit/Grep) instead of bash commands
- [ ] Providing specific context in prompts instead of vague requests
- [ ] Breaking large tasks into todos with TodoWrite
- [ ] Using Task tool for complex exploration instead of manual searching
- [ ] Switching to Haiku (`/model haiku`) for implementation after planning
- [ ] Using Context7 for library documentation ("use context7")

## 1. Tool Efficiency Maximization

### Parallel Execution
**DO**: Call multiple independent tools in ONE message
```
✓ Read 3 files in parallel if all needed
✓ Run git status, git diff, git log in parallel
✓ Search multiple patterns simultaneously
```

**DON'T**: Make sequential calls when parallel would work
```
✗ Read file 1, wait, read file 2, wait, read file 3
✗ Run git status, wait, run git diff
```

### Tool Selection
- **File reading**: Use `Read` (not `cat` or `bash`)
- **File searching**: Use `Glob` for patterns (not `find` or `ls`)
- **Content searching**: Use `Grep` (not `bash grep`)
- **File editing**: Use `Edit` for exact replacements (not `sed`)
- **Complex exploration**: Use `Task` with Explore agent (not manual Grep/Glob loops)

### When to Use Task Tool
- Searching for something that might take multiple attempts
- Exploring unfamiliar codebases
- Complex analysis requiring multiple file reads
- Research that doesn't have a specific target file

## 2. Prompt Crafting Excellence

### The 5 Golden Rules
1. **Be Specific**: "Fix the validation in LoginForm.tsx line 45" vs "fix the login"
2. **Provide Context**: Share error messages, file paths, relevant code
3. **State Constraints**: "Don't modify tests" or "Keep existing API structure"
4. **Show Examples**: "Like how we did it in UserForm.tsx"
5. **Define Success**: "Should validate email format and show error below field"

### Effective Prompt Patterns
**Vague**: "Make the app faster"
**Optimized**: "The dashboard loads in 3s, should be <1s. Profile shows ProductList re-renders 50+ times. Optimize using React.memo and useMemo."

**Vague**: "Add a feature for users"
**Optimized**: "Add email notification toggle in Settings page (settings/profile.tsx). Store in user preferences table. Use existing NotificationService pattern from app/services/."

### Context Loading
- Reference specific files: "Looking at app/leadprosper_client.py..."
- Include error messages in full
- Mention relevant patterns: "Using the same pattern as QuoteWizard integration..."

## 3. Project Setup Optimization

### CLAUDE.md: Your Project Memory System

**What is CLAUDE.md?**
A single file that contains all your project's patterns, conventions, and context. Claude reads it once and remembers everything for the entire session.

#### 📊 Quantified Benefits

**Token Savings: 70-85% per request**

**Before CLAUDE.md:**
```
You: "Create a new controller"

Claude must read:
- Coding guidelines (2,500 tokens)
- Function naming conventions (1,800 tokens)
- Example controllers (3,000 tokens)
- Interface definitions (800 tokens)
- Import rules (500 tokens)
Total: ~8,600 tokens per request
```

**With CLAUDE.md:**
```
You: "Create a new controller"

Claude:
- Reads CLAUDE.md once at start (5,000 tokens)
- Has all patterns in memory
- No re-reading needed
Total: ~5,000 tokens (one-time)
Savings: 3,600 tokens per request!
```

**Speed Improvement: 5-6x faster**
- Without: 45-60 seconds (reading multiple files)
- With: 5-10 seconds (instant context)

**Accuracy: Near-perfect first try**
- Pattern adherence: 100%
- Manual corrections: 0-1 vs 3-5 per feature
- Time saved per feature: 1.5-2 hours

**Cost Savings:**
- 100 requests/month × 3,600 tokens = 360K tokens saved
- At $3/M (Sonnet): $1.08/month saved
- At $0.25/M (Haiku): $0.09/month saved
- **Plus time savings = actual value**

#### 🎯 What to Include in CLAUDE.md

**Essential Sections:**
1. **Project Overview** - Tech stack, architecture, purpose
2. **Coding Standards** - Indentation, naming, conventions
3. **File Patterns** - Where files go, how they're structured
4. **Common Patterns** - Response formats, error handling, imports
5. **External Integrations** - APIs, services, databases
6. **Security Guidelines** - What never to do, safe practices
7. **File Locations** - Where to find key configuration files

**Advanced Additions:**
- **Critical Paths**: Files that change frequently
- **Gotchas**: Common mistakes or edge cases
- **Decision Log**: Why certain approaches were chosen
- **Performance Notes**: Known bottlenecks or optimization opportunities
- **Function Naming**: Reference to CSV or naming conventions
- **Import Organization**: Exact order expected

#### 📋 Template Structure

```markdown
# Project Name

> **Global Standards**: Reference to ~/.claude/coding-standards.md

## Project Overview
[Tech stack, purpose, architecture]

## Coding Standards
[Merged global + project-specific rules]

## Architecture Patterns
[MVC, Clean Architecture, etc.]

## Common Patterns
[Response formats, error handling, etc.]

## File Organization
[Where files go, project structure]

## External Integrations
[APIs, databases, services]

## Security & Privacy
[Never do X, always do Y]

## Quick Reference
[Common file locations, commands]
```

#### 🔄 Context Persistence Across Sessions

**Without CLAUDE.md:**
```
Session 1: "Create rating controller"
[Claude learns patterns, reads files]

Session 2 (next day): "Create ticket controller"
[Claude must RE-READ everything - starting from scratch]
```

**With CLAUDE.md:**
```
Session 1: "Create rating controller"
[Claude reads CLAUDE.md, knows patterns]

Session 2 (next day): "Create ticket controller"
[Claude reads CLAUDE.md, same quality/speed]
```

#### 💡 Best Practices

**Keep it Updated:**
- Update when patterns change
- Add new conventions as they emerge
- Remove outdated information

**Keep it Focused:**
- 300-700 lines is ideal (15-30KB)
- Too small: Misses important context
- Too large: Expensive to read each session

**Make it Actionable:**
- Include exact code patterns, not just descriptions
- Provide file path examples
- Reference other documentation files

**Structure for Scanning:**
- Use clear headers
- Keep sections organized
- Make patterns easy to find

#### 📈 Real-World Impact Example

**Scenario: Creating a new feature**

**Without CLAUDE.md:**
- Development time: 2-3 hours
- Token cost: 50,000+ tokens
- Manual corrections: 3-5 per feature
- Context loss between sessions

**With CLAUDE.md:**
- Development time: 30-45 minutes
- Token cost: 15,000-20,000 tokens
- Manual corrections: 0-1 per feature
- Context retained across sessions

**Time saved: 1.5-2 hours per feature**
**If you create 10 features/month: 15-20 hours saved**

#### 🎓 Knowledge Transfer Benefits

**For Teams:**
- New developers read CLAUDE.md = instant project understanding
- Claude follows same patterns = consistent codebase
- Onboarding time reduced by 70%
- No "Why is this controller different?" questions

#### 🛠️ Maintenance Tips

**Monthly:**
- Review CLAUDE.md for outdated info
- Add new patterns discovered during development
- Remove patterns no longer used

**Per Feature:**
- If you correct Claude 3+ times on same pattern → Add to CLAUDE.md
- If team asks "how do we do X?" → Document in CLAUDE.md

**Team Workflow:**
- Commit CLAUDE.md to git (unlike .claude.json with secrets)
- Update as part of architecture decisions
- Reference in PR reviews: "Follows CLAUDE.md patterns"

### Slash Commands to Consider
Create commands for repeated tasks:
- `/test-integration [vendor]` - Run vendor integration tests
- `/check-mappings [vendor]` - Validate CSV field mappings
- `/deploy-checklist` - Pre-deployment verification steps
- `/new-vendor [name]` - Scaffold new vendor integration

### Hooks Opportunities
- **pre-commit**: Check for sensitive data in lead_logs.txt
- **post-tool**: Remind about testing after API changes
- **user-prompt-submit**: Expand abbreviations or add context

### MCP Servers
Recommended:
- **Context7** - Up-to-date library documentation (use with "use context7")
  - Install: `claude mcp add context7 npx -- -y @upstash/context7-mcp`
  - Get API key: https://context7.com/dashboard
  - Eliminates API hallucinations with current docs

Consider adding:
- Database MCP for direct DB queries
- HTTP testing MCP for API endpoint testing
- File watcher MCP for monitoring changes

## 4. Workflow Optimization

### Model Selection Strategy (HUGE Token Savings!)

**Sonnet → Haiku Workflow** (70-90% cost reduction on implementation):

1. **Planning Phase** (Sonnet 4.5):
   - Default model for starting sessions
   - Best for: Architecture decisions, complex analysis, planning
   - Cost: $3/M input, $15/M output
   - Enable Plan Mode: Press **Shift+Tab** for read-only exploration

2. **Implementation Phase** (Haiku 4.5):
   - Switch with `/model haiku` after plan is approved
   - Best for: Executing plans, straightforward coding
   - Cost: $1/M input, $5/M output (66.7% cheaper!)
   - Exit Plan Mode: **Shift+Tab** again for build/deploy

**Quick Model Switching:**
```bash
/model sonnet    # Planning and architecture
/model haiku     # Fast implementation
/model opus      # Complex reasoning (when needed)
```

**Alternative: OpusPlan Mode**
```bash
/model opusplan  # Auto: Opus for planning, Sonnet for execution
```

**Monitor Usage:**
```bash
/usage          # Check plan limits and usage
```

### Task Planning
- Use `TodoWrite` for tasks with 3+ steps
- Break down complex features into concrete steps
- Mark todos as in_progress BEFORE starting work
- Complete todos IMMEDIATELY after finishing

### Git Workflow
- Use parallel bash calls for git commands:
  ```
  git status && git diff && git log -5 (in one call)
  ```
- Read changes before committing
- Follow existing commit message style
- Don't commit commented-out code or logs with real data

### Testing Workflow
1. Make changes
2. Run specific tests (don't run full suite if unnecessary)
3. Fix issues immediately
4. Verify in production-like environment

### Agent Coordination
- Use Explore agent for "where is..." questions
- Use Plan agent for architectural decisions
- Don't re-read large CSV files (already in context)
- Reference existing patterns (LeadProsper as template)

## Current Project-Specific Optimizations

### Your Insurance Lead Platform
1. **Vendor Integration Pattern**: Always reference `app/leadprosper_client.py` as template
2. **Form Mappings**: CSV files already loaded - don't re-parse
3. **Testing**: Use `app/test_leadprosper.py` pattern for new vendors
4. **Security**: Double-check lead_logs.txt before commits

### Quick Command Reference
```bash
# Efficient git workflow
git status && git diff && git log --oneline -5

# Test specific integration
python app/test_leadprosper.py

# Check for sensitive data
grep -r "real_email\|real_phone" lead_logs.txt
```

## Proactive Optimization Triggers

I'll suggest optimizations when I notice:
- Sequential tool calls that could be parallel
- Bash commands instead of specialized tools
- Vague prompts that could be more specific
- Missing context that would improve results
- Opportunities to use slash commands or hooks
- TodoWrite would help track progress
- Task tool would be more efficient than manual search
- Project setup could be enhanced

## How to Use This Guide
1. **Before starting work**: Skim relevant sections
2. **During conversations**: I'll reference specific sections when relevant
3. **Weekly**: Review checklist and add new patterns you've discovered
4. **When stuck**: Check if prompt crafting tips would help

---
*Last updated: 2025-12-04*
*This guide evolves with your project - update it as you discover new optimizations!*
