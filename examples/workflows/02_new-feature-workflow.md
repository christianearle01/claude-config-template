# Workflow Example: New Feature

**Scenario:** Build user profile page with avatar upload and settings
**Complexity:** High (multi-session feature)
**Time:** 3 sessions (~90 minutes total)
**Tokens used:** ~8,500 tokens (vs ~15,000 traditional approach)

---

## Initial State

**Product requirement:**
```
Users need a profile page where they can:
- Upload profile photo
- Edit display name and bio
- Update notification preferences
- View account statistics
```

**What we know:**
- Feature scope is clear
- Will take multiple sessions to complete
- Need persistent memory across sessions

**What we don't know:**
- Exact implementation approach
- Which files need changes
- How to maintain context across sessions

---

## Decision Point 1: Implementation Approach?

**Options considered:**
1. **Ad-hoc coding** - Jump in and start building
2. **Plan agent only** - Create detailed plan, then implement manually
3. **Domain Memory pattern** - Initializer + Coder agents with persistent artifacts

**Decision:** Use **Domain Memory pattern** (Option 3)

**Reasoning:**
- Multi-session feature (will lose context without memory)
- Clear requirements (good candidate for structured breakdown)
- Want atomicity (complete features incrementally, not all-or-nothing)
- Long-term project (need to pick up where we left off)

**Models selected:**
- Initializer agent: **Opus** (feature decomposition requires creativity)
- Coder agent: **Sonnet** (implementation work)

**Tokens:** Decision made, no tools used yet (~0 tokens)

---

## Decision Point 2: Launch Initializer Agent

**Question:** How to structure the feature breakdown?

**Decision:** Use Initializer agent to create domain memory artifacts

**Tool used:**
```bash
@initializer Build user profile page with avatar upload, settings, and stats display
```

**Initializer output:**
- Created `features.json` (structured task breakdown)
- Created `progress.md` (session journal)
- Defined bootup ritual checklist

**features.json excerpt:**
```json
{
  "features": [
    {
      "id": "profile-001",
      "name": "Profile Page Route and Layout",
      "description": "Create /profile route with basic layout structure",
      "priority": "HIGH",
      "dependencies": [],
      "test_criteria": [
        "Route /profile renders without errors",
        "Layout includes header, content, footer sections"
      ],
      "status": "pending"
    },
    {
      "id": "profile-002",
      "name": "Avatar Upload Component",
      "description": "Build avatar upload with preview and validation",
      "priority": "HIGH",
      "dependencies": ["profile-001"],
      "test_criteria": [
        "Can select image file",
        "Preview shows before upload",
        "Only accepts image types",
        "Shows upload progress"
      ],
      "status": "pending"
    }
    // ... 6 more features
  ]
}
```

**Bootup ritual checklist:**
```markdown
## Bootup Ritual

Every session, Claude should:
1. Read features.json (understand task structure)
2. Read progress.md (understand what's been done)
3. Run `npm test -- profile` (verify existing features still work)
4. Identify next feature with status="pending" and dependencies met
5. Propose next task with confidence score
```

**Tokens:** ~2,000 tokens (Opus for decomposition)

---

## Session 1: Initial Setup

### Decision Point 3: Which Feature First?

**Coder agent bootup:**
1. ✅ Read features.json → 8 features identified
2. ✅ Read progress.md → Empty (first session)
3. ✅ Run tests → Base tests passing
4. ✅ Identify next task → profile-001 (no dependencies)

**Proposal:**
```
Next Task: profile-001 - Profile Page Route and Layout
Confidence: 🟢 High (95%)

Rationale:
- No dependencies (safe to start)
- Foundation for all other features
- Clear test criteria
- Low risk (just route + layout)

Estimated tokens: ~800 (route + layout + tests)
```

**User approval:** "Yes, proceed"

**Tool used:**
```bash
@coder implement profile-001
```

