# Environment Variables - Claude Code Configuration

**Introduced:** Claude Code 2.1.0-2.1.4
**Purpose:** Control Claude Code behavior without modifying settings files
**Reading Time:** 8 minutes

---

## Overview

Environment variables provide **runtime configuration** for Claude Code - controlling behavior without editing `settings.json` files. Introduced across Claude Code 2.1.0-2.1.4 releases, these variables enable:

- **Dynamic configuration** (change behavior without file edits)
- **Environment-specific settings** (dev vs staging vs production)
- **CI/CD integration** (configure Claude Code in pipelines)
- **Privacy controls** (disable telemetry)
- **Performance tuning** (caching, model selection)

---

## Variable Reference

### CLAUDE_DEFAULT_MODEL

**Purpose:** Override default model without editing settings.json
**Values:** `sonnet`, `opus`, `haiku` (or full model IDs like `claude-sonnet-4-5-20250929`)
**Introduced:** Claude Code 2.1.0

**Use Cases:**
- **Cost optimization:** Set `haiku` for bulk exploration tasks
- **Quality boost:** Set `opus` for architecture/planning sessions
- **Testing:** Quickly switch models without config changes

**Example:**
```bash
# Use Haiku for file exploration (91% cheaper than Sonnet)
export CLAUDE_DEFAULT_MODEL=haiku
claude "List all TypeScript files and summarize their purpose"

# Use Opus for architecture decisions
export CLAUDE_DEFAULT_MODEL=opus
claude "Design the authentication system architecture"

# Reset to Sonnet (default)
unset CLAUDE_DEFAULT_MODEL
```

**Precedence:**
1. Model specified in prompt (highest priority)
2. `CLAUDE_DEFAULT_MODEL` environment variable
3. `model` field in settings.json
4. Claude Code default (sonnet)

---

### CLAUDE_DISABLE_TELEMETRY

**Purpose:** Privacy control - disable usage telemetry
**Values:** `true` (disable) or unset (enable - default)
**Introduced:** Claude Code 2.1.2

**Use Cases:**
- **Enterprise environments:** Corporate privacy policies
- **Sensitive projects:** Regulated industries (healthcare, finance)
- **Air-gapped systems:** Offline development

**Example:**
```bash
# Disable telemetry
export CLAUDE_DISABLE_TELEMETRY=true

# Verify (no telemetry data sent)
claude "Create a simple React component"

# Re-enable (unset variable)
unset CLAUDE_DISABLE_TELEMETRY
```

**What telemetry includes:**
- Usage statistics (features used, session duration)
- Error reports (crashes, failures)
- **Does NOT include:** Your code, project data, or prompts

---

### CLAUDE_LOG_LEVEL

**Purpose:** Control debug logging verbosity
**Values:** `error`, `warn`, `info`, `debug`
**Introduced:** Claude Code 2.1.3

**Use Cases:**
- **Troubleshooting:** Debug MCP server issues, hook failures
- **Development:** Monitor agent behavior, tool calls
- **Production:** Reduce log noise (error-only)

**Example:**
```bash
# Debug mode - verbose logging
export CLAUDE_LOG_LEVEL=debug
claude "Setup MCP servers"
# Logs: All MCP server startup messages, connection attempts, etc.

# Production mode - errors only
export CLAUDE_LOG_LEVEL=error
claude "Run build"
# Logs: Only failures

# Reset to default (info)
unset CLAUDE_LOG_LEVEL
```

**Log levels:**
- `error`: Failures only (crashes, API errors)
- `warn`: Warnings + errors (deprecated features, non-blocking issues)
- `info`: Info + warnings + errors (default - normal operation)
- `debug`: All logs (verbose - development only)

---

### CLAUDE_PROMPT_CACHING

**Purpose:** Control prompt caching behavior
**Values:** `true` (enable - default), `false` (disable)
**Introduced:** Claude Code 2.1.4

**Use Cases:**
- **Testing:** Disable caching to test "fresh" behavior
- **Debugging:** Verify cache-related issues
- **Development:** Ensure latest changes aren't cached

**Example:**
```bash
# Disable caching (for testing)
export CLAUDE_PROMPT_CACHING=false
claude "Test the new feature"
# No cached responses - all requests fresh

# Re-enable (default behavior)
export CLAUDE_PROMPT_CACHING=true
# Or unset
unset CLAUDE_PROMPT_CACHING
```

**Impact:**
- **With caching (default):** 80-95% token cost reduction on repeated prompts
- **Without caching:** Higher cost, guaranteed fresh responses

**When to disable:**
- Testing prompt changes
- Debugging unexpected responses
- Comparing cached vs non-cached behavior

---

### CLAUDE_SANDBOX_MODE

**Purpose:** Control sandbox security restrictions
**Values:** `strict`, `permissive`, `disabled`
**Introduced:** Claude Code 2.1.1

