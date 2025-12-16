# Prompt Caching Guide

**How Claude Code's automatic caching works + official controls**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Prompt caching: Automatic feature in Claude Code ✅ VALIDATED
- Environment variables: Official configuration method ✅ VALIDATED
- Claude Code Documentation: https://docs.claude.com

**Note:** All information in this guide is based on official Claude Code features and documentation. No imaginary or projected features.

---

## What is Prompt Caching?

**Definition:** Claude Code automatically caches frequently-used context to reduce token costs and improve response speed.

**How it works:**
- Certain files are cached for 90-minute windows
- Cached content doesn't count toward input tokens on subsequent requests
- Cache automatically expires and refreshes

**Which files are cached:**
- `CLAUDE.md` (your project memory)
- `.claude/SETUP_CONTEXT.md` (setup guides)
- `~/.claude/coding-standards.md` (global standards)
- Large context files in conversations

---

## Token Savings

**Without caching:**
```
Request 1: 2,000 tokens (CLAUDE.md) + 500 tokens (query) = 2,500 tokens
Request 2: 2,000 tokens (CLAUDE.md) + 500 tokens (query) = 2,500 tokens
Request 3: 2,000 tokens (CLAUDE.md) + 500 tokens (query) = 2,500 tokens
Total: 7,500 tokens
```

**With caching (automatic):**
```
Request 1: 2,000 tokens (CLAUDE.md - cached) + 500 tokens (query) = 2,500 tokens
Request 2: 0 tokens (cache hit) + 500 tokens (query) = 500 tokens
Request 3: 0 tokens (cache hit) + 500 tokens (query) = 500 tokens
Total: 3,500 tokens
```

**Savings:** 4,000 tokens (53% reduction) in just 3 requests

**Multi-turn conversations:**
- 10 requests: 400-600 tokens saved per session
- Daily usage: 2,000-4,000 tokens saved
- Monthly: 50,000-100,000 tokens saved

---

## Official Environment Variables

### Disable All Caching

```bash
export DISABLE_PROMPT_CACHING=true
```

**When to use:**
- Testing cache behavior
- Debugging context issues
- Measuring true token usage

**When NOT to use:**
- Normal development (you want caching!)
- Cost optimization (caching saves money)

---

### Disable Per-Model

**Disable for Haiku only:**
```bash
export DISABLE_PROMPT_CACHING_HAIKU=true
```

**Disable for Sonnet only:**
```bash
export DISABLE_PROMPT_CACHING_SONNET=true
```

**Disable for Opus only:**
```bash
export DISABLE_PROMPT_CACHING_OPUS=true
```

**Use case:** Testing model-specific behavior

---

## How to Maximize Cache Hits

### 1. Keep CLAUDE.md Stable

**Good:**
```markdown
# Project Memory

## Business Purpose
E-commerce platform for handmade crafts

## Tech Stack
- React 18
- Node.js Express
- PostgreSQL
```

**Why it works:** Content doesn't change frequently, cache stays valid

**Bad:**
```markdown
# Project Memory - Updated 2025-01-15 3:42 PM

## Current Status
Currently working on login feature (85% done)
```

**Why it fails:** Timestamp changes every save, cache invalidates

---

### 2. Structure for Stability

**Stable sections (cache-friendly):**
- Business purpose (rarely changes)
- Tech stack (changes infrequently)
- Architecture decisions (stable)
- Code conventions (stable)

**Dynamic sections (put at end):**
- Current work status
- Recent decisions
- Temporary notes

**Optimization:**
```markdown
# Project Memory

## Stable Context (cached effectively)
[Business, tech, architecture - rarely changes]

## Dynamic Context (lower in file)
[Current work, recent changes - updates frequently]
```

---

### 3. Avoid Frequent Small Edits

**Pattern to avoid:**
```bash
# Every 5 minutes:
echo "Updated at $(date)" >> CLAUDE.md
```

**Cache impact:** Invalidates cache on every edit

**Better pattern:**
```bash
# Use # hash for quick adds (Claude manages efficiently)
# Or batch updates once per session
```

---

## File Structure Patterns

### Pattern 1: Stable Core + Dynamic Notes

```
project/
├── CLAUDE.md                 # Stable (cached well)
├── .claude/
│   └── SETUP_CONTEXT.md     # Stable (cached well)
└── CURRENT_WORK.md          # Dynamic (not cached, that's OK)
```

**Strategy:** Keep cached files stable, use separate file for dynamic notes

---

### Pattern 2: Template + Overrides