**Coder implementation:**
1. Created `src/pages/ProfilePage.tsx` (layout structure)
2. Added route to `src/routes.tsx`
3. Created test file `src/pages/ProfilePage.test.tsx`
4. Ran tests → All passing ✅
5. Updated features.json → profile-001 status="completed"
6. Updated progress.md with session notes

**Tokens used (Session 1):** ~1,200 tokens
- Read domain memory: 200 tokens
- Implementation: 800 tokens
- Update artifacts: 200 tokens

**Commit:**
```bash
git commit -m "feat: Add profile page route and basic layout

Implements profile-001 from features.json.
Includes route, layout structure, and tests.

Related: profile-002 (avatar upload) is next"
```

**Session 1 ends.** Context preserved in features.json + progress.md.

---

## Session 2: Avatar Upload (Next Day)

### Decision Point 4: Resuming Work

**Problem:** New session, blank slate for Claude. How to resume?

**Solution:** Bootup ritual executes automatically

**Coder agent bootup (Session 2):**
1. ✅ Read features.json → profile-001 completed, 7 pending
2. ✅ Read progress.md → "Session 1: Created route and layout"
3. ✅ Run tests → All passing (verified no regressions)
4. ✅ Identify next task → profile-002 (dependency profile-001 met)

**No regrounding needed!** Domain memory provides full context.

**Proposal:**
```
Next Task: profile-002 - Avatar Upload Component
Confidence: 🟢 High (92%)

Rationale:
- Dependency met (profile-001 completed)
- Clear test criteria (4 specific requirements)
- Standard pattern (file upload with preview)

Estimated tokens: ~1,500 (component + upload logic + tests)
```

**User approval:** "Go ahead"

**Implementation:**
1. Created `src/components/AvatarUpload.tsx`
2. Added image validation logic
3. Created upload preview component
4. Added progress indicator
5. Wrote comprehensive tests (4 test criteria from features.json)
6. Ran tests → All passing ✅
7. Updated artifacts

**Tokens used (Session 2):** ~2,300 tokens
- Bootup (read memory, tests): 300 tokens
- Implementation: 1,500 tokens
- Update artifacts: 200 tokens
- **Regrounding saved:** 700 tokens (vs starting from scratch)

**Session 2 ends.**

---

## Session 3: Settings and Stats (Week Later)

### Decision Point 5: Long Gap, Still Works

**Context:** User returns after 1 week. Traditional approach would require:
- Re-reading all code
- Understanding what's done vs what's left
- Explaining previous decisions

**Domain memory approach:**
Bootup ritual works identically. Time gap irrelevant.

**Coder agent bootup (Session 3):**
1. ✅ Read features.json → 2 completed, 6 pending
2. ✅ Read progress.md → Full history of Sessions 1-2
3. ✅ Run tests → All passing
4. ✅ Identify next tasks → profile-003, profile-004, profile-005

**Proposal (3 features at once):**
```
Next Tasks: Settings + Stats (3 features)
Confidence: 🟡 Medium (78%)

Rationale:
- All dependencies met
- Can implement together (related UI sections)
- Test criteria clear for all 3

Estimated tokens: ~2,500

Risk: Slightly larger scope, but features are independent
```

**User approval:** "Yes, but do them one at a time"

**Implementation:** (profile-003 → profile-004 → profile-005)
Each feature: Implement → Test → Update artifacts → Commit atomically

**Tokens used (Session 3):** ~3,500 tokens
- Bootup: 300 tokens
- 3 features: 2,400 tokens (800 each)
- Updates: 300 tokens
- **Regrounding saved:** 1,000 tokens

---

## Final Workflow Summary

```
Session 1: Initializer + Feature 1
├─ @initializer                     → 2,000 tokens (Opus)
├─ @coder (profile-001)             → 1,200 tokens (Sonnet)
└─ Total: 3,200 tokens

Session 2: Feature 2 (next day)
├─ Bootup ritual                    →   300 tokens
├─ @coder (profile-002)             → 2,000 tokens
└─ Total: 2,300 tokens
   Regrounding saved: 700 tokens

Session 3: Features 3-5 (1 week later)
├─ Bootup ritual                    →   300 tokens
├─ @coder (profile-003/004/005)     → 3,200 tokens
└─ Total: 3,500 tokens
   Regrounding saved: 1,000 tokens

─────────────────────────────────────────
TOTAL: 9,000 tokens (3 sessions)
REGROUNDING SAVED: 1,700 tokens (19%)
```

