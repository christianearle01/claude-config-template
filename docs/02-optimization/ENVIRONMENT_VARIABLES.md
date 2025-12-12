# Environment Variables Reference

**Complete guide to Claude Code environment variables**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Environment variables: Official configuration method ✅ VALIDATED
- Claude Code Documentation: https://docs.claude.com

**Note:** All environment variables listed are officially documented features.

---

## Overview

**Environment variables** configure Claude Code behavior without editing settings.json.

**Advantages:**
- Per-project configuration
- Easy to toggle on/off
- No file editing required
- Override global settings

---

## Token Control

### CLAUDE_CODE_MAX_OUTPUT_TOKENS

**What it does:** Limits maximum tokens in Claude's responses

**Default:** 4000 tokens

**Usage:**
```bash
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000
```

**When to use:**
- Force concise responses
- Reduce costs for simple tasks
- Prevent verbose outputs

**Example:**
```bash
# Global setting
echo 'export CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000' >> ~/.bashrc

# Per-session
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=3000
```

---

### MAX_THINKING_TOKENS

**What it does:** Limits tokens used in extended thinking

**Default:** Varies by model

**Usage:**
```bash
export MAX_THINKING_TOKENS=5000
```

**When to use:**
- Control thinking depth
- Balance cost vs. quality
- Debug thinking issues

---

## Prompt Caching

### DISABLE_PROMPT_CACHING

**What it does:** Disables all prompt caching

**Default:** false (caching enabled)

**Usage:**
```bash
export DISABLE_PROMPT_CACHING=true
```

**When to use:**
- Testing cache behavior
- Debugging context issues
- Measuring true token usage

**When NOT to use:**
- Normal development (caching saves money!)

---

### DISABLE_PROMPT_CACHING_HAIKU

**What it does:** Disables caching for Haiku model only

**Usage:**
```bash
export DISABLE_PROMPT_CACHING_HAIKU=true
```

**Use case:** Model-specific testing

---

### DISABLE_PROMPT_CACHING_SONNET

**What it does:** Disables caching for Sonnet model only

**Usage:**
```bash
export DISABLE_PROMPT_CACHING_SONNET=true
```

**Use case:** Model-specific testing

---

### DISABLE_PROMPT_CACHING_OPUS

**What it does:** Disables caching for Opus model only

**Usage:**
```bash
export DISABLE_PROMPT_CACHING_OPUS=true
```

**Use case:** Model-specific testing

---

## Authentication

### ANTHROPIC_API_KEY

**What it does:** Sets API key for Claude API access

**Usage:**
```bash
export ANTHROPIC_API_KEY=sk-ant-...
```

**Security:**
- NEVER commit to git
- Store in ~/.bashrc or ~/.zshrc
- Or use .env file (git-ignored)

---

### AWS Credentials (if using AWS)

```bash
export AWS_ACCESS_KEY_ID=your-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-key
export AWS_REGION=us-east-1
```

**When needed:** Using Claude via AWS Bedrock

---

## Debugging

### CLAUDE_CODE_DEBUG

**What it does:** Enables debug logging

**Usage:**
```bash
export CLAUDE_CODE_DEBUG=true
```

**Output:** Detailed logs for troubleshooting

---

### CLAUDE_CODE_LOG_LEVEL

**What it does:** Sets logging verbosity

**Options:** error, warn, info, debug, trace

**Usage:**
```bash
export CLAUDE_CODE_LOG_LEVEL=debug
```

**Use case:** Debugging issues, seeing internal operations

---

## Per-Project Configuration

### Using .claude/settings.json

**Instead of environment variables:**
```json
{
  "env": {
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "2000",
    "DISABLE_PROMPT_CACHING_HAIKU": "true"
  }
}
```

**Advantages:**
- Project-specific settings
- Version controlled (committed to git)
- Team consistency

---

## Common Patterns

### Pattern 1: Development Mode

```bash
# High verbosity, no token limits
export CLAUDE_CODE_LOG_LEVEL=debug
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=8000
```

**Use case:** Exploring, learning, debugging

---

### Pattern 2: Production Optimization

```bash
# Concise outputs, normal logging
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000
export CLAUDE_CODE_LOG_LEVEL=warn
```

**Use case:** Cost optimization, efficient workflows

---

### Pattern 3: Testing/Benchmarking

```bash
# Disable caching for accurate measurements
export DISABLE_PROMPT_CACHING=true
export CLAUDE_CODE_LOG_LEVEL=info
```

**Use case:** Measuring true token usage

---

## Configuration Hierarchy

**Priority order (highest to lowest):**

1. Environment variables (this session)
2. Project settings (`.claude/settings.json`)
3. Global settings (`~/.claude/settings.json`)
4. Claude Code defaults

**Example:**
```
ENV: CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000  ← Takes precedence
Project .claude/settings.json: "outputStyle": "concise"
Global ~/.claude/settings.json: (no override)
Result: 2000 token limit with concise style
```

