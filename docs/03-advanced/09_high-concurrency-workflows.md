# High-Concurrency Workflows (5-20 Terminals)

**Priority:** 💡 Nice-to-have (Expert users, Month 3+, Complex projects only)
**Time:** 2-3 months to master
**Benefit:** 3-5x productivity for large refactors and multi-feature sprints

---

## ⚠️ CRITICAL WARNING: Read This First

**This workflow is NOT for most developers.**

### Who Should NOT Use This

❌ **Beginners** (0-6 months with Claude Code)
- Use 1-2 terminals instead
- Master fundamentals first

❌ **Intermediate users** (6-12 months)
- 2-3 terminals is optimal for you
- No need to scale yet

❌ **Simple projects** (1-2 feature work)
- Overhead > benefit
- Stick with 2-3 terminals

❌ **Limited RAM** (<16 GB)
- System will struggle
- Risk of crashes

❌ **Tight budget** (<$200/month API costs)
- 10 terminals = $200/month
- Cost may exceed budget

---

### Who SHOULD Use This

✅ **Expert users** (12+ months with Claude Code)
- Comfortable with 3-5 terminals
- Deep understanding of coordination
- Proven productivity gains

✅ **Complex projects** (5+ parallel features)
- Large refactors spanning multiple modules
- Multi-feature sprint work
- Architectural changes

✅ **High RAM systems** (32+ GB recommended)
- Can handle 10-20 concurrent sessions
- No performance degradation

✅ **Professional budget** ($200-400/month)
- 10-20 terminals = $200-400/month API costs
- Business justifies expense

---

### Prerequisites (Must Meet ALL)

**Technical:**
- [ ] Mastered 2-3 terminal workflows
- [ ] Comfortable with tmux/screen
- [ ] 16+ GB RAM (32+ GB recommended)
- [ ] SSD with fast I/O

**Cognitive:**
- [ ] Can manage 3 contexts without confusion
- [ ] Proven coordination skills
- [ ] No feeling of overwhelm at 3-5 terminals

**Experience:**
- [ ] 12+ months with Claude Code
- [ ] Completed 20+ multi-terminal sessions
- [ ] 95%+ success rate with 3-5 terminals

**Budget:**
- [ ] $200-400/month API cost budget
- [ ] Billing alerts set up
- [ ] Usage tracking enabled

**If ANY prerequisite not met → Stop here, use 2-3 terminals instead.**

---

## What is High-Concurrency?

**High-concurrency** means running 5-20 Claude Code terminals simultaneously, each handling independent work streams.

### Concurrency Levels

**Low (2-3 terminals):** Standard workflow
- 90% of developers
- Feature + tests + logs
- Sweet spot for most work

**Medium (4-5 terminals):** Intermediate
- 8% of developers
- Multi-feature work
- Occasional use

**High (6-10 terminals):** Advanced
- 1.5% of developers
- Large refactors
- Requires expertise

