# CLAUDE.md Health Check - /claude-md-health

**Purpose:** Analyze CLAUDE.md file health and provide actionable recommendations

**Priority:** ⭐ Good-to-have (All users, monthly check recommended)

---

## Command Usage

When the user types `/claude-md-health`, perform a comprehensive health check of their CLAUDE.md file:

---

## Step 1: File Size Analysis

**Check CLAUDE.md file size:**

```bash
# Get file size in bytes
ls -l CLAUDE.md | awk '{print $5}'

# Get line count
wc -l CLAUDE.md

# Get character count
wc -c CLAUDE.md
```

**Evaluate:**

| Size (characters) | Size (tokens est.) | Status | Message |
|-------------------|-------------------|--------|---------|
| <20,000 | <5,000 | ✅ Healthy | Perfect size, well within limits |
| 20,000-40,000 | 5,000-10,000 | ⚠️ Caution | Approaching limits, monitor growth |
| 40,000-60,000 | 10,000-15,000 | ⚠️ Warning | Large file, consider splitting soon |
| >60,000 | >15,000 | ❌ Critical | Too large, split immediately |

**Notes:**
- Token estimate: chars / 4 (rough approximation)
- claude.ai Custom Instructions limit: 40,000 characters
- Recommended target: <20,000 characters

---

## Step 2: Section Analysis

**Count rules/sections in CLAUDE.md:**

Look for patterns indicating structure:
- `##` headers (main sections)
- `-` or `*` bullet lists (rules)
- Code blocks (examples)

**Evaluate:**

| Metric | Count | Status | Notes |
|--------|-------|--------|-------|
| Main sections | 8-15 | ✅ Good | Well-organized |
| Main sections | 16-25 | ⚠️ Many | Consider consolidating |
| Main sections | >25 | ❌ Too many | Definitely split |
| Bullet lists | <50 | ✅ Good | Manageable |
| Bullet lists | 50-100 | ⚠️ Many | Review for redundancy |
| Bullet lists | >100 | ❌ Bloat | Severe bloat, prune heavily |

---

## Step 3: Content Type Analysis

**Identify what's in CLAUDE.md:**

Check for these content types:
1. **Business context** (what app does) ✅ Should be here
2. **Tech stack** (frameworks, languages) ✅ Should be here
3. **External APIs** (purposes, usage) ✅ Should be here
4. **Coding standards** (style, patterns) ⚠️ Consider `.claude/rules/coding-standards.md`
5. **Security policies** (rules, checks) ⚠️ Consider `.claude/rules/security-policies.md`
6. **Testing requirements** (frameworks, coverage) ⚠️ Consider `.claude/rules/testing-requirements.md`
7. **Workflow details** (CI/CD, deployment) ⚠️ Consider `.claude/workflows/*.md`
8. **Implementation details** (how features work) ❌ Should be in code comments

**Recommendation:**
If 4+ items in "Consider" or "Should not" categories → recommend splitting

---

## Step 4: Staleness Check

**Check last modified date:**

```bash
# Get last modified date
stat -f "%Sm" -t "%Y-%m-%d" CLAUDE.md  # macOS
stat -c "%y" CLAUDE.md  # Linux
```

**Evaluate:**

| Last Modified | Status | Message |
|---------------|--------|---------|
| <1 month ago | ✅ Fresh | Recently reviewed |
| 1-3 months ago | ⚠️ Aging | Consider reviewing |
| 3-6 months ago | ⚠️ Stale | Likely outdated rules |
| >6 months ago | ❌ Very stale | Definitely needs review |

**Suggest:** Review quarterly (every 3 months) at minimum

---

## Step 5: Redundancy Detection

**Check for common redundancy patterns:**

1. **Repeated phrases:**
   ```bash
   # Find most common 3-word phrases
   grep -o '\b\w\+\s\+\w\+\s\+\w\+\b' CLAUDE.md | sort | uniq -c | sort -rn | head -10
   ```

   If same phrase appears 5+ times → suggest consolidation

2. **Similar section names:**
   Look for sections with overlapping topics:
   - "Testing Requirements" + "Test Guidelines" → Merge
   - "Coding Style" + "Code Conventions" → Merge
   - "Security" + "Security Best Practices" → Merge

3. **Duplicate rules:**
   Search for rules that say the same thing differently

---

## Step 6: Anti-Pattern Detection

**Check for known anti-patterns:**

### Anti-Pattern 1: Implementation Details

Search for:
- "How to implement..."
- "Step-by-step..."
- "Algorithm for..."
- Excessive code examples (>10 code blocks)

**If found:** Suggest moving to inline code comments or separate docs

---

### Anti-Pattern 2: Outdated Tech

Search for:
- Version numbers (e.g., "React 16", "Python 2.7")
- Deprecated packages
- "Legacy" mentions

**If found:** Suggest updating or removing

---

### Anti-Pattern 3: Over-Prescription

