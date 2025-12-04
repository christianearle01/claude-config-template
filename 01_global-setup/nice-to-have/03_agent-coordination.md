# Agent Coordination & Token Optimization Guide

## Overview

This guide explains how Claude Code handles subagents (spawned via the Task tool) and how to minimize token usage from duplicate file analysis and coordination overhead.

---

## How Agent Coordination Works

### Automatic Features (Already Configured)

#### 1. **Prompt Caching (Enabled)**
```bash
# In ~/.zshrc:
export DISABLE_PROMPT_CACHING=false
```

**How it works:**
- When parent agent reads a file, it's cached
- When subagent reads the same file, cache is reused
- **Result**: Second read costs ~10% of original tokens

**Example:**
```
Parent reads: app/leadprosper_client.py (1000 tokens)
Child reads: app/leadprosper_client.py (100 tokens from cache)
Savings: 90% on duplicate reads
```

#### 2. **Shared Project Memory (CLAUDE.md)**
- All agents automatically access CLAUDE.md
- First access: Full tokens
- Subsequent access: Cached (minimal cost)
- **Result**: Agents share project context without re-discovery

#### 3. **Model and Settings Inheritance**
```json
// .claude/settings.json
{
  "model": "sonnet",              // Subagents inherit this
  "alwaysThinkingEnabled": true,  // Better decisions = fewer retries
  "outputStyle": "concise"        // Less verbose = fewer tokens
}
```

---

## What's NOT Automatically Optimized

### System Limitations:

1. **No Explicit Plan File Sharing**
   - Each agent creates its own plan context
   - Parent's analysis isn't automatically passed to children
   - **Workaround**: Use detailed prompts with known context

2. **No File Analysis Deduplication**
   - Agents may re-analyze files independently
   - Caching helps, but doesn't eliminate re-analysis
   - **Workaround**: Document structure in CLAUDE.md

3. **No "Resume from Parent Context" Feature**
   - Can't explicitly pass parent's file reads to child
   - Each agent starts with CLAUDE.md + cache only
   - **Workaround**: Reference specific files/patterns in prompts

---

## Best Practices for Token Optimization

### 1. Use Specific, Context-Rich Prompts

**❌ BAD - Causes Full Re-Analysis:**
```python
Task(
    subagent_type="Explore",
    prompt="Find the authentication system"
)
# Agent will: grep auth, scan files, read implementations
# Cost: 5000-10000 tokens
```

**✅ GOOD - References Known Context:**
```python
Task(
    subagent_type="Explore",
    prompt="""
    Explore OAuth implementation in app/leadprosper_client.py.

    Known context:
    - LeadProsper integration is complete (see line 45-120)
    - Uses requests library for API calls
    - Form mappings in root CSV files

    Focus: Find how authentication tokens are refreshed.
    Don't re-read: CSV files, test files, migrations.
    """
)
# Agent will: Check specific file, focused search
# Cost: 1000-2000 tokens (80% savings)
```

### 2. Document Project Structure in CLAUDE.md

Your CLAUDE.md should include:

```markdown
## Project Structure (For Agent Coordination)
- **Lead Processing**: `app/leadprosper_client.py` - Main client
- **API Endpoints**: `app/api/` - Vendor integrations
- **Form Mappings**: Root CSV files - Field configurations
- **Testing**: `app/test_leadprosper.py` - Integration tests

## Agent Optimization Notes
- Form field mappings are in CSV format - already documented
- LeadProsper integration is complete - use as reference
- Large files to skip: migrations/, CSV files (unless needed)
- API patterns are consistent across vendors
```

**How this helps:**
- Agents read CLAUDE.md (cached after first read)
- Know where to look without exploring
- Skip unnecessary files
- Reference existing patterns

### 3. Use Agent "Resume" When Possible

```python
# First agent run:
agent1 = Task(
    subagent_type="Explore",
    prompt="Find authentication files"
)
# Returns: agent_id="agent-123"

# Continue same agent (preserves context):
Task(
    subagent_type="Explore",
    resume="agent-123",
    prompt="Now implement OAuth refresh logic"
)
# Cost: Only new work tokens, not re-analysis
```

### 4. Avoid Spawning Agents for Simple Tasks

**❌ BAD - Wastes Tokens:**
```python
# For a simple file read:
Task(subagent_type="Explore", prompt="Read app/auth.py")
# Cost: Agent overhead + file read = 500+ tokens

# Parent could just:
Read(file_path="app/auth.py")
# Cost: 100 tokens
```

**✅ GOOD - Use Agents for Complex Work:**
```python
Task(
    subagent_type="Plan",
    prompt="""
    Design OAuth implementation across 3 vendors:
    - LeadProsper (reference: app/leadprosper_client.py)
    - QuoteWizard (needs implementation)
    - Ricochet360 (needs implementation)

    Create unified auth pattern.
    """
)
# Agent value: Complex planning, multiple files, pattern design
# Worth the overhead
```

### 5. Leverage Caching with Repeated Operations

