# Team Lead

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > Team Lead

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Deploy Claude Code consistently across your development team. Covers rollout strategy, shared configuration templates, team-specific coding standards, and pilot deployment. Includes onboarding playbooks and feedback collection frameworks for smooth adoption.

**Time:** 90-120 min | **Difficulty:** Medium | **Outcome:** Repeatable team deployment process

---

## You Are This Persona If...

- You're deploying Claude Code for multiple developers (3+ people)
- You need consistent standards across the team
- You want a tested rollout strategy (not just ad-hoc adoption)
- You're responsible for team productivity and quality
- You want to measure adoption success

---

## Your Path (Team Deployment)

### 1. Understand Team Rollout Strategy (20 min)
**→ [Team Onboarding Guide](../../02_project-onboarding/02_good-to-have/03_team-onboarding.md)**

Learn the proven deployment pattern:
- Pilot phase (2-3 developers, 1 week)
- Refinement phase (gather feedback, iterate)
- Full rollout (entire team, phased)

### 2. Create Shared Template (30 min)
**→ [Optimization Guide](../../02_project-onboarding/02_good-to-have/02_optimization-guide.md)**

Fork this template for your organization:
- Customize CLAUDE.md template for your domain
- Add team-specific coding standards
- Configure shared MCP servers
- Set up security hooks

### 3. Write Team Guidelines (30 min)
**→ [CLAUDE.md Template](../../templates/CLAUDE.md.template)**

Document your team's patterns:
- Naming conventions
- Architecture patterns
- Code review standards
- Git workflow

### 4. Pilot Deployment (30 min)
**→ [Setup Checklist](../../02_project-onboarding/01_must-have/02_setup-checklist.md)**

Onboard 2-3 pilot users:
- Walk through setup together
- Observe pain points
- Collect feedback
- Refine process

---

## Team Deployment Checklist

**Planning Phase (Week 0):**
- [ ] Identified pilot users (2-3 developers)
- [ ] Scheduled pilot kickoff meeting
- [ ] Prepared feedback collection template
- [ ] Set success metrics (setup time, completion rate, satisfaction)

**Template Preparation Phase (Week 0):**
- [ ] Forked claude-config-template to team repository
- [ ] Customized CLAUDE.md.template for your domain
- [ ] Documented team-specific coding standards in `~/.claude/coding-standards.md`
- [ ] Added team MCP servers (if applicable)
- [ ] Tested template with your own projects

**Pilot Phase (Week 1):**
- [ ] Onboarded pilot user #1 (pair programming style)
- [ ] Onboarded pilot user #2 (observe independently)
- [ ] Onboarded pilot user #3 (self-service with docs)
- [ ] Collected feedback from all 3 users
- [ ] Measured setup time (target: <30 min)

**Refinement Phase (Week 2):**
- [ ] Analyzed feedback and pain points
- [ ] Updated documentation based on feedback
- [ ] Refined CLAUDE.md template
- [ ] Simplified setup steps (if needed)
- [ ] Tested refined process with 1 pilot user

**Full Rollout Phase (Week 3+):**
- [ ] Announced rollout to full team
- [ ] Provided async documentation + office hours
- [ ] Onboarded remaining team members (phased: 3-5 per week)
- [ ] Monitored adoption metrics
- [ ] Addressed blockers quickly

**✅ Success Criteria:**
- [ ] 80%+ of team using Claude Code within 1 month
- [ ] Average setup time <30 minutes
- [ ] Team satisfaction >7/10
- [ ] Consistent CLAUDE.md patterns across projects

---

## Success Criteria

You have:
1. At least 2 team members successfully set up and using Claude Code
2. Shared template repository with team-specific customizations
3. Documented onboarding process (can onboard new members without you)
4. Feedback loop for continuous improvement
5. Metrics showing adoption success

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Skipping Pilot Phase
**Problem:** Full rollout reveals issues at scale, hard to fix

**Example:**
```
Week 1: Deploy to entire team (20 developers)
Week 2: 15 developers report same setup issue
Week 3: Frantically fixing docs, re-onboarding 15 people
Week 4: Team frustrated, adoption drops to 40%
```

**✅ Correct Approach:**

Pilot → Refine → Rollout (in phases):

```
Week 0: Prepare template
Week 1: Pilot with 3 users → Find setup issue early
Week 2: Fix docs, refine process
Week 3: Roll out to 5 more users → Success rate 100%
Week 4: Roll out to remaining 12 users → Smooth process
```