**Traditional approach (estimated):**
```
Session 1: Manual implementation      → 3,000 tokens
Session 2: Re-read code, continue     → 5,000 tokens (3K regrounding)
Session 3: Re-read again, continue    → 7,000 tokens (4K regrounding)
─────────────────────────────────────────
TOTAL: 15,000 tokens (67% more!)
```

**Time saved:** ~45 minutes across 3 sessions (no context switching)

---

## Alternative Approach (Ad-Hoc Coding)

**What if we'd just started coding without Initializer?**

```
Session 1: Build everything at once
├─ Manual breakdown in head         → No artifact
├─ Code until done                  → 8,000 tokens
├─ Tests afterward (if at all)      → 1,000 tokens
└─ Status: 70% complete, unclear what's left

Session 2: Resume (unclear state)
├─ Re-read all code                 → 3,000 tokens
├─ Figure out what's left           → ???
├─ Restart some work (duplicate)    → 2,000 tokens
└─ Status: 85% complete, bugs appearing

Session 3: Finish + fix bugs
├─ Re-read everything again         → 3,500 tokens
├─ Fix integration bugs             → 2,500 tokens
├─ Finally done                     → 20,000 total tokens
```

**Problems with ad-hoc:**
- No clear task breakdown
- Context loss across sessions
- Integration bugs (not tested incrementally)
- Duplicate work
- **40% mental load** from "where was I?"

**Lesson:** Domain memory prevents rework and mental load.

---

## Key Takeaways

### ✅ Good Decisions

1. **Used Domain Memory pattern** - Preserved context across 3 sessions
2. **Initializer with Opus** - High-quality feature decomposition upfront
3. **Atomic features** - Each feature tested and committed independently
4. **Bootup ritual** - Zero regrounding time (just read artifacts)
5. **Test criteria in features.json** - Clear definition of "done"

### ❌ Common Mistakes to Avoid

1. **Skipping Initializer** - Starting without structured plan
2. **Large atomic units** - Trying to complete everything in one session
3. **Not updating artifacts** - Domain memory becomes stale
4. **Skipping bootup ritual** - Loses benefit of persistent memory

### 🎯 Decision Framework Applied

- **Known vs unknown:** Well-defined feature → Initializer can structure it
- **Single vs multi-session:** Multi-session work → Domain memory essential
- **Simple vs complex:** 8 features over 3 sessions → Need orchestration
- **Model selection:** Opus for decomposition, Sonnet for implementation

---

## When to Use Domain Memory Pattern

**Use Domain Memory if:**
- Feature takes multiple sessions
- Team needs to understand progress
- Want atomic feature delivery (ship incrementally)
- Context loss is a risk

**Use Explore agent if:**
- Unknown codebase structure
- Need to understand existing patterns first
- Single-session exploration

**Use Plan agent if:**
- Architecture decisions needed
- Single-session implementation
- Don't need persistent artifacts

---

## Related Examples

- [Bug Fix Workflow](01_bug-fix-workflow.md) - See simple escalation (Grep → Read → Fix)
- [Refactor Workflow](03_refactor-workflow.md) - See adversarial validation
- [Optimization Workflow](04_optimization-workflow.md) - See graduated complexity

**Guides:**
- [Decision Framework](../../docs/01-fundamentals/09_decision-framework.md) - Master tool selection
- [Domain Memory Architecture](../../CLAUDE.md#domain-memory-architecture-v360) - Initializer + Coder pattern
- [Bootup Ritual Guide](../../docs/03-advanced/bootup-ritual-guide.md) - Session continuity

---

**Last updated:** v4.18.0 (2025-12-17)
