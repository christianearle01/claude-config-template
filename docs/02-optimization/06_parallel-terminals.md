# Parallel Terminals Workflow

**Priority:** ⭐ Good-to-have (Intermediate users, Month 1+)
**Time:** Progressive adoption over 4-8 weeks
**Benefit:** 2-3x productivity for multi-feature work

---

## What is Parallel Terminals Workflow?

**Parallel terminals** means running multiple Claude Code sessions simultaneously, each handling a separate task or feature. This is a core pattern from Boris Cherny's (Claude Code creator) workflow.

**Key Concept:** Each terminal = one cognitive context. No mental juggling between tasks.

---

## Before vs After

### Without Parallel Terminals (Serial Work)

```
Timeline: 90 minutes

┌─────────────────────────────────────────────┐
│ Terminal 1: Single Claude session          │
│                                             │
│ [Feature A - 30 min] → Context switch      │
│ [Feature B - 30 min] → Context switch      │
│ [Feature C - 30 min]                       │
│                                             │
│ Total: 90 minutes + 10 min switching       │
└─────────────────────────────────────────────┘
```

**Cognitive Load:** High (must remember all 3 contexts)
**Context Switches:** 2 expensive switches (5 min each)
**Total Time:** 100 minutes

---

### With Parallel Terminals (Concurrent Work)

```
Timeline: 35 minutes

┌─────────────┬─────────────┬─────────────┐
│ Terminal 1  │ Terminal 2  │ Terminal 3  │
│             │             │             │
│ Feature A   │ Feature B   │ Feature C   │
│ (30 min)    │ (30 min)    │ (30 min)    │
│             │             │             │
└─────────────┴─────────────┴─────────────┘

Startup: 5 min (launch 3 terminals)
Parallel Work: 30 min (all run simultaneously)
Review: 10 min (3 min per feature)

Total: 45 minutes
```

**Cognitive Load:** Low (each terminal isolated)
**Context Switches:** None (visual separation)
**Total Time:** 45 minutes
**Speedup:** 2.2x faster

---

## Progressive Adoption Path

**⚠️ CRITICAL: Do NOT jump to 5+ terminals on Day 1**

Follow this progression to avoid cognitive overload:

### Week 1: Single Terminal (Baseline)

**Goal:** Get comfortable with Claude Code basics

```
┌─────────────────────┐
│   Claude Terminal   │
│                     │
│   Feature work      │
│   Single session    │
└─────────────────────┘
```

**What to learn:**
- Basic prompting
- Plan mode (Shift+Tab twice)
- Reading and editing files
- Git workflow

**Success metric:** Comfortable completing 1 feature per session

---

### Week 2-3: Two Terminals (First Parallel)

**Goal:** Handle feature + tests simultaneously

```
┌─────────────┬─────────────┐
│ Terminal 1  │ Terminal 2  │
│             │             │
│ Feature     │ Tests       │
│ (main work) │ (coverage)  │
└─────────────┴─────────────┘
```

**Use Cases:**
- Terminal 1: Implement feature
- Terminal 2: Write tests for that feature
- Allows checking both contexts without switching

**What to learn:**
- Managing 2 mental contexts
- Coordinating between terminals
- When to check Terminal 2 vs Terminal 1

**Success metric:** Complete feature + tests in less time than serial work

---

### Month 1: Three Terminals (Monitoring Added)

**Goal:** Add real-time feedback loop

```
┌──────────┬──────────┬──────────┐
│Terminal 1│Terminal 2│Terminal 3│
│          │          │          │
│ Feature  │  Tests   │  Logs    │
│ (code)   │(coverage)│(feedback)│
└──────────┴──────────┴──────────┘
```

**Use Cases:**
- Terminal 1: Feature implementation
- Terminal 2: Test writing
- Terminal 3: Dev server logs (`npm run dev`, `pytest --watch`)

**What to learn:**
- Split-screen monitoring
- Real-time feedback interpretation
- When to check logs vs code

**Success metric:** Catch errors in logs before reviewing code

---

### Month 2+: 4-5 Terminals (Only If Needed)

**Goal:** Handle complex multi-feature projects

```
┌──────┬──────┬──────┬──────┬──────┐
│Term 1│Term 2│Term 3│Term 4│Term 5│
│      │      │      │      │      │
│Feat A│Feat B│Feat C│Tests │ Logs │
└──────┴──────┴──────┴──────┴──────┘
```

