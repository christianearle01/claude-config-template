---
name: workflow-analyzer
description: Analyzes git commit patterns to detect repeated manual operations and suggests skill improvements. Auto-activates when users ask about workflow patterns, commit analysis, or skill optimization opportunities. Meta-skill that enables skill evolution.
allowed-tools: Read, Bash, Grep
---

# Workflow Analyzer Skill (Meta-Skill)

## Purpose & Activation

**What it does:** Analyzes git history to detect workflow patterns and suggests skill improvements.

**When it activates:**
- "What patterns do you see in my commits?"
- "Analyze my workflow"
- "What skills should I create?"
- "What operations do I repeat?"

**How it helps:**
- Detects repeated manual operations
- Suggests new skills to create
- Identifies skill improvement opportunities
- Enables skill evolution based on actual usage

---

## Key Operations

### Operation 1: Commit Pattern Analysis

**User Query:**
> "What patterns do you see?"

**Confidence:** 🟢 High (0.90)
- Exact keyword match: "patterns"
- Git repository available with commit history
- Clear intent to analyze workflow

**Skill Response:**
```
📊 Workflow Pattern Analysis (last 50 commits)

Repeated Operations Detected:
- "Update version.json" (8 times / 16%)
- "Fix typo in README" (6 times / 12%)
- "Update CHANGELOG" (7 times / 14%)
- "Sync version files" (8 times / 16%)

Pattern: Version management appears in 23/50 commits (46%)

Recommendation:
version-management skill already exists! ✅
This addresses your most frequent workflow.

Other opportunities:
- typo-detection skill (6 occurrences)
  Suggests: Auto-detect common typos before commit

Continue using version-management skill.
Consider typo-detection for future.
```

**Why This Matters:**
- 46% of commits are version-related → High-friction workflow that's already automated
- Typo fixes waste 12% of commit time → Opportunity for new skill
- Pattern detection reveals ROI: version-management saves ~800 tokens/week
- **Quick win:** Run `./scripts/claude-skills.sh show version-management` to see usage patterns

**Next Step:** Want to analyze specific operation frequency or explore typo-detection skill creation?

### Operation 2: Skill Improvement Suggestions

**User Query:**
> "How can I improve my skills?"

**Confidence:** 🟢 High (0.85)
- Keyword match: "improve", "skills"
- Git history available for analysis
- Established skill ecosystem to analyze

**Skill Response:**
```
🔍 Skill Improvement Opportunities

Based on commit analysis:

version-management skill:
✅ Well-used (8 times in 50 commits)
💡 Could add: Auto-detect if sync-version.sh ran
💡 Could add: Suggest CHANGELOG template

commit-readiness-checker skill:
⚠️ Usage unknown (skill recently added)
📊 Monitor: Check if pre-commit queries increase

Recommendation:
Update version-management SKILL.md to include:
- sync-version.sh detection operation
- CHANGELOG template generation

This would save additional 200 tokens/release.
```

**Why This Matters:**
- Well-used skills (8+ times) deserve investment → High ROI for enhancements
- New skills need monitoring → Track adoption to validate value
- Incremental improvements compound → 200 tokens/release × 12 releases/year = 2,400 tokens saved
- **Quick win:** Edit `.claude/skills/version-management/SKILL.md` to add suggested operations

**Next Step:** Want detailed implementation guidance for these improvements?

### Operation 3: New Skill Discovery

**User Query:**
> "What skills should I create next?"

**Confidence:** 🟢 High (0.92)
- Direct question about skill creation
- Git history shows repeated patterns
- Clear data-driven recommendations possible

**Skill Response:**
```
🎯 Skill Recommendations (data-driven)

Based on your git history:

High Value:
1. typo-fixer skill
   Evidence: 6 "fix typo" commits in 2 weeks
   Savings: 300 tokens/query × 3 queries/week = 900 tokens/week

2. link-validator skill
   Evidence: 4 "fix broken link" commits
   Savings: 400 tokens/query × 2 queries/week = 800 tokens/week

Medium Value:
3. code-formatter skill
   Evidence: 3 formatting commits
   Savings: 200 tokens/query × 1 query/week = 200 tokens/week

Start with typo-fixer (highest ROI).
```

**Why This Matters:**
- Data-driven recommendations ensure high ROI → Build what you actually need
- Typo-fixer saves 900 tokens/week → 3,600 tokens/month (~$0.11/month)
- Pattern frequency indicates pain points → 6 typo commits in 2 weeks = clear need
- **Quick win:** Run `./scripts/skill-template-generator.sh typo-fixer` to scaffold new skill

**Next Step:** Want help creating the typo-fixer skill SKILL.md structure?

---

## Git-Based Analysis

**Analyzes:**
- Commit message patterns
- File change frequency
- Time between related commits
- Commit types (feat, fix, docs, etc.)

**Detects:**
- Repeated manual tasks
- High-friction workflows
- Missing automation opportunities

---

## Meta-Skill: Enables Evolution

**This skill answers:** "Do skills improve automatically?"

**Answer:** No, but workflow-analyzer observes patterns and SUGGESTS improvements!

**Example Evolution Loop:**
```
Week 1: User commits "Update CHANGELOG" 3 times
Week 2: workflow-analyzer notices pattern
Week 3: Suggests: "Add CHANGELOG template to version-management skill"
Week 4: User updates skill with template
Week 5: CHANGELOG updates become faster
```

---

## Token Efficiency

**Without Skill:** 900 tokens (manual git log analysis)
**With Skill:** 400 tokens (structured git analysis)
**Savings:** 500 tokens/query (56% reduction, projected)

**Monthly:** 2 analyses × 500 = 1,000 tokens (~$0.03/month)

---

## See Also

- version-management skill
- commit-readiness-checker skill
- skill-creation-guide.md

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Type:** Meta-skill (analyzes and improves other skills)
