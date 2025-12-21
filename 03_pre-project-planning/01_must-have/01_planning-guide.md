# Pre-Project Planning Guide

**Purpose:** Learn how to plan new projects BEFORE writing any code using the project-planner agent.

**Time Investment:** 25-30 minutes per project planning session

**When to Use This:** You have a project idea but no code yet. You need help with:
- Architecture decisions (tech stack, database, hosting)
- Validating your project idea with technical feedback
- Creating a structured plan before starting development
- Avoiding analysis paralysis while still planning thoughtfully

---

## What is the Project Planner Agent?

The **project-planner agent** is a collaborative thought partner that helps you architect new projects through a structured conversation. It uses 6 coordinated perspectives:

- **🧠 Psychological** - Empathetic conversation that builds confidence
- **📚 Educator** - Scaffolded learning through Socratic questions
- **💻 Software Engineering** - Technical recommendations with clear trade-offs
- **🎨 Product/UX** - Focus on user value and MVP scope
- **🔧 DevOps** (lightweight) - Hosting options and deployment awareness
- **🛡️ Security** (lightweight) - Authentication and data sensitivity

---

## The Planning Conversation (4 Phases)

### Phase 1: Discovery (5 min)
- Tell the agent about your project idea
- Answer clarifying questions about your goals
- Identify your expertise level and constraints

### Phase 2: Exploration (10-15 min)
- Discuss 2-3 architectural approaches
- Explore trade-offs collaboratively
- Validate your existing ideas
- Address concerns and questions

### Phase 3: Recommendation (5 min)
- Receive structured tech stack recommendations
- Understand WHY for each choice
- Learn about migration paths (escape hatches)
- Get learning resources tailored to your level

### Phase 4: Documentation (5 min)
- Generate CLAUDE.md template draft for your new project
- Receive project structure outline
- Get next steps checklist
- Option to iterate and refine

**Total Time:** 25-30 minutes (time-boxed to prevent over-planning)

---

## How to Start Planning

### Step 1: Invoke the Agent

```bash
# In Claude Code terminal or VS Code Extension
@project-planner I want to build [your project idea]
```

**Example:**
```
@project-planner I want to build a SaaS for freelancers to track time and invoice clients
```

### Step 2: Answer Questions

The agent will ask clarifying questions like:
- What's your experience level with web development?
- Are you building solo or with a team?
- How many users do you expect initially?
- What technologies are you comfortable with?

**Tip:** Be honest about your skill level - the agent tailors recommendations accordingly.

### Step 3: Explore Options

The agent will present 2-3 architectural approaches with:
- **Default recommendation** (80% use case - proven, learnable)
- **Alternatives if...** (specific conditions like "if you need real-time...")
- **Avoid if...** (anti-recommendations to save you from common mistakes)
- **Migration paths** (how to change decisions later)

**Example Output:**
```markdown
### Recommended Tech Stack

**Language:** TypeScript
- **Why:** Type safety helps as codebase grows, catches bugs early
- **Alternative:** Can add TypeScript later (gradual migration is straightforward)

**Framework:** Next.js 14 (App Router)
- **Why:** Server-side rendering, built-in API routes, excellent deployment
- **Alternative:** If you prefer separate frontend/backend, React + Express works well

**Database:** PostgreSQL
- **Why:** Your data is highly relational (users → projects → tasks)
- **Alternative:** If you want serverless/edge, consider PlanetScale (MySQL)
- **Avoid:** MongoDB for this use case (relational data doesn't fit document model)
```

### Step 4: Receive Documentation

The agent generates:

1. **Project Planning Summary** - Complete technical plan
2. **CLAUDE.md Draft** - Pre-filled project memory template
3. **Next Steps Checklist** - Concrete action items to start coding
4. **Learning Resources** - Links to tutorials and documentation
5. **Migration Paths** - How to change decisions if needed

---

## What You'll Get (Example Output)

See [Project Plan Template Example](../../templates/project-plan-template.md) for a complete example of what the agent generates.

