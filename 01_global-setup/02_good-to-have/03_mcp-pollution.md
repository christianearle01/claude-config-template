# MCP Pollution Prevention Guide

Quick reference for avoiding API key pollution between projects.

---

## TL;DR

**Global (`~/.claude.json`):**
- ✅ Sequential Thinking
- ✅ Memory
- ✅ Filesystem
- ✅ Fetch

**Per-Project (`.claude.json` + `.env`):**
- ⚠️ Context7 (different API keys per client)
- ⚠️ GitHub (different tokens per org/client)
- ⚠️ Brave Search (different API keys per project)
- ⚠️ Database MCPs (different DBs per project)

---

## Decision Tree

```
Does the MCP require an API key?
├─ NO → Install globally (safe)
└─ YES → Do all your projects use the SAME API key?
    ├─ YES → Install globally (safe)
    └─ NO → Install per-project (avoid pollution)
```

---

## What is MCP Pollution?

**Pollution occurs when:**
- Multiple client projects share the same API key
- Client A's work gets billed to Client B
- API rate limits are shared between unrelated projects
- Security boundaries are crossed

**Example:**
```
You work on Client A's project → uses Context7 key A
You work on Client B's project → uses SAME Context7 key A

Result: Client B is charged for Client A's API usage!
```

---

## Safe Global Setup

**These MCPs are safe to install globally (`~/.claude.json`):**

```json
{
  "mcpServers": {
    "sequential-thinking": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "memory": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "filesystem": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"]
    },
    "fetch": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-fetch"]
    }
  }
}
```

**Why these are safe:**
- No API keys required (stateless)
- Or: Store data per-project directory (Memory)
- Or: Operate in current working directory (Filesystem)

---

## Per-Project Setup (Pollution-Free)

**For MCPs with different API keys per client:**

### Step 1: Create `.env` file

```bash
# project/.env (add to .gitignore!)
CONTEXT7_API_KEY=client-specific-key
GITHUB_TOKEN=client-specific-token
BRAVE_API_KEY=client-specific-brave-key
```

### Step 2: Configure `.claude.json`

```json
// project/.claude.json
{
  "mcpServers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    },
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### Step 3: Verify `.gitignore`

```gitignore
# Essential - NEVER commit these!
.env
.claude.json  # If it contains secrets
```

---

## Migration Guide

### If you currently have pollution:

**Symptoms:**
- Same API key in multiple projects
- Client work mixed in billing
- Can't track usage per client

**Fix:**

1. **Identify polluted MCPs:**
   ```bash
   # Check global config
   cat ~/.claude.json | grep -A 5 "mcpServers"

   # Check project configs
   cat .claude.json | grep -A 5 "env"
   ```

2. **Move API keys to `.env`:**
   ```bash
   # Create .env in each project
   echo "CONTEXT7_API_KEY=project-specific-key" >> .env
   echo "GITHUB_TOKEN=project-specific-token" >> .env
   ```

3. **Update `.claude.json` to use env vars:**
   ```json
   {
     "env": {
       "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
     }
   }
   ```

4. **Update `.gitignore`:**
   ```bash
   echo ".env" >> .gitignore
   ```

5. **Remove from global config:**
   - Edit `~/.claude.json`
   - Remove MCPs with client-specific API keys
   - Keep only stateless MCPs

---

## Quick Reference Table

| MCP Server | Global? | Per-Project? | Reason |
|------------|---------|--------------|---------|
| Sequential Thinking | ✅ | - | Stateless, no API key |
| Memory | ✅ | - | Project-scoped storage |
| Filesystem | ✅ | - | Directory-scoped |
| Fetch | ✅ | - | Stateless, no API key |
| **Context7** | - | ✅ | Different keys per client |
| **GitHub** | ⚠️ | ✅ | Usually different per client |
| **Brave Search** | ⚠️ | ✅ | Different keys per project |
| **Database MCPs** | - | ✅ | Different DBs per project |

**Legend:**
- ✅ = Recommended
- ⚠️ = Depends on your situation
- - = Not recommended

---

## Testing Isolation

**After migration, verify each project is isolated:**

### Test 1: Environment Variables
```bash
# Project A
cd /path/to/clientA
echo $CONTEXT7_API_KEY
# Should show: ctx7sk-client-a-key

# Project B
cd /path/to/clientB
echo $CONTEXT7_API_KEY
# Should show: ctx7sk-client-b-key
```

### Test 2: MCP Connection
```bash
# In each project
claude
/mcp

