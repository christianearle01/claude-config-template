# Stop Wasting Tokens on Repeated Context

**Every Claude Code session:**

❌ "What framework are you using?"
❌ "Remind me about your tech stack"
❌ 500+ tokens explaining the same project
❌ Lost time re-explaining architecture every session

**Every session with this template:**

✅ Claude already knows (CLAUDE.md loads automatically)
✅ 0 tokens wasted on repeated context
✅ Instant context: "Read CLAUDE.md" → Done
✅ Start coding in seconds, not minutes

**Projected savings:** 50-95% on tokens | 66.7% on costs (model switching)

---

## 🚀 Quick Start (2 Minutes)

**One command to get started:**

```bash
git clone https://github.com/christianearle01/claude-config-template.git
cd claude-config-template
./scripts/quickstart.sh
```

The script asks 2-3 questions and routes you automatically to the best setup path for your situation.

**Don't want to choose?** The script detects:
- Whether you have an urgent problem to solve RIGHT NOW
- How much time you have available
- Whether you're setting up for a team

**Want all options explained?** See [SETUP_OPTIONS.md](SETUP_OPTIONS.md) (9 paths detailed)

---

## ⚠️ Project Status

**New project** - Created December 2025 by one developer

- **Real users:** 1 (the author)
- **Metrics:** Projected/estimated, not validated by multiple users
- **Looking for:** 5-10 early adopters to validate claims

**All metrics shown are theoretical projections.** Token math is factual (Anthropic API pricing), but savings claims need real-world validation.

**Want to help validate?** See [CONTRIBUTING.md](CONTRIBUTING.md) - Early Adopters Program

---

## ✨ What This Template Provides

### Before vs After: Context Management

**Without Template:**
```
Session 1: Explain project (500 tokens)
Session 2: Re-explain project (500 tokens)
Session 3: Re-explain again (500 tokens)
10 sessions = 5,000 tokens wasted
```

**With Template:**
```
One-time: Create CLAUDE.md (500 tokens)
Every session: "Read CLAUDE.md" (50 tokens)
10 sessions = 550 tokens total
Savings: 89% (5,000 → 550 tokens)
```

---

### Before vs After: Model Selection

**Without Template:**
```
All work with Sonnet: $15 per million tokens
Bug fix: 2,000 tokens × $15 = $0.030
Feature: 5,000 tokens × $15 = $0.075
Monthly (50 tasks): ~$5.00
```

**With Template:**
```
Planning with Sonnet: $15/M tokens
Implementation with Haiku: $5/M tokens (66.7% cheaper)
Bug fix: 500 (Sonnet) + 1,500 (Haiku) = $0.015
Feature: 1,000 (Sonnet) + 4,000 (Haiku) = $0.035
Monthly (50 tasks): ~$2.50 (50% savings)
```

*Based on official Anthropic API pricing*

---

### Before vs After: Understanding

**Without Template:**
```
✗ Copy-paste configs without understanding
✗ "Hope it works" mentality
✗ Chronic anxiety from mystery settings
✗ Can't troubleshoot when things break
✗ Dependent on tutorials forever
```

**With Template:**
```
✓ Understand WHY each config exists
✓ Confidence from comprehension
✓ Ship code you can explain and maintain
✓ Troubleshoot issues yourself
✓ Build on knowledge over time
```

*"Understanding Over Speed" - Jake Nations principle*

---

## 🎁 What's Included

**📚 Documentation** (30,000+ lines)
- 5-minute quickstart to see value immediately
- Problem-first guides (learn by solving real problems)
- 40+ comprehensive guides (progressive learning)
- Searchable quick reference

**🤖 Custom Agents** (7 production-ready)
- @project-planner - Multi-perspective architecture analysis
- @coder - Atomic feature execution with bootup ritual
- @quality-reviewer - Security + testing + standards validation
- @initializer - Feature decomposition (vision → features.json)
- @prompt-polisher - Projected 50-80% token savings
- @deployment-readiness - Release validation
- *Plus 3 experimental utility agents*

**💡 Skills Catalog** (19 skills, 3 levels)
- Foundation (3) - Essential for all projects
- Optimization (10) - Workflow-specific improvements
- Strategic (6) - Meta-skills and automation
- Organized to prevent choice overload

**⚙️ Configuration Templates**
- CLAUDE.md template (project memory)
- Optimized settings.json
- Coding standards template
- 5 slash commands (/test, /build, /review, /release, /commit-readiness)
- 3 YAML spec examples

**🧙 Interactive Wizards**
- Problem-First Setup (60 sec, learn by doing)
- Smart Quickstart (auto-routing)
- 5 persona-specific paths
- Progress tracking & validation

---

## 🎯 What You'll Learn

**Foundation Concepts:**
- How Claude Code reads CLAUDE.md automatically
- Why token optimization matters (cost & performance)
- Model selection strategy (Opus vs Sonnet vs Haiku)
- When to use agents vs skills vs commands

**Optimization Techniques:**
- CLAUDE.md best practices (projected 50-95% token savings)
- Prompt caching strategies
- Model switching workflows (66.7% cost reduction)
- Agent coordination patterns

**Advanced Features:**
- Custom agent development
- Skill creation methodology
- MCP server integration
- Security hooks (optional)

