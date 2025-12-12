# 02 - Optimization

**Token-saving strategies and configuration patterns**

---

## What's in This Section?

Learn how to optimize Claude Code for maximum efficiency and minimum cost.

### 🎯 Optimization Guides (Coming Soon)

**PROMPT_CACHING_GUIDE.md** (Commit 7)
- How Claude Code's automatic caching works
- Environment variables to control caching
- Token savings: 400-600 tokens per multi-turn conversation
- File structure patterns that maximize cache hits

**MCP_OPTIMIZATION_GUIDE.md** (Commit 7)
- Selectively enable/disable MCP servers
- Official configuration fields (validated)
- Token impact: 50-100 tokens per MCP
- Project-type optimization patterns

**ENVIRONMENT_VARIABLES.md** (Commit 7)
- Complete reference for all Claude Code env vars
- Token control, caching, authentication, debugging
- How to set per-project configurations
- Real features (no imaginary configs)

---

## Why Optimization Matters

**Token savings translate to:**
- 50-95% cost reduction
- Faster response times
- More context available for actual code
- Better long-term project sustainability

**Current template features:**
- Automatic prompt caching (400-600 tokens saved)
- Context management (CLAUDE.md system)
- Model switching (Sonnet for planning, Haiku for execution)
- MCP selective loading (100-200 tokens saved)

---

## Optimization Philosophy

**From the plan:**
> "Unlike original plan, Phase 2 no longer invents config fields. It documents how to use REAL features (caching, env vars, MCP controls) that already exist in Claude Code."

**This section teaches:**
- ✅ How to use OFFICIAL Claude Code features
- ✅ Real environment variables (not imaginary settings)
- ✅ Validated configuration patterns
- ❌ NO invented features or fake configurations

---

## Recommended Reading Order

1. **Prompt Caching Guide** - Understand automatic caching (10 min) ← Coming soon
2. **Environment Variables** - Configuration reference (5 min) ← Coming soon
3. **MCP Optimization** - Selective loading (10 min) ← Coming soon

---

## Learning Outcome

**After this section, you'll know:**
- ✅ How Claude Code caching works automatically
- ✅ Which environment variables control behavior
- ✅ How to optimize MCP loading for your project type
- ✅ Real token savings (400-600 per session from caching alone)

---

**Previous:** [01-Fundamentals](../01-fundamentals/) - Core concepts and tools
**Next:** [03-Advanced](../03-advanced/) - Power user techniques
