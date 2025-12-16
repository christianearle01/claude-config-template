# Planning a New Project

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > Planning a New Project

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Use the project-planner agent to architect a new project before writing code. Get tech stack recommendations, CLAUDE.md draft, and concrete next steps. Includes 6-perspective analysis (Psychological, Educator, Engineering, Product, DevOps, Security) for sound decisions.

**Time:** 25-30 min | **Difficulty:** Medium | **Outcome:** Complete project plan + CLAUDE.md draft

---

## You Are This Persona If...

- You have a project idea but no code yet
- You want tech stack recommendations with rationale
- You prefer to plan before coding (not dive in blindly)
- You want to avoid costly architecture mistakes early
- You're willing to spend 30 minutes thinking before 30 hours coding

---

## Your Path (Planning Session)

### Step 1: Invoke the Project-Planner Agent (2 min)

```bash
# Start Claude Code in any directory
claude

# Invoke the project-planner agent
@project-planner I want to build [describe your project idea]
```

**Example:**
```
@project-planner I want to build a task management SaaS for small teams
with real-time collaboration and mobile apps
```

### Step 2: Planning Conversation (20-25 min)

The agent will guide you through 4 phases:

**Phase 1: Discovery (5 min)**
- Agent asks clarifying questions
- You provide: users, features, constraints, timeline
- Example questions:
  - "Who are your users?"
  - "What's your technical experience?"
  - "Timeline constraints?"

**Phase 2: Exploration (10-15 min)**
- Agent presents 2-3 architectural approaches
- Shows tradeoffs (complexity, cost, scalability)
- You discuss preferences and concerns
- Agent uses 6-perspective analysis:
  - 🧠 Psychological (user emotions, motivation)
  - 👨‍🏫 Educator (learning curve, skill gaps)
  - 🔧 Engineering (technical feasibility, maintenance)
  - 📦 Product (user value, competitive advantage)
  - 🚀 DevOps (deployment, scaling, infrastructure)
  - 🔒 Security (vulnerabilities, compliance)

**Phase 3: Recommendation (5 min)**
- Agent recommends tech stack with WHY for each choice
- Provides migration paths (how to change decisions later)
- Shows learning resources tailored to your skill level

**Phase 4: Documentation (5 min)**
- Agent generates CLAUDE.md draft
- Provides next steps checklist
- Gives concrete action items to start coding

---

## Planning Checklist

