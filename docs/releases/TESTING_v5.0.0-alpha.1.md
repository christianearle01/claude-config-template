# v5.0.0-alpha.1 Testing Checklist

**Status:** Ready for Testing
**Branch:** `feature/pressure-driven-learning-v5.0.0-alpha`
**Date:** 2025-01-13

---

## Testing Overview

This document provides a systematic testing approach for v5.0.0-alpha.1 "Pressure-Driven Learning" release.

**Testing Goals:**
1. Verify all new components work as designed
2. Ensure backwards compatibility with traditional paths
3. Validate user experience (checkpoints, demos, wizard)
4. Confirm documentation accuracy

---

## Prerequisites

**Before Testing:**
```bash
# Switch to alpha branch
git checkout feature/pressure-driven-learning-v5.0.0-alpha

# Verify branch
git branch
# Should show: * feature/pressure-driven-learning-v5.0.0-alpha

# Check file permissions
ls -la scripts/problem-first-setup.sh
ls -la demos/*/demo.sh
# All should be executable (-rwxr-xr-x)
```

**Test Environment:**
- Fresh directory (not existing Claude Code project)
- Claude Code CLI installed and working
- Terminal with bash support

---

## Test Suite 1: Demo System

### Test 1.1: Bug Fix Demo

**Steps:**
```bash
./demos/bug-fix-security/demo.sh
```

**Expected Output:**
- Banner showing "Demo 1: Bug Fix - Security Vulnerability Detection"
- Red "Vulnerable Code" box showing SQL injection
- Cyan "Claude's Analysis" with timing (< 2 seconds)
- Green "Claude's Solution" with fixed code
- Cyan "Bonus: Security Test Added" with test code
- Green "Result:" showing time saved (~30 minutes)
- Total demo time: 3-5 seconds

**Pass Criteria:**
- [ ] Demo runs without errors
- [ ] Output is readable and formatted correctly
- [ ] Colors display properly (red/green/cyan)
- [ ] Timing feels appropriate (not too fast/slow)
- [ ] Demo completes in < 10 seconds

### Test 1.2: Feature Addition Demo

**Steps:**
```bash
./demos/feature-addition/demo.sh
```

**Expected Output:**
- Banner showing "Demo 2: Feature Addition - API Endpoint with Tests"
- Yellow "Traditional Approach" (~60 minutes)
- Green "Claude Code Approach" (~10 minutes)
- Green box showing generated endpoint code
- Cyan "+ Tests: 5 test cases"
- Result showing 50 minutes saved

**Pass Criteria:**
- [ ] Demo runs without errors
- [ ] Traditional vs Claude comparison is clear
- [ ] Time savings are displayed
- [ ] Demo completes in < 10 seconds

### Test 1.3: Refactoring Demo

**Steps:**
```bash
./demos/refactoring/demo.sh
```

**Expected Output:**
- Banner showing "Demo 3: Refactoring - Code Quality Improvement"
- Yellow "Before: 150-line function doing everything"
- Green "After: 4 focused functions" (validateUser, transformUser, saveUser, notifyUser)
- Green checkmarks for SRP, testable, clear naming, reduced complexity
- Result showing maintainable code in 15 minutes

**Pass Criteria:**
- [ ] Demo runs without errors
- [ ] Before/after contrast is clear
- [ ] Benefits are listed
- [ ] Demo completes in < 10 seconds

---

## Test Suite 2: Problem-First Wizard

### Test 2.1: Wizard Execution

**Steps:**
```bash
# In a test directory (not existing project)
mkdir ~/test-problem-first
cd ~/test-problem-first

# Run wizard
/path/to/claude-config-template/scripts/problem-first-setup.sh
```

**Interactive Flow:**

**Step 1: Welcome Banner**
- Expected: Cyan box with "Problem-First Setup - v5.0.0 Alpha"
- Expected: Yellow welcome text explaining philosophy
- Prompt: "Ready to try? (yes/no):"
- Input: `yes`

