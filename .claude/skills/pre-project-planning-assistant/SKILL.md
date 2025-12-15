---
name: pre-project-planning-assistant
description: Guides users through pre-project planning phase. Auto-activates when users ask about starting new projects, planning architecture, choosing tech stacks, or creating project plans. Provides structured guidance through concept → architecture → tech decisions → timeline phases.
allowed-tools: Read, Grep
---

# Pre-Project Planning Assistant Skill

**Purpose:** Guide users through structured pre-project planning to reduce rework, make informed architectural decisions, and set up projects for success from day one.

**For:** Developers planning new projects who need systematic guidance before writing code.

---

## When This Skill Auto-Activates

This skill automatically activates when you ask:
- "Help me plan a new project"
- "What should I consider before starting [project type]?"
- "Create a project plan for [idea]"
- "I'm starting a new [app/website/API/service]"
- "How do I plan a [type] project?"
- "What tech stack should I use for [requirements]?"
- "Help me architect [project description]"
- "Where do I begin with [project idea]?"

---

## What This Skill Does

### 1. Structured Planning Guidance

Guides you through **4 planning phases** systematically:

**Phase 1: Concept Clarification**
- What problem are you solving?
- Who are the target users?
- What are the core features vs nice-to-haves?
- What's the success criteria?

**Phase 2: Architecture Design**
- What's the high-level architecture? (monolith, microservices, serverless, etc.)
- What are the major components?
- How do components interact?
- What are the data flows?

**Phase 3: Tech Stack Selection**
- What constraints exist? (team skills, budget, timeline, hosting)
- What technologies fit the requirements?
- Why choose these over alternatives?
- What are the trade-offs?

**Phase 4: Timeline & Milestones**
- What's the MVP (minimum viable product)?
- What are the development phases?
- What are realistic timelines?
- What are the dependencies?

### 2. References Planning Documentation

Points you to the comprehensive planning guide:
- `03_pre-project-planning/must-have/01_planning-guide.md` (detailed methodology)
- `templates/project-plan-template.md` (structured template)

### 3. Coordinates with project-planner Agent

For **complex decisions** requiring deep multi-perspective analysis:
- Suggests when to use `@project-planner` agent
- Explains how agent provides 6-perspective coordinated analysis
- Helps you get maximum value from agent invocation

**Pattern:**
```
Skill (quick guidance) → Agent (deep analysis)

Simple projects: Skill handles everything
Complex projects: Skill guides → Agent analyzes → Skill synthesizes
```

### 4. Prevents Common Mistakes

Proactively warns about anti-patterns:
- **Premature optimization** - Don't architect for scale you don't need
- **Tech stack overload** - Don't use 10 technologies when 3 will do
- **Unclear requirements** - Don't start coding without user stories
- **No MVP defined** - Don't build everything at once
- **Ignoring constraints** - Don't ignore team skills, budget, timeline

---

## Example Interactions

### Example 1: Simple Web App

**User Query:**
> "Help me plan a task management web app"

**Confidence:** 🟢 High (0.90)
- Clear project type (web app, task management)
- Standard architectural patterns exist
- Well-understood problem domain

**Skill Response:**
```
I'll guide you through planning your task management web app.

Phase 1: Concept Clarification
Let me ask a few questions to understand your vision:

1. Who are your target users?
   - Personal use, teams, enterprises?
   - Technical background of users?

2. What are the 3 core features users must have?
   - Task creation/editing?
   - Collaboration features?
   - Notifications/reminders?

3. What's your success criteria?
   - Number of users?
   - User retention?
   - Revenue goals?

Once you answer these, I'll help with architecture and tech stack decisions.

Resources:
- Detailed planning guide: 03_pre-project-planning/must-have/01_planning-guide.md
- Project plan template: templates/project-plan-template.md
```

**Why This Matters:**
- Clarifying questions prevent building wrong product (most common failure mode)
- Target user identification drives all tech decisions (personal → simple, enterprise → complex)
- Core features vs nice-to-haves prevent scope creep and endless development
- **Quick win:** Answer 3 questions now, get concrete architecture recommendations in < 5 min

**Next Step:** After answering, I'll suggest tech stack based on your constraints

### Example 2: Complex System Requiring Agent

**User Query:**
> "I'm building a real-time multiplayer game with chat, matchmaking, and leaderboards"

**Confidence:** 🟡 Medium (0.65)
- High complexity project (multiple subsystems)
- Architectural decisions require trade-off analysis
- Agent invocation recommended for depth