**Use Cases:**
- **Maximum security:** `strict` for sensitive environments
- **Development:** `permissive` for local testing
- **Legacy systems:** `disabled` for compatibility (⚠️ not recommended)

**Example:**
```bash
# Strict mode - maximum security
export CLAUDE_SANDBOX_MODE=strict
claude "Install npm packages"
# Blocked: npm install outside approved directories

# Permissive mode - development
export CLAUDE_SANDBOX_MODE=permissive
claude "Install npm packages"
# Allowed: npm install with warnings

# Disabled (⚠️ use with caution)
export CLAUDE_SANDBOX_MODE=disabled
claude "Install npm packages"
# Allowed: No restrictions
```

**Security implications:**
- `strict`: Blocks unapproved commands, restricts file access (safest)
- `permissive`: Allows most commands with warnings (balanced)
- `disabled`: No restrictions (⚠️ use only in trusted environments)

---

### CLAUDE_OUTPUT_STYLE

**Purpose:** Control output formatting (deprecated styles replaced in 2.0.0)
**Values:** `compact`, `detailed`
**Introduced:** Claude Code 2.0.0 (replaced `minimal`/`default`/`verbose`)

**Use Cases:**
- **CI/CD pipelines:** `compact` for machine-readable output
- **Interactive use:** `detailed` for human-readable output
- **Log parsing:** `compact` for easier parsing

**Example:**
```bash
# Compact output - CI/CD friendly
export CLAUDE_OUTPUT_STYLE=compact
claude "Run tests"
# Output: Brief summaries, minimal formatting

# Detailed output - human-friendly
export CLAUDE_OUTPUT_STYLE=detailed
claude "Run tests"
# Output: Full context, formatted results

# Reset to default (detailed)
unset CLAUDE_OUTPUT_STYLE
```

---

## Configuration Patterns

### Pattern 1: Per-Project Configuration

Use `.env` files for project-specific settings (never commit secrets).

**.env.development:**
```bash
# Development environment
CLAUDE_DEFAULT_MODEL=haiku
CLAUDE_LOG_LEVEL=debug
CLAUDE_PROMPT_CACHING=false
CLAUDE_DISABLE_TELEMETRY=false
```

**.env.production:**
```bash
# Production environment
CLAUDE_DEFAULT_MODEL=sonnet
CLAUDE_LOG_LEVEL=error
CLAUDE_PROMPT_CACHING=true
CLAUDE_DISABLE_TELEMETRY=true
CLAUDE_SANDBOX_MODE=strict
```

**Usage:**
```bash
# Load development config
source .env.development
claude "Start development session"

# Load production config
source .env.production
claude "Deploy application"
```

**⚠️ Add to `.gitignore`:**
```
.env
.env.*
```

---

### Pattern 2: Global Configuration

Set user-wide defaults in shell profile (`~/.bashrc`, `~/.zshrc`).

**~/.zshrc:**
```bash
# Claude Code global settings
export CLAUDE_DEFAULT_MODEL=sonnet
export CLAUDE_LOG_LEVEL=info
export CLAUDE_DISABLE_TELEMETRY=true  # Privacy by default

# Function to quickly switch models
claude-haiku() {
  export CLAUDE_DEFAULT_MODEL=haiku
  echo "Switched to Haiku (cost-optimized)"
}

claude-opus() {
  export CLAUDE_DEFAULT_MODEL=opus
  echo "Switched to Opus (quality-optimized)"
}

claude-sonnet() {
  export CLAUDE_DEFAULT_MODEL=sonnet
  echo "Switched to Sonnet (balanced)"
}
```

**Usage:**
```bash
# Use Haiku for exploration
claude-haiku
claude "Explore codebase structure"

# Switch to Opus for architecture
claude-opus
claude "Design new feature architecture"

# Back to Sonnet (balanced)
claude-sonnet
```

---

### Pattern 3: CI/CD Integration

Configure Claude Code for automated pipelines.

**GitHub Actions:**
```yaml
name: Claude Code Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    env:
      CLAUDE_DEFAULT_MODEL: haiku  # Cost-optimized for CI
      CLAUDE_LOG_LEVEL: debug     # Full logs for debugging
      CLAUDE_OUTPUT_STYLE: compact # Machine-readable
      CLAUDE_PROMPT_CACHING: true  # Token savings
      CLAUDE_DISABLE_TELEMETRY: true # Privacy in CI
      CLAUDE_SANDBOX_MODE: strict  # Maximum security

    steps:
      - uses: actions/checkout@v3
      - name: Run Claude Code tests
        run: |
          claude "Run all tests and report results"
```

**GitLab CI:**
```yaml
claude-tests:
  stage: test
  variables:
    CLAUDE_DEFAULT_MODEL: "haiku"
    CLAUDE_LOG_LEVEL: "debug"
    CLAUDE_OUTPUT_STYLE: "compact"
  script:
    - claude "Run tests and generate report"
```

---

### Pattern 4: Temporary Overrides