**Use Cases:**
- Large refactors (3-5 related features)
- Multi-module updates
- Complex dependency changes

**⚠️ Warning:** This is advanced. Most developers never need more than 3 terminals.

**Success metric:** Managing 4-5 terminals without feeling overwhelmed

---

## Memory Efficiency Comparison

### VS Code / Cursor (IDE-based)

```
Base Memory:     ~800 MB (Electron)
Per Extension:   ~200 MB
5 Windows:       ~4,000 MB (4 GB)
```

### Terminal-based (Ghostty, Warp, iTerm2)

```
Base Memory:     ~50 MB per terminal
5 Terminals:     ~250 MB (0.25 GB)
With Claude:     ~500 MB total (with sessions)
```

**Result: 8x memory efficiency**

This enables running 10-20 parallel sessions on the same machine that struggles with 5 VS Code windows.

---

## When to Use Multiple Terminals

### ✅ Good Use Cases (2-3 Terminals)

**Scenario 1: Feature + Tests**
- Terminal 1: Implement feature
- Terminal 2: Write tests
- Benefit: Parallel development, faster completion

**Scenario 2: Frontend + Backend**
- Terminal 1: API endpoint
- Terminal 2: UI component
- Benefit: Full-stack feature in parallel

**Scenario 3: Code + Documentation**
- Terminal 1: Implementation
- Terminal 2: Update docs
- Benefit: Keep documentation current

**Scenario 4: Bug Fix + Verification**
- Terminal 1: Fix bug
- Terminal 2: Run test suite
- Terminal 3: Monitor logs
- Benefit: Immediate verification

---

### ✅ Excellent Use Cases (4-5 Terminals)

**Scenario 1: Large Refactor**
- Terminal 1-3: Different modules
- Terminal 4: Tests
- Terminal 5: Logs
- Benefit: Coordinated multi-module changes

**Scenario 2: Multi-Feature Sprint**
- Terminal 1-4: 4 independent features
- Terminal 5: Shared tests
- Benefit: Complete sprint in 1 session

---

### ❌ Bad Use Cases (Don't Use Multiple Terminals)

**Scenario 1: Single small task**
- "Fix typo in README"
- Result: Overhead > benefit

**Scenario 2: Highly dependent work**
- Terminal 1: Must complete before Terminal 2 starts
- Result: One terminal sits idle

**Scenario 3: Learning new codebase**
- Exploring is serial work (one discovery leads to next)
- Result: Context juggling, confusion

**Scenario 4: Debugging complex issue**
- Need to focus deeply on one problem
- Result: Divided attention reduces effectiveness

---

## Cognitive Load Management

### The 7±2 Rule (Miller's Law)

**Human working memory: 7±2 items**

**Serial workflow cognitive load:**
```
Task A details (3 items) +
Task B details (3 items) +
Task C details (3 items) +
Context switching (2 items)
= 11 items → EXCEEDS CAPACITY
```

**Parallel workflow cognitive load:**
```
Which terminal to check (1 item) +
Current task status (1 item)
= 2 items → WITHIN CAPACITY
```

**How parallel terminals reduce load:**
- Each terminal holds its own context (externalized)
- Visual boundaries create mental boundaries
- No need to remember "where was I?"

---

## Progressive Scaling Decision Matrix

### Should You Add Another Terminal?

Ask these 4 questions:

**1. Are you regularly working on 3+ independent features?**
- Yes → Consider adding terminal
- No → Stay at current level

**2. Is context switching costing >15 min per session?**
- Yes → Consider adding terminal
- No → Stay at current level

**3. Can you manage current terminals without feeling overwhelmed?**
- Yes → Consider adding terminal
- No → Stay at current level (or reduce)

**4. Do you have available memory? (Check: `top -o MEM`)**
- Yes (>2 GB free) → Consider adding terminal
- No (<1 GB free) → Stay at current level

**If all 4 are YES → Add one more terminal**
**If any are NO → Stay at current level**

---

## Memory Budget Guidelines

### System Requirements by Terminal Count

**1-2 Terminals:**
- RAM Required: 4 GB minimum
- Comfortable: 8 GB
- Best for: Learning, simple projects

**3-5 Terminals:**
- RAM Required: 8 GB minimum
- Comfortable: 16 GB
- Best for: Most professional work

