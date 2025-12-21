# Custom Agents - Usage Guide

## Available Agents

### 🎨 prompt-polisher

**Purpose:** Transforms vague, inefficient prompts into optimized, context-rich requests using 12+ techniques. Teaches prompt engineering while polishing. Saves 50-80% tokens.

**When to use:**
- Before making any request to Claude (simple or complex)
- When you want to learn better prompting techniques
- To see how your prompt could be improved
- When you want to understand WHY improvements help

**The 3-Tier System:**

- **🎯 Tier 1: Core Rules** (always applied) - Be Specific, Provide Context, Reference Files, Tell What to Skip, Break into Steps
- **⚡ Tier 2: Power Techniques** (task-dependent) - @-mentions, CLAUDE.md references, Plan Mode, XML tags, Chain of Thought
- **🚀 Tier 3: Expert Techniques** (situational) - Few-shot examples, Output formats, Role/persona, Success criteria

**How to use:**

```bash
# In Claude Code, invoke with @-mention:
@prompt-polisher Fix the login bug

# The agent will:
1. Analyze your prompt (task type, complexity, current quality)
2. Select appropriate techniques intelligently
3. Return immediately usable polished version
4. Explain WHY each improvement helps
5. Teach you techniques for next time
6. Show expected token savings
```

**Example session:**

```
You: @prompt-polisher Fix the login bug

Agent:
## 📝 Original Prompt Analysis

**What you did well:** ✅
- Identified it's a bug fix task

**Opportunities for improvement:** 📈
- ❌ No file specified → Needs Specificity (#1)
- ❌ No description of bug → Needs Context (#2)
- ❌ No scope defined → Needs Skip Instructions (#4)

**Task type detected:** Debugging
**Complexity level:** Unknown (need details)
**Estimated cost:** 8,000 tokens

---

## ✨ Polished Prompt

Fix the login authentication bug in `app/auth/LoginController.ts`

**Issue:** Users with valid credentials get "Invalid password" error
**Occurs when:** Password contains special characters (!@#$%)
**Current behavior:** Line 67 compares plain text without encoding
**Expected behavior:** Passwords should be compared after UTF-8 encoding

**Context:**
- Using bcrypt for password hashing
- Special character encoding added in User model (line 34)
- LoginController not updated to match

**Fix needed:**
- Encode password input before bcrypt comparison
- Follow pattern from UserService.updatePassword() (line 120)

**Test with:** User email test@example.com, password "Pass!@#2024"

**Skip:** Other auth files (registration, password reset) - they work correctly

---

## 🔍 Improvements Made

**Tier 1 - Core Rules Applied:**
1. **Be Specific (#1)**: Added file path, line number, exact error, test case
2. **Provide Context (#2)**: Explained bcrypt usage, related model changes
3. **Reference Files (#3)**: Pointed to UserService pattern
4. **Tell What to Skip (#4)**: Excluded working auth files

---

## 📊 Expected Impact

**Original estimated cost:** 8,000 tokens
**Optimized estimated cost:** 1,200 tokens
**Savings:** 85% (6,800 tokens saved)

**Quality improvements:**
- Claude won't need to explore entire auth system
- Clear context prevents wrong solution approaches
- Reference pattern ensures consistency

---

## 💡 Technique Guide for Next Time

**What you learned today:**
- **Specificity (#1)**: File path + line number = Claude goes straight there
- **Context (#2)**: Explaining "why" prevents wrong solutions

**Try this next time:**
Add exact error message from logs if you have it!

**Level up opportunity:** 🚀
For debugging, try adding **Chain of Thought (#10)** - ask Claude to think step by step!
```

**What you learn:**
- 14 prompt optimization techniques across 3 tiers
- When to apply which techniques (intelligent selection)
- WHY each technique improves results
- How to write better prompts independently
- Progressive learning path (basic → power → expert)

