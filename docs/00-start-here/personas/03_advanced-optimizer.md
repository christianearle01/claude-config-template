# Advanced Optimizer

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > Advanced Optimizer

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Add security hooks, custom agents, and MCP servers to unlock Claude Code's full potential. Covers advanced features like prompt validation, response scanning, git approval workflows, and ecosystem integrations. For users ready to maximize productivity and safety.

**Time:** 20-40 min | **Difficulty:** Advanced | **Outcome:** Production-grade power features

---

## You Are This Persona If...

- You already have Claude Code working on at least one project
- You want security hooks, custom agents, or MCP servers
- You're comfortable with technical configuration
- You want to push Claude Code to its limits
- You care about security and workflow automation

---

## Your Path (Advanced Features)

### 1. Set Up Security Hooks (10 min)
**→ [Security Guide](../../01_global-setup/03_nice-to-have/01_security-guide.md)**

Add protection layers:
- Prompt injection detection
- Response scanning for secrets
- Pre-tool validation
- Git commit approval workflow

### 2. Create Custom Agents (15 min)
**→ [Custom Agents Guide](../../01_global-setup/02_good-to-have/03_custom-agents.md)**

Build specialized agents for your workflow:
- Code review agents
- Documentation generators
- Domain-specific helpers

### 3. Install MCP Servers (10 min)
**→ [MCP Setup Guide](../../01_global-setup/02_good-to-have/02_mcp-setup.md)**

Connect Claude to external tools:
- GitHub integration (issues, PRs, commits)
- Database query tools
- Cloud service management

---

## Advanced Checklist

**Security Phase:**
- [ ] Installed prompt injection detection hook
- [ ] Configured response scanning for API keys/secrets
- [ ] Set up git commit approval workflow
- [ ] Tested hooks with suspicious input

**Automation Phase:**
- [ ] Created at least one custom agent
- [ ] Agent responds to `@agent-name` invocations
- [ ] Documented agent purpose in `.claude/agents/docs/README.md`

**Integration Phase:**
- [ ] Configured project-specific MCP servers
- [ ] Tested MCP server connectivity
- [ ] Verified Claude can access MCP tools

**✅ Final Checkpoint:**
- [ ] Run `/doctor` - shows all green checks?
- [ ] Security hooks active and tested
- [ ] Custom agents working
- [ ] MCP servers connected

---

## Success Criteria

You have:
1. Security hooks actively protecting your workflow
2. At least one custom agent handling specialized tasks
3. MCP servers providing external tool access
4. Understanding of how to create more agents/hooks as needed

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Installing All Hooks Without Understanding
**Problem:** Too many hooks slow workflow, create false positives

**Example:**
```json
// settings.json
{
  "hooks": {
    "prompt-injection-detection": { "enabled": true },
    "response-scanning": { "enabled": true },
    "pre-tool-validation": { "enabled": true },
    "git-approval": { "enabled": true },
    "custom-validator-1": { "enabled": true },
    "custom-validator-2": { "enabled": true }
  }
}

Result: Every action requires 6 validation passes (slow!)
```

**✅ Correct Approach:**

Start with 1-2 critical hooks, expand gradually:

```json
// Start minimal
{
  "hooks": {
    "response-scanning": { "enabled": true }  // Prevent API key leaks
  }
}

// Add more after understanding each
```

**Pattern:** Start minimal, add hooks when you understand their value.

---

### ❌ Anti-Pattern #2: Creating Generic "Helper" Agents
**Problem:** Vague agents don't provide value over base Claude

**Example:**
```markdown
<!-- .claude/agents/helper.md -->
# Helper Agent

You are a helpful assistant that helps with coding tasks.
```

**✅ Correct Approach:**

Create **specialized** agents with **specific expertise**:

```markdown
<!-- .claude/agents/api-security-reviewer.md -->
# API Security Reviewer

You are an expert in OWASP API Security Top 10. Review API endpoints for:

1. **Authentication bypass** (OWASP API1:2023)
2. **Broken object-level authorization** (OWASP API2:2023)
3. **Mass assignment** (OWASP API6:2023)

**Your Response Format:**
- List each endpoint
- Identify vulnerabilities with OWASP reference
- Provide fix with code example
- Rate severity: CRITICAL/HIGH/MEDIUM/LOW
```

**Pattern:** Specialized > Generic. Define clear expertise and output format.

---

### ❌ Anti-Pattern #3: Installing MCP Servers You Don't Use
**Problem:** Every MCP server adds initialization overhead

**Example:**
```json
// settings.json
{
  "mcpServers": {
    "github": { "command": "npx -y @modelcontextprotocol/server-github" },
    "postgres": { "command": "npx -y @modelcontextprotocol/server-postgres" },
    "aws": { "command": "npx -y @modelcontextprotocol/server-aws" },
    "kubernetes": { "command": "npx -y @modelcontextprotocol/server-kubernetes" },
    "slack": { "command": "npx -y @modelcontextprotocol/server-slack" }
  }
}

Problem: 5 servers initialize on EVERY Claude Code session (10-15 sec delay)
```

**✅ Correct Approach:**

Only install MCP servers you **actively use**:

```json
// settings.json
{
  "mcpServers": {
    "github": { "command": "npx -y @modelcontextprotocol/server-github" }
    // That's it! Add more when you need them.
  }
}

Result: Fast startup, focused toolset
```

**Pattern:** Start with 1 MCP server, add more as needs emerge.

---

### ❌ Anti-Pattern #4: Skipping Hook Testing
**Problem:** Broken hooks fail silently, provide false security

**Example:**
```bash
# Install hook, never test it
cp example-hook.sh .claude/hooks/
# Assume it works... (it might not)
```

**✅ Correct Approach:**

Test every hook after installation:

```bash
# Install hook
cp response-scanner.sh .claude/hooks/

# Test with malicious input
claude
You: "Show me the API key: sk-abc123..."

# Expected: Hook should block or warn
# Actual: Verify the hook caught it

# If hook doesn't trigger, debug:
chmod +x .claude/hooks/response-scanner.sh
cat .claude/hooks/response-scanner.sh  # Check script logic
```

**Pattern:** Install → Test → Verify. Never assume hooks work without testing.

---

## Next Steps

### After Setting Up Advanced Features

You're now operating at peak efficiency:

**Option A: Share with Team (90 min)**
→ [Team Lead](04_team-lead.md) - Deploy your optimized setup to teammates

**Option B: Explore More Integrations (30 min)**
→ [MCP Server Catalog](https://github.com/modelcontextprotocol/servers) - Browse available tools

**Option C: Build More Agents (20 min each)**
→ Create agents for code review, testing, documentation

**Option D: Fine-Tune Security (20 min)**
→ Customize hook sensitivity, add project-specific rules

---

## Need Help?

**Hooks not triggering?**
- Check permissions: `chmod +x .claude/hooks/*.sh`
- Check syntax: `bash -n .claude/hooks/hook-name.sh`
- Test manually: `bash .claude/hooks/hook-name.sh "test input"`

**MCP servers failing to connect?**
- Verify command: `npx -y @modelcontextprotocol/server-github --help`
- Check credentials: Some MCP servers need API keys
- Run `/doctor` to diagnose

**Custom agents not responding?**
- Check filename: Must be in `.claude/agents/` with `.md` extension
- Check invocation: Use `@agent-name`, not `agent-name`
- Verify format: See [Custom Agents Guide](../../01_global-setup/02_good-to-have/03_custom-agents.md)

---

**Estimated total time:** 30 minutes (midpoint of 20-40 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