**Step 2: Problem Capture**
- Expected: Cyan box "Step 1: What's YOUR Problem?"
- Expected: Examples of valid problems (bug fix, feature, refactor, etc.)
- Prompt: "Your problem:"
- Input: `Fix SQL injection in my API` (or your real problem)

**Step 3: Problem Classification**
- Expected: Cyan box "Step 2: Problem Classification"
- Expected: 4 categories shown (Bug Fix, Feature Addition, Refactoring, Other)
- Prompt: "Choose (1-4):"
- Input: `1` (for Bug Fix)

**Step 4: Demo Execution**
- Expected: Cyan box "Step 3: See Claude Code in Action"
- Expected: Demo runs automatically (bug-fix-security demo)
- Expected: Demo completes in 3-5 seconds
- Prompt: "Want Claude to help with YOUR problem? (yes/no):"
- Input: `yes`

**Step 5: Minimal Config**
- Expected: Cyan box "Step 4: Minimal Configuration"
- Expected: Progress messages:
  - "Creating .claude/ directory..."
  - "Installing default settings..."
  - "Creating minimal CLAUDE.md..."
- Expected: Green checkmark "Minimal configuration complete!"

**Step 6: Launch Instructions**
- Expected: Cyan box "🚀 Ready to Solve Your Problem!"
- Expected: Summary of what happens next
- Expected: Instructions to start Claude Code
- Expected: Additional resources listed
- Prompt: "Press Enter to finish setup..."
- Input: `Enter`

**Step 7: Completion**
- Expected: Green box "✅ Problem-First Setup Complete!"
- Expected: Problem and category displayed
- Expected: "Now go solve it! 🚀"

**Pass Criteria:**
- [ ] All 7 steps complete without errors
- [ ] Files created: `.claude/`, `.claude/settings.json`, `CLAUDE.md`, `.claude/.problem-first-setup`
- [ ] CLAUDE.md contains user's problem statement
- [ ] .claude/.problem-first-setup contains correct metadata
- [ ] Wizard exits cleanly (no hanging processes)
- [ ] Total time: < 3 minutes

### Test 2.2: Generated Files Validation

**After wizard completion, verify files:**

```bash
# Check directory structure
ls -la .claude/
# Expected: settings.json, .problem-first-setup

# Check CLAUDE.md
cat CLAUDE.md
# Expected: Contains "Current Problem: [user's problem]"
# Expected: Has minimal template structure

# Check problem-first marker
cat .claude/.problem-first-setup
# Expected: Contains setup_date, user_problem, problem_category, first_session=true

# Check settings.json
cat .claude/settings.json | python -m json.tool
# Expected: Valid JSON
# Expected: Contains promptCaching enabled
```

**Pass Criteria:**
- [ ] All expected files exist
- [ ] Files contain correct content
- [ ] JSON files are valid
- [ ] CLAUDE.md has user's problem statement
- [ ] Marker file has all required fields

---

## Test Suite 3: Problem-First Documentation

### Test 3.1: Guide Navigation

**Steps:**
```bash
# Read each guide in sequence
cat docs/00-start-here/problem-first/00_choose-your-learning-path.md
cat docs/00-start-here/problem-first/01_how-claude-solves-problems.md
cat docs/00-start-here/problem-first/02_understanding-claude-memory.md
cat docs/00-start-here/problem-first/03_token-optimization-basics.md
cat docs/00-start-here/problem-first/04_quick-wins-path.md
```

**Pass Criteria:**
- [ ] All guides exist and are readable
- [ ] Navigation footer links are correct
- [ ] Reading times are accurate (3-8 min range)
- [ ] Code examples are formatted correctly
- [ ] No broken internal links
- [ ] Consistent formatting across guides

### Test 3.2: Guide Content Quality

**For each guide, verify:**

**Guide 0: Choose Your Learning Path**
- [ ] Clearly explains Problem-First vs Traditional
- [ ] Decision framework is helpful
- [ ] Examples are relatable
- [ ] Links to next steps work