**Very High (11-20 terminals):** Expert
- 0.5% of developers (Boris Cherny's level)
- Complex multi-module projects
- Requires orchestration skills

---

## When High-Concurrency is Justified

### ✅ Excellent Use Cases

**Scenario 1: Large Monolith Refactor**
```
10 Terminals:
- Term 1-6: Refactor 6 different modules
- Term 7-8: Update tests for modules 1-3, 4-6
- Term 9: Integration tests
- Term 10: Monitor build logs

Benefit: Refactor that takes 3 weeks serially → 1 week parallel
```

**Scenario 2: Multi-Feature Sprint**
```
8 Terminals:
- Term 1-5: 5 independent features
- Term 6: Shared tests
- Term 7: Documentation updates
- Term 8: Dev server logs

Benefit: Complete sprint in 1 session instead of 5
```

**Scenario 3: Microservices Migration**
```
12 Terminals:
- Term 1-8: Migrate 8 services
- Term 9-10: Update API gateway for services 1-4, 5-8
- Term 11: Integration tests
- Term 12: Deployment scripts

Benefit: Migration that takes 2 months → 2 weeks
```

---

### ❌ Bad Use Cases

**Scenario 1: Normal Feature Work**
- Adding 2-3 features
- Result: Overhead > benefit, use 2-3 terminals

**Scenario 2: Learning New Codebase**
- Exploring unfamiliar code
- Result: Cognitive overload, use 1 terminal

**Scenario 3: Debugging Complex Issue**
- Deep focus required
- Result: Divided attention, use 1 terminal

**Scenario 4: Small Team (<5 people)**
- Not enough parallel work
- Result: Terminals sit idle, wasteful

---

## System Requirements

### Hardware Requirements by Concurrency Level

**6-8 Terminals:**
- RAM: 16 GB minimum, 24 GB comfortable
- CPU: 4 cores minimum, 8 cores recommended
- Storage: SSD (HDD will bottleneck)
- Network: Stable broadband (10+ Mbps)

**9-12 Terminals:**
- RAM: 24 GB minimum, 32 GB comfortable
- CPU: 8 cores minimum, 12 cores recommended
- Storage: Fast SSD (NVMe preferred)
- Network: Fast broadband (50+ Mbps)

**13-20 Terminals:**
- RAM: 32 GB minimum, 64 GB comfortable
- CPU: 12+ cores
- Storage: NVMe SSD
- Network: Very fast broadband (100+ Mbps)
- Consider: Dedicated GPU for terminal rendering

---

### Memory Budget Calculation

**Per-Terminal Memory:**
- Terminal emulator: ~50 MB
- Claude session (active): ~200 MB
- Claude session (idle): ~50 MB
- Total per active terminal: ~250 MB

**Total System Memory Needed:**
```
Base OS:           2 GB
Terminal app:      0.5 GB
10 terminals:      2.5 GB (10 × 250 MB)
IDE/Browser:       2 GB
Safety margin:     1 GB
---
Total needed:      8 GB minimum, 16 GB comfortable
```

**For 20 terminals:**
```
Base + 20 terminals (5 GB) + IDE + safety = 12 GB minimum, 24 GB comfortable
```

---

### Cost Budget Calculation

**API Cost Scaling:**

| Terminals | Typical Monthly Cost | Heavy Usage |
|-----------|---------------------|-------------|
| 1         | $20                 | $40         |
| 5         | $100                | $200        |
| 10        | $200                | $400        |
| 15        | $300                | $600        |
| 20        | $400                | $800        |

**Cost optimization:**
- Use Haiku for routine work (66% cheaper)
- Close idle terminals
- Set billing alerts
- Track usage weekly

**Budget formula:**
```
Monthly cost ≈ ($20 × active_terminals) + (heavy_usage_multiplier)

heavy_usage_multiplier = 0 (light), 1.0 (typical), 2.0 (heavy)
```

---

## Coordination Strategies

### Problem: Managing 10+ Contexts

**Without coordination:** Chaos
- Lost track of which terminal does what
- Duplicate work
- Conflicting changes
- Mental overload

**With coordination:** Control
- Clear work boundaries
- No conflicts
- Efficient handoffs
- Mental clarity

---

### Strategy 1: Terminal Naming Convention

**Pattern: [Module]-[Type]-[ID]**

```bash
# Set terminal titles
echo -e "\033]0;Auth-Feature-1\007"
echo -e "\033]0;Auth-Tests-2\007"
echo -e "\033]0;API-Feature-3\007"
echo -e "\033]0;API-Tests-4\007"
echo -e "\033]0;DB-Migration-5\007"
echo -e "\033]0;Docs-Update-6\007"
echo -e "\033]0;Logs-Monitor-7\007"
```

**Visual layout:**
```
┌─────────┬─────────┬─────────┬─────────┐
│ Auth-   │ Auth-   │ API-    │ API-    │
│ Feature │ Tests   │ Feature │ Tests   │
│ (1)     │ (2)     │ (3)     │ (4)     │
├─────────┼─────────┼─────────┼─────────┤
│ DB-     │ Docs-   │ Logs-   │ Build-  │
│ Migrate │ Update  │ Monitor │ Status  │
│ (5)     │ (6)     │ (7)     │ (8)     │
└─────────┴─────────┴─────────┴─────────┘
```

---

### Strategy 2: Work Assignment Matrix

**Document in project CLAUDE.md:**

```markdown
## Terminal Assignment Matrix (Session: 2026-01-13)

| Terminal | Module | Task | Status | ETA |
|----------|--------|------|--------|-----|
| 1 | Auth | Implement OAuth | In Progress | 30min |
| 2 | Auth | Write OAuth tests | Waiting on T1 | 20min |
| 3 | API | Add /users endpoint | In Progress | 25min |
| 4 | API | Add /users tests | Waiting on T3 | 15min |
| 5 | DB | Create users table | Completed | - |
| 6 | Docs | Update API docs | In Progress | 15min |
| 7 | Logs | Monitor dev server | Monitoring | - |
| 8 | Build | Watch build status | Monitoring | - |

Dependencies:
- T2 depends on T1 (OAuth implementation)
- T4 depends on T3 (/users endpoint)
- T3 depends on T5 (users table) ✅ Done

Last updated: 14:30
```

---

### Strategy 3: Handoff Protocol

**When Terminal A completes, Terminal B needs output:**

**Terminal 1 (OAuth implementation):**
```markdown
✅ COMPLETED: OAuth implementation

Exported functions:
- `async function authenticateUser(token: string): Promise<User>`
- `async function refreshToken(oldToken: string): Promise<string>`

Files changed:
- src/auth/oauth.ts (new)
- src/types/user.ts (updated)

Handoff to Terminal 2 (Tests):
Copy signatures above, write comprehensive tests covering:
- Valid token authentication
- Invalid token handling
- Token refresh flow
- Edge cases (expired, malformed)
```

**Terminal 2 (Tests):**
```markdown
RECEIVED HANDOFF from Terminal 1

Starting OAuth tests with provided signatures...
[Implement tests]
```

---

### Strategy 4: Conflict Prevention

**Problem:** Two terminals accidentally edit same file

**Solution: Lock File Pattern**

Create `.claude/terminal-locks.json`:
```json
{
  "src/auth/oauth.ts": {
    "locked_by": "Terminal-1",
    "locked_at": "2026-01-13T14:30:00Z",
    "task": "Implement OAuth"
  },
  "src/auth/oauth.test.ts": {
    "locked_by": "Terminal-2",
    "locked_at": "2026-01-13T14:35:00Z",
    "task": "Write OAuth tests"
  }
}
```

**In each terminal prompt:**
```
I'm working in Terminal-3 on src/api/users.ts.

Before you start:
1. Check .claude/terminal-locks.json
2. If src/api/users.ts is locked, choose different file
3. If unlocked, add lock for this terminal
4. Begin work

[Task description]
```

---

## Orchestration Patterns

### Pattern 1: Serial Dependency Chain

**When:** Tasks must complete in order

```
Terminal 1: Database schema
     ↓ (wait for completion)
Terminal 2: API endpoints
     ↓ (wait for completion)
Terminal 3: Frontend components
     ↓ (wait for completion)
Terminal 4: Integration tests
```

**Coordination:** Manual handoffs at each stage

---

### Pattern 2: Parallel Independent Work

**When:** Tasks have no dependencies

```
Terminal 1-5: 5 independent features (parallel)
     ↓ (all complete)
Terminal 6: Integration tests (waits for all 1-5)
```

**Coordination:** Minimal, just track completion

---

### Pattern 3: Module-Based Parallelism

**When:** Multiple modules, each with layers

```
Module Auth:              Module API:
- Terminal 1: Logic       - Terminal 3: Logic
- Terminal 2: Tests       - Terminal 4: Tests

Module DB:                Module Docs:
- Terminal 5: Migrations  - Terminal 7: Updates
- Terminal 6: Tests       - Terminal 8: Reviews
```

**Coordination:** Pair-wise within modules

---

### Pattern 4: Pipeline Workflow

**When:** Production-line style work

```
Stage 1 (Planning):       Terminal 1-2
     ↓
Stage 2 (Implementation): Terminal 3-6
     ↓
Stage 3 (Testing):        Terminal 7-8
     ↓
Stage 4 (Review):         Terminal 9-10
```

**Coordination:** Batch handoffs between stages

---

## Monitoring & Dashboards

### The "Terminal Dashboard" Pattern

**Terminal 10 (reserved): Dashboard terminal**

Create `.claude/commands/dashboard.md`:

```markdown
# Terminal Dashboard - /dashboard

When user types `/dashboard`, show overview of all terminals:

1. Parse .claude/terminal-locks.json
2. Check each terminal's status
3. Show summary table:

```
┌──────────┬────────────┬──────────────┬──────────┐
│ Terminal │ Module     │ Task         │ Status   │
├──────────┼────────────┼──────────────┼──────────┤
│ T1       │ Auth       │ OAuth impl   │ ✅ Done   │
│ T2       │ Auth       │ OAuth tests  │ 🔄 Active│
│ T3       │ API        │ /users       │ 🔄 Active│
│ T4       │ API        │ Tests        │ ⏸️  Wait  │
│ T5       │ DB         │ Migration    │ ✅ Done   │
│ T6       │ Docs       │ API docs     │ 🔄 Active│
│ T7       │ Logs       │ Monitoring   │ 👀 Watch │
│ T8       │ Build      │ Monitoring   │ 👀 Watch │
│ T9       │ Tests      │ Integration  │ ⏸️  Wait  │
└──────────┴────────────┴──────────────┴──────────┘

Completed: 2/9
Active: 3/9
Waiting: 2/9
Monitoring: 2/9

Estimated completion: 15 minutes

Next actions:
- T2, T3, T6 will complete in ~10 min
- Then start T4, T9 (depend on T3, T2)
```
```

---

## Cognitive Load Management

### The 7±2 Problem at Scale

**Human working memory: 7±2 items**

**With 10 terminals:**
- Cannot track all 10 simultaneously
- Risk of overwhelm

**Solution: Chunking**

**Group terminals into 3 chunks:**

**Chunk 1: Auth Module (T1-T2)**
- Only remember "Auth work in progress"
- Don't remember individual tasks

**Chunk 2: API Module (T3-T4)**
- Only remember "API work in progress"

**Chunk 3: Infrastructure (T5-T8)**
- Only remember "Infra work"

**Mental load: 3 chunks (within 7±2 capacity)**

---

### External Memory Pattern

**Don't rely on memory, externalize:**

**Terminal status board** (physical or digital):
```
┌─────────────────────────────────┐
│ Auth Module: 50% complete       │
│ API Module: 75% complete        │
│ Infra: 100% complete            │
│                                 │
│ Next: Start integration tests   │
└─────────────────────────────────┘
```

**Benefits:**
- Glance to see status
- No mental tracking
- Reduces cognitive load

---

## Troubleshooting

### "I lost track of what each terminal is doing"

**Solution 1: /dashboard command** (see above)

**Solution 2: Terminal check-in**

Visit each terminal, ask:
```
What are you currently working on?
What's the status?
What's next?
```

**Solution 3: Reduce terminals**

If 10 is too many, drop to 6-8.

---

### "Memory is maxed out, system is slow"

**Check memory usage:**
```bash
# macOS
vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f MB\n", "$1:", $2 * $size / 1048576);'

# Linux
free -h
```

**Solutions:**
1. Close unused terminals (keep only active 6-8)
2. Close other apps (browsers, IDEs)
3. Restart terminal app
4. Upgrade RAM (if regularly hitting limits)

---

### "API costs are way too high"

**Track usage:**
```bash
claude usage --detailed
```

**Cost reduction strategies:**

1. **Model switching** (biggest impact)
   - Haiku for routine work (66% cheaper)
   - Sonnet for implementation
   - Opus for architecture only

2. **Close idle terminals**
   - After completing task, close terminal
   - Don't leave terminals running

3. **Batch work**
   - Open 10 terminals for 2 hours (focused session)
   - Better than: 10 terminals for 8 hours (waste)

4. **Set billing alerts**
   - $50, $100, $200 thresholds
   - Review when alert triggers

---

### "Terminals are conflicting (editing same files)"

**Solution: Lock file pattern** (see Coordination Strategies above)

**Manual check before starting:**
```bash
# In each terminal, before starting work
grep "filename.ts" .claude/terminal-locks.json

# If locked by another terminal, choose different file
```

---

### "Feeling overwhelmed with 10+ terminals"

**This is normal. Options:**

**Option 1: Reduce to 6-8 terminals**
- Most experts thrive at 6-8, not 10-20
- Boris's 20 terminals is rare exception

**Option 2: Take breaks**
- Work 50 min, break 10 min
- Review dashboard, adjust strategy

**Option 3: Group terminals**
- Focus on Chunk 1 (Auth) for 30 min
- Then Chunk 2 (API) for 30 min
- Rotate focus, don't try to track all simultaneously

---

## Success Metrics

### Week 1 (6-8 terminals)

- ✅ Managing 6-8 terminals without confusion
- ✅ Coordination strategies working (no conflicts)
- ✅ Memory usage stable (<80% RAM)
- ✅ Cost within budget

---

### Month 1 (8-10 terminals)

- ✅ 3-4x faster for large refactors
- ✅ Terminal dashboard providing clear overview
- ✅ Handoff protocol smooth
- ✅ Can context-switch between chunks without losing track

---

### Month 3+ (10-20 terminals, expert level)

- ✅ Boris Cherny level: 10-20 terminals for complex projects
- ✅ Orchestration feels natural
- ✅ Proven productivity gains in production
- ✅ Can mentor others on high-concurrency

---

## Alternatives to High-Concurrency

**Before committing to 10+ terminals, consider:**

### Option 1: Better Task Decomposition

**Instead of:** 10 terminals doing 10 features
**Try:** 3 terminals doing 10 features sequentially

**Benefit:** Less overhead, same completion time for many cases

---

### Option 2: Batch Processing

**Instead of:** 10 terminals open for 8 hours
**Try:** 3 terminals, 3 batch sessions of 2 hours each

**Benefit:** Lower cost, fresher focus per session

---

### Option 3: Team Distribution

**Instead of:** 1 developer with 10 terminals
**Try:** 2 developers with 5 terminals each

**Benefit:** Human coordination > AI coordination

---

## Related Guides

- **Parallel Terminals (2-5):** `docs/02-optimization/06_parallel-terminals.md`
- **Terminal Setup:** `01_global-setup/02_good-to-have/04_terminal-setup.md`
- **Split-Screen Setup:** `docs/02-optimization/07_split-screen-setup.md`
- **Model Selection:** `docs/02-optimization/01_model-selection-strategy.md`
- **Overnight Agents:** `docs/03-advanced/10_overnight-agents.md` (next level)

---

## Summary

**Key Takeaways:**

⚠️ **High-concurrency is NOT for most developers** (only ~2% need this)

✅ **Prerequisites required:** 12+ months experience, 32+ GB RAM, $200-400/month budget

✅ **Justified use cases:** Large refactors, multi-feature sprints, complex projects

✅ **Coordination essential:** Terminal naming, work assignment matrix, handoff protocol

✅ **Alternatives exist:** Better task decomposition, batch processing, team distribution

**Final Warning:**

If you're reading this and thinking "maybe I should try 10 terminals":
- **Stop**
- Master 2-3 terminals first
- Then 4-5 terminals
- Only scale to 6-8 if proven need
- 10+ terminals is **expert-level only**

Most developers (98%) achieve optimal productivity with 2-5 terminals.

Boris Cherny's 10-20 terminal workflow is inspirational, but not prescriptive. Find YOUR optimal level.

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.3
**Based on:** Boris Cherny's advanced workflow patterns
**Warning Level:** 🔴 Advanced - Expert Users Only