**Preparation Phase:**
- [ ] Defined project idea in 1-2 sentences
- [ ] Know your target users
- [ ] Have rough feature list (doesn't need to be complete)
- [ ] Understand your timeline constraints

**Planning Session Phase:**
- [ ] Answered discovery questions honestly
- [ ] Reviewed all architectural options presented
- [ ] Understood tradeoffs between approaches
- [ ] Asked questions about unclear recommendations

**Output Phase:**
- [ ] Received tech stack recommendations with rationale
- [ ] Got CLAUDE.md template draft
- [ ] Have next steps checklist
- [ ] Understand learning resources for unfamiliar technologies

**✅ Ready to Code:**
- [ ] Create project repository
- [ ] Copy `.claude/` configuration
- [ ] Use generated CLAUDE.md draft
- [ ] Initialize tech stack (framework, database, etc.)

---

## Success Criteria

You have:
1. Clear project vision (problem, users, features)
2. Tech stack recommendations with WHY for each choice
3. CLAUDE.md draft ready to use
4. Concrete next steps to start building
5. Understanding of migration paths (can change decisions later)

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Being Too Vague in Discovery
**Problem:** Vague input = generic recommendations

**Example:**
```
You: "@project-planner I want to build a web app"
Agent: "What kind of web app? Who are your users? What features?"
You: "Just a web app for users to do stuff"

Result: Generic tech stack, no project-specific guidance
```

**✅ Correct Approach:**

Be specific about problem, users, and core features:

```
You: "@project-planner I want to build a task management SaaS for
remote teams (5-20 people). Core features: real-time task updates,
file attachments, mobile apps. Users are non-technical project managers.
I have 3 months, experienced with React but new to real-time features."

Agent: [Provides tailored recommendations for real-time architecture,
React ecosystem, mobile options, learning path for WebSockets/polling]

Result: Specific, actionable plan
```

**Pattern:** Specific problem + target users + core features = actionable recommendations.

---

### ❌ Anti-Pattern #2: Choosing Tech Because It's "Cool"
**Problem:** Technology hype > project needs

**Example:**
```
Agent: "For your MVP, I recommend PostgreSQL (reliable, proven) or
       Firebase (fast setup, managed). What's your priority?"

You: "I heard MongoDB is web-scale. Let's use that."

Agent: "MongoDB works, but for relational task data, PostgreSQL fits
       better. Why MongoDB?"

You: "It's NoSQL and everyone's using it."

Result: Mismatched tech, harder development, potential refactor later
```

**✅ Correct Approach:**

Choose tech based on **project needs**, not hype:

```
Agent: "For your task management app with relational data (tasks →
       users, projects → tasks), I recommend PostgreSQL. Here's why:

       ✅ Relational data model (perfect fit)
       ✅ ACID transactions (data integrity)
       ✅ Mature ecosystem (lots of resources)

       Alternative: Firebase (faster MVP but vendor lock-in)

       What's your priority: Speed or control?"

You: "I want to learn proper backend development. PostgreSQL."

Agent: "Great choice. Here's your learning path..."

Result: Right tech for right reasons
```

**Pattern:** Needs-driven decisions > hype-driven decisions.

---

### ❌ Anti-Pattern #3: Skipping the "Why" Behind Recommendations
**Problem:** Accept recommendations blindly, regret later

**Example:**
```
Agent: "I recommend Next.js for your frontend."

You: "Okay, let's use Next.js."

[2 weeks later]
You: "Why is server-side rendering so complicated? I just wanted
     a simple SPA!"

Result: Chose complex framework without understanding tradeoffs
```

**✅ Correct Approach:**

Ask "WHY?" for every recommendation:

```
Agent: "I recommend Next.js for your frontend."

You: "Why Next.js instead of plain React?"

Agent: "Great question! Here's my reasoning:

       ✅ SEO matters for your landing pages (SSR benefit)
       ✅ Built-in routing (less setup)
       ✅ API routes (can build backend in same project)

       Alternative: Plain React if you don't need SEO or backend

       Does SEO matter for your project?"

You: "Actually, this is an internal tool (no SEO needed). Plain React?"

Agent: "Perfect! Plain React is simpler for your use case. Here's why..."

Result: Right tool, understood tradeoffs
```

**Pattern:** Always ask "WHY?" — understand rationale before accepting.

---

### ❌ Anti-Pattern #4: Not Documenting Decisions
**Problem:** Forget WHY you chose something in 3 months

**Example:**
```
[Planning session]
Agent: "Use PostgreSQL because [good reasons]"
You: "Okay!" [doesn't write it down]

[3 months later, project struggling]
You: "Why did we choose PostgreSQL again? Should we switch to MongoDB?"
[No record of original reasoning, restart debate]

Result: Repeat decisions, waste time
```

**✅ Correct Approach:**

Use the generated CLAUDE.md draft + add decision log:

```markdown
<!-- CLAUDE.md -->
## Tech Stack Decisions

### Database: PostgreSQL
**Decided:** 2025-12-16
**Why:**
- Relational data model fits task management (tasks → users relationship)
- ACID transactions ensure data integrity
- Team has SQL experience

**Alternatives Considered:**
- MongoDB (rejected: doesn't fit relational data)
- Firebase (rejected: vendor lock-in concerns)

**Migration Path:**
If we need to scale beyond PostgreSQL:
1. Add read replicas (handles 10× traffic)
2. Add caching layer (Redis)
3. Consider sharding (only if 1M+ users)
```

**Pattern:** Document decisions + rationale = avoid repeating debates.

---

## Next Steps

### After Completing Planning

You have a roadmap, now build:

**Step 1: Set Up Project (10 min)**
```bash
# Create repository
mkdir my-project && cd my-project
git init

# Copy Claude Code configuration
cp -r ~/Developer/claude-config-template/.claude .

# Use generated CLAUDE.md draft
# (Copy from planning session output)
```

**Step 2: Initialize Tech Stack (20 min)**
```bash
# Example: Next.js + PostgreSQL
npx create-next-app@latest
npm install pg

# Follow agent's setup recommendations
```

**Step 3: Start Development Loop (ongoing)**
→ [Quick Setup User](02_quick-setup-user.md) - Fast project configuration

**Step 4: Use Agents During Development**
- `@initializer` - Break project into features with confidence scores
- `@coder` - Implement features with TDD
- `@quality-reviewer` - Security + testing + standards

---

## What You'll Receive from Planning

### 1. Project Planning Summary
- Problem statement
- Target users
- Core features (prioritized)
- Success metrics

### 2. Tech Stack Recommendations
- Frontend framework (with WHY)
- Backend framework (with WHY)
- Database choice (with WHY)
- Deployment platform (with WHY)
- Each choice includes alternatives and tradeoffs

### 3. CLAUDE.md Draft
Ready-to-use project memory file:
```markdown
## What Does This App Do?
[Generated based on your conversation]

## Tech Stack
[Your chosen technologies with rationale]

## External APIs
[APIs you'll use with business reasons]
```

### 4. Next Steps Checklist
Concrete action items:
- [ ] Initialize project repository
- [ ] Set up development environment
- [ ] Install dependencies
- [ ] Create database schema
- [ ] Build first feature (recommended starting point)

### 5. Learning Resources
Tailored to your skill level:
- Tutorials for unfamiliar technologies
- Best practices guides
- Common pitfalls to avoid

### 6. Migration Paths
How to change decisions later:
- "If PostgreSQL becomes limiting, here's how to migrate to..."
- "If Next.js is too complex, here's how to switch to..."

---

## Example Planning Session

**User Input:**
```
@project-planner I want to build a personal finance tracker for
millennials who struggle with budgeting. Core features: expense
tracking, budget recommendations, bill reminders. I'm a solo developer
with React experience, want to launch MVP in 6 weeks.
```

**Agent Output (25 min conversation):**
- Recommended: React + Firebase (fast MVP, managed backend)
- Provided: CLAUDE.md draft with business purpose
- Suggested: Start with expense tracking (core feature), add AI later
- Learning path: Firebase auth tutorial (2 hours)
- Next steps: 7-item checklist to start coding

**Result:** Developer starts coding Day 1 with clear direction.

---

## Need Help?

**Agent not responding to @project-planner?**
- Check: Are you in claude-config-template directory?
- Verify: `.claude/agents/project-planner.md` exists
- Try: Restart Claude Code

**Recommendations feel generic?**
- Be more specific in discovery phase
- Share constraints (timeline, budget, team size)
- Mention your experience level with technologies

**Not sure about a recommendation?**
- Ask "Why?" for every tech choice
- Request alternatives: "What if I used X instead?"
- Ask for learning resources: "I'm new to Y, where should I start?"

---

**Estimated total time:** 27 minutes (midpoint of 25-30 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