**Key Sections:**
- Problem Statement
- Target Users & Pain Points
- Core Features (MVP scope)
- Recommended Tech Stack (with WHY for each choice)
- Project Structure
- Next Steps Checklist
- Learning Resources
- Migration Paths (escape hatches)
- CLAUDE.md Template Draft

---

## Best Practices

### ✅ Do This:

**Be Specific About Your Idea:**
```
✅ "I want to build a task management app for small teams (2-10 people)
    with real-time collaboration, similar to Trello but simpler"
```

**Share Your Constraints:**
```
✅ "I'm a solo developer, familiar with Python and JavaScript,
    budget is $20/month for hosting"
```

**Ask About Trade-offs:**
```
✅ "Why did you recommend PostgreSQL over MongoDB?"
✅ "What's the learning curve for Next.js vs plain React?"
```

**Request Alternatives:**
```
✅ "What if I wanted to use Vue instead of React?"
✅ "Is there a simpler option for authentication?"
```

### ❌ Avoid This:

**Being Too Vague:**
```
❌ "I want to build a web app"
```

**Asking for Everything:**
```
❌ "I want real-time collaboration, AI features, mobile apps,
    desktop apps, and it should scale to millions of users"
```

**Over-planning:**
```
❌ Spending 3 hours planning every detail
    (Agent will time-box you at 30 min)
```

**Ignoring Your Skill Level:**
```
❌ "I'm a beginner but I want to use Kubernetes, microservices,
    and GraphQL federation"
```

---

## Decision Frameworks (How the Agent Thinks)

### Start Simple Bias
- Default to proven, boring technology
- Add complexity only when justified
- Example: Start with monolith, extract microservices IF needed

### Optimize for Change
- Defer irreversible decisions
- Use abstractions for vendor-specific features
- Example: Start with SQLite, switch to Postgres later if needed

### Team-First
- Choose stack team knows over "best" stack
- Learning curve is a real cost
- Example: Node.js if team knows JavaScript, not Rust

### Escape Hatches
- Every recommendation includes migration path
- No decision is permanent
- Example: "Start with Firebase, migrate to self-hosted if needed"

---

## Anti-Patterns (What the Agent Helps You Avoid)

### 🚫 Resume-Driven Development
Don't use trendy tech just to learn it. Choose based on project needs.

**Bad:** "I want to use Kubernetes for my 10-user blog"
**Good:** "I'll deploy on Vercel for now, can scale later if needed"

### 🚫 Premature Optimization
Don't plan for millions of users if you have zero users.

**Bad:** "I need database sharding and caching from day 1"
**Good:** "I'll start with PostgreSQL, add caching when I have performance data"

### 🚫 Technology Bias
Don't always recommend the same stack regardless of use case.

**Bad:** "Always use PostgreSQL for everything"
**Good:** "Use PostgreSQL for relational data, Redis for caching, S3 for files"

### 🚫 Feature Creep in Planning
Don't suggest features beyond MVP during planning.

**Bad:** "You should also add AI recommendations, analytics dashboard, and mobile app"
**Good:** "Start with core task management, add features based on user feedback"

---

## Success Criteria

**You're ready to start coding when:**

✅ You can articulate your project vision clearly (problem, users, core features)
✅ You understand WHY each technology was recommended
✅ You have a CLAUDE.md draft ready to use
✅ You have concrete next steps (not vague guidance)
✅ You feel confident (not overwhelmed or paralyzed)
✅ You know what to build first (MVP feature priority)
✅ You understand how to change decisions later (migration paths)

