# Vibe Coding vs. Vibe Engineering: The Mode Selection Framework

**Last Updated:** 2025-12-16
**Version:** v4.9.0
**Reading Time:** 15 minutes

---

## TL;DR

**The Core Question:** When should I optimize for speed (Vibe Coding) vs. quality (Vibe Engineering)?

**The Answer:** Context determines approach. Use the 6-dimension analysis framework (@mode-selector agent) to choose the right mode for your specific situation.

**Quick Decision:**
- Building a prototype to validate an idea? → **Vibe Coding**
- Building production features for 10k+ users? → **Vibe Engineering**
- Unsure? → Use `@mode-selector` for objective recommendation

---

## The Problem This Framework Solves

### The Developer's Dilemma

Every developer faces this recurring tension:

**Option A: Move Fast (Vibe Coding)**
- ✅ Validate ideas quickly
- ✅ High iteration velocity
- ❌ Accumulates technical debt
- ❌ Breaks frequently in production

**Option B: Move Carefully (Vibe Engineering)**
- ✅ Production-quality code
- ✅ Sustainable long-term velocity
- ❌ Slow to validate ideas
- ❌ Over-engineering risk

**The trap:** Most developers default to their personality type (always fast OR always slow) instead of adapting to context.

**The cost (Author's observation from industry experience):**
- **Many MVPs are over-engineered** - weeks wasted on throwaway code with unnecessary complexity
- **Many production systems are under-engineered** - technical debt explosion from "move fast" mindset
- **Result:** "Should I design first or just code?" becomes a source of anxiety

_Note: These patterns are based on author's observation of industry practices, not formal research. The exact prevalence varies by team and context._

### The Solution: Context-Appropriate Mode Selection

**This framework teaches:**
- **WHEN** to optimize for speed vs. quality (6-dimension analysis)
- **HOW** to transition between modes (refactoring checklist)
- **WHY** each mode exists (philosophy and trade-offs)

**The outcome:** Remove decision anxiety, ship the right quality code at the right time.

---

## The Two Modes Explained

### Vibe Coding: Speed and Intuition

**Philosophy:**
> "Move fast and learn things. Code is temporary."

**When to use:**
- Discovery/exploration (uncertain requirements)
- MVP/prototype (validating an idea)
- Hackathons/demos (time-boxed showcases)
- Internal tools (low risk, small audience)

**Characteristics:**
- **Time distribution:** 90% coding, 10% debugging
- **Planning:** Minimal upfront, iterate rapidly
- **Testing:** Manual testing, fix bugs as found
- **Code quality:** Good enough to validate idea
- **Prompting style:** "Build X fast, refine later"
- **Agent workflow:** @coder (direct implementation)

**Mindset:**
- Embrace throwaway code (will rewrite if validated)
- Intuition-driven decisions (fast choices)
- Speed of iteration > perfection of implementation
- Failure is cheap and informative

**Example prompts:**
```
"Build a user login form with email and password"
"Create a quick API endpoint to fetch user data"
"Implement search - just a simple keyword match"
```

---

### Vibe Engineering: Structure and Quality

**Philosophy:**
> "Measure twice, cut once. Code is permanent."

**When to use:**
- Production systems (serving real users)
- Business-critical features (revenue, security, compliance)
- Long-term infrastructure (1+ years expected lifespan)
- Large teams (coordination requires standards)

**Characteristics:**
- **Time distribution:** 30% design/planning, 70% implementation/testing
- **Planning:** Comprehensive upfront analysis
- **Testing:** TDD, automated tests, comprehensive coverage
- **Code quality:** Production-ready, maintainable
- **Prompting style:** "Analyze requirements, design approach, implement with tests"
- **Agent workflow:** @prompt-polisher → @project-planner → @coder → @quality-reviewer

**Mindset:**
- Investment in permanent code (living with this long-term)
- Analysis-driven decisions (considered choices)
- Quality of implementation > speed of delivery
- Failure is expensive and avoidable

**Example prompts:**
```
"Analyze requirements for user authentication, design the architecture, then implement with comprehensive tests and error handling"

"Design a scalable API for user data with pagination, filtering, and proper HTTP semantics"

"Plan the search implementation considering performance, relevance scoring, and edge cases"
```

---

## Visual Comparison Table

| Aspect | Vibe Coding | Vibe Engineering |
|--------|-------------|------------------|
| **Primary Goal** | Learn by building | Build to spec |
| **Code Lifespan** | Temporary (throwaway) | Permanent (investment) |
| **Planning** | Minimal upfront | Comprehensive design |
| **Testing** | Manual, fix bugs as found | TDD, automated, comprehensive |
| **Time Split** | 90% coding, 10% debugging | 30% design, 70% implementation/testing |
| **Documentation** | Comments where critical | Comprehensive docs |
| **Refactoring** | Rare (throwaway mindset) | Continuous (investment mindset) |
| **Decision Making** | Intuition-driven, fast | Analysis-driven, considered |
| **Acceptable Debt** | High (will rewrite) | Low (living with this) |
| **Risk Tolerance** | High (failure is cheap) | Low (failure is expensive) |
| **Team Size** | Solo or small (2-3) | Large (7+) or cross-functional |
| **User Impact** | Internal or demo | Customer-facing or critical |
| **Agent Workflow** | @coder (direct) | @prompt-polisher → @project-planner → @coder → @quality-reviewer |

---

## The 6-Dimension Decision Framework

Use these 6 dimensions to objectively determine which mode fits your context:

### 1. Project Phase
- **Discovery/Exploration** → Vibe Coding
- **MVP/Prototype** → Vibe Coding
- **Production** → Vibe Engineering
- **Refactoring** → Vibe Engineering

### 2. Requirements Clarity
- **Vague/uncertain** → Vibe Coding (build to learn)
- **Clear/specific** → Vibe Engineering (design to build)

### 3. Longevity
- **Throwaway** (< 1 month) → Vibe Coding
- **Long-term** (1+ years) → Vibe Engineering

### 4. Risk Level
- **Internal tool** → Vibe Coding acceptable
- **User-facing** → Vibe Engineering
- **Business-critical** (revenue, security, compliance) → Vibe Engineering mandatory

### 5. Team Size
- **Solo or small** (2-3 people) → Vibe Coding acceptable
- **Large team** (7+ people) → Vibe Engineering (coordination cost)

### 6. Timeline
- **Hours/days** → Vibe Coding
- **4+ weeks** → Vibe Engineering

**How to use:**
1. Score each dimension: -1 (Vibe Coding), 0 (Neutral), +1 (Vibe Engineering)
2. Sum total score: -6 to +6
3. Calculate confidence: |total_score| / 6.0
4. Determine recommendation based on score range

**Example:**
```
Project: Internal admin dashboard, 3-day timeline, solo dev
- Phase: New build (-1)
- Requirements: Clear CRUD (+1)
- Longevity: Uncertain (0)
- Risk: Internal (-1)
- Team: Solo (-1)
- Timeline: 3 days (-1)
Total: -3 → Strong Vibe Coding
```

For comprehensive analysis, use: `@mode-selector I'm about to [describe task]. What mode should I use?`

---

## Real-World Examples

### Example 1: Startup MVP (Vibe Coding)

**Scenario:** Solo founder building recipe-sharing app MVP for investor demo in 2 weeks.

**Why Vibe Coding:**
- Uncertain requirements (will users want this?)
- Temporary code (rewrite if validated)
- Low risk (demo only, no real users)
- Tight timeline (2 weeks)
- Solo work (no coordination overhead)

**Approach:**
- Use starter template (don't build from scratch)
- Hardcode recipes (no database for demo)
- Skip authentication (demo with pre-populated user)
- Focus on UI polish (investors judge by appearance)
- Manual testing only

**Outcome:** Demo ready in 2 weeks, idea validated, plan 6-week rewrite in Vibe Engineering mode.

---

### Example 2: SaaS Payment Feature (Vibe Engineering)

**Scenario:** Adding payment processing to SaaS product with 50,000 paying customers.

**Why Vibe Engineering:**
- Clear requirements (payment processing is well-defined)
- Permanent code (core revenue infrastructure)
- High risk (financial data, regulatory compliance)
- Large team (8 engineers, cross-functional)
- Flexible timeline (can invest in quality)

**Approach:**
- Week 1: Requirements + security architecture
- Week 2-3: Implementation with comprehensive tests
- Week 4: Security review + penetration testing
- Week 5: Integration testing + load testing
- Week 6: Staged rollout (1% → 10% → 50% → 100%)

**Outcome:** Production-quality payment system, zero user-facing incidents, sustainable long-term.

---

### Example 3: Hackathon (Vibe Coding)

**Scenario:** 48-hour hackathon, theme is "AI for education," working with designer.

**Why Vibe Coding:**
- Uncertain requirements (no idea yet)
- Throwaway code (demo only)
- Low risk (competition, no real users)
- Extreme timeline (48 hours)
- Small team (2 people)

**Approach:**
- Hours 0-4: Ideation, pick high-demo-appeal idea
- Hours 4-12: Rapid prototyping, get something on screen
- Hours 12-36: Add 3-5 "wow" features, fake anything slow
- Hours 36-44: Polish for demo, rehearse pitch
- Hours 44-48: Rest, prepare for judging

**Outcome:** Working demo in 48 hours, impressive presentation, potential prize win.

---

## Transition Points: When to Change Modes

### Signals to Transition from Vibe Coding → Vibe Engineering

Watch for these 7 signals:

1. **Success Signal: Prototype Validated**
   - Stakeholders say "let's build this for real"
   - **Action:** Plan 4-6 week refactoring sprint

2. **Adoption Signal: Users Growing**
   - Started as "just for me" → now 10+ people using it
   - **Action:** Add tests, improve error handling, write docs

3. **Longevity Signal: Code Living Longer**
   - Past 1 month, shows no signs of replacement
   - **Action:** Refactor incrementally, add architecture

4. **Stability Signal: Breaking Frequently**
   - Bugs accumulating faster than you can fix
   - **Action:** Stop new features, write tests, stabilize

5. **Collaboration Signal: Team Growing**
   - More than 3 people touching the code
   - **Action:** Document architecture, establish standards

6. **Risk Signal: Stakes Increasing**
   - Now customer-facing (was internal only)
   - **Action:** Security audit, add encryption, access controls

7. **Operational Signal: Manual → Automated**
   - Can't manually test anymore (too many cases)
   - **Action:** Build automated test suite, create CI/CD

### Refactoring Checklist (6-Week Transition)

**Phase 1: Stabilize** (Week 1)
- Fix all known bugs
- Add basic error handling
- Write tests for critical paths

**Phase 2: Security** (Week 2)
- Security audit (@quality-reviewer)
- Fix critical vulnerabilities
- Add authentication/authorization

**Phase 3: Architecture** (Week 3)
- Refactor monolithic code
- Remove duplication
- Add architecture documentation

**Phase 4: Quality** (Week 4)
- Expand test coverage (80%+)
- Add integration tests
- Code review

**Phase 5: Operations** (Week 5)
- Set up monitoring/alerting
- Create deployment automation
- Write runbooks

**Phase 6: Handoff** (Week 6)
- User documentation
- Developer documentation
- Team training

---

## Common Anti-Patterns (Mistakes to Avoid)

### ❌ Anti-Pattern #1: Vibe Coding in Production

**What it looks like:**
- Shipping prototypes to customers without refactoring
- "We'll add tests later" (never do)
- Accumulating technical debt with no paydown plan

**Why it fails:**
- Users experience bugs (churn)
- Security vulnerabilities (breaches)
- Team velocity decreases (firefighting)

**Recovery:** Stop features, refactor for 4-6 weeks, then resume with quality standards.

---

### ❌ Anti-Pattern #2: Vibe Engineering in Prototypes

**What it looks like:**
- Spending weeks architecting a 2-day hackathon project
- Writing comprehensive tests for throwaway POC
- Perfectionism when speed is the goal

**Why it fails:**
- Opportunity cost (could have validated 5 ideas in same time)
- Over-investment in code that will be discarded
- Missed deadlines (demo date passes while architecting)

**Recovery:** Cut scope ruthlessly, accept "good enough," ship and learn.

---

### ❌ Anti-Pattern #3: Never Transitioning

**What it looks like:**
- Prototype in production for 3+ years
- "We'll refactor later" becomes "never"
- Adding features to unstable foundation

**Why it fails:**
- Technical debt compounds (velocity decreases)
- Customer trust erodes (frequent bugs)
- Eventual costly rewrite required

**Recovery:** Acknowledge debt, stop features, strangler fig refactoring (6-8 weeks).

---

## When to Use @mode-selector Agent

**Invoke @mode-selector when:**
- Starting a new project or feature (before writing code)
- Transitioning from prototype to production
- Unsure if design/planning is needed
- Team disagrees on quality standards
- Debating whether to add tests/docs/architecture

**Don't invoke when:**
- Context is obvious (emergency hotfix, regulatory requirement)
- Already mid-project (changing modes is disruptive)
- Personal learning project (Vibe Coding by default)

**How to invoke:**
```
@mode-selector I'm about to build an internal tool to track team vacation days. Just our 10-person team will use it. Timeline is 1 week. What mode should I use?
```

**What you get:**
- Clear recommendation (Strong Vibe Coding / Lean Vibe Engineering / etc.)
- Confidence score (0.0-1.0)
- Detailed reasoning (why this mode fits context)
- Dimension analysis (how each of 6 dimensions scored)
- Next steps (specific guidance for the recommended mode)
- Transition guidance (when/how to change modes)

---

## The Meta-Lesson: Metacognition

**What this framework really teaches:**

**Level 1 (Beginner):** Follow rules
- "Prototypes use Vibe Coding, production uses Vibe Engineering"

**Level 2 (Intermediate):** Recognize patterns
- "This is temporary + low-risk + tight-timeline = Vibe Coding"

**Level 3 (Advanced):** Independent judgment
- *Analyzes context intuitively, chooses mode without agent*

**Level 4 (Expert):** Teach others
- *Helps team make context-appropriate decisions*

**Goal:** Eventually, you won't need @mode-selector. But until then, it's training wheels for building intuition.

**The highest-leverage skill in software development is choosing the right methodology for the context.**

---

## Additional Resources

**Related Documentation:**
- `.claude/agents/mode-selector.md` - Full agent specification with decision algorithm
- `.claude/skills/mode-selector/SKILL.md` - Auto-activation skill for proactive guidance
- `.claude/skills/mode-selector/examples/` - 5 detailed scenario examples
- `do../00-start-here/05_anti-patterns.md` - Common mistakes and how to avoid them
- `docs/02-optimization/01_model-selection-strategy.md` - Which Claude model for which mode

**Usage Examples:**
- Example 1: MVP prototype → Strong Vibe Coding
- Example 2: Production feature → Strong Vibe Engineering
- Example 3: Hackathon → Strong Vibe Coding
- Example 4: Refactoring legacy → Strong Vibe Engineering (incremental)
- Example 5: Transition point → Vibe Coding → Vibe Engineering

**Further Reading:**
- [Two-Agent Pattern (Anthropic)](https://www.youtube.com/watch?v=xNcEgqzlPqs) - Domain memory architecture
- [Vibe Coding to Vibe Engineering (Kitze)](https://www.youtube.com/watch?v=JV-wY5pxXLo) - Active steering vs passive acceptance
- [AI Code Quality Research (Qodo)](https://www.youtube.com/watch?v=rgjF5o2Qjsc) - Industry data on quality concerns

---

## Summary

**The Framework:**
- **Two modes:** Vibe Coding (speed) and Vibe Engineering (quality)
- **Six dimensions:** Phase, requirements, longevity, risk, team size, timeline
- **Decision algorithm:** Score dimensions, sum total, calculate confidence, recommend mode
- **Transition guidance:** 7 signals to watch, 6-week refactoring checklist

**The Philosophy:**
- Context determines approach (not personality)
- Both modes are valid (appropriate for different situations)
- Metacognition is the goal (eventually don't need agent)
- No guilt for choosing speed OR quality (permission to choose)

**The Tools:**
- `@mode-selector` agent for comprehensive analysis
- `mode-selector` skill for proactive guidance
- Transition checklist for prototype → production
- Anti-patterns guide to avoid common mistakes

**The Impact (Projected Goals):**
- Reduced decision anxiety (clear framework)
- Fewer over-engineered MVPs (goal: 40% → 10%)
- Fewer under-engineered production systems (goal: 35% → 5%)
- Sustainable velocity (right quality at right time)

**The Next Step:**

Try it now:
```
@mode-selector I'm about to [describe your next task]. What mode should I use?
```

---

**Version:** v4.9.0 (2025-12-16)
**Feedback:** This is a new framework. Help us validate these patterns! Share your mode selection experiences.