Override settings for single commands without changing defaults.

```bash
# One-time Opus usage (don't change default)
CLAUDE_DEFAULT_MODEL=opus claude "Design authentication system"

# One-time debug logging (don't change default)
CLAUDE_LOG_LEVEL=debug claude "Troubleshoot MCP server"

# One-time disable caching (testing)
CLAUDE_PROMPT_CACHING=false claude "Test new prompt pattern"

# Combine multiple overrides
CLAUDE_DEFAULT_MODEL=haiku CLAUDE_LOG_LEVEL=error claude "Quick exploration"
```

---

## Best Practices

### 1. Document Project Defaults

**Create `.env.example` (safe to commit):**
```bash
# Claude Code Configuration

# Model selection (sonnet, opus, haiku)
CLAUDE_DEFAULT_MODEL=sonnet

# Logging verbosity (error, warn, info, debug)
CLAUDE_LOG_LEVEL=info

# Privacy (true = disable telemetry)
CLAUDE_DISABLE_TELEMETRY=false

# Caching (true = enable, false = disable)
CLAUDE_PROMPT_CACHING=true

# Security (strict, permissive, disabled)
CLAUDE_SANDBOX_MODE=strict
```

**Team members copy to `.env`:**
```bash
cp .env.example .env
# Customize .env for local development
```

### 2. Use Model Switching Functions

**Add to shell profile:**
```bash
# Quickly switch between models based on task
alias claude-explore='CLAUDE_DEFAULT_MODEL=haiku claude'
alias claude-implement='CLAUDE_DEFAULT_MODEL=sonnet claude'
alias claude-architect='CLAUDE_DEFAULT_MODEL=opus claude'
```

**Usage:**
```bash
claude-explore "What files handle authentication?"
claude-architect "Design a scalable auth system"
claude-implement "Implement JWT authentication"
```

### 3. CI/CD Optimization

**Minimize CI costs:**
```bash
# CI environment - cost-optimized
export CLAUDE_DEFAULT_MODEL=haiku      # 91% cheaper than Sonnet
export CLAUDE_PROMPT_CACHING=true       # 80-95% token savings
export CLAUDE_OUTPUT_STYLE=compact      # Minimal tokens
```

**Security in CI:**
```bash
export CLAUDE_SANDBOX_MODE=strict       # Maximum security
export CLAUDE_DISABLE_TELEMETRY=true    # Privacy compliance
```

### 4. Development vs Production

**Development (permissive, verbose):**
```bash
export CLAUDE_LOG_LEVEL=debug
export CLAUDE_SANDBOX_MODE=permissive
export CLAUDE_PROMPT_CACHING=false  # Test without cache
```

**Production (secure, quiet):**
```bash
export CLAUDE_LOG_LEVEL=error
export CLAUDE_SANDBOX_MODE=strict
export CLAUDE_PROMPT_CACHING=true
export CLAUDE_DISABLE_TELEMETRY=true
```

---

## Troubleshooting

### "Environment variable not taking effect"

**Check:**
1. Variable exported? (`export VAR=value`, not just `VAR=value`)
2. Correct spelling? (`CLAUDE_DEFAULT_MODEL`, not `CLAUDE_MODEL`)
3. Valid value? (`haiku`, not `Haiku` or `HAIKU`)
4. Settings.json overriding? (settings.json takes precedence for some fields)

**Verify:**
```bash
# Check if variable is set
echo $CLAUDE_DEFAULT_MODEL

# Test in same shell session
export CLAUDE_DEFAULT_MODEL=haiku
claude "Echo current model"
```

### "Variable works in terminal but not in scripts"

**Solution:** Export in script:
```bash
#!/bin/bash
export CLAUDE_DEFAULT_MODEL=haiku
claude "Run task"
```

### "CI/CD not using environment variables"

**Check:**
1. Variables defined in CI config? (GitHub Actions: `env:`, GitLab: `variables:`)
2. Syntax correct? (YAML indentation, no typos)
3. Secrets properly configured? (For sensitive values)

---

## Integration with Template

The claude-config-template provides:
- **Example .env files** in `examples/env/` directory
- **Shell function examples** for quick model switching
- **CI/CD templates** with optimized settings

**To use:**
1. Copy `.env.example` to your project
2. Customize for your environment (dev/staging/prod)
3. Add shell functions to your profile
4. Update CI/CD configs with environment variables

---

## Further Reading

- [Model Selection Strategy](01_model-selection-strategy.md) - When to use Opus/Sonnet/Haiku
- [Prompt Caching Guide](03_prompt-caching-optimization.md) - 80-95% token savings
- [Settings Reference](.claude/settings-explained.json) - Complete settings documentation

---

**Next:** [Advanced MCP Workflows](../03-advanced/ADVANCED_MCP_WORKFLOWS.md)
**Previous:** [Rules Directory Guide](../01-fundamentals/05_rules-directory-guide.md)