**Guide 1: How Claude Solves Problems**
- [ ] 5 problem types covered (bug fix, feature, refactor, doc, debug)
- [ ] Each has Traditional vs Claude comparison
- [ ] Time savings are realistic
- [ ] "Key Difference" insights are clear

**Guide 2: Understanding Claude Memory**
- [ ] CLAUDE.md purpose is clear
- [ ] ELI12 analogy (notebook) is helpful
- [ ] Token math is understandable
- [ ] Size guidelines are practical

**Guide 3: Token Optimization Basics**
- [ ] Three big wins explained (caching, model selection, CLAUDE.md)
- [ ] Real cost calculations shown
- [ ] Checklist is actionable
- [ ] Examples are concrete

**Guide 4: Quick Wins Path**
- [ ] 4 quick wins (security, tests, explain, CLAUDE.md)
- [ ] Each takes stated time (2-3 min)
- [ ] Value is immediately apparent
- [ ] Next steps are clear

---

## Test Suite 4: Understanding Checkpoints Skill

### Test 4.1: Skill Files Exist

```bash
ls -la .claude/skills/understanding-checkpoints/
# Expected: SKILL.md, checkpoint-scenarios.md, README.md
```

**Pass Criteria:**
- [ ] All 3 files exist
- [ ] Files are readable
- [ ] Total size ~1300 lines

### Test 4.2: Skill Content Validation

**Read and verify:**

```bash
cat .claude/skills/understanding-checkpoints/SKILL.md | head -100
cat .claude/skills/understanding-checkpoints/checkpoint-scenarios.md | head -100
cat .claude/skills/understanding-checkpoints/README.md
```

**Pass Criteria:**
- [ ] SKILL.md has trigger patterns section
- [ ] SKILL.md has checkpoint protocol (5 steps)
- [ ] SKILL.md has verification templates
- [ ] checkpoint-scenarios.md has detection matrix
- [ ] checkpoint-scenarios.md has quick triggers
- [ ] README.md explains auto-invocation
- [ ] All examples are complete

### Test 4.3: Checkpoint Integration

**Simulated Test** (manual verification needed with Claude Code):

1. Start Claude Code session
2. Ask: "How do I make Claude remember my project?"
3. Expected: Understanding checkpoint triggers
4. Expected: Checkpoint shows:
   - Banner with 🛑 symbol
   - ELI12 analogy
   - Intermediate states
   - Traditional vs Claude comparison
   - Verification question
5. Provide weak answer (generic explanation)
6. Expected: Claude requests clarification
7. Provide good answer (specific mechanism)
8. Expected: Claude confirms understanding, proceeds

**Pass Criteria:**
- [ ] Checkpoint triggers appropriately
- [ ] Checkpoint format matches SKILL.md
- [ ] Verification works (weak/good answers distinguished)
- [ ] Can proceed after verification
- [ ] Checkpoint doesn't repeat for same concept

---

## Test Suite 5: README Integration

### Test 5.1: Entry Point Validation

```bash
cat README.md | head -100
```

**Pass Criteria:**
- [ ] "Get Started" section shows 3 paths
- [ ] Problem-First is first option (left column)
- [ ] Problem-First has 🔥 emoji and "v5.0.0 Alpha" label
- [ ] Traditional paths still present (Instant Setup, Full Setup)
- [ ] "What's Different in v5.0.0?" explanation included

### Test 5.2: Navigation Guide

```bash
cat README.md | grep -A 10 "Your journey path"
```

