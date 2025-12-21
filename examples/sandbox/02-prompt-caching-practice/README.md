# Sandbox 2: Prompt Caching Practice

**Duration:** 30 minutes
**Skill Level:** Intermediate (Optimization)
**Goal:** Structure CLAUDE.md for optimal prompt caching

## Scenario

Large React project with slow Claude queries. Learn to structure CLAUDE.md for 90% cache hit rate.

## Challenge

**Step 1:** Structure CLAUDE.md with stable content first, dynamic content last
**Step 2:** Ensure content exceeds model minimum (1024+ tokens for Sonnet)
**Step 3:** Calculate cache break-even point (1.25x write, 0.1x read)

## Validation

```bash
./validation.sh
```

Checks:
- ✅ Stable sections before dynamic sections
- ✅ File exceeds 1024 tokens
- ✅ Calculates cache savings correctly

## Solution

See `solution/CLAUDE-optimized.md` for reference structure.

**Learn more:** `../../docs/02-optimization/02_prompt-caching-guide.md`
