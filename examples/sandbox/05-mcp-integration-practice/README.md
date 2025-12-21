# Sandbox 5: MCP Integration Practice

**Duration:** 25 minutes
**Skill Level:** Advanced (Strategic)
**Goal:** Selective MCP loading for token efficiency

## Scenario

Local-only MCP setup (no API keys required). Practice enabling only needed MCPs.

## Challenge

**Step 1:** Identify which MCPs you need (filesystem always, others optional)
**Step 2:** Configure `.claude/settings.json` with selective loading
**Step 3:** Understand restart requirement for plugin MCPs

## Key Learning

- Each MCP adds ~50-100 tokens per request
- Disable unused MCPs: Save 100-200 tokens/request
- Filesystem MCP: Essential
- GitHub MCP: Only if committing via Claude
- Sequential-thinking MCP: Only for complex analysis

**Learn more:** `../../docs/02-optimization/03_mcp-optimization-guide.md`
