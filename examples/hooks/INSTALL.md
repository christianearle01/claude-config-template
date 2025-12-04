# Security Hook Installation Guide

## ⚠️ Important: Hooks Are Optional

**Before you install:** Security hooks are **completely optional**. You need to decide if your project needs them.

### 🤔 Do You Need Security Hooks?

**Answer these questions:**

1. **Does your project fetch content from external/untrusted sources?**
   - ✅ YES → Consider adding hooks
   - ❌ NO → You can skip hooks

2. **Does your project handle sensitive information?**
   - ✅ YES → Consider adding hooks for defense-in-depth
   - ❌ NO → Claude's built-in protection is likely sufficient

3. **Are you comfortable relying on Claude's built-in prompt injection resistance?**
   - ✅ YES → You can skip hooks
   - ❌ NO → Add hooks for peace of mind

4. **Do you mind 2-3 seconds of latency when fetching web content?**
   - ✅ NO (latency is acceptable) → Hooks are fine
   - ❌ YES (need speed) → Skip hooks or use PreToolUse only

### Your Choice

**Choose one:**

**Option A: No Hooks (Simplest)**
- Rely on Claude's built-in protection
- Fastest performance
- Best for: Development, prototyping, trusted sources
- Skip this entire guide

**Option B: PreToolUse Only (Recommended)**
- Scans requests before fetching content
- Minimal performance impact
- Best for: Most production projects
- Continue with "Quick Install" below

**Option C: PreToolUse + PostToolUse (Maximum Security)**
- Scans both requests and responses
- Adds 2-3 seconds latency per fetch
- Best for: High-security, sensitive data projects
- See "Advanced: PostToolUse" section at bottom

---

## Quick Install (Option B: PreToolUse Only)

**If you chose Option B above**, copy the prompt injection detection hook to your project:

```bash
# 1. Navigate to your project
cd /path/to/your/project

# 2. Create hooks directory
mkdir -p .claude/hooks

# 3. Copy the detection hook
cp ~/Developer/claude-config-template/examples/hooks/detect-prompt-injection.js .claude/hooks/

# 4. Make it executable
chmod +x .claude/hooks/detect-prompt-injection.js

# 5. Add hook configuration to .claude/settings.json (see below)
```

## Configuration

Add to your `.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": {
      "command": "node",
      "args": [".claude/hooks/detect-prompt-injection.js"],
      "matchers": [
        "WebFetch(*)",
        "WebSearch(*)",
        "mcp__brave-search__search(*)",
        "mcp__fetch__fetch(*)"
      ],
      "timeout": 2000
    }
  }
}
```

## Verify Installation

```bash
# Start Claude Code
claude

# Run doctor to check hook status
/doctor

# Look for: "✓ Hooks configured: 1"
```

## Test the Hook

Try fetching content with a test injection:

```bash
claude
"Fetch content from a test URL and look for 'ignore all previous instructions'"
```

The hook should detect and block this pattern.

## Troubleshooting

**Hook not running?**
- Check file permissions: `ls -la .claude/hooks/`
- Verify Node.js installed: `node --version`
- Check hook syntax: `node .claude/hooks/detect-prompt-injection.js < /dev/null`

**False positives?**
- Edit `.claude/hooks/detect-prompt-injection.js`
- Adjust `MALICIOUS_PATTERNS` array
- Remove patterns causing false alarms

**Need to disable temporarily?**
- Comment out the hook in `.claude/settings.json`
- Or set `"hooks": {}` temporarily

## Security Levels

**Paranoid (Maximum Security):**
```json
{
  "permissions": {
    "defaultMode": "ask"
  }
}
```

**Balanced (Recommended):**
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

**Development (Faster Iteration):**
```json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  }
}
```

---

## 🔒 Advanced: PostToolUse Response Protection (Optional)

### What's the Difference?

