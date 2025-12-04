# MCP Server Configuration Examples

Model Context Protocol (MCP) servers extend Claude Code's capabilities with external tools and resources.

## Context7 (Recommended)

**What it does:** Provides up-to-date library documentation, eliminating API hallucinations.

**Setup:**
```bash
# Add to your project
claude mcp add context7 npx -- -y @upstash/context7-mcp

# Get API key
Visit: https://context7.com/dashboard
```

**Configuration** (automatically added to project `.claude.json`):
```json
{
  "mcpServers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "ctx7sk-..."
      }
    }
  }
}
```

**Usage:**
```
You: "How do I use React Server Components? use context7"
Claude: [Fetches latest React docs]
```

**Supported Libraries:**
- React, Next.js, Vue, Angular
- Python: Django, FastAPI, Flask, SQLAlchemy
- Node.js: Express, NestJS, Prisma
- Cloudflare Workers, Vercel Edge
- And many more...

## Other Useful MCP Servers

### GitHub MCP
Access repository data and manage issues/PRs.

```bash
claude mcp add github npx -- -y @modelcontextprotocol/server-github
```

### Database MCP
Query databases directly from Claude Code.

```bash
# PostgreSQL
claude mcp add postgres npx -- -y @modelcontextprotocol/server-postgres

# Configuration needed in project .claude.json
```

### Filesystem MCP
Enhanced file operations beyond built-in tools.

```bash
claude mcp add filesystem npx -- -y @modelcontextprotocol/server-filesystem
```

## MCP Server Best Practices

1. **Install per-project**: MCP servers are configured in project `.claude.json`
2. **Secure API keys**: Never commit `.claude.json` to git
3. **Test connection**: Use `/mcp` command to verify status
4. **Fallback gracefully**: Claude can use WebSearch if MCP fails

## Troubleshooting

**Server not connecting?**
```bash
# Check status
claude
/mcp

# Look for "connected" status
```

**Slow startup?**
- MCP servers load on Claude Code startup
- First run downloads packages via npx
- Subsequent runs use cached packages

**Need more servers?**
- Browse official registry: https://github.com/modelcontextprotocol/servers
- Check community servers: https://mcp.so/

## Configuration Location

MCP servers are configured in:
- **Project level**: `/path/to/project/.claude.json` (per-project)
- **User level**: `~/.claude/mcp.json` (global)

**Recommendation:** Use project-level for team collaboration.