**Skill Response:**
```
This is a complex project with several architectural decisions. I recommend
using the @project-planner agent for deep multi-perspective analysis.

Why use the agent for this project?
- Multiple technologies needed (WebSockets, game servers, databases)
- Performance critical (real-time requirements)
- Complex state synchronization
- Multiple architectural approaches possible

I can help you prepare questions for the agent:

1. What's your experience level with real-time systems?
2. What's your budget for hosting?
3. How many concurrent users do you expect?
4. What platforms? (web, mobile, desktop)

With this context, the @project-planner agent can provide:
- 🧠 Psychological: User engagement patterns for game retention
- 📚 Educator: Learning path for technologies you'll need
- 💻 Engineering: Architecture recommendations (peer-to-peer vs server-authoritative)
- 🎨 UX Designer: Matchmaking flow and chat UX patterns
- 🔒 Security: Cheat prevention and data validation strategies
- 💰 Business: Cost analysis for different hosting approaches

Should I prepare a detailed prompt for the @project-planner agent?
```

**Why This Matters:**
- Complex projects = high failure risk without proper planning (60-70% fail)
- Agent provides 6-perspective analysis → Catches blind spots you'd miss alone
- Preparing context questions maximizes agent value (focused analysis vs generic advice)
- **Quick win:** Answer 4 prep questions, then agent delivers comprehensive plan

**Next Step:** After agent analysis, I'll help synthesize recommendations into actionable plan

### Example 3: Tech Stack Decision

**User Query:**
> "What tech stack should I use for a REST API with authentication?"

**Confidence:** 🟢 High (0.82)
- Focused tech decision (REST API + auth)
- 3 common patterns with clear trade-offs
- Constraint-based recommendation possible

**Skill Response:**
```
Let me help you choose a tech stack by understanding your constraints:

Questions to narrow down options:
1. What's your current expertise? (Python, Node.js, Go, etc.)
2. What's your deployment target? (AWS, Vercel, self-hosted)
3. How many requests per second do you expect?
4. Do you have database preferences?

Common patterns for REST API + Auth:

Option 1: Node.js + Express + JWT + PostgreSQL
- ✅ Large ecosystem, good for teams familiar with JavaScript
- ✅ Fast development with npm packages
- ❌ Not ideal for CPU-intensive tasks
- Best for: Quick MVP, JavaScript teams

Option 2: Python + FastAPI + JWT + PostgreSQL
- ✅ Excellent for data-heavy APIs
- ✅ Strong typing with Pydantic
- ❌ Slower than Go for high concurrency
- Best for: Data processing, ML integration

Option 3: Go + Gin + JWT + PostgreSQL
- ✅ Excellent performance and concurrency
- ✅ Simple deployment (single binary)
- ❌ Smaller ecosystem than Node/Python
- Best for: High-performance, microservices

Based on your answers, I can recommend the best fit.

Deep dive: See 03_pre-project-planning/must-have/01_planning-guide.md
```

**Why This Matters:**
- Wrong tech stack = months of pain (migration is expensive)
- Constraint-based selection prevents "shiny technology syndrome"
- Trade-off transparency helps make informed choices (not hype-driven)
- **Quick win:** Answer 4 questions, get tailored recommendation in < 2 min

**Next Step:** After choosing stack, ask "What's the MVP for this API?"

---

## Integration with Planning Documentation

