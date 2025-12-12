# Third-Party MCP Servers

**Community-built tools to extend Claude Code**

---

## Sources & Validation

**⚠️ THIRD-PARTY NOTICE:** These are community-built tools, NOT official Anthropic products.

**Official Claude Code Documentation:**
- MCP Protocol: https://modelcontextprotocol.io ✅ VALIDATED
- MCP Server installation: Official Claude Code feature

**Community Insights:**
Analysis from NotebookLLM covering three YouTube sources:
- "Vibe Coding vs AI Augmented Coding": https://www.youtube.com/watch?v=hwEgheORjjs
- "800+ Hours of Claude Code Experience": https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- "Claude Code Agent Skills": https://www.youtube.com/watch?v=CEvIs9y1uog

**Note:** Power users recommend these MCPs based on real-world experience. Not endorsed by Anthropic.

---

## What Are Third-Party MCPs?

**Official MCPs** (built by Anthropic):
- filesystem (read/write files)
- github (PRs, issues, repos)
- memory (knowledge graphs)
- sequential-thinking (extended reasoning)

**Third-Party MCPs** (built by community):
- Context7 (latest library docs)
- Supabase (database operations)
- Playwright (browser automation)
- Stripe (payment integration)
- ...and many more

**How they work:**
1. Install via `claude mcp add` command
2. Configure in `.claude/.mcp.json`
3. Available to Claude Code in all projects
4. Same Tool Use API as official MCPs

---

## Context7 MCP (Recommended by Power Users)

### What It Does

**Purpose:** Fetches latest documentation for popular libraries

**Why it's valuable:**
- Claude's training data has a cutoff date
- Libraries update frequently (Next.js, React, etc.)
- Official docs are the source of truth
- No more outdated API recommendations

**Quote from power users:**
> "Context7 solves the documentation staleness problem - Claude gets the LATEST library docs"

---

### Installation

**1. Install Context7:**
```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
```

**2. Verify installation:**
```bash
cat ~/.claude/.mcp.json
```

You should see:
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

**3. Test it:**
```
You: "Create Next.js middleware... use context7"
Claude: *fetches latest Next.js docs, uses current API*
```

---

### Usage Patterns

**Pattern 1: Explicit Request**
```
You: "Create a React component with the latest hooks API. Use context7."
```

**Pattern 2: When Unsure**
```
You: "What's the current best practice for Next.js data fetching? Check context7."
```

**Pattern 3: Version-Specific**
```
You: "How do I use Tailwind CSS v4? Use context7 for the latest docs."
```

**When NOT needed:**
- Stable APIs (Python standard library)
- Your own internal code
- Language fundamentals (JavaScript, TypeScript)

---

### Supported Libraries

**Context7 covers 100+ popular libraries:**
- **Frameworks:** Next.js, React, Vue, Svelte, Angular
- **Databases:** Prisma, Drizzle, Sequelize
- **Styling:** Tailwind CSS, Styled Components
- **Testing:** Jest, Vitest, Playwright
- **Build Tools:** Vite, Webpack, esbuild
- ...and more

**Check full list:**
Visit https://context7.com or ask Claude: "What libraries does context7 support?"

---

## Supabase MCP

### What It Does

**Purpose:** Direct database operations from Claude Code

**Capabilities:**
- Create tables and schemas
- Run migrations
- Execute SQL queries
- View database structure
- Insert/update/delete data

**Use case:** "Add a new feature that needs a database table"

**Example workflow:**
```
You: "Add user preferences table"
Claude:
  1. Designs schema (following best practices)
  2. Generates migration SQL
  3. Uses Supabase MCP to apply migration
  4. Verifies table created successfully
```

---

### Installation

**Note:** Installation varies by Supabase MCP implementation. Check the specific MCP's documentation.

**General pattern:**
```bash
claude mcp add supabase -- <installation-command>
```

**Configuration:**
You'll need:
- Supabase project URL
- Supabase API key (service role)

**Add to environment:**
```bash
export SUPABASE_URL=https://your-project.supabase.co
export SUPABASE_KEY=your-service-role-key
```

---

### Usage Examples

**Example 1: Create Migration**
```
You: "Add posts table with user_id, title, content, published_at"

Claude:
  1. Uses Supabase MCP to inspect current schema
  2. Generates migration:
     CREATE TABLE posts (
       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
       user_id UUID REFERENCES users(id),
       title TEXT NOT NULL,
       content TEXT,
       published_at TIMESTAMP,
       created_at TIMESTAMP DEFAULT NOW()
     );
  3. Applies migration via Supabase MCP
  4. Confirms success
```

