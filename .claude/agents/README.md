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

## Sharing Agents with Team

Agents in `.claude/agents/` are committed to git, so your team automatically gets them when they clone the project!

To share broadly:
1. Copy to the template: `~/Developer/claude-config-template/.claude/agents/`
2. Document in README how to use them
3. Create examples for common use cases

---

**Pro tip:** Use agents to codify your team's best practices. They're like having a senior developer always available to guide the team!
