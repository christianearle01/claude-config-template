# Sandbox 4: Git Workflow Testing

**Duration:** 15 minutes
**Skill Level:** Beginner (Foundation)
**Goal:** Configure git commit approval workflow

## Scenario

Safe repository for practicing 3 approval modes: Full, Commit-Only, Minimal.

## Challenge

**Step 1:** Run `../../scripts/setup-git-workflow.sh`
**Step 2:** Test each protection level
**Step 3:** Understand trade-offs (safety vs speed vs tokens)

## Key Learning

- Full: Git status + diff + approval (safest, ~1200 tokens)
- Commit-Only: Skip diff, approval only (~400 tokens, 75% savings)
- Minimal: Auto-commit (~100 tokens, but risky)

**Learn more:** `../../docs/00-start-here/09_quick-reference.md#git-workflow--commit-approval`