# Verify:
# - context7: ✓ Connected (with project-specific key)
# - github: ✓ Connected (with project-specific token)
```

### Test 3: Git Safety
```bash
# Verify no API keys in git
git grep -i "ctx7sk-" || echo "✓ No API keys found"
git grep -i "ghp_" || echo "✓ No tokens found"

# Check .gitignore
cat .gitignore | grep -E "\.env|\.claude\.json"
```

---

## Common Mistakes

### ❌ Mistake 1: Hardcoding API keys
```json
// DON'T DO THIS
{
  "mcpServers": {
    "context7": {
      "env": {
        "CONTEXT7_API_KEY": "ctx7sk-actual-key-here"  // ← WRONG!
      }
    }
  }
}
```

**Fix:** Use environment variable reference
```json
{
  "env": {
    "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"  // ← RIGHT!
  }
}
```

### ❌ Mistake 2: Forgetting `.gitignore`
```bash
# DON'T DO THIS
git add .claude.json  # ← WRONG if it has secrets!
git add .env          # ← WRONG!
```

**Fix:** Always gitignore secrets
```gitignore
.env
.claude.json  # If contains project-specific secrets
```

### ❌ Mistake 3: Reusing same key across clients
```bash
# DON'T DO THIS
# Client A project
CONTEXT7_API_KEY=ctx7sk-shared-key

# Client B project
CONTEXT7_API_KEY=ctx7sk-shared-key  # ← WRONG! Same key = pollution
```

**Fix:** Use different keys per client
```bash
# Client A project
CONTEXT7_API_KEY=ctx7sk-client-a-key

# Client B project
CONTEXT7_API_KEY=ctx7sk-client-b-key  # ← RIGHT!
```

---

## FAQ

### Q: Can I use the same GitHub token for all my projects?
**A:** Depends on your situation:
- **Same for all:** If you use one GitHub account for all work → Safe globally
- **Different per client:** If each client has their own GitHub org → Use per-project

### Q: What if I work on personal projects AND client projects?
**A:** Best practice:
- Global MCPs: Only stateless (Sequential Thinking, Memory, Filesystem, Fetch)
- Per-project: Everything with API keys (Context7, GitHub, etc.)
- This way: No risk of mixing personal/client work

### Q: How do I know if I have pollution?
**A:** Check for these signs:
```bash
# Sign 1: Same API key in multiple projects
grep -r "CONTEXT7_API_KEY.*ctx7sk-" ~/Developer/*/\.env

# Sign 2: API keys in global config
cat ~/.claude.json | grep -i "api_key"

# Sign 3: Shared billing between clients
# Check your Context7 dashboard for mixed usage
```

### Q: Can I migrate without breaking my projects?
**A:** Yes! Follow this safe migration:
1. Create `.env` in project (don't commit)
2. Add API keys to `.env`
3. Update `.claude.json` to use `${VAR}` references
4. Test MCP connection: `claude` → `/mcp`
5. Once working, remove from global config
6. Repeat for each project

---

## Security Benefits

**Before (Polluted):**
- ❌ API keys hardcoded in config files
- ❌ Risk of accidental git commit
- ❌ Same key across all projects
- ❌ Can't track usage per client
- ❌ One key leak = all projects compromised

**After (Clean):**
- ✅ API keys in `.env` (gitignored)
- ✅ Environment variable references only
- ✅ Different key per client project
- ✅ Clear usage tracking per client
- ✅ One key leak = only one project affected

---

## Additional Resources

- **Full MCP Setup:** [02_mcp-setup.md](02_mcp-setup.md)
- **Security Guide:** [01_security-guide.md](../03_nice-to-have/01_security-guide.md)
- **Quick Start:** [START_HERE.md](../../../docs/00-start-here/START_HERE.md)
- **Template README:** [README.md](../../../README.md)

---

**Last Updated:** 2025-12-04
**Maintained By:** Development Team
**Version:** 1.0

---

## Need Help?

**Still have pollution issues?**
1. Read the full [02_mcp-setup.md](02_mcp-setup.md)
2. Check [01_security-guide.md](../03_nice-to-have/01_security-guide.md) for best practices
3. Review your configuration:
   ```bash
   # Global config
   cat ~/.claude.json | jq '.mcpServers'

   # Project config
   cat .claude.json | jq '.mcpServers'

   # Environment variables
   cat .env
   ```

**Quick fix checklist:**
- [ ] API keys moved to `.env`
- [ ] `.claude.json` uses `${VAR}` references
- [ ] `.gitignore` includes `.env`
- [ ] Global config has only stateless MCPs
- [ ] Each project has unique API keys
- [ ] Tested MCP connections
- [ ] Verified no keys in git history

✅ **All checked?** You're pollution-free!