**Pass Criteria:**
- [ ] Problem-First is #1 in navigation
- [ ] Link to problem-first/00_choose-your-learning-path.md works
- [ ] Traditional paths (#2-7) still intact
- [ ] No broken links

---

## Test Suite 6: Version Management

### Test 6.1: Version.json Validation

```bash
cat version.json | python -m json.tool
```

**Pass Criteria:**
- [ ] Version is "5.0.0-alpha.1"
- [ ] Release date is 2026-01-13
- [ ] Release name is "Pressure-Driven Learning (Alpha)"
- [ ] breaking_changes is false
- [ ] update_priority is "optional"
- [ ] alpha_status is true
- [ ] production_ready is false
- [ ] All new features listed (problem-first-wizard, demo-engine, etc.)
- [ ] Metadata updated (total_files: 161, skill_count: 21, demo_count: 3)

### Test 6.2: Release Notes

```bash
cat RELEASE_NOTES_v5.0.0-alpha.1.md | head -50
```

**Pass Criteria:**
- [ ] Release notes exist
- [ ] Contains clear overview of v5.0.0
- [ ] Lists all 5 new features
- [ ] Includes technical details section
- [ ] Has breaking changes (NONE)
- [ ] Has migration guide (not needed)
- [ ] Has testing instructions
- [ ] Has roadmap to beta/release

---

## Test Suite 7: Backwards Compatibility

### Test 7.1: Traditional Paths Still Work

**Test Instant Setup:**
```bash
# Create fresh test directory
mkdir ~/test-traditional
cd ~/test-traditional

# Run instant setup (if exists)
cat /path/to/claude-config-template/docs/00-start-here/03_instant-setup.md
```

**Pass Criteria:**
- [ ] Instant Setup guide still exists
- [ ] No changes to traditional setup flow
- [ ] All traditional links work
- [ ] Traditional wizards unchanged

### Test 7.2: Existing Projects Unaffected

**Test with existing project:**
```bash
# Go to existing Claude Code project
cd /path/to/existing/project

# Verify no changes
ls -la .claude/
# Expected: No new files added automatically

# Verify Claude Code still works normally
claude chat
"Help me understand this project"
```

**Pass Criteria:**
- [ ] Existing projects work unchanged
- [ ] No automatic problem-first setup
- [ ] No unexpected checkpoints
- [ ] Traditional workflow intact

---

## Test Suite 8: End-to-End User Journey

### Test 8.1: Complete Problem-First Flow

**Scenario:** New user with real problem

**Steps:**
1. User clones template
2. User switches to alpha branch
3. User runs problem-first wizard
4. User watches demo (bug-fix)
5. User gets minimal config created
6. User starts working on their problem
7. User hits wall (e.g., "Where does Claude get context?")
8. Understanding checkpoint triggers
9. User learns about CLAUDE.md just-in-time
10. User continues working with new knowledge

**Pass Criteria:**
- [ ] All steps complete smoothly
- [ ] User sees value in < 60 seconds (demo)
- [ ] User starts working with minimal friction
- [ ] Checkpoint feels helpful, not intrusive
- [ ] User retains understanding after checkpoint

### Test 8.2: Traditional Path Still Preferred for Teams

**Scenario:** Team lead setting up for team

**Steps:**
1. User clones template
2. User reads README
3. User chooses Traditional Setup (Instant or Full)
4. User completes traditional wizard
5. User configures for team consistency
6. User shares config with team

**Pass Criteria:**
- [ ] Traditional path clearly available
- [ ] No pressure to use problem-first
- [ ] Team workflow unchanged
- [ ] Traditional is still recommended for teams

---

## Test Suite 9: Error Handling

### Test 9.1: Wizard Edge Cases

**Test: User declines problem-first**
```bash
./scripts/problem-first-setup.sh
# When asked "Ready to try?", answer: no
```

**Expected:**
- Yellow message: "No problem! You can use traditional setup instead"
- Paths shown: claude-wizard.sh, instant-setup.md
- Wizard exits cleanly

**Pass Criteria:**
- [ ] Graceful exit
- [ ] Helpful alternative shown
- [ ] No files created

**Test: User provides no problem**
```bash
./scripts/problem-first-setup.sh
# When asked "Your problem:", press Enter (empty)
```

**Expected:**
- Red error: "No problem entered. This setup requires a real problem."
- Message: "Come back when you have something concrete"
- Wizard exits

**Pass Criteria:**
- [ ] Validation works
- [ ] Clear error message
- [ ] No partial setup

**Test: User declines help after demo**
```bash
./scripts/problem-first-setup.sh
# Complete through demo
# When asked "Want help?", answer: no
```

**Expected:**
- Yellow message: "No worries! Come back when you're ready"
- Wizard exits cleanly
- No files created

**Pass Criteria:**
- [ ] User can exit after demo
- [ ] No forced commitment
- [ ] Clean exit

---

## Test Suite 10: Performance

### Test 10.1: Script Execution Speed

**Measure wizard speed:**
```bash
time ./scripts/problem-first-setup.sh
# Interact normally, measure total time
```

**Expected:**
- User interaction time: ~2-3 minutes
- Script execution time: < 5 seconds (non-interactive parts)

**Pass Criteria:**
- [ ] No noticeable lag
- [ ] Demos run in 3-5 seconds
- [ ] File creation is instant
- [ ] Total time < 3 minutes

### Test 10.2: File Size Validation

```bash
# Check demo file sizes
ls -lh demos/*/demo.sh

# Check skill file sizes
ls -lh .claude/skills/understanding-checkpoints/*

# Check guide file sizes
ls -lh docs/00-start-here/problem-first/*
```

**Expected:**
- Demos: ~2-4KB each
- Skill files: ~15-30KB each
- Guides: ~15-25KB each

**Pass Criteria:**
- [ ] No bloated files
- [ ] Reasonable sizes for content
- [ ] Fast to read/load

---

## Critical Path Test (Minimum Viable)

**If time is limited, test ONLY these:**

1. [ ] Run bug-fix demo (`./demos/bug-fix-security/demo.sh`)
2. [ ] Run problem-first wizard (`./scripts/problem-first-setup.sh`)
3. [ ] Verify CLAUDE.md created with problem statement
4. [ ] Read choose-your-learning-path guide
5. [ ] Verify version.json shows 5.0.0-alpha.1
6. [ ] Check README shows Problem-First as first option

**If all 6 pass:** Alpha is functional enough for feedback.

---

## Known Limitations (Alpha)

**Expected to NOT work:**
- Full 7-demo suite (only 3 implemented)
- Advanced checkpoint triggers (basic implementation only)
- Checkpoint analytics/tracking
- Intermediate state logging UI
- Query counter / 100/day metric

**These are planned for Beta, not Alpha.**

---

## Reporting Issues

**If test fails, report:**

1. **Test number** (e.g., "Test 2.1: Wizard Execution")
2. **Expected behavior** (from checklist)
3. **Actual behavior** (what happened)
4. **Steps to reproduce**
5. **Environment** (OS, shell, Claude Code version)

**Example:**
```
Test 2.1: Wizard Execution - FAILED

Expected: Step 4 runs bug-fix demo automatically
Actual: Demo did not run, wizard proceeded to Step 5

Steps to reproduce:
1. Run ./scripts/problem-first-setup.sh
2. Answer: yes, "Fix SQL injection", choose option 1
3. Wizard skipped demo, went to config creation

Environment: macOS 14.2, bash 5.2, Claude Code 2.1.0
```

---

## Sign-Off Checklist

**Before marking Alpha as "tested":**

- [ ] All critical path tests pass
- [ ] At least one complete end-to-end test (Test 8.1 or 8.2)
- [ ] No blocking issues found
- [ ] Backwards compatibility confirmed (Test 7.1 & 7.2)
- [ ] Documentation readable and accurate (Test 3.1 & 3.2)
- [ ] Version metadata correct (Test 6.1 & 6.2)

**When all checked:** Alpha is ready for user feedback.

---

**Status:** Ready for Testing
**Tester:** [Your Name]
**Date Completed:** [Date]
**Overall Result:** [ ] PASS | [ ] FAIL | [ ] PASS WITH ISSUES

**Notes:**
[Add any additional observations]

---

**Path:** `TESTING_v5.0.0-alpha.1.md`
**Version:** 5.0.0-alpha.1
**Last Updated:** 2025-01-13