**Philosophy:**
- Understanding Over Speed (Jake Nations)
- Problem-First Learning (Gabriel Petersson)
- Simple > Easy (reduce complexity, not friction)
- Ship code you can explain

---

## 💡 Core Features Explained

### CLAUDE.md Project Memory

**What it does:** Write project context once, Claude reads it every session

**Traditional workflow:**
```
Claude: "What framework?"
You: "Next.js with TypeScript"
Claude: "What's your folder structure?"
You: "src/app/, src/components/..."
500+ tokens per session explaining the same things
```

**With CLAUDE.md:**
```
Claude: "Read CLAUDE.md"
Claude: "Got it - Next.js, TypeScript, src/ structure"
50 tokens per session
```

**Projected savings:** 95% reduction on context queries (500 → 50 tokens)

---

### Model Switching (Sonnet→Haiku)

**What it does:** Use expensive models for planning, cheap models for implementation

**Why it works:**
- Planning needs reasoning (Sonnet)
- Implementation is mechanical (Haiku works fine, 66.7% cheaper)

**Example workflow:**
```
1. Plan with Sonnet: "Design API architecture"
2. Switch to Haiku: "/model haiku"
3. Implement with Haiku: "Write the CRUD endpoints"
4. Save 66.7% on implementation costs
```

**Based on:** Official Anthropic API pricing ($15/M Sonnet, $5/M Haiku)

---

### Interactive Wizards

**What they do:** Guide you through setup with validation

**Traditional setup:**
```
Read 50-page guide
Copy-paste 20 configs
Hope you didn't miss anything
60% completion rate (estimated)
52 minutes average (estimated)
```

**With wizards:**
```
Answer questions interactively
Configs generated automatically
Validation at each step
Projected 95% completion rate
Target: 28 minutes average
```

---

## 📖 Quick Reference

**Essential commands:**
```bash
/model haiku      # Switch to cheapest model (66.7% cheaper)
/model sonnet     # Switch to balanced model
/test             # Run test suite
/build            # Build and report errors
/review           # Code review against standards
```

**Essential keyboard shortcuts:**
```
Esc Esc          # Undo last changes (Rewind)
Ctrl-b           # Run command in background
Tab              # Toggle thinking on/off
```

**→ [Complete Quick Reference](docs/00-start-here/09_quick-reference.md)**

---

## 🔄 How It Works Together

**4-layer optimization stack:**

```
Layer 4: AGENTS (Complex tasks)
         @project-planner, @coder, @quality-reviewer
         ↑ uses

Layer 3: SKILLS (Domain automation)
         testing-workflow, commit-readiness
         ↑ triggers

Layer 2: COMMANDS (Quick operations)
         /test, /build, /review
         ↑ reads

Layer 1: CONTEXT (Foundation)
         CLAUDE.md, settings.json, standards
```

**Example workflow:** Adding a feature
1. CLAUDE.md provides project context (Layer 1)
2. @coder agent implements with TDD (Layer 4)
3. /test command runs suite (Layer 2)
4. testing-workflow analyzes results (Layer 3)
5. @quality-reviewer validates security (Layer 4)

**Result:** Vague idea → Shipped feature with quality checks

---

## 📚 Documentation Hub

### Start Here
- [Quick Start (2 min)](docs/00-start-here/03_instant-setup.md) - Fast setup
- [5-Minute Success](docs/00-start-here/03_5-minute-success.md) - See value immediately
- [Problem-First Path](docs/00-start-here/problem-first/00_choose-your-learning-path.md) - Learn by doing
- [Visual Quickstart](docs/00-start-here/07_visual-quickstart.md) - Decision flowchart

### Learn More
- [Quick Reference](docs/00-start-here/09_quick-reference.md) - Searchable feature index
- [Fundamentals](docs/01-fundamentals/) - Core concepts
- [Optimization](docs/02-optimization/) - Token & cost savings
- [Advanced](docs/03-advanced/) - MCP, agents, custom configs

---

## 🆘 Need Help?

**Settings not loading?**
```bash
cat .claude/settings.json | python -m json.tool
```

**CLAUDE.md not found?**
- Must be in project ROOT (not .claude/)
- Filename: `CLAUDE.md` (all caps)

**More issues?**
- Run `/doctor` in Claude Code
- Check [Troubleshooting Guide](docs/00-start-here/09_quick-reference.md#troubleshooting)

---

## 🌟 Ready to Begin?

**Three steps:**

### 1. Clone the Template
```bash
git clone https://github.com/christianearle01/claude-config-template.git
cd claude-config-template
```

### 2. Run Quick Start
```bash
./scripts/quickstart.sh
```

### 3. Start Saving
Begin using Claude Code with optimized configuration.

**Want to explore all paths first?** See [SETUP_OPTIONS.md](SETUP_OPTIONS.md) for 9 detailed options.

---

## 📞 Connect & Contribute

**Early Adopters Program:** [CONTRIBUTING.md](CONTRIBUTING.md) - Help validate our claims!

**Issues & Feedback:** [GitHub Issues](https://github.com/christianearle01/claude-config-template/issues)

**Official Docs:** [Claude Code Documentation](https://code.claude.com/docs)

---

**Compatible with:** Claude Code 2.0+
**Template Version:** v5.0.0-alpha.2
**Last Updated:** 2025-01-13

---

*Stop wasting tokens. Start building with confidence.*

**→ [Get Started Now](./scripts/quickstart.sh)** 👈
