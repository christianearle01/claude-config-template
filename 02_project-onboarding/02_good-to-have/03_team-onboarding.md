# Claude Code Setup - Team Onboarding

## New Team Member Checklist:

### Part 1: One-Time Global Setup (15 minutes)

- [ ] Install Claude Code (if not already installed)
- [ ] Add environment variables to ~/.zshrc:
  ```bash
  nano ~/.zshrc
  # Scroll to bottom and add:

  # ===== Claude Code Performance Optimization =====
  export CLAUDE_CODE_MAX_OUTPUT_TOKENS=4000
  export MAX_MCP_OUTPUT_TOKENS=50000
  export DISABLE_PROMPT_CACHING=false
  export CLAUDE_CODE_ENABLE_TELEMETRY=1
  export CLAUDE_CODE_METRICS_EXPORTER=console
  export BASH_DEFAULT_TIMEOUT_MS=30000
  export BASH_MAX_TIMEOUT_MS=120000

  # Save and exit (Ctrl+X, Y, Enter)
  source ~/.zshrc
  ```
- [ ] Create ~/.claude.json:
  ```bash
  nano ~/.claude.json
  # Paste this JSON:

  {
    "model": "sonnet",
    "alwaysThinkingEnabled": true,
    "outputStyle": "concise"
  }

  # Save and exit (Ctrl+X, Y, Enter)
  ```
- [ ] Verify setup:
  ```bash
  echo $CLAUDE_CODE_MAX_OUTPUT_TOKENS  # Should output: 4000
  cat ~/.claude.json  # Should show your settings
  ```

### Part 2: Use Existing Project (2 minutes)

- [ ] Clone project repository:
  ```bash
  git clone <repo-url>
  cd <project-name>
  ```
- [ ] Verify project configs exist:
  ```bash
  ls .claude/settings.json  # Should exist
  ls CLAUDE.md  # Should exist
  ```
- [ ] Read project conventions:
  ```bash
  cat CLAUDE.md
  ```
- [ ] Start using Claude Code:
  ```bash
  claude
  ```

### Part 3: Start New Project (5 minutes)

- [ ] Copy template to new project:
  ```bash
  cd /path/to/new/project
  cp -r ~/Developer/claude-config-template/.claude .
  cp ~/Developer/claude-config-template/CLAUDE.md .
  ```
- [ ] Customize CLAUDE.md for the project
- [ ] Adjust .claude/settings.json if needed
- [ ] Commit configs to git:
  ```bash
  git add .claude/ CLAUDE.md
  git commit -m "Add Claude Code configuration"
  ```

## Essential Commands:

| Command | Purpose |
|---------|---------|
| `/usage` | Check plan limits and usage |
| `/model haiku` | Switch to cheaper model (92% savings) |
| `/clear` | Start fresh context between tasks |
| `/model opus` | Switch to Opus for complex problems |
| `/model sonnet` | Switch to Sonnet for regular work |
| `/doctor` | Diagnose installation issues |

## Expected Benefits:

- **30-50% cost reduction** from optimizations
- **90% faster project setup** (2-3 minutes)
- **Consistent behavior** across team
- **Better code quality** from documented standards

## Troubleshooting:

### Environment variables not loading:
```bash
# Check which shell you're using:
echo $SHELL

# If zsh: edit ~/.zshrc
# If bash: edit ~/.bashrc

# Reload after editing:
source ~/.zshrc  # or source ~/.bashrc
```

### Claude not following project conventions:
```bash
# Verify CLAUDE.md exists in project root:
ls -la CLAUDE.md

# Start fresh session:
claude
/clear
```

### Settings not applying:
```bash
# Verify JSON is valid:
cat ~/.claude.json | python -m json.tool
cat .claude/settings.json | python -m json.tool
```

## Need Help?

- **Full guide**: Check IMPLEMENTATION_GUIDE.md in any project's `.claude/` folder
- **Template**: `~/Developer/claude-config-template/`
- **Team contact**: [Add your team lead contact here]

---

**Quick Start**: If you just want to get going fast:
1. Run the environment variable setup (Part 1 above)
2. Clone the project (it has configs already)
3. Start coding with `claude`

---

## 🚫 Common Team Onboarding Mistakes (Anti-Patterns)

### ❌ Anti-Pattern #1: Skipping the Pilot Phase

**Problem:** Rolling out to entire team immediately without testing

**Example:**
```
Week 1: Announce "Everyone use Claude Code now!"
Week 2: 20 people encounter different issues
Week 3: Support tickets overwhelm team leads
Result: Failed adoption, wasted 60+ hours
```

**✅ Correct Approach:**
```
Week 1: 2-3 pilot users test setup
Week 2: Collect feedback, fix issues
Week 3: Pilot users help onboard next wave
Week 4: Full team rollout with proven process
Result: 95%+ adoption rate, smooth deployment
```

**Pattern:** Always pilot with 2-3 users first. Fix issues before scaling.

---

### ❌ Anti-Pattern #2: No Standard CLAUDE.md

**Problem:** Every team member creates their own project documentation