**Example 2: Query Analysis**
```
You: "Why is the user dashboard slow?"

Claude:
  1. Uses Supabase MCP to run EXPLAIN ANALYZE
  2. Identifies N+1 query pattern
  3. Suggests adding index
  4. Can apply fix if approved
```

---

## Playwright MCP

### What It Does

**Purpose:** Autonomous browser automation and UI testing

**Capabilities:**
- Open browser programmatically
- Navigate to pages
- Inspect DOM elements
- Check console logs
- Take screenshots
- Test accessibility (WCAG)
- Verify responsive design

**Use case:** "Test the login component for accessibility issues"

---

### Installation

**Check Playwright MCP documentation for exact installation command.**

**General pattern:**
```bash
claude mcp add playwright -- <installation-command>
```

---

### Usage Examples

**Example 1: Accessibility Audit**
```
You: "Test the login page for WCAG compliance"

Claude (via Playwright MCP):
  1. Opens browser to login page
  2. Checks for ARIA labels
  3. Tests keyboard navigation
  4. Verifies color contrast
  5. Takes screenshots of issues
  6. Generates detailed report
```

**Example 2: Responsive Testing**
```
You: "Verify the dashboard works on mobile"

Claude:
  1. Opens browser in mobile viewport
  2. Navigates to dashboard
  3. Checks for layout issues
  4. Tests touch interactions
  5. Screenshots at different breakpoints
```

---

### UI Testing Sub-Agent Pattern

**Combining Sub-Agent + Playwright MCP:**

```yaml
---
name: ui-reviewer
description: Tests UI components for accessibility and responsiveness
allowed-tools: Read, Playwright
---

# UI Reviewer Sub-Agent

## Task
Test UI components for:
- WCAG accessibility compliance
- Responsive design (mobile, tablet, desktop)
- Keyboard navigation
- Screen reader compatibility
```

**Usage:**
```
You: "Review the user profile component"

Claude:
  1. Spawns ui-reviewer sub-agent
  2. Sub-agent uses Playwright to open component
  3. Runs full accessibility + responsive tests
  4. Returns detailed report
```

**Quote from power users:**
> "Playwright MCP enables autonomous front-end debugging and testing"

---

## Other Recommended Third-Party MCPs

### Stripe MCP

**Purpose:** Payment integration workflows

**Capabilities:**
- Create payment intents
- Manage subscriptions
- Handle webhooks
- Test payment flows

**Use case:** "Add subscription feature with Stripe"

---

### More Third-Party MCPs

**Discover community MCPs:**
- Search GitHub for "mcp-server"
- Check npm for "@*/mcp" packages
- Ask Claude: "What third-party MCPs are available for [use case]?"

**Popular categories:**
- **Databases:** PostgreSQL, MongoDB, Redis MCPs
- **APIs:** REST API testing, GraphQL MCPs
- **Cloud:** AWS, GCP, Azure MCPs
- **Monitoring:** Datadog, Sentry MCPs

---

## Installing Third-Party MCPs

### General Installation Pattern

**1. Find the MCP:**
- GitHub repositories
- npm packages
- Community recommendations

**2. Install via Claude Code:**
```bash
claude mcp add <name> -- <command> [args]
```

**3. Configure (if needed):**
- Add API keys to environment
- Update `.mcp.json` with config

**4. Verify:**
```bash
cat ~/.claude/.mcp.json
```

**5. Test:**
```
You: "Use [mcp-name] to [task]"
```

---

## Security Considerations

### API Keys and Secrets

**⚠️ CRITICAL:**
- Third-party MCPs may require API keys
- Store keys in environment variables (NOT in .mcp.json)
- Use `.env` files (add to .gitignore)
- Never commit secrets to git

**Example:**
```bash
# .env (add to .gitignore!)
SUPABASE_KEY=your-key
STRIPE_SECRET_KEY=sk_test_...

# Load in shell
export $(cat .env | xargs)
```

---

### Trust and Verification

**Before installing third-party MCPs:**

1. **Check source:**
   - Official repository? (e.g., @upstash/context7-mcp)
   - Community-maintained?
   - Last updated recently?

2. **Review code:**
   - Open-source?
   - Can you audit the code?
   - Active maintainers?

3. **Test in isolation:**
   - Install in test project first
   - Verify it does what it claims
   - Check for unexpected behavior

