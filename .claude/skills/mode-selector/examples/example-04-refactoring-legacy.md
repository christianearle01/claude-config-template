# Example 4: Refactoring Legacy Code (Vibe Engineering)

## User Message

"Our codebase is a mess. No tests, duplicate code everywhere, hard to add features. Should I just rewrite from scratch or try to refactor? We have 5,000 active users depending on this daily."

## Skill Activation

**Trigger detected:** Transition point question ("rewrite or refactor?") + Quality uncertainty (implied: how much effort is appropriate?)

**Context signals:**
- Permanent (5k users, production system)
- High risk (existing users depend on this)
- Timeline implied as flexible (strategic decision, not urgent)

**Lightweight analysis:**
- Temporary? **No** → Vibe Engineering
- High risk? **Yes** → Vibe Engineering
- Tight timeline? **No** → Vibe Engineering

**Score:** 3/3 signals point to Vibe Engineering

## Skill Response

```
🎯 I noticed you're considering refactoring vs rewriting legacy code.
Let me help you choose the right mode for this task.

Based on what you've described, I recommend: **Vibe Engineering (Refactor, Don't Rewrite)**

With 5k active users, rewriting from scratch is extremely high-risk. Instead, use incremental refactoring: (1) Write characterization tests first (understand current behavior), (2) Refactor in small steps (verify tests pass after each change), (3) Improve gradually (don't change behavior and structure simultaneously), (4) Use Strangler Fig pattern (build new alongside old, migrate gradually). This takes 6-8 weeks but maintains stability.

Want detailed analysis? Invoke @mode-selector for full 6-dimension breakdown.
```

## Expected User Actions

**Vibe Engineering (Incremental Refactoring) approach:**

**Week 1: Characterization Testing**
- Document all current behaviors (even buggy ones)
- Write tests that verify existing behavior
- Goal: 80%+ coverage before touching code
- These tests will catch regressions during refactoring

**Week 2-3: Incremental Refactoring**
- Extract functions (break up monolithic code)
- Remove duplication (DRY principle)
- Clarify naming (make code self-documenting)
- **Rule:** Run tests after EVERY change (catch breakage immediately)

**Week 4-5: Architecture Improvement**
- Separate concerns (UI, business logic, data access)
- Introduce abstractions (but only where needed)
- Simplify complex logic (reduce cyclomatic complexity)

**Week 6: Integration Testing**
- End-to-end test suite (verify system works as a whole)
- Performance testing (ensure no regressions)
- User acceptance testing (real users validate changes)

**Week 7-8: Staged Rollout**
- Feature flags (toggle between old/new code paths)
- Gradual rollout: 1% → 10% → 50% → 100%
- Monitoring (detect issues immediately)
- Easy rollback (revert if problems arise)

## Why Refactor Instead of Rewrite?

**Rewrite risks (why NOT to rewrite):**
- 6+ months development time (vs 6-8 weeks refactoring)
- Months without new features (opportunity cost)
- High probability of introducing new bugs (reimplemented bugs)
- Users affected by outages (switching costs)
- **80% of rewrites fail** (industry data)

**Refactoring benefits (why this is better):**
- Continuous stability (users unaffected)
- Incremental improvement (steady progress)
- Learn from existing code (preserve domain knowledge)
- Easy rollback (small, reversible changes)
- **Test safety net** (catch regressions immediately)

## Why This Recommendation Is Correct

**Indicators of success:**
- ✅ Zero user-facing downtime (stable throughout)
- ✅ Code is now maintainable (future changes are easier)
- ✅ Tests provide safety (future refactoring is safe)
- ✅ Completed in 6-8 weeks (vs 6+ months for rewrite)

**If user had chosen Vibe Coding (rewrite) instead:**
- ❌ 6+ months with no new features (competitive disadvantage)
- ❌ New bugs introduced (reimplemented edge cases incorrectly)
- ❌ Users frustrated by instability (churn risk)
- ❌ High chance of project abandonment (80% failure rate)

**Lesson:** "The only thing more dangerous than bad code is a complete rewrite." - Joel Spolsky

## Refactoring Best Practices

**Safe refactoring principles:**
1. **Tests first** - Never refactor without tests
2. **Small steps** - Commit after every change
3. **One thing at a time** - Don't change behavior and structure simultaneously
4. **Run tests constantly** - Catch breakage immediately
5. **Feature flags** - Enable safe rollback

**Strangler Fig Pattern:**
```
Old System ← [Traffic] → New System (built alongside)
              ↓ (gradually migrate)
Old System (deprecated) ← New System (fully migrated)
```

**When rewriting IS appropriate:**
- Technology is obsolete (language/framework no longer maintained)
- Architecture is fundamentally wrong (can't be fixed incrementally)
- Codebase is truly small (< 10k lines, rewrite in 2-4 weeks)
- No active users yet (pre-launch refactoring)

**This scenario doesn't qualify:** 5k active users = rewrite is too risky.
