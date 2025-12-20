# Skills Progression Map - Learning Path from Novice to Expert

**Purpose:** Clear path showing what to learn, when to learn it, and why it matters.

**Problem:** 269 features create "where do I start?" paralysis.

**Solution:** Follow the three-tier progression below. Each tier builds on the previous.

---

## 🎯 How to Use This Map

1. **Start with Foundation** (Tier 1) - Everyone needs these first
2. **Add Optimization** (Tier 2) - When Foundation feels comfortable
3. **Explore Strategic** (Tier 3) - When you want advanced capabilities

**Don't skip tiers!** Foundation skills are prerequisites for everything else.

---

## 📊 Visual Progression

```
┌─────────────────────────────────────────────────────────────┐
│  TIER 1: FOUNDATION (Must-Have) - Everyone Starts Here     │
│  Estimated time: 15-30 minutes                               │
│  Skills: 3 core                                              │
└─────────────────────────────────────────────────────────────┘
                            ↓
                    Comfortable with?
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  TIER 2: OPTIMIZATION (Good-to-Have) - Add When Ready      │
│  Estimated time: 30-60 minutes                               │
│  Skills: 10 workflow-specific (choose 3-5 for your needs)   │
└─────────────────────────────────────────────────────────────┘
                            ↓
                   Want more power?
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  TIER 3: STRATEGIC (Nice-to-Have) - Advanced Capabilities  │
│  Estimated time: 20-40 minutes                               │
│  Skills: 6 meta-skills and automation                       │
└─────────────────────────────────────────────────────────────┘
```

---

## 🏗️ TIER 1: FOUNDATION (Must-Have)

**Goal:** Get productive with Claude Code basics in 15-30 minutes.

**When to learn:** Day 1 - Before everything else.

**Skills (3 core):**

### 1. CLAUDE.md Project Memory ⚠️ **START HERE**
**What:** Single file that gives Claude instant project context
**Why:** 95% reduction in context queries (20K → 200 tokens)
**Estimated time:** 10 minutes to create, lifetime value
**Prerequisites:** None (start here!)