Count words like:
- "always" (>10 occurrences)
- "never" (>10 occurrences)
- "must" (>20 occurrences)

**If excessive:** Suggest more flexible language (prefer "prefer", "consider", "typically")

---

### Anti-Pattern 4: Context Rot Indicators

Search for:
- TODO comments not addressed (>5)
- Contradictory rules
- "Update this later" mentions
- Commented-out sections

**If found:** Cleanup needed immediately

---

## Output Format

Provide results in this structure:

```markdown
## CLAUDE.md Health Check Results

**File:** CLAUDE.md
**Checked:** 2026-01-13 15:30:00
**Overall Health Score:** 75/100 ⚠️

---

### 📊 Size Analysis

- **File size:** 18,342 characters (~4,585 tokens)
- **Status:** ✅ Healthy (target: <20,000)
- **Line count:** 326 lines
- **Recommendation:** Size is good, no action needed

---

### 🗂️ Structure Analysis

- **Main sections:** 12 (✅ Well-organized)
- **Bullet points:** 45 (✅ Manageable)
- **Code blocks:** 8 (✅ Reasonable)
- **Recommendation:** Structure is clear

---

### 📋 Content Type Analysis

**Should be here (✅):**
- Business context ✅ Present
- Tech stack ✅ Present
- External APIs ✅ Present

**Consider moving (⚠️):**
- Coding standards (45 lines) → `.claude/rules/coding-standards.md`
- Security policies (30 lines) → `.claude/rules/security-policies.md`

**Recommendation:** Move 75 lines to `.claude/rules/` to slim down main file

---

### 📅 Freshness Check

- **Last modified:** 2025-12-15 (1 month ago)
- **Status:** ✅ Fresh
- **Recommendation:** On track for quarterly review (next: 2026-03-15)

---

### 🔍 Quality Issues

**Redundancy detected:**
- Phrase "make sure to" appears 12 times → Consider consolidating
- Two sections on testing → Suggest merging

**Anti-patterns found:**
- ⚠️ "always" used 15 times (suggests over-prescription)
- ⚠️ 3 TODO items not addressed
- ✅ No implementation details (good!)
- ✅ No outdated tech references (good!)

**Recommendation:**
1. Consolidate testing sections
2. Address 3 TODO items
3. Replace 5+ "always" with "prefer" or "typically"

---

### 📈 Historical Trends (Optional)

**If tracking metrics over time:**

```
Size trend:
  Dec: 15KB → Jan: 18KB (+3KB/month)

Projection: Will reach 20KB limit in 2 months
Action: Monitor next month, plan split if growth continues
```

---

### ✅ Action Items

**High Priority:**
1. Move coding standards to `.claude/rules/coding-standards.md` (save ~45 lines)
2. Address 3 TODO items or remove

**Medium Priority:**
3. Merge duplicate testing sections
4. Replace rigid language (15 instances of "always")

**Low Priority:**
5. Review redundant phrases next quarterly check

---

### 🎯 Health Score Breakdown

| Category | Score | Weight | Notes |
|----------|-------|--------|-------|
| Size | 95/100 | 30% | ✅ Well within limits |
| Structure | 85/100 | 20% | ✅ Clear organization |
| Content | 60/100 | 25% | ⚠️ Some misplaced content |
| Freshness | 90/100 | 10% | ✅ Recently reviewed |
| Quality | 65/100 | 15% | ⚠️ Some redundancy, TODOs |

**Overall:** 75/100 ⚠️ **Good, but needs attention**

**Next check recommended:** 2026-02-13 (1 month from now)
```

---

## Automation Suggestion

**For power users, suggest:**

```bash
# Add to cron for monthly checks
# Create: ~/scripts/claude-md-health-check.sh

#!/bin/bash
cd /path/to/project
claude chat <<EOF
/claude-md-health
EOF > claude-md-health-$(date +%Y-%m-%d).txt

# Email or notify if score < 70
```

---

## Important Notes

1. **This is a diagnostic tool, not enforcement**
   - Recommendations, not requirements
   - User decides what actions to take
   - Context matters (some projects need larger files)

2. **Thresholds are guidelines**
   - 20KB target is comfortable, not mandatory
   - 60KB is warning, not hard limit
   - Adjust for your project's needs

3. **Quality > quantity**
   - Small file with poor content = low health score
   - Larger file with great content = acceptable
   - Focus on usefulness, not just size

4. **Run regularly**
   - Monthly for active projects
   - Quarterly for stable projects
   - Before major releases
   - After team onboarding

---

## Related Commands

- **`/verify`:** Post-session verification (security, efficiency) - `.claude/commands/verify.md`
- **Anti-patterns guide:** `docs/00-start-here/05_anti-patterns.md`
- **ACE patterns:** `docs/03-advanced/11_ace-inspired-patterns.md`

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.4
**Part of:** ACE-inspired context management patterns