---

## Quick Reference

### Token Control
```bash
CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000    # Limit response tokens
MAX_THINKING_TOKENS=5000              # Limit thinking tokens
```

### Caching Control
```bash
DISABLE_PROMPT_CACHING=true           # Disable all caching
DISABLE_PROMPT_CACHING_HAIKU=true     # Disable Haiku caching
DISABLE_PROMPT_CACHING_SONNET=true    # Disable Sonnet caching
DISABLE_PROMPT_CACHING_OPUS=true      # Disable Opus caching
```

### Authentication
```bash
ANTHROPIC_API_KEY=sk-ant-...          # API key
AWS_ACCESS_KEY_ID=...                 # AWS credentials (if needed)
AWS_SECRET_ACCESS_KEY=...
AWS_REGION=us-east-1
```

### Debugging
```bash
CLAUDE_CODE_DEBUG=true                # Enable debug mode
CLAUDE_CODE_LOG_LEVEL=debug           # Set log verbosity
```

---

## Setup Examples

### Global Setup (~/.bashrc or ~/.zshrc)

```bash
# Claude Code Configuration
export ANTHROPIC_API_KEY=sk-ant-xxx
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=3000
export CLAUDE_CODE_LOG_LEVEL=warn
```

**Apply changes:**
```bash
source ~/.bashrc  # or source ~/.zshrc
```

---

### Per-Project Setup

**Option 1: Project .env file (git-ignored)**
```bash
# .env
CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000
CLAUDE_CODE_LOG_LEVEL=info
```

**Load before Claude Code:**
```bash
source .env
claude code
```

---

**Option 2: Project settings.json (committed)**
```json
// .claude/settings.json
{
  "env": {
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "2000"
  }
}
```

**Automatic loading:** Claude Code reads this on startup

---

### Session-Specific Override

```bash
# Temporary override for this session only
export CLAUDE_CODE_MAX_OUTPUT_TOKENS=1000
claude code

# Next session will use default or global setting
```

---

## Best Practices

### 1. Use Project Settings for Team Consistency

```json
// .claude/settings.json (committed to git)
{
  "model": "sonnet",
  "env": {
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "3000"
  }
}
```

**Result:** Entire team uses same configuration

---

### 2. Use ENV for Secrets

```bash
# ~/.bashrc (not committed)
export ANTHROPIC_API_KEY=sk-ant-xxx
```

**Never in settings.json!** (git-tracked)

---

### 3. Document in CLAUDE.md

```markdown
## Environment Configuration

**Required:**
- ANTHROPIC_API_KEY (in ~/.bashrc)

**Recommended:**
- CLAUDE_CODE_MAX_OUTPUT_TOKENS=2000 (concise mode)

**Optional:**
- CLAUDE_CODE_LOG_LEVEL=debug (when debugging)
```

---

### 4. Use Defaults Unless You Have a Reason

**Don't override just because you can.**

**Good reason to override:**
- Reduce costs (lower token limits)
- Debug issues (enable logging)
- Test behavior (disable caching)

**Bad reason to override:**
- "Just trying settings"
- No clear goal
- Copying from internet without understanding

---

## Troubleshooting

### Issue: Settings not taking effect

**Check:**
1. ENV variable actually set: `echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS`
2. Restarted Claude Code after setting
3. No typos in variable name
4. Correct shell (.bashrc vs .zshrc)

---

### Issue: Caching still happening after disable

**Solution:**
```bash
# Ensure ENV is set
echo $DISABLE_PROMPT_CACHING  # Should output: true

# Restart Claude Code
# Try again
```

---

### Issue: API key not found

**Solution:**
```bash
# Check ENV
echo $ANTHROPIC_API_KEY

# If empty, add to ~/.bashrc:
export ANTHROPIC_API_KEY=sk-ant-xxx

# Reload:
source ~/.bashrc
```

---

## Summary

**Environment Variables Core Principles:**

1. **Official configuration** - Validated by Claude Code team
2. **Hierarchy respected** - ENV > Project > Global > Defaults
3. **Secrets in ENV** - API keys never in settings.json
4. **Team settings in project** - .claude/settings.json for consistency
5. **Override when needed** - Don't change defaults without reason

**The outcome:**
- ✅ Flexible per-project configuration
- ✅ Secure secret management
- ✅ Team consistency (project settings.json)
- ✅ Easy debugging (log levels, cache control)

**Best practice:**
> Use environment variables for secrets and debugging. Use project settings.json for team configuration. Document your choices in CLAUDE.md.

---

**See also:**
- [Prompt Caching](PROMPT_CACHING_GUIDE.md) - Caching environment variables
- [MCP Optimization](MCP_OPTIMIZATION_GUIDE.md) - MCP configuration options
- [Skills Paradigm](../01-fundamentals/SKILLS_PARADIGM.md) - Skills folder structure