This skill **complements** (doesn't replace) comprehensive documentation:

**Use the Skill when:**
- Quick planning guidance needed
- Interactive Q&A style helpful
- Want to validate approach quickly
- Starting from scratch (no clear direction)

**Read planning-guide.md when:**
- Need comprehensive methodology
- Want to understand WHY behind recommendations
- Building complex systems
- Planning for team/enterprise projects

**Use project-plan-template.md when:**
- Ready to document your plan
- Need structured format for stakeholders
- Creating project specification document

**Use @project-planner agent when:**
- Complex architectural decisions
- Multiple valid approaches exist
- Need multi-perspective analysis
- High-stakes project (significant time/budget)

---

## Token Efficiency

**Without Skill (Manual Exploration):**
1. User asks: "How do I plan a new project?" (20 tokens)
2. Claude explores planning docs: Read files, search patterns (400 tokens)
3. Claude synthesizes guidance (300 tokens)
4. Follow-up questions repeat exploration (200 tokens each)
**Total: ~1,100 tokens per planning session**

**With Skill (Structured Knowledge):**
1. Skill auto-activates on question (50 tokens)
2. Provides structured guidance from expertise (250 tokens)
3. Follow-ups use skill context (100 tokens each)
**Total: ~400 tokens per planning session**

**Savings: 700 tokens per project (64% reduction)** ⚠️ **projected**

**Frequency:**
- New projects: Varies by user (1-10 per year)
- 5 projects/year: 3,500 tokens saved/year
- Teams planning together: Higher impact

---

## Common Planning Workflows

### Workflow 1: Solo Developer, Simple Project

```
You: "Plan a blog website"
Skill: Asks 3-4 clarifying questions
You: Answers questions
Skill: Recommends simple stack (Next.js + MDX or WordPress)
You: "How do I structure this?"
Skill: Points to project-plan-template.md
You: Fills out template, starts coding
```

**Time:** 15-20 minutes
**Outcome:** Clear plan, appropriate tech choices

### Workflow 2: Team Project, Medium Complexity

```
You: "Plan a SaaS application for team collaboration"
Skill: Asks about users, features, constraints
You: Provides context
Skill: "This needs deeper analysis - use @project-planner"
You: "@project-planner [detailed prompt from skill]"
Agent: Provides 6-perspective analysis (1,500+ tokens)
You: Reviews recommendations with team
Skill: "Need help documenting plan?"
You: "Yes"
Skill: Guides through project-plan-template.md
```

**Time:** 1-2 hours (with team discussion)
**Outcome:** Comprehensive plan, stakeholder buy-in

### Workflow 3: Validating Existing Idea

```
You: "I'm thinking MERN stack for e-commerce site with 10k users"
Skill: "Let me validate this against your requirements"
Skill: Asks about payment processing, inventory, performance needs
You: Provides details
Skill: "MERN works, but consider these trade-offs:
       - MongoDB: Good for product catalogs, but payment data needs ACID
       - Recommend: PostgreSQL for transactions, MongoDB for products
       - Add Redis for cart sessions (performance)
       See why: 03_pre-project-planning/must-have/01_planning-guide.md#tech-stack"
You: Adjusts plan based on feedback
```

**Time:** 10-15 minutes
**Outcome:** Validated plan, avoided pitfalls

---

## Best Practices

### DO Use This Skill For:
- ✅ Starting new projects from scratch
- ✅ Validating tech stack choices
- ✅ Quick architecture sanity checks
- ✅ Understanding planning methodology
- ✅ Learning what questions to ask

### DON'T Use This Skill For:
- ❌ Detailed implementation planning (use project-planner agent)
- ❌ Code generation (that's later, after planning)
- ❌ Debugging existing projects (use other skills)
- ❌ Marketing/business strategy (outside scope)

---

## When to Escalate to @project-planner Agent

**Use the agent when ANY of these apply:**

**Complexity Indicators:**
- 3+ major components with interactions
- Multiple technology choices with trade-offs
- Performance/scale requirements unclear
- Team has mixed skill levels
- Budget/timeline constraints tight

**Decision Quality Needs:**
- High stakes (significant time/money investment)
- Multiple stakeholders need alignment
- Architectural patterns unclear
- Need justification for technology choices
- Want to explore alternatives systematically

**Learning Goals:**
- Want deep understanding of trade-offs
- Building in unfamiliar domain
- Teaching opportunity for team
- Creating documentation for stakeholders

**Skill will suggest agent proactively when appropriate.**

---

## Integration with Other Skills

**Coordinates with:**

**global-setup-assistant** - After planning, guides machine setup
```
Plan project → Choose tech stack → Setup environment
```

**project-onboarding-assistant** - After planning, guides project setup
```
Plan project → Create CLAUDE.md → Configure .claude/
```

**workflow-analyzer** - After 10+ projects, suggests planning improvements
```
"I notice you always choose X stack - consider Y for Z use case"
```

**Natural progression:**
```
pre-project-planning-assistant (plan) →
global-setup-assistant (machine setup) →
project-onboarding-assistant (project setup) →
[build project] →
workflow-analyzer (improve process)
```

---

## Helpful Resources

**Within Template:**
- `03_pre-project-planning/must-have/01_planning-guide.md` - Comprehensive methodology
- `templates/project-plan-template.md` - Structured documentation template
- `.claude/agents/project-planner.md` - Deep multi-perspective analysis
- `docs/01-fundamentals/ANTI_PATTERNS.md` - Common planning mistakes

**External:**
- Architecture decision records (ADRs) - Document key decisions
- C4 model diagrams - Visualize architecture
- User story mapping - Define features from user perspective

---

## FAQ

**Q: Should I always fill out the project-plan-template.md?**

A: For solo projects, you can skip it if the plan is clear in your head. For team projects or future reference, documenting is valuable. The template takes 20-30 minutes but saves hours of alignment later.

**Q: How detailed should my plan be before coding?**

A: Enough to answer: (1) What problem am I solving? (2) Who's the user? (3) What's the MVP? (4) What tech am I using and why? Don't over-plan - you'll learn more by building.

**Q: What if my project changes after I start?**

A: Normal! Plans are guides, not contracts. Update your project plan when direction shifts significantly. The planning process teaches you what questions to ask, even if answers change.

**Q: Should I use the @project-planner agent for every project?**

A: No. Simple projects (CRUD apps, static sites, scripts) don't need deep analysis. Use the agent when complexity is high, stakes are significant, or you're uncertain about approach.

**Q: Can this skill help me learn new technologies?**

A: Yes! When choosing tech, I can suggest learning paths and resources. But for systematic learning guidance, the planning-guide.md has detailed methodology.

---

## Version History

- **v3.4.0** (2025-12-14): Initial release - Complete setup assistance coverage
  - Guides through 4 planning phases
  - Coordinates with @project-planner agent
  - Prevents common anti-patterns
  - Token savings: 64% per project (**projected**)

---

**Remember:** Good planning prevents rework. Spend 30 minutes planning to save 30 hours debugging poorly chosen architecture.