**Key Features:**
- ✅ Works on ANY project (reads your CLAUDE.md if available)
- ✅ Intelligent technique selection (doesn't dump all 12 at once)
- ✅ Educational focus (teaches while polishing)
- ✅ Encourages growth (suggests next-level techniques)
- ✅ 5 diverse examples (debugging, features, reviews, refactoring, docs)

---

### 🎯 project-planner

**Purpose:** Collaborative project planning assistant that helps you architect new projects before any code exists. Uses 6-perspective analysis (Psychological, Educator, Software Engineering, Product/UX, DevOps, Security) to guide systematic planning.

**When to use:**
- Starting a brand new project (before writing code)
- Need architecture guidance and tech stack recommendations
- Want to validate your project idea with technical feedback
- Planning but want to avoid analysis paralysis

**How to use:**

```bash
# In Claude Code, invoke with @-mention:
@project-planner I want to build a task management app

# The agent will:
1. Ask clarifying questions about your project
2. Understand your skill level and constraints
3. Recommend appropriate tech stack with rationale
4. Generate a project plan with next steps
5. Create a CLAUDE.md template draft for your project
```

**Example session:**

```
You: @project-planner I want to build a SaaS for freelancers to track time and invoice clients

Agent:
I'd love to help you plan this! Let me ask a few questions:

1. What's your experience level with web development?
2. Are you building solo or with a team?
3. Roughly how many users do you expect initially? (10? 100? 1000?)
4. What tech are you comfortable with?

[After your responses...]

Based on our conversation, here's what I recommend:

**Tech Stack:**
- Language: TypeScript (type safety helps as codebase grows)
- Framework: Next.js (full-stack, easy deployment)
- Database: PostgreSQL (relational data: clients, projects, invoices)
- Hosting: Vercel + Railway (fast setup, free tiers)

**Why these choices:**
[Detailed rationale...]

**Next Steps:**
1. Set up Next.js project
2. Design database schema (clients, projects, time_entries, invoices)
3. Build authentication first
4. Start with time tracking feature

**Migration paths:**
- Can add mobile app later with React Native
- Can self-host if you outgrow Vercel
- Database can scale to millions of records

Would you like me to generate a full project plan document?
```

**What you learn:**
- How to think systematically about project planning
- Key questions to ask when starting any project
- Trade-offs between different architectural approaches
- How to choose tech stack based on requirements, not hype

**Output:**
- Comprehensive project planning summary
- Tech stack recommendations with rationale
- Project structure outline
- CLAUDE.md template draft
- Next steps checklist
- Learning resources
- Migration paths (if you need to change decisions later)

---

## Creating Your Own Agents

Custom agents live in `.claude/agents/` and use markdown frontmatter:

```markdown
---
name: your-agent-name
description: What this agent does
color: blue  # or green, purple, red, yellow
model: sonnet  # or opus, haiku
---

Your agent's system prompt here...
```

**Tips for creating agents:**
1. Make them focused on one specific task
2. Include examples in the system prompt
3. Reference project-specific context (CLAUDE.md)
4. Use consistent output formatting
5. Teach users while helping them

## Agent Best Practices

### Good Agent Uses:
✅ Specialized tasks (prompt polishing, code review, etc.)
✅ Consistent formatting needs (commit messages, docs)
✅ Domain-specific knowledge (your project patterns)
✅ Teaching/learning (explain while doing)

### Not Great Agent Uses:
❌ One-off tasks (just ask Claude directly)
❌ Simple operations (use tools instead)
❌ Tasks that change frequently (agent becomes outdated)

## More Agent Ideas

Consider creating agents for:
- **code-reviewer**: Reviews code against project standards
- **commit-message-writer**: Generates conventional commit messages
- **test-generator**: Creates tests following project patterns
- **doc-writer**: Documents code in your preferred style
- **security-checker**: Checks for common security issues
- **refactoring-guide**: Suggests refactoring patterns for cleaner code
- **performance-optimizer**: Identifies performance bottlenecks

## Sharing Agents with Team

Agents in `.claude/agents/` are committed to git, so your team automatically gets them when they clone the project!

To share broadly:
1. Copy to the template: `~/Developer/claude-config-template/.claude/agents/`
2. Document in README how to use them
3. Create examples for common use cases

---

## Troubleshooting Agent Issues

### Agent Parse Errors in `/doctor`

If `/doctor` shows "Failed to parse agent file(s)" with "Missing required 'name' field":

**Quick fix:**
```yaml
# Add version field to your agent frontmatter:
---
name: your-agent
description: What it does
model: sonnet
version: 4.21.0  ← Add this line
---
```

**Why this happens:**
- Error message is misleading (name field IS present, but parser fails)
- Large `structured_output` schemas (100+ lines) can overwhelm YAML parser
- Missing `version:` field causes some agents to fail parsing
- Agents with complex frontmatter need version field for successful parsing

**Full guide:** See [Proactive Troubleshooting Guide](../../04-ecosystem/03_proactive-troubleshooting.md#issue-7-agent-parse-errors-in-doctor) for complete resolution steps, prevention tips, and real-world examples.

### MCP Context Token Warnings

If `/doctor` shows "⚠ Large MCP tools context (~35,985 tokens > 25,000)":

**Is this a problem?**
- **25,000-40,000 tokens**: Elevated but functional - monitor, no immediate action needed
- **40,000-50,000 tokens**: High - consider optimization
- **>50,000 tokens**: Critical - immediate optimization required

**Your case (35,985 tokens):** System works normally, no action required unless you want to optimize.

**Full guide:** See [Proactive Troubleshooting Guide](../../04-ecosystem/03_proactive-troubleshooting.md#issue-8-mcp-context-token-warnings-in-doctor) for optimization strategies, when to worry vs. ignore, and tier-based MCP removal approach.

---

**Pro tip:** Use agents to codify your team's best practices. They're like having a senior developer always available to guide the team!