**Example:**
```
Developer A: Writes 500-line CLAUDE.md with everything
Developer B: Writes 20-line CLAUDE.md with basics
Developer C: Skips CLAUDE.md entirely
Result: Inconsistent Claude behavior across team
```

**✅ Correct Approach:**
```
1. Team lead creates master CLAUDE.md template
2. Template includes: Business purpose, tech stack, conventions
3. Each project copies and customizes template
4. Team reviews CLAUDE.md in code reviews
Result: Consistent Claude behavior, faster onboarding
```

**Pattern:** Create team CLAUDE.md template. Review in PRs like you review code.

---

### ❌ Anti-Pattern #3: Over-Documenting in CLAUDE.md

**Problem:** Putting implementation details in project memory

**Example:**
```markdown
# CLAUDE.md (BAD - Too detailed!)

## How Authentication Works
1. User submits form (line 45 in login.tsx)
2. API validates credentials (line 127 in auth.py)
3. JWT token generated (line 89 in tokens.py)
4. Token stored in localStorage (line 23 in auth-context.tsx)
... [500 more lines of implementation details]
```

**✅ Correct Approach:**
```markdown
# CLAUDE.md (GOOD - Business focus!)

## What Does This Application Do?
User authentication system for enterprise customers.
Supports OAuth, SAML, and magic link authentication.

## Key Features
- Single sign-on (SSO)
- Multi-factor authentication (MFA)
- Role-based access control (RBAC)

## Tech Stack
- Frontend: React + TypeScript
- Backend: Python + FastAPI
- Database: PostgreSQL
```

**Pattern:** Document WHAT the app does (business), not HOW it works (implementation). Let Claude explore code for implementation details.

---

### ❌ Anti-Pattern #4: Not Tracking Cost/Usage

**Problem:** No visibility into token usage across team

**Example:**
```
Month 1: Team uses Claude Code freely
Month 2: Bill is $2,000 (unexpected!)
Month 3: No idea who/what caused high usage
Result: Budget overrun, no optimization path
```

**✅ Correct Approach:**
```bash
# Weekly team check-in:
/usage

# Share results: "This week I used 45% of my plan limit"
# Discuss: "Try model switching to reduce costs"
# Track: Spreadsheet of weekly usage per person
Result: Predictable costs, optimization opportunities
```

**Pattern:** Check `/usage` weekly. Share with team. Optimize high users first.

---

### ❌ Anti-Pattern #5: No Feedback Loop

**Problem:** Team encounters issues but never shares them

**Example:**
```
Developer A: Struggles with settings, figures it out alone (2 hours)
Developer B: Has same issue, figures it out alone (2 hours)
Developer C: Has same issue, figures it out alone (2 hours)
Result: 6 hours wasted on duplicate problem-solving
```

**✅ Correct Approach:**
```
Developer A: Encounters issue, posts in #claude-code Slack
Developer B: Sees post, avoids issue entirely
Developer C: Sees post, uses solution immediately
Team Lead: Updates onboarding doc with solution
Result: Issue solved once, benefits everyone forever
```

**Pattern:** Create feedback channel (Slack, Teams). Update docs when issues repeat.

---

## ✅ You've Completed: Team Onboarding

**What you accomplished:**
- Understand 3-part onboarding process (global setup, existing project, new project)
- Know essential commands (/usage, /model, /clear)
- Configure environment variables for performance
- Set up ~/.claude.json for user preferences
- Understand expected benefits (30-50% cost reduction, 90% faster setup)
- Know 5 critical anti-patterns to avoid

**Team readiness checklist:**
- ✅ Pilot users identified (2-3 people)
- ✅ Master CLAUDE.md template created
- ✅ Feedback channel established (Slack/Teams)
- ✅ Usage tracking process defined
- ✅ Rollout timeline planned (4 weeks)

**Next logical step:**

**Option A: Start Pilot Phase (Week 1) - Recommended**
→ Select 2-3 pilot users from your team
- Walk through this guide with them
- Collect feedback on pain points
- Fix issues before wider rollout
- Document solutions in team wiki

**Option B: Create Master CLAUDE.md Template (30 min)**
→ Define team standards for project documentation
- What sections are required?
- What level of detail?
- Review process for updates?
- Share template in team repo

**Option C: Set Up Feedback Loop (15 min)**
→ Create #claude-code channel in Slack/Teams
- Pin this onboarding guide
- Set weekly check-in schedule
- Assign someone to monitor/respond
- Update docs based on feedback

**Option D: Learn Advanced Team Patterns (20 min)**
→ Explore advanced coordination for teams
- Model selection strategy across team
- Shared skill libraries
- Team preference templates
- Cross-project learnings

---

**Estimated next step time:** 15-30 minutes (depending on choice)
**Expected team impact:** 30-50% cost reduction, 90% faster project setup
**Rollout timeline:** 4 weeks (pilot → feedback → rollout → optimization)
**Having trouble?** Check the Troubleshooting section above or post in your team feedback channel

**Last Updated:** 2025-12-16