4. **Monitor usage:**
   - Review MCP calls (use Ctrl+O)
   - Check API usage limits
   - Audit what data is sent

**Quote:**
> "AI-generated code needs human review. Third-party MCPs need the same scrutiny."

---

### Sandboxing and Permissions

**Claude Code's built-in protection:**
- MCPs run in separate processes
- Can't access files outside allowed directories
- Network calls visible in logs (Ctrl+O)

**Your additional protection:**
- Use read-only API keys when possible
- Limit MCP permissions via settings
- Disable unused MCPs

**Example: Disable MCP for specific projects:**
```json
{
  "disabledMcpjsonServers": ["stripe", "supabase"]
}
```

---

## Combining Third-Party MCPs with Skills

### The Power User Pattern

**Skills + Third-Party MCPs = Autonomous Workflows**

**Example: Database Optimization Skill + Supabase MCP**

```
.claude/skills/database-optimization/
├── SKILL.md              # Query optimization expertise
├── query-patterns.md     # Common anti-patterns
└── scripts/
    └── analyze.sql       # Analysis queries
```

**Workflow:**
```
You: "Optimize the user queries in our database"

Claude:
  1. Activates database-optimization Skill (automatic)
  2. Reads query-patterns.md (knows what to look for)
  3. Uses Supabase MCP to inspect actual queries
  4. Runs analyze.sql to get performance metrics
  5. Identifies N+1 queries and missing indexes
  6. Suggests specific optimizations with code examples
```

**Quote:**
> "Developers are using Skills that orchestrate workflows of multiple MCP tools stitched together"

---

## Troubleshooting Third-Party MCPs

### MCP Not Found

**Error:** "MCP server 'context7' not found"

**Solutions:**
1. Check installation:
   ```bash
   cat ~/.claude/.mcp.json
   ```
2. Verify command is correct:
   ```bash
   npx -y @upstash/context7-mcp@latest --version
   ```
3. Reinstall:
   ```bash
   claude mcp remove context7
   claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
   ```

---

### Authentication Errors

**Error:** "Unauthorized" or "Invalid API key"

**Solutions:**
1. Check environment variables:
   ```bash
   echo $SUPABASE_KEY
   ```
2. Verify key is valid (not expired)
3. Ensure key has correct permissions
4. Reload environment:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

---

### Performance Issues

**Symptom:** MCP calls are slow

**Solutions:**
1. Check network connection
2. Verify API rate limits not exceeded
3. Use caching when available
4. Disable unused MCPs (saves tokens too)

---

## FAQ

**Q: Are third-party MCPs safe?**
A: Review the source code, check maintainers, test in isolation. Same due diligence as any third-party package.

**Q: Do third-party MCPs cost tokens?**
A: Yes, each MCP adds ~50-100 tokens to context. Disable unused MCPs.

**Q: Can I create my own MCP?**
A: Yes! See MCP Protocol docs: https://modelcontextprotocol.io

**Q: How do I find more third-party MCPs?**
A: Search GitHub for "mcp-server", check npm for "@*/mcp" packages, ask power users.

**Q: Can I use multiple MCPs in one workflow?**
A: Yes! Skills can orchestrate multiple MCPs. Example: Supabase + Playwright + GitHub for full-stack testing.

**Q: What if an MCP breaks?**
A: Disable it via disabledMcpjsonServers in settings.json. Report issue to maintainer.

---

## Summary

**Third-Party MCP Core Principles:**

1. **Context7 for docs** - Latest library documentation
2. **Supabase for databases** - Direct database operations
3. **Playwright for UI** - Autonomous browser testing
4. **Security first** - Audit code, protect API keys
5. **Skills orchestrate** - Combine MCPs for powerful workflows

**The outcome:**
- ✅ Latest library docs (no stale recommendations)
- ✅ Direct database access (migrations, queries)
- ✅ Autonomous UI testing (accessibility, responsiveness)
- ✅ Powerful workflows (Skills + multiple MCPs)

**Best practice:**
> Install MCPs you actually need. Test them first. Review their actions (Ctrl+O). Combine with Skills for maximum power.

---

**See also:**
- [Advanced MCP Workflows](../03-advanced/ADVANCED_MCP_WORKFLOWS.md) - Orchestrating multiple MCPs
- [MCP Optimization Guide](../02-optimization/MCP_OPTIMIZATION_GUIDE.md) - Selective loading
- [Plugins Guide](PLUGINS_GUIDE.md) - Bundling workflows