**Pattern that maximizes caching:**
```python
# First operation (high cost):
Read(file_path="app/leadprosper_client.py")  # 1000 tokens

# Later operations (cached):
Task(
    prompt="Add error handling to app/leadprosper_client.py"
)
# File already cached from parent read: ~100 tokens

Task(
    prompt="Add logging to app/leadprosper_client.py"
)
# Still cached: ~100 tokens
```

---

## Real-World Example: Your Insurance Project

### Scenario: Add New Vendor Integration

**❌ Token-Wasteful Approach:**
```python
# Agent 1: Explore codebase
Task(prompt="Understand the project structure")
# Cost: 10,000 tokens (reads everything)

# Agent 2: Find integrations
Task(prompt="Find vendor integrations")
# Cost: 8,000 tokens (re-reads files)

# Agent 3: Implement
Task(prompt="Add NCC integration")
# Cost: 6,000 tokens (re-reads again)

# Total: ~24,000 tokens
```

**✅ Optimized Approach:**
```python
# Parent reads reference implementation:
Read(file_path="app/leadprosper_client.py")
# Cost: 1,000 tokens (now cached)

# Single focused agent with context:
Task(
    subagent_type="Plan",
    prompt="""
    Implement NCC vendor integration following LeadProsper pattern.

    Known context from CLAUDE.md:
    - LeadProsper: app/leadprosper_client.py (reference implementation)
    - Form mappings: Root directory CSV files
    - API pattern: POST leads, receive confirmation

    Tasks:
    1. Create app/ncc_client.py based on LeadProsper pattern
    2. Add form mapping CSV
    3. Wire into API endpoint

    Don't re-analyze:
    - LeadProsper implementation (already known)
    - CSV format (documented in CLAUDE.md)
    - Database models (unchanged)
    """
)
# Cost: 3,000 tokens

# Total: ~4,000 tokens (83% savings)
```

---

## Token Usage Monitoring

### Track Your Optimization:

```bash
# Start session
claude

# Check usage
/usage
# Monitor plan limits consumption

# Track efficiency by:
# - Fewer agent spawns (better planning)
# - Shorter conversations (more focused prompts)
# - Successful first-try results
```

### Expected Metrics:

| Scenario | Without Optimization | With Optimization | Savings |
|----------|---------------------|-------------------|---------|
| Single agent spawn | 5,000 tokens | 2,000 tokens | 60% |
| Multiple agents (same files) | 15,000 tokens | 4,000 tokens | 73% |
| Complex multi-agent task | 30,000 tokens | 8,000 tokens | 73% |

---

## Configuration Summary

### What's Already Set Up:

✅ Prompt caching enabled globally
✅ CLAUDE.md with project structure
✅ Agent optimization notes in CLAUDE.md
✅ Concise output style (less verbose agents)
✅ Token tracking enabled

### What You Should Do:

1. **Keep CLAUDE.md Updated**
   - Document new integrations
   - List large files to skip
   - Note completed patterns

2. **Use Specific Agent Prompts**
   - Reference known files
   - Specify what to skip
   - Mention existing patterns

3. **Monitor with /usage**
   - Check plan limits consumption
   - Track agent efficiency
   - Switch to cheaper models when appropriate

4. **Resume Agents When Possible**
   - Continue existing agent work
   - Preserve agent context
   - Avoid duplicate setup

---

## Troubleshooting High Token Usage

### Problem: Agents using too many tokens

**Check:**
```bash
/usage
# Monitor plan limits consumption
```

**If usage is high:**
- Agents might be doing redundant work
- Prompts might be too vague
- Try more specific prompts with file references
- Use cheaper models (Haiku) when appropriate

**Solution:**
1. Update CLAUDE.md with more structure details
2. Reference specific files in agent prompts
3. Use parent to read files first, then spawn agents

### Problem: Agents re-analyzing same files

**Solution:**
```markdown
# Add to CLAUDE.md Agent Optimization Notes:
- Already analyzed: [list files]
- Reference implementation: [specific file:lines]
- Skip these: [large unchanging files]
```

### Problem: Multiple agents duplicating work

**Solution:**
Use a single agent with comprehensive prompt instead of multiple agents:
```python
# Instead of 3 agents:
Task(prompt="Explore")
Task(prompt="Plan")
Task(prompt="Implement")

# Use one:
Task(prompt="""
1. Use existing LeadProsper pattern (app/leadprosper_client.py)
2. Plan NCC integration structure
3. Implement following the pattern
All context in CLAUDE.md - don't re-explore.
""")
```

---

## Summary: Key Takeaways

1. **Caching is automatic** - but only helps if agents read the same files
2. **CLAUDE.md is shared** - keep it detailed with structure and patterns
3. **Specific prompts save tokens** - reference known context explicitly
4. **Fewer agents = lower cost** - combine work when possible
5. **Monitor with /usage** - track plan limits and efficiency

**Expected overall savings: 50-70% on multi-agent tasks**

---

## Questions?

- Full setup: `.claude/IMPLEMENTATION_GUIDE.md`
- Team onboarding: `~/Developer/claude-config-template/TEAM_ONBOARDING.md`
- This guide: `.claude/AGENT_COORDINATION_GUIDE.md`