**Warning Signs (You're Over-planning):**
❌ Planning session exceeded 45 minutes
❌ Designing database schema in detail
❌ Debating minor implementation details
❌ Comparing 5+ alternative technologies
❌ Feeling paralyzed by "what if" scenarios

**If this happens:** The agent will suggest: "You have enough to start! Begin with [first feature] and refine as you build."

---

## After Planning: Next Steps

### 1. Create Your Project Repository
```bash
mkdir your-project-name
cd your-project-name
git init
```

### 2. Copy Claude Code Configuration
```bash
# Copy the template configuration
cp -r ~/Developer/claude-config-template/.claude .
```

### 3. Use Your Generated CLAUDE.md
```bash
# The agent gave you a CLAUDE.md draft - save it
# Edit to add project-specific details
nano CLAUDE.md
```

### 4. Initialize Your Chosen Tech Stack
```bash
# Example for Next.js (use what the agent recommended)
npx create-next-app@latest . --typescript --tailwind --app
npm install [dependencies the agent suggested]
```

### 5. Start Building Your First Feature
```bash
# Open Claude Code and start implementing
claude

# Reference your plan
You: "I just finished planning this project with project-planner.
     Let's start by implementing [first feature from your plan]."
```

---

## Example Planning Session

### User Input:
```
@project-planner I want to build a SaaS for small teams to track tasks
and collaborate. I'm a solo developer comfortable with JavaScript and Python.
I expect 10-50 teams (5-10 people each) initially. Budget is $50/month for hosting.
```

### Agent's Questions:
```
Great! Let me ask a few clarifying questions:

1. Do you need real-time collaboration (multiple people editing simultaneously)?
2. Will you need mobile access or primarily web-based?
3. Any integrations you need (Google Calendar, Slack, etc.)?
4. What's your timeline? (MVP in weeks vs months)
```

### User Answers:
```
1. Not initially - email notifications are fine for now
2. Primarily web, mobile later if needed
3. Google Calendar sync would be nice eventually
4. MVP in 4-6 weeks
```

### Agent's Recommendations:
```markdown
## Recommended Tech Stack

**Language:** TypeScript
- You know JavaScript, TypeScript adds type safety (catches bugs early)
- Gradual learning curve, many resources available

**Framework:** Next.js 14 (App Router)
- Full-stack (frontend + backend in one codebase)
- Server-side rendering for better SEO
- Vercel deployment (free tier for MVP)

**Database:** PostgreSQL (hosted on Railway or Neon)
- Relational data fits your use case (teams → users → tasks)
- Free tier: Neon (generous limits)
- Easy migration to self-hosted later

**Hosting:** Vercel (frontend + API) + Railway (PostgreSQL)
- Combined free tier supports 50 teams easily
- Zero-config deploys
- Migrate to AWS/GCP when you outgrow limits

## Next Steps
1. [ ] Set up Next.js project (10 min)
2. [ ] Initialize PostgreSQL on Neon (5 min)
3. [ ] Build authentication first (2-3 hours)
4. [ ] Then task CRUD (3-4 hours)

## Migration Paths
- Can add React Native for mobile later
- Can self-host on Railway/Fly.io if you outgrow Vercel
- Can add real-time with Pusher or Socket.io when needed
```

---

## Common Questions

### Q: How is this different from just asking Claude directly?

**A:** The project-planner agent is specifically designed for pre-project planning with:
- 6 coordinated perspectives (psychological, educational, technical, product, devops, security)
- Structured 4-phase conversation flow
- Built-in anti-patterns to avoid (resume-driven development, premature optimization)
- Time-boxing to prevent analysis paralysis
- Consistent output format (CLAUDE.md draft, next steps, migration paths)
- Persona-aware responses (adjusts for your skill level)

Regular Claude conversations can wander or go too deep into implementation details.

### Q: Can I use this for existing projects?

**A:** This is specifically for **new projects with no code yet**. For existing projects, use:
- `02_project-onboarding/` guides to set up Claude Code configuration
- Regular Claude Code sessions to refactor or add features

### Q: What if I disagree with the recommendations?

**A:** Great! The agent presents options with trade-offs, not absolute rules. You can:
- Ask for alternatives: "What if I used Vue instead of React?"
- Challenge assumptions: "Why do you think PostgreSQL is better than MongoDB here?"
- Request different approaches: "I prefer separate frontend/backend - how would that change things?"

The agent is a **thought partner**, not a dictator.

### Q: Can I have multiple planning sessions for one project?

**A:** Yes! You might:
- Plan initial architecture in session 1
- Come back to plan a specific feature in session 2
- Refine tech stack after initial prototyping in session 3

Each session should be time-boxed (25-30 min) to prevent over-planning.

### Q: What if I want to start coding immediately without planning?

**A:** That's totally valid! Skip this directory entirely and:
- Go to `02_project-onboarding/` to set up Claude Code for your project
- Start coding and ask Claude for help as you go
- Use project-planner later if you get stuck on architecture decisions

Some developers prefer "learn by doing" - that's fine!

---

## Related Resources

- **[Project Planner Agent Documentation](../../.claude/agents/docs/README.md#-project-planner)** - Full agent capabilities
- **[Example Project Plan](../../templates/project-plan-template.md)** - See complete output example
- **[CLAUDE.md Template](../../templates/CLAUDE.md.template)** - Template you'll customize after planning
- **[Project Onboarding](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)** - What to do AFTER planning

---

## Quick Start Command

```bash
# Start planning your new project
@project-planner I want to build [describe your project idea]
```

**Remember:**
- Be specific about your idea and constraints
- Answer questions honestly about your skill level
- Time-box to 30 minutes maximum
- Start coding after you have enough clarity (don't over-plan!)

---

**Last Updated:** December 5, 2025
**Template Version:** 2.3.0
**Recommended Time Investment:** 25-30 minutes per project

---

## 🚫 Common Planning Mistakes (Anti-Patterns)

### ❌ Anti-Pattern #1: Analysis Paralysis (Over-Planning)

**Problem:** Spending hours/days planning without writing code

**Example:**
```
Hour 1: Debating React vs Vue vs Svelte
Hour 2: Comparing 5 hosting providers
Hour 3: Designing complete database schema
Hour 4: Planning API versioning strategy
Hour 5: Still haven't written a single line of code!
```

**✅ Correct Approach:**
```
Minute 0-25: Quick planning session with @project-planner
  - Get tech stack recommendation
  - Identify first 2-3 features
  - Understand migration paths

Minute 30: Start coding MVP
  - Build simplest version that works
  - Refine as you learn
  - Make decisions when you need to, not before
```

**Pattern:** Time-box planning to 30 minutes max. Start coding with "good enough" decisions. Iterate based on real problems, not hypothetical ones.

---

### ❌ Anti-Pattern #2: Resume-Driven Development

**Problem:** Choosing tech stack to learn new skills, not to solve problem

**Example:**
```
Project: Simple blog with 100 visitors/month

Bad decision: "I'll use Kubernetes + microservices + GraphQL +
Redis + Kafka + gRPC because I want to learn them!"

Result:
- 6 months to build simple blog
- Over-engineered for actual needs
- Maintenance nightmare
- Never finishes project
```

**✅ Correct Approach:**
```
Project: Simple blog with 100 visitors/month

Good decision: "I'll use Next.js + Vercel because:
- I already know JavaScript
- Deploys in 5 minutes
- Free hosting
- Can finish in 1 week"

Result:
- MVP in 1 week
- Learn by shipping, not by over-engineering
- Can always refactor later if needed
```

**Pattern:** Choose familiar tech for MVP. Learn new skills in side projects or on-the-job, not in critical path of your main project.

---

### ❌ Anti-Pattern #3: Planning Without Constraints

**Problem:** Not specifying budget, timeline, or skill level

**Example:**
```
You: "I want to build a social network"
Agent: "What's your timeline?"
You: "No specific deadline"
Agent: "What's your budget?"
You: "Unlimited"
Agent: "What's your skill level?"
You: "I can learn anything"

Result: Agent can't give actionable recommendations
```

**✅ Correct Approach:**
```
You: "I want to build a social network for 1,000 users.
     I'm intermediate with Python and React.
     I have $50/month for hosting.
     I want MVP in 8 weeks working 10 hours/week."

Agent: "Great! Here's what's realistic with those constraints..."

Result: Specific, actionable plan based on YOUR reality
```

**Pattern:** Always specify: timeline, budget, skill level, scale. Constraints breed creativity and focus.

---

### ❌ Anti-Pattern #4: Ignoring Migration Paths

**Problem:** Choosing tech with no upgrade path when needs grow

**Example:**
```
Project: MVP for 50 users
Decision: "I'll use Firebase (no-code backend)"

6 months later: 5,000 users, need custom logic
Problem: Firebase Functions too expensive ($500/month)
Problem: Locked into Firebase ecosystem
Problem: Can't migrate data easily

Result: Complete rewrite required
```

**✅ Correct Approach:**
```
Project: MVP for 50 users
Decision: "I'll use Supabase (PostgreSQL + REST API)"

Agent explains migration path:
- Start: Supabase free tier (1GB database)
- Grow: Supabase pro ($25/month, 8GB database)
- Scale: Self-host PostgreSQL + custom API ($100/month, unlimited)

Result: Smooth migration path as needs grow
```

**Pattern:** Always ask "What happens when I outgrow this?" Choose tech with clear upgrade/migration paths.

---

### ❌ Anti-Pattern #5: Skipping MVP Feature Priority

**Problem:** Treating all features as equally important

**Example:**
```
Feature list (all "high priority"):
- User authentication
- Payment processing
- Real-time chat
- Email notifications
- Admin dashboard
- Analytics
- Mobile app
- API documentation

Result: Work on all features at once, finish none
```

**✅ Correct Approach:**
```
MVP Feature Priority (ask @project-planner):

Week 1: Authentication only
  - Can't do anything without users

Week 2: Core feature (the thing that makes your app unique)
  - This is why users will come

Week 3: Payment processing
  - Can't run business without revenue

Later: Chat, notifications, admin, analytics
  - Nice to have, not critical for MVP

Result: Shipping features in priority order, validating early
```

**Pattern:** Ruthlessly prioritize. Build ONE feature at a time. Ship minimum viable version, then iterate.

---

## ✅ You've Completed: Pre-Project Planning Guide

**What you accomplished:**
- Understand when to use @project-planner (new projects with no code yet)
- Know the 4-phase conversation flow (discover → constrain → recommend → output)
- Learn what makes a good planning session (25-30 min, time-boxed, specific constraints)
- See example planning session (SaaS task tracker)
- Know 5 critical anti-patterns to avoid (analysis paralysis, resume-driven dev, no constraints, no migration paths, no MVP priority)
- Understand "good enough" planning (start coding once you have clarity)

**Planning readiness checklist:**
- ✅ Project idea defined (what problem does it solve?)
- ✅ Constraints specified (timeline, budget, skill level, scale)
- ✅ Ready for 25-30 minute planning session
- ✅ Understand you can change decisions later
- ✅ Time-boxed commitment (no analysis paralysis)

**Next logical step:**

**Option A: Start Your Planning Session (30 min) - Recommended**
→ Open Claude Code and invoke @project-planner
```bash
claude

# Then type:
@project-planner I want to build [your project idea].
I'm [your skill level] with [languages/frameworks].
I have [budget] for hosting and [timeline] to build MVP.
I expect [number of users] initially.
```

**Option B: See Example Planning Output (5 min)**
→ [Project Plan Template](../../templates/project-plan-template.md)
- See complete agent output example
- Understand what recommendations look like
- Review before starting your session

**Option C: Learn Project Onboarding First (30 min)**
→ [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)
- If you want to understand AFTER-planning steps first
- See complete project setup workflow
- Then come back to plan

**Option D: Skip Planning, Start Coding**
→ If you prefer learning by doing
- Go to [Project Onboarding](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)
- Set up Claude Code for your project
- Ask Claude for help as you code
- Use @project-planner later if stuck on architecture

---

**Estimated next step time:** 25-30 minutes for planning session
**Planning output:** CLAUDE.md draft, tech stack recommendations, MVP feature priority, migration paths
**After planning:** Project onboarding → Start coding first feature
**Having trouble?** Check the Common Questions section above or ask: "Help me plan my project idea"

**Last Updated:** 2025-12-16
**Template Version:** 2.3.0
**Recommended Time Investment:** 25-30 minutes per project
