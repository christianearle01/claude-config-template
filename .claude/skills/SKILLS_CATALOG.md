# Skills Catalog: Choose by Experience Level

> **Help choosing skills?** This catalog organizes all 19 skills by experience level to prevent overwhelm.
> Start with Foundation skills, then add Optimization based on your project type.

**Last Updated:** 2025-12-17 | **Total Skills:** 19

---

## 🎯 These Are EXAMPLE Skills, Not Universal Requirements

### This Template is a Documentation-Heavy Project

**Context that created these 19 skills:**
- 87 markdown files with 11 Mermaid diagrams
- Weekly releases (heavy version management)
- Meta-work (creating skills about skills, documentation about skills)
- Template maintenance (cross-project registry, inheritance, validation)

**Your project is different. Don't cargo-cult.**

### The Methodology > The Skills

**What to learn from this catalog:**
1. ✅ HOW to detect patterns (workflow-analyzer found 26% Mermaid waste)
2. ✅ WHEN to create skills (ROI > 3 uses, >500 tokens saved)
3. ✅ HOW to measure impact (before/after token counts)

**What NOT to do:**
1. ❌ Copy all 19 skills blindly
2. ❌ Assume these are universal requirements
3. ❌ Skip workflow-analyzer (it's the real skill)

### Example: mermaid-validator Origin Story

**Pattern detected:** 13 Mermaid fix commits in 50 commits (26% waste)
**ROI calculated:** 4,900 tokens saved per validation batch (94% reduction)
**Decision:** Create the skill (payback immediate)
**Context:** This project is documentation-heavy with 87 MD files

**Your project:** If you have 0 Mermaid diagrams, you need 0 mermaid-validator.

### Start with the Meta-Skill: workflow-analyzer

**The only truly universal skill: workflow-analyzer**

It will tell you:
- "You have 10 API debugging commits → consider api-debugging skill"
- "You have 0 Mermaid commits → skip mermaid-validator"
- "You have 5 version bumps → version-management makes sense"

Let YOUR workflow tell you what skills YOU need.

### Skills Are Emergent, Not Prescriptive

This catalog is:
- ✅ A case study (how skills emerged HERE)
- ✅ A methodology demonstration (detect → calculate ROI → create → measure)
- ❌ NOT a checklist (don't install all 19)
- ❌ NOT universal requirements (context matters)

**The lesson:** Use workflow-analyzer monthly to discover YOUR patterns.

---

## 🆕 Foundation Skills (Start Here)

**For:** First-time users, essential for all projects
**Count:** 5 skills
**Time to setup:** 10 minutes
**Token savings:** ~60% (collective)

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **version-management** | Tracks version consistency across version.json, README, CLAUDE.md, CHANGELOG, and SETUP_CONTEXT | What version are we at? | 58% token reduction (600→250 tokens/query) |
| **commit-readiness-checker** | Validates all release criteria are met before git commit | Am I ready to commit? | Prevents 15% of fixup commits |

**Quick Start:**
```bash
# Enable foundation skills (recommended for all projects)
# Skills auto-activate when you ask relevant questions
```

**Why Foundation skills?**
- High-value, immediate ROI (save tokens/time in first session)
- Low complexity (deterministic, clear inputs/outputs)
- No prerequisites (work standalone)
- Universal applicability (95%+ of projects)

---

## ⚡ Optimization Skills (Level Up)

**For:** Intermediate users, workflow-specific improvements
**Count:** 8 skills
**Choose:** Based on your project type

### For Projects with Domain Memory (features.json)

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **project-analyzer** | Zero-config project intelligence analyzing features.json and progress.md | What's our project status? | 67% token reduction (1,200→400 tokens/query) |

### For Test-Driven Development

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **testing-workflow** | Provides insights on test execution results, test failures, pass rates | Show test results | Test-specific diagnostics and failure analysis |
| **test-generator** | Generates tests from features.json test criteria with multi-framework support | Generate tests for feat-X | Automated test creation, ensures coverage |

### For API Projects

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **security-scanner** | Automated security validation for OWASP Top 10, CVE detection, secrets scanning | Scan for vulnerabilities | Catch security issues early, prevent vulnerabilities |
| **api-debugging** | Helps debug API requests, responses, status codes, and network issues | API error help | Faster API debugging, clear diagnostics |

### For Team Projects

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **standards-enforcer** | Applies coding standards from CLAUDE.md with dynamic learning | Check code style | Consistent code quality, team alignment |
| **mode-selector** | Model selection decision tree (Opus/Sonnet/Haiku) | Which model should I use? | 24% token reduction through optimal model selection |

**Why Optimization skills?**
- Workflow-specific value (boost productivity in specific contexts)
- Moderate complexity (requires understanding domain patterns)
- Project-type specific (choose based on your needs)
- Clear ROI metrics (measurable token/time savings)

---

## 🚀 Strategic Skills (Power Users)

**For:** Advanced users, meta-skills and automation
**Count:** 6 skills
**When:** After mastering foundation & optimization

| Skill | What it does | When to use | ROI |
|-------|--------------|-------------|-----|
| **workflow-analyzer** | Meta-skill: Analyzes git commit patterns, detects repeated operations, suggests new skills | What patterns do you see? | 56% token reduction, enables skill evolution |
| **personalization-engine** | Central hub for managing user preferences, learning patterns, cross-session memory | What are my preferences? | 40% context recovery, reduces repeated decisions |
| **project-onboarding-assistant** | Guides users through per-project Claude Code setup | Setup new project | Setup time 20min → 5min (75% reduction) |
| **global-setup-assistant** | Guides users through one-time machine setup for claude-config-template | Install Claude Code | Reduces setup friction, validates installation |
| **pre-project-planning-assistant** | Guides users through pre-project planning phase (concept → architecture → tech → timeline) | Plan new project | Structured planning, prevents rework |
| **projects-registry** | Manages and provides insights from the projects registry (multi-project tracking) | List my projects | Cross-project tracking, 58% token savings vs CLI |
| **skill-template-generator** | Generates SKILL.md structure interactively, accelerates skill creation | Create new skill | Accelerates skill creation with interactive questions |

**Why Strategic skills?**
- Meta-skills (create/improve other skills)
- Complex orchestration (coordinate multiple tools)
- Personalization and learning (adapt over time)
- Multi-project management and scaffolding

---

## Quick Decision Tree

```
Are you NEW to Claude Code?
├─ YES → Start with Foundation Skills (5 skills, 10 min setup)
└─ NO → Do you have a specific workflow?
    ├─ Domain Memory (features.json) → Add project-analyzer
    ├─ Test-Driven Development → Add testing-workflow + test-generator
    ├─ API Development → Add api-debugging + security-scanner
    ├─ Team Project → Add standards-enforcer + mode-selector
    └─ Want Meta-Skills → Strategic Skills (workflow-analyzer, personalization-engine)
```

---

## Recommendation by Project Type

| Project Type | Foundation | + Optimization | + Strategic |
|--------------|------------|----------------|-------------|
| **Personal Project** | ✅ All 5 | project-analyzer | workflow-analyzer |
| **Documentation Site** | ✅ All 5 | mermaid-validator, documentation-sync-checker | - |
| **API Backend** | ✅ All 5 | api-debugging, security-scanner | - |
| **Frontend App** | ✅ All 5 | component-finder, testing-workflow | - |
| **Team Codebase** | ✅ All 5 | standards-enforcer, mode-selector | personalization-engine |
| **Template Maintainer** | ✅ All 5 | All optimization | All strategic |

---

## Quick Start by Use Case

### First-Time Setup
**Recommended:**
- version-management
- commit-readiness-checker

### Test-Driven Development
**Recommended:**
- version-management
- commit-readiness-checker
- testing-workflow
- test-generator

### API Development
**Recommended:**
- version-management
- commit-readiness-checker
- api-debugging
- security-scanner

### Team Collaboration
**Recommended:**
- version-management
- commit-readiness-checker
- standards-enforcer
- personalization-engine

### Documentation Projects
**Recommended:**
- version-management
- commit-readiness-checker
- mermaid-validator
- documentation-sync-checker

### Template Maintainers
**Recommended:**
- version-management
- commit-readiness-checker
- documentation-sync-checker
- workflow-analyzer
- skill-template-generator

---

## How to Use Skills

**Skills auto-activate** when you ask relevant questions:
- Just ask naturally: "Is version synced?", "Check my Mermaid diagram", "What's our status?"
- Claude automatically invokes the appropriate skill
- No manual configuration required

**Skill files** are located in `.claude/skills/[skill-name]/SKILL.md`

---

## Success Metrics (Projected)

**After adopting foundation skills:**
- Skill selection time: 10 min → 3 min (70% reduction)
- Setup confidence: Clear recommendations vs overwhelming list
- Token savings: ~60% across version, commit, and documentation tasks

**After adding optimization skills:**
- Workflow-specific efficiency: 50-70% token reduction per use case
- Project-type alignment: Tailored tools for your needs

**After mastering strategic skills:**
- Meta-capabilities: Create your own skills, analyze patterns
- Cross-project efficiency: Multi-project tracking and automation

---

## FAQ

**Q: Do I need all 19 skills?**
A: No! Start with 5 foundation skills, then add optimization based on your project type.

**Q: Can I skip foundation and go straight to strategic?**
A: Foundation skills provide immediate value and are prerequisites for understanding advanced patterns.

**Q: How do skills activate?**
A: Automatically! Just ask questions naturally, and Claude invokes the right skill.

**Q: What if I'm not sure which optimization skills I need?**
A: Check the project type table above, or start with project-analyzer (works for all domain memory projects).

**Q: Can I create my own skills?**
A: Yes! Use the skill-template-generator (strategic level) to scaffold new skills.

---

**Generated from:** `.claude/skills-catalog.json`
**Generator script:** `scripts/generate-skills-catalog.sh`
**Manual edits:** This file is auto-generated. Edit the JSON catalog, then re-run the generator.