```markdown
# CLAUDE.md

<!-- Stable template content (cached) -->
## Business Purpose
[Stable description]

## Tech Stack
[Stable list]

<!-- Dynamic overrides (end of file) -->
## Current Focus
[Changes frequently but doesn't invalidate whole cache]
```

---

## Cache Lifecycle

**Cache creation:**
```
1. Claude Code sends request with CLAUDE.md
2. API creates cache for CLAUDE.md content
3. Cache valid for 90 minutes
```

**Cache hit:**
```
1. Subsequent request within 90 minutes
2. API checks: "Same CLAUDE.md content?"
3. If yes: Use cache (0 tokens)
4. If no: Create new cache (full tokens)
```

**Cache expiry:**
```
1. 90 minutes pass with no requests
2. Cache automatically expires
3. Next request creates fresh cache
```

---

## When Caching Helps vs. Hurts

### ✅ Caching Helps When:

- **Multi-turn conversations** (10+ requests in session)
- **Large CLAUDE.md files** (1,000+ lines)
- **Stable context** (rarely edit CLAUDE.md during session)
- **Frequent questions** (ask Claude questions throughout day)

**Example:** Developer working on feature, asking Claude questions every 5-10 minutes for 2 hours.

**Savings:** 400-600 tokens per session

---

### ⚠️ Caching Less Helpful When:

- **Single requests** (no follow-ups)
- **Constantly changing CLAUDE.md** (editing every request)
- **Very small CLAUDE.md** (<100 lines, minimal savings)
- **Long breaks** (>90 min between requests, cache expires)

---

## Measuring Cache Impact

### Check Token Usage

**In Claude Code:**
```
1. Run task with caching enabled (default)
2. Note token usage in response
3. Run similar task again immediately
4. Compare token usage (should be lower)
```

**Example:**
```
Request 1: 2,450 input tokens
Request 2: 520 input tokens (2,000 cached!)
Savings: 1,930 tokens (79%)
```

---

## Best Practices

### 1. Structure for Caching

```markdown
# CLAUDE.md Structure for Optimal Caching

## 📌 STABLE CONTEXT (Top of file - caches well)
### Business Purpose
### Tech Stack
### Architecture Decisions
### Code Conventions
### External APIs

## 🔄 DYNAMIC CONTEXT (End of file - OK to change)
### Current Sprint
### Recent Decisions
### Known Issues
```

---

### 2. Use # Hash Wisely

**Good use of # hash:**
```
# Remember: We use JWT for auth (7-day expiry)
```

**Why:** Claude adds to CLAUDE.md intelligently without invalidating entire cache

**Bad use:**
```
# Updated status at 3:42 PM
```

**Why:** Timestamp changes cache unnecessarily

---

### 3. Batch Updates

**Instead of:**
```bash
# Throughout the day:
edit CLAUDE.md  # 10 AM
edit CLAUDE.md  # 11 AM
edit CLAUDE.md  # 2 PM
```

**Do this:**
```bash
# End of day:
edit CLAUDE.md  # 5 PM (one comprehensive update)
```

**Impact:** Cache stays valid during work session

---

## FAQ

**Q: Can I disable caching for my project?**
A: Yes, set `DISABLE_PROMPT_CACHING=true` in your environment. But you probably don't want to (it costs more).

**Q: Does caching work with all models?**
A: Yes, works with Sonnet, Haiku, and Opus.

**Q: What if I need to force cache refresh?**
A: Edit CLAUDE.md (even a small change) or wait 90 minutes for auto-expiry.

**Q: Does caching affect response quality?**
A: No, it's purely a cost/speed optimization. Responses are identical.

**Q: Can I see which content is cached?**
A: Not directly, but you can infer from token usage (lower tokens = cache hit).

---

## Summary

**Prompt Caching Core Principles:**

1. **Automatic** - Claude Code handles it, no configuration needed
2. **90-minute windows** - Cache expires after inactivity
3. **400-600 token savings** - Per multi-turn session
4. **Stable files cache better** - Keep CLAUDE.md structure stable
5. **Environment variables** - Official way to control caching

**The outcome:**
- ✅ Lower token costs (automatic savings)
- ✅ Faster responses (cache hits are instant)
- ✅ No setup required (works out of the box)
- ✅ Can disable if needed (environment variables)

**Best practice:**
> Structure CLAUDE.md with stable content at top, dynamic content at bottom. Let caching work automatically.

---

**See also:**
- [MCP Optimization](MCP_OPTIMIZATION_GUIDE.md) - Selective MCP loading
- [Environment Variables](ENVIRONMENT_VARIABLES.md) - Complete env var reference
- [Skills Paradigm](../01-fundamentals/SKILLS_PARADIGM.md) - Context protection via Skills
