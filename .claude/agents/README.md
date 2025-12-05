# Custom Agents - Usage Guide

## Available Agents

### 🎨 prompt-polisher

**Purpose:** Transforms vague, inefficient prompts into optimized, specific requests that save 50-80% on token costs.

**When to use:**
- Before making a complex request to Claude
- When you want to learn better prompting techniques
- To see how your prompt could be improved

**How to use:**

```bash
# In Claude Code, invoke with @-mention:
@prompt-polisher Here's my prompt: "Fix the API integration"

# The agent will:
1. Analyze what's wrong with your prompt
2. Apply the 5 golden rules of optimization
3. Return a polished version
4. Explain what was improved and why
5. Show expected token savings
```

**Example session:**

```
You: @prompt-polisher I need to add error handling to the lead posting

Agent:
## 📝 Original Prompt Analysis
Your prompt is vague - which lead posting? What kind of errors? Where?

Issues identified:
- ❌ No specific file or method mentioned
- ❌ No context about current error handling
- ❌ Unclear what errors to handle
- ❌ No reference to existing patterns

Estimated cost: 8,000 tokens

---

## ✨ Polished Prompt

Add error handling to LeadProsper lead posting in app/leadprosper_client.py

Location: post_lead() method (line 127)

Current behavior: Direct API call with no retry logic
Errors to handle:
- ConnectionError: Retry 3 times with exponential backoff
- Timeout: Log and return error response
- HTTPError 401: Refresh token and retry once
- HTTPError 4xx/5xx: Log and return error dict

Pattern reference: app/quotewizard_client.py:145-167 has similar error handling

Error response format:
{
  "success": false,
  "error": "error message",
  "vendor": "leadprosper"
}

Skip: Other vendor clients (will add separately)

---

## 📊 Expected Impact

Estimated cost: 1,500 tokens
Savings: ~81% (6,500 tokens saved)
Quality improvement: Specific location, clear requirements, reference pattern

---

## 💡 Pro Tips for This Task
1. Check if app/validators.py has retry utilities to reuse
2. Make timeout configurable via .env (LEADPROSPER_TIMEOUT)
3. Add error metrics for monitoring vendor reliability
```

**What you learn:**
- How to be specific with file paths and line numbers
- How to provide context and reference existing code
- How to break down vague requests into clear requirements
- How to estimate and reduce token costs

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

**Pro tip:** Use agents to codify your team's best practices. They're like having a senior developer always available to guide the team!