**6-10 Terminals:**
- RAM Required: 16 GB minimum
- Comfortable: 32 GB
- Best for: Complex multi-feature projects

**10-20 Terminals:**
- RAM Required: 32 GB minimum
- Comfortable: 64 GB
- Best for: Large refactors, advanced users only

---

## Cost Awareness

### API Costs Scale Linearly

**Important:** More terminals = more API costs

**Cost Scaling (Typical Usage):**
```
1 terminal:  ~$20/month
2 terminals: ~$40/month
3 terminals: ~$60/month
5 terminals: ~$100/month
10 terminals: ~$200/month
```

**Budget Planning:**
- Track usage: `claude usage`
- Set billing alerts in Anthropic dashboard
- Use model switching (Haiku for routine work saves 30-50%)

**See:** `01_global-setup/02_good-to-have/01_model-switching.md`

---

## Common Layouts

### Layout 1: Dual Development (Beginner-Friendly)

```
┌─────────────────┬─────────────────┐
│   Terminal 1    │   Terminal 2    │
│                 │                 │
│   Feature A     │   Feature B     │
│   (main work)   │  (secondary)    │
│                 │                 │
└─────────────────┴─────────────────┘
```

**When to use:** Two independent features
**Benefit:** Simple parallel work

---

### Layout 2: Development + Testing (Recommended)

```
┌─────────────────┬─────────────────┐
│   Terminal 1    │   Terminal 2    │
│                 │                 │
│  Implementation │     Tests       │
│   (Feature)     │   (Coverage)    │
│                 │                 │
└─────────────────┴─────────────────┘
```

**When to use:** Building feature with tests
**Benefit:** Parallel development, immediate coverage

---

### Layout 3: Triple Workflow (Intermediate)

```
┌───────────┬───────────┬───────────┐
│ Terminal 1│ Terminal 2│ Terminal 3│
│           │           │           │
│  Feature  │   Tests   │   Logs    │
│   (Code)  │ (Coverage)│(Feedback) │
│           │           │           │
└───────────┴───────────┴───────────┘
```

**When to use:** Most professional work
**Benefit:** Real-time feedback loop

---

### Layout 4: Multi-Feature (Advanced)

```
┌──────┬──────┬──────┬──────┬──────┐
│Term 1│Term 2│Term 3│Term 4│Term 5│
│      │      │      │      │      │
│Feat A│Feat B│Feat C│Tests │ Logs │
└──────┴──────┴──────┴──────┴──────┘
```

**When to use:** Large refactors, multi-feature sprints
**Benefit:** Maximum parallelization

⚠️ **Warning:** Cognitive overload risk for beginners

---

## Terminal Naming Strategy

### Problem: Losing Track of Terminals

**With 3+ terminals, you'll forget which does what.**

### Solution 1: Set Terminal Titles

```bash
# In each terminal, set a descriptive title
echo -e "\033]0;Claude - Feature: User Auth\007"
echo -e "\033]0;Claude - Tests\007"
echo -e "\033]0;Claude - Logs\007"
```

**Add to your shell profile** (`.zshrc` or `.bashrc`):
```bash
# Function to set terminal title
set_terminal_title() {
  echo -e "\033]0;$1\007"
}

# Example usage
# set_terminal_title "Claude - Feature A"
```

---

### Solution 2: tmux Named Windows

```bash
# Create tmux session with named windows
tmux new -s dev

# Rename windows
Ctrl-b ,
# Enter: "Feature", "Tests", "Logs"

# Switch between named windows
Ctrl-b w  # Show window list with names
```

**See:** `docs/02-optimization/07_split-screen-setup.md` for tmux tutorial

---

### Solution 3: Document in CLAUDE.md

Add to your project's `CLAUDE.md`:

```markdown
## Terminal Layout (Current Session)

- **Terminal 1 (left):** User authentication feature
- **Terminal 2 (center):** Auth tests + coverage
- **Terminal 3 (right):** Dev server logs (npm run dev)

Last updated: 2026-01-13
```

This helps when you return to project after a break.

---

## Coordination Between Terminals

### Work Claiming Pattern

**Problem:** Two terminals accidentally work on the same file

**Solution:** Explicit work claiming in prompts

**Terminal 1:**
```
I'm working on src/auth/login.js in this terminal.
Please implement the login function.
```

**Terminal 2:**
```
I'm working on src/auth/login.test.js in this terminal.
Note: Terminal 1 is handling login.js implementation.
Please write tests for the login function.
```