**Pattern:** Test with small group, fix issues, then scale.

---

### ❌ Anti-Pattern #2: Creating One-Size-Fits-All Template
**Problem:** Different projects need different configs

**Example:**
```
Shared Template (WRONG):
- Frontend React project settings
- Backend API needs different settings (fails)
- Data science project needs different MCP servers (fails)

Result: 60% of team can't use template without heavy modification
```

**✅ Correct Approach:**

Create **base template** + **project-type variants**:

```
team-claude-config/
├── base/                    # Core standards (all projects)
│   └── coding-standards.md
│
├── frontend-react/          # Frontend variant
│   ├── .claude/
│   └── CLAUDE.md.template
│
├── backend-api/             # Backend variant
│   ├── .claude/
│   └── CLAUDE.md.template
│
└── data-science/            # Data science variant
    ├── .claude/
    └── CLAUDE.md.template
```

**Pattern:** Base standards + project-type specialization.

---

### ❌ Anti-Pattern #3: No Feedback Collection
**Problem:** Can't improve what you don't measure

**Example:**
```
You: "Setup complete! Any questions?"
Team: "Nope, looks good!"

[3 weeks later]
You: "Is everyone using Claude Code?"
Team: "We tried, but ran into issues... gave up..."

Result: Low adoption, no data to fix it
```

**✅ Correct Approach:**

Structured feedback collection:

```markdown
## Pilot User Feedback Form

**Name:** _____
**Date:** _____
**Setup Time:** _____ minutes

**Setup Experience:**
1. What was confusing? (rate 1-10, 10=very confusing)
   - Installation: ___
   - CLAUDE.md creation: ___
   - First usage: ___

2. What would you improve?
   - _____________________________

3. Would you recommend this to teammates? (1-10)
   - Rating: ___
   - Why: _____________________________

**Weekly Usage (Week 1):**
- How often did you use Claude Code? (daily/few times/once/never)
- What worked well? _____
- What didn't work? _____
```

**Pattern:** Collect quantitative + qualitative feedback, iterate based on data.

---

### ❌ Anti-Pattern #4: Forcing Adoption Without Training
**Problem:** Tools fail without understanding WHY they exist

**Example:**
```
Email: "Everyone must use Claude Code starting Monday. See docs."

Monday:
- 5 people ask "Why are we using this?"
- 3 people can't install it
- 8 people installed but don't understand CLAUDE.md
- 4 people revert to old workflow

Result: 20% adoption, team resentment
```

**✅ Correct Approach:**

Educate → Enable → Encourage (not force):

```
Phase 1 - Educate (Week 0):
- "Lunch & Learn" demo (30 min)
- Show real example: "This task used to take 2 hours, now 30 min"
- Answer questions, build excitement

Phase 2 - Enable (Week 1-2):
- Pilot program (opt-in, not mandatory)
- Office hours for support
- Share pilot users' success stories

Phase 3 - Encourage (Week 3+):
- "Here's how Sarah used Claude to ship 3 features this week"
- Make success visible, organic adoption follows
- Never mandate, let results speak
```

**Pattern:** Demonstrate value → Support adoption → Let success spread organically.

---

## Next Steps

### After Successful Team Deployment

You've built momentum:

**Option A: Measure Impact (15 min/week)**
→ Track metrics: adoption rate, setup time, satisfaction
→ Share wins with team ("Sarah saved 10 hours this week")

**Option B: Expand to More Teams (replicate process)**
→ Share playbook with other team leads
→ Help them customize for their domain

**Option C: Advanced Features for Team (30 min)**
→ [Advanced Optimizer](03_advanced-optimizer.md) - Add team-wide security hooks
→ Create shared custom agents for common tasks

**Option D: Continuous Improvement (ongoing)**
→ Monthly feedback sessions
→ Update templates based on team evolution
→ Share lessons learned with community

---

## Need Help?

**Low adoption rate?**
- Review feedback: What's blocking people?
- Simplify setup: Can you remove steps?
- Pair with users: Walk through setup together

**Inconsistent usage across team?**
- Check CLAUDE.md quality: Are they documenting business purpose?
- Provide examples: Share best CLAUDE.md files
- Office hours: Available for questions

**Template not fitting projects?**
- Create variants: Different project types need different configs
- Make it modular: Base + optional add-ons
- Get feedback: What do projects need that's missing?

---

**Estimated total time:** 105 minutes (midpoint of 90-120 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
