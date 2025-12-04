# Hooks Examples

Hooks allow you to customize Claude Code behavior at key points in the workflow.

## ⚠️ Hooks Are Optional - Your Choice

**Before exploring hooks:** They are **completely optional**. Many projects work great without any hooks.

**Do you need hooks?** Ask yourself:
- Do I fetch content from untrusted sources?
- Does my project handle sensitive information?
- Am I comfortable with Claude's built-in protection?

**If unsure:** Start without hooks. You can always add them later if needed.

---

## What Are Hooks?

Hooks are scripts that run automatically when specific events occur:
- Before/after tool execution
- On session start/end
- When user submits a prompt
- When requesting permissions

## 🛡️ Security Hook (Optional, User Choice)

### Prompt Injection Detection

**File:** `detect-prompt-injection.js`

**What it does:** Automatically scans external content (web results, API responses) for malicious patterns attempting to manipulate the AI agent.

**Protection Level:** **PreToolUse** (scans before fetching content)

**Why you need it:** Protects against:
- "Ignore all previous instructions" attacks
- System prompt manipulation
- Information extraction attempts
- Jailbreak attempts

**Quick Install:**
```bash
cp examples/hooks/detect-prompt-injection.js .claude/hooks/
chmod +x .claude/hooks/detect-prompt-injection.js
```

**See:** [INSTALL.md](./INSTALL.md) for complete setup guide
**See:** [SECURITY_GUIDE.md](../../SECURITY_GUIDE.md) for full security documentation

### 🔒 Advanced: PostToolUse Response Protection (Optional)

**When to add:** Only if your project has:
- Sensitive information requiring maximum protection
- High-security requirements (financial, healthcare, government)
- Concerns about Claude's built-in safeguards being insufficient

**Trade-off:** Adds 2-3 seconds latency to every web fetch for additional security scanning of response data.

**Most projects don't need this** - Claude has strong built-in prompt injection resistance. See [INSTALL.md](./INSTALL.md#-advanced-posttooluse-response-protection-optional) for details.

## Example: Pre-commit Security Check

**File:** `.claude/hooks/pre-commit.sh`

```bash
#!/bin/bash
# Check for secrets before committing

echo "🔍 Checking for secrets..."

# Search for common secret patterns
if grep -r "API_KEY\|SECRET\|PASSWORD" lead_logs.txt 2>/dev/null; then
    echo "❌ Found potential secrets in lead_logs.txt"
    echo "Please remove sensitive data before committing"
    exit 1
fi

echo "✅ No secrets found"
exit 0
```

**Configuration in `.claude/settings.json`:**
```json
{
  "hooks": {
    "PreToolUse": {
      "command": "bash",
      "args": [".claude/hooks/pre-commit.sh"],
      "matchers": ["Bash(git commit*)"]
    }
  }
}
```

## Example: Auto-format Before Edit

**File:** `.claude/hooks/format-before-edit.sh`

```bash
#!/bin/bash
# Auto-format Python files before editing

FILE=$1

if [[ $FILE == *.py ]]; then
    echo "🎨 Formatting $FILE with black..."
    black $FILE --quiet
fi

exit 0
```

## Example: Context7 Fallback

**File:** `.claude/hooks/context7-fallback.js`

```javascript
#!/usr/bin/env node
// Automatically fallback to WebSearch if Context7 fails

const input = JSON.parse(process.stdin.read());

if (input.tool === 'get-library-docs' && input.error) {
    console.log(JSON.stringify({
        systemMessage: "Context7 failed - falling back to WebSearch",
        additionalActions: [{
            tool: "WebSearch",
            parameters: {
                query: `${input.library} documentation latest`
            }
        }]
    }));
    process.exit(0);
}

process.exit(0);
```

## Hook Events

Available hook types:
- `SessionStart` - When Claude Code starts
- `SessionEnd` - When session ends
- `UserPromptSubmit` - Before processing user input
- `PreToolUse` - Before tool execution
- `PostToolUse` - After tool completes
- `PermissionRequest` - When tool needs permission

## Best Practices

1. **Keep hooks fast** - They run synchronously
2. **Use matchers** - Only trigger for relevant events
3. **Return JSON** - For structured communication
4. **Handle errors** - Exit codes: 0 (success), 1 (failure)
5. **Test thoroughly** - Hooks can block operations

## Documentation

Full hook documentation:
https://code.claude.com/docs/en/hooks

## Debugging Hooks

```bash
# Enable hook debugging
export CLAUDE_CODE_DEBUG_HOOKS=true

# Run Claude Code
claude
```

Hook execution logs will appear in the terminal.