**Benefit:** Clear boundaries, no conflicts

---

### Handoff Pattern

**Problem:** Terminal 1 finishes, Terminal 2 needs that output

**Solution:** Explicit handoff in prompts

**Terminal 1 (after completing):**
```
Implementation complete. Exported function signature:

export async function login(username: string, password: string): Promise<User>

(Copy this signature to Terminal 2 for testing)
```

**Terminal 2 (starting tests):**
```
Terminal 1 completed implementation with this signature:
[paste signature]

Please write comprehensive tests for this function.
```

**Benefit:** Smooth coordination, no rework

---

## Troubleshooting

### "I feel overwhelmed with multiple terminals"

**Solution:** Reduce by one terminal

If 3 terminals feel like too much:
- Drop Terminal 3 (logs) - check manually instead
- Keep Terminal 1 (feature) + Terminal 2 (tests)

**The goal is productivity, not terminal count.**

---

### "Memory is running low"

**Check current usage:**
```bash
# macOS
vm_stat | grep "Pages free" | awk '{print $3 * 4096 / 1024 / 1024 " MB"}'

# Linux
free -h
```

**Solutions:**
1. Close unused terminals
2. Close other memory-heavy apps
3. Use lighter terminal (Ghostty < Warp < iTerm2)
4. Upgrade RAM (if regularly hitting limits)

---

### "Can't keep track of which terminal does what"

**Solutions:**
1. Set terminal titles (see "Terminal Naming Strategy")
2. Use tmux named windows
3. Document layout in CLAUDE.md
4. Reduce terminal count (if 5+, try 3)

---

### "API costs are too high"

**Solutions:**
1. Reduce terminal count (fewer sessions = lower cost)
2. Use model switching (Haiku for routine work)
3. Close terminals when not actively using
4. Set billing alerts

**Budget formula:**
```
Monthly cost ≈ $20 × number of terminals actively used
```

---

## Integration with Other Workflows

### Parallel Terminals + Plan Mode

**Pattern:** Use Plan Mode in Terminal 1 first

```
Terminal 1: Plan Mode (architecture decisions)
  ↓ (after plan approved)
Terminal 1: Implement core logic
Terminal 2: Write tests
Terminal 3: Monitor logs
```

**Benefit:** Coordinated implementation after deliberate planning

---

### Parallel Terminals + /verify Command

**Pattern:** Verify each terminal separately

```bash
# Terminal 1
/verify  # Check Feature A

# Terminal 2
/verify  # Check Feature B

# Terminal 3
/verify  # Check Tests
```

**Benefit:** Catch issues in each context before merging

---

## Success Metrics

### How to Know It's Working

**Week 2-3 (2 terminals):**
- ✅ Completing feature + tests faster than serial
- ✅ Comfortable switching between 2 terminals
- ✅ No feeling of overwhelm

**Month 1 (3 terminals):**
- ✅ Catching errors in logs before code review
- ✅ Real-time feedback loop feels natural
- ✅ Context switches feel effortless

**Month 2+ (4-5 terminals):**
- ✅ 2-3x faster for multi-feature work
- ✅ Managing multiple contexts without confusion
- ✅ Coordinating handoffs smoothly

**If NOT seeing these benefits:** Scale back terminals

---

## Related Guides

- **Terminal Setup:** `01_global-setup/02_good-to-have/04_terminal-setup.md`
- **Split-Screen Setup:** `docs/02-optimization/07_split-screen-setup.md`
- **Model Selection:** `01_global-setup/02_good-to-have/01_model-switching.md`
- **Plan Mode:** `docs/01-fundamentals/02_skills-paradigm.md`
- **Verify Command:** `.claude/commands/verify.md`
- **Quick Reference:** `docs/00-start-here/09_quick-reference.md`

---

## Summary

**Key Takeaways:**

✅ **Progressive adoption:** 1 → 2 → 3 terminals over months (not days)
✅ **Memory efficiency:** 8x more efficient than IDEs
✅ **Cognitive load:** Each terminal = one context (no juggling)
✅ **Cost awareness:** Budget $20/terminal/month
✅ **Scale when needed:** Most developers thrive with 2-3 terminals

**Golden Rule:** More terminals ≠ more productivity

Start with 1, add terminals only when you hit limits. Quality over quantity.

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.2
**Based on:** Boris Cherny's Claude Code workflow