**How to learn:**
- [5-Minute Success Demo](03_5-minute-success.md) - See it work instantly
- [QUICK_REFERENCE § CLAUDE.md](09_quick-reference.md#claudemd-template) - Full details

**Success indicator:** Claude answers "What does this project do?" without exploring files

---

### 2. Keyboard Shortcuts ⚠️
**What:** Esc Esc (rewind), Ctrl-b (background tasks), Tab (thinking), Shift-Tab (permissions)
**Why:** 10x faster workflow, instant error recovery
**Estimated time:** 5 minutes to learn, daily time savings
**Prerequisites:** None

**How to learn:**
- [QUICK_REFERENCE § Keyboard Shortcuts](09_quick-reference.md#keyboard-shortcuts)
- Practice in any Claude Code conversation

**Success indicator:** You use Esc Esc to undo mistakes instead of starting over

---

### 3. Permission Modes ⚠️
**What:** Plan (read-only), Ask (approval-required), AcceptEdits (auto-approve)
**Why:** Control when Claude edits files vs just explores
**Estimated time:** 5 minutes to understand, ongoing control
**Prerequisites:** None

**How to learn:**
- [QUICK_REFERENCE § Permission Modes](09_quick-reference.md#permission-modes)
- Experiment: Try /mode plan for exploration, /mode ask for changes

**Success indicator:** You know when to use plan mode vs ask mode

---

## ⚡ TIER 2: OPTIMIZATION (Good-to-Have)

**Goal:** Optimize workflow for your specific use case.

**When to learn:** After Tier 1 feels comfortable (Day 2-7).

**Skills (10 available, choose 3-5 for your needs):**

### Workflow Optimization

#### 4. Model Switching (Sonnet→Haiku) ⭐
**What:** Use Sonnet for planning, Haiku for implementation (92% cheaper)
**Why:** Same quality, massive cost savings
**Estimated time:** 10 minutes to understand pattern
**Prerequisites:** CLAUDE.md (Tier 1)

**Project types:** All (universal optimization)
**How to learn:** [QUICK_REFERENCE § Model Switching](09_quick-reference.md#model-switching)

---

#### 5. Prompt Patterns ⭐
**What:** 10 reusable templates for common tasks
**Why:** 50-80% token savings per query
**Estimated time:** 15 minutes to learn patterns
**Prerequisites:** None

**Project types:** All (universal skill)
**How to learn:** [QUICK_REFERENCE § Prompt Patterns](09_quick-reference.md#prompt-patterns)

---

#### 6. Git Workflow & Commit Approval ⭐
**What:** Token-optimized git commits (skip diff, minimal workflow)
**Why:** 75% token savings on git operations (2,000 → 400 tokens)
**Estimated time:** 10 minutes to configure
**Prerequisites:** Git basics

**Project types:** Any project using git
**How to learn:** [QUICK_REFERENCE § Git Workflow](09_quick-reference.md#git-workflow--commit-approval)

---

### Project-Specific Optimization

#### 7. Testing Workflow Skill
**What:** Natural language test execution and results analysis
**Why:** 58% token savings vs CLI (600 → 250 tokens per query)
**Estimated time:** 5 minutes to enable
**Prerequisites:** Project with tests

**Project types:** Projects with test suites (Jest, pytest, RSpec, etc.)
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#testing-workflow)

---

#### 8. API Debugging Skill
**What:** Debug API requests, responses, status codes
**Why:** Structured debugging vs random exploration
**Estimated time:** 5 minutes to enable
**Prerequisites:** Project making API calls

**Project types:** Web apps, microservices, API clients
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#api-debugging)

---

#### 9. Component Finder Skill
**What:** Locate React/Vue/Angular components quickly
**Why:** Faster than manual file searching
**Estimated time:** 5 minutes to enable
**Prerequisites:** Frontend project

**Project types:** React, Vue, Angular, Svelte projects
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#component-finder)

---

### Quality & Release

#### 10. Commit Readiness Checker Skill ⭐
**What:** Validates all release criteria before git commit
**Why:** Catches missing version bumps, changelog updates
**Estimated time:** 5 minutes to enable
**Prerequisites:** Git workflow

**Project types:** Any project with release process
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#commit-readiness-checker)

---

#### 11. Documentation Sync Checker Skill
**What:** Validates docs consistency, broken links, version sync
**Why:** Prevents stale documentation
**Estimated time:** 5 minutes to enable
**Prerequisites:** Project with documentation

**Project types:** Projects with docs/ folder, README.md
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#documentation-sync-checker)

---

#### 12. Version Management Skill
**What:** Tracks version consistency across multiple files
**Why:** Ensures package.json, README, CHANGELOG all match
**Estimated time:** 5 minutes to enable
**Prerequisites:** Versioned project

**Project types:** NPM packages, Python packages, versioned apps
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#version-management)

---

#### 13. Security Scanner Skill
**What:** OWASP Top 10 scanning, CVE detection, secrets scanning
**Why:** Catch vulnerabilities before deployment
**Estimated time:** 5 minutes to enable
**Prerequisites:** None

**Project types:** Web applications, APIs
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#security-scanner)

---

## 🚀 TIER 3: STRATEGIC (Nice-to-Have)

**Goal:** Meta-skills, automation, and advanced workflows.

**When to learn:** When Tier 2 feels natural (Week 2+).

**Skills (6 strategic):**

### Meta-Skills

#### 14. Project Analyzer Skill 💡
**What:** Zero-config intelligence from features.json + progress.md
**Why:** Status summaries, blocker detection, next action suggestions
**Estimated time:** 10 minutes to set up features.json
**Prerequisites:** Project using Domain Memory Architecture

**Project types:** Long-running projects with >10 features
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#project-analyzer)

---

#### 15. Personalization Engine Skill 💡
**What:** Learns your preferences over time ("tell me once" paradigm)
**Why:** Adapts behavior based on your feedback patterns
**Estimated time:** 10 minutes to configure
**Prerequisites:** Experience with Tier 1-2 skills

**Project types:** All (universal meta-skill)
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#personalization-engine)

---

#### 16. Workflow Analyzer Skill 💡
**What:** Analyzes git commits to detect repeated manual operations
**Why:** Suggests skill improvements based on your patterns
**Estimated time:** 5 minutes to enable
**Prerequisites:** Git history with multiple commits

**Project types:** Projects with established workflow
**How to learn:** [Skills Catalog](../02-optimization/08_skills-catalog.md#workflow-analyzer)

---

### Advanced Agents

#### 17. Custom Agents 💡
**What:** @prompt-polisher, @project-planner, @quality-reviewer
**Why:** Specialized agents for complex tasks
**Estimated time:** 20 minutes to understand all agents
**Prerequisites:** Tier 1-2 comfort

**Project types:** All (different agents for different needs)
**How to learn:** [QUICK_REFERENCE § Custom Agents](09_quick-reference.md#custom-agents)

---

#### 18. MCP Servers 💡
**What:** Sequential-thinking, memory, filesystem integrations
**Why:** Extended capabilities beyond base Claude Code
**Estimated time:** 15 minutes to configure
**Prerequisites:** Comfort with Claude Code basics

**Project types:** Complex analysis, multi-step reasoning
**How to learn:** [QUICK_REFERENCE § MCP Servers](09_quick-reference.md#mcp-servers)

---

#### 19. Security Hooks (Optional) 💡
**What:** Prompt injection detection, response scanning
**Why:** Extra security layer for sensitive projects
**Estimated time:** 20 minutes to set up
**Prerequisites:** Security awareness

**Project types:** Enterprise, regulated industries
**How to learn:** [QUICK_REFERENCE § Security Hooks](09_quick-reference.md#security-hooks)

---

## 🎯 Skill Selection by Project Type

**Not sure which skills to learn?** Match your project type below:

### Web Application (Frontend)
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** Component Finder, Testing Workflow, Security Scanner
**Strategic:** Custom Agents (@quality-reviewer)

### Web Application (Backend/API)
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** API Debugging, Testing Workflow, Security Scanner
**Strategic:** Custom Agents (@quality-reviewer), MCP Servers

### CLI Tool / Package
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** Version Management, Testing Workflow, Git Workflow
**Strategic:** Commit Readiness, Documentation Sync

### Data Science / ML Project
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** Testing Workflow, Model Switching (save on analysis)
**Strategic:** Project Analyzer, MCP Servers (sequential-thinking)

### Documentation-Heavy Project
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** Documentation Sync, Version Management, Git Workflow
**Strategic:** Workflow Analyzer, Personalization Engine

### Team / Enterprise Project
**Foundation:** CLAUDE.md, Keyboard Shortcuts, Permission Modes
**Optimization:** Git Workflow, Commit Readiness, Version Management
**Strategic:** Security Hooks, Personalization Engine, Workflow Analyzer

---

## ⏱️ Time Investment by Tier

**Tier 1 (Foundation):** 15-30 minutes total
- Essential for everyone
- Learn on Day 1
- Immediate productivity boost

**Tier 2 (Optimization):** 30-60 minutes total (for 3-5 skills)
- Choose based on project type
- Learn over first week
- Workflow-specific benefits

**Tier 3 (Strategic):** 20-40 minutes total (for 2-3 skills)
- Optional advanced capabilities
- Learn when comfortable with Tier 1-2
- Meta-skills and automation

**Total for full progression:** 65-130 minutes (spread over 2-4 weeks)

---

## 🧭 Learning Path Recommendations

### Path 1: Absolute Beginner (Never used Claude Code)
**Week 1:**
- Day 1: [5-Minute Success](03_5-minute-success.md) → CLAUDE.md
- Day 2: Keyboard Shortcuts + Permission Modes
- Day 3: Prompt Patterns (universal skill)
- Day 4-7: Practice with Tier 1 skills

**Week 2:**
- Choose 2-3 Tier 2 skills based on project type
- Practice until comfortable

**Week 3+:**
- Explore Tier 3 when curious

---

### Path 2: Experienced Developer (Used Claude Code before)
**Day 1:**
- CLAUDE.md setup (10 min)
- Model Switching (10 min)
- Git Workflow optimization (10 min)

**Day 2:**
- Choose 3 skills from Tier 2 based on project type
- Enable and test

**Week 2:**
- Add 1-2 Tier 3 skills
- Customize with Personalization Engine

---

### Path 3: Team Lead (Setting up for team)
**Week 1:**
- CLAUDE.md template for team
- Git Workflow + Commit Readiness (standardize commits)
- Documentation Sync (prevent doc drift)

**Week 2:**
- Security Scanner (if needed)
- Version Management (if releasing packages)
- Personalization Engine (team preferences)

**Week 3:**
- Security Hooks (enterprise only)
- Workflow Analyzer (improve team patterns)

---

## ✅ Self-Assessment: Am I Ready to Advance?

### Ready for Tier 2? (Check all that apply)

- [ ] I have CLAUDE.md in my project and Claude reads it automatically
- [ ] I use Esc Esc to undo mistakes instead of starting conversations over
- [ ] I know when to use /mode plan vs /mode ask
- [ ] I can explain to a teammate what CLAUDE.md does
- [ ] Foundation skills feel natural, not something I have to think about

**If 4/5 checked:** You're ready for Tier 2!

---

### Ready for Tier 3? (Check all that apply)

- [ ] I've used 3+ Tier 2 skills and they feel comfortable
- [ ] I understand when to use Haiku vs Sonnet (model switching)
- [ ] I can write effective prompts using patterns
- [ ] I've saved measurable time/tokens with Tier 2 optimizations
- [ ] I want to automate or extend workflows beyond basics

**If 4/5 checked:** You're ready for Tier 3!

---

## 🔄 What's Next After This Map?

**Option 1: Start Learning (Recommended)**
Go to [5-Minute Success](03_5-minute-success.md) and complete Tier 1, Skill 1 (CLAUDE.md) right now.

**Option 2: Deep Dive on One Skill**
Pick one skill from the map and explore via [QUICK_REFERENCE](09_quick-reference.md).

**Option 3: See It In Action**
Check [Workflow Examples](09_quick-reference.md#workflow-examples) to see how skills combine in real scenarios.

**Option 4: Get Guided Help**
Run the wizard: `./scripts/claude-wizard.sh` for interactive setup with validation.

---

## 🎓 Learning Philosophy

**Progressive Disclosure:**
- Don't overwhelm with 269 features at once
- Start simple (Tier 1), add complexity when ready
- Each tier builds on previous understanding

**Project-Specific:**
- Not all 19 skills needed for every project
- Choose 5-8 total skills that match your work
- Better to master few than superficially know many

**Measured Progress:**
- Self-assessment checkpoints at tier boundaries
- Time estimates help plan learning investment
- Clear "ready to advance" indicators

---

## 📊 Skills Catalog Quick Reference

For detailed information on each skill, see:
- **Full Catalog:** [Skills Catalog](../02-optimization/08_skills-catalog.md)
- **Quick Reference:** [QUICK_REFERENCE](09_quick-reference.md)
- **Visual Guides:** [Visual Guides](06_visual-guides.md)

---

## Navigation

**🏠 [Back to README](../../README.md)** | **🗺️ [Choose Your Path](01_entry-points.md)** | **⚡ [5-Minute Win](03_5-minute-success.md)** | **📖 [Quick Reference](09_quick-reference.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/christianearle01/claude-config-template) - v4.21.0*

*Last updated: 2025-12-20*