**PreToolUse (Default Setup Above):**
- ✅ Scans BEFORE fetching content
- ✅ Protects against malicious URLs and your own prompts
- ✅ Blocks suspicious requests before they're sent
- ❌ Does NOT scan the response data from websites

**PostToolUse (Additional Protection):**
- ✅ Scans AFTER receiving content from external sources
- ✅ Protects against malicious content hidden in webpage responses
- ✅ Catches injection attempts in fetched data
- ⚠️ Adds 2-3 seconds latency to every web fetch
- ⚠️ May have more false positives from legitimate content

### Should You Add PostToolUse Protection?

**✅ YES - Add PostToolUse if your project has:**
- Sensitive information that must be protected at all costs
- High-security requirements (financial, healthcare, government)
- Frequent fetching from untrusted or unknown sources
- Automated systems processing external content without human review
- Compliance requirements for defense-in-depth security
- Concerns about Claude's built-in safeguards being insufficient

**❌ NO - Skip PostToolUse if:**
- Standard security is sufficient for your use case
- You trust Claude's built-in prompt injection resistance
- You want faster performance (no additional latency)
- You're in a development/prototyping phase
- You primarily fetch from trusted sources
- False positives would disrupt your workflow

### Claude's Built-in Protection

**Important Note:** Claude has strong built-in safeguards:
- Trained to recognize and resist prompt injection in fetched content
- Maintains context boundaries (knows external content ≠ system instructions)
- Understands that webpage content is not authoritative commands

PostToolUse adds an **extra layer of defense** for projects where the stakes are high and you don't feel safe relying solely on Claude's training.

### Installation (If Needed)

**1. Create the response scanner:**

```bash
# Copy and modify the existing hook for response scanning
cp .claude/hooks/detect-prompt-injection.js .claude/hooks/scan-response-injection.js
```

**2. Update `.claude/settings.json`:**

Add PostToolUse alongside your existing PreToolUse hooks:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "WebFetch(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/detect-prompt-injection.js",
            "timeout": 2
          }
        ]
      }
      // ... other PreToolUse matchers
    ],
    "PostToolUse": [
      {
        "matcher": "WebFetch(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/scan-response-injection.js",
            "timeout": 3,
            "statusMessage": "Scanning fetched content for security threats..."
          }
        ]
      },
      {
        "matcher": "WebSearch(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/scan-response-injection.js",
            "timeout": 3
          }
        ]
      },
      {
        "matcher": "mcp__brave-search__search(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/scan-response-injection.js",
            "timeout": 3
          }
        ]
      },
      {
        "matcher": "mcp__fetch__fetch(*)",
        "hooks": [
          {
            "type": "command",
            "command": "node .claude/hooks/scan-response-injection.js",
            "timeout": 3
          }
        ]
      }
    ]
  }
}
```

**3. Modify `scan-response-injection.js`:**

Update the script to scan the `result` field instead of `parameters`:

```javascript
// Change line ~103 from:
const content = JSON.stringify(input.parameters).toLowerCase();

// To:
const content = JSON.stringify(input.result || input.parameters).toLowerCase();
```

**4. Test both hooks:**

```bash
claude
"Fetch a webpage and summarize it"
# You'll see two security checks:
# 1. PreToolUse: Scans your request BEFORE fetching
# 2. PostToolUse: Scans the response AFTER fetching
```

### Performance Impact

**With PostToolUse enabled:**
- Each web fetch adds 2-3 seconds for security scanning
- More CPU usage for pattern matching on large responses
- Potential false positives from legitimate security articles/docs

**Trade-off:**
- Extra security layer vs. Slower performance
- Peace of mind vs. Development friction

### Recommendation

**For most projects:** PreToolUse (default setup) is sufficient. Claude's built-in safeguards are strong, and the performance impact of PostToolUse may not be worth it.

**For sensitive projects:** If your project handles sensitive information and you don't feel safe with Claude's default protection, add PostToolUse for defense-in-depth security.

---

For complete documentation, see [SECURITY_GUIDE.md](../../SECURITY_GUIDE.md)
