# Coding Principles Handbook

**Quick Reference:** Alphabetical lookup of all principles with examples from this project

**Purpose:** This handbook consolidates coding principles scattered across 9 documentation files into a single discoverable reference. Use Cmd+F to search for specific principles.

---

## 📖 Table of Contents

- [Foundational Principles](#foundational-principles) - SOLID, DRY, KISS, YAGNI
- [Context-Specific Principles](#context-specific-principles) - Vibe Coding, AI-Assisted, Quality
- [Progressive Learning Path](#progressive-learning-path) - Beginner → Advanced
- [Quick Lookup Table](#quick-lookup-table) - Fast reference
- [Cross-References](#cross-references) - Deep dives

---

## Foundational Principles

### SOLID Principles

#### S - Single Responsibility Principle
**"A class/module should have one, and only one, reason to change."**

**Example from this project:**
- Each skill has ONE clear purpose
  - `component-finder` → Find UI components only
  - `api-debugging` → Debug API requests only
  - NOT: `frontend-helper` (combines unrelated operations)

**Counter-example avoided:**
- Could have combined component-finder + api-debugging into single "developer-tools" skill
- Rejected: Violates SRP, harder to maintain, unclear responsibility

**See:** `.claude/skills/*/SKILL.md` for examples of focused responsibility

**Application:**
When creating new agent/skill/command, ask: "What is its ONE job?"

---

#### O - Open/Closed Principle
**"Software entities should be open for extension, but closed for modification."**

**Example from this project:**
- Standards enforcer learns team preferences without changing core logic
- Confidence thresholds adapt (85% → 90%) through learning, not code changes
- New standards added via configuration, not code modification

**How it works:**
```
Base logic: Check code against standard → Calculate confidence
Extension: Adjust confidence based on team acceptance history
No modification: Core checking algorithm unchanged
```

**See:** `.claude/skills/standards-enforcer/SKILL.md`

**Application:**
Design systems to adapt through configuration/learning, not code rewrites

---

#### L - Liskov Substitution Principle
**"Objects of a superclass should be replaceable with objects of subclasses without breaking the application."**

**Example from this project:**
- All agents implement same interface → can be swapped
- Any agent invoked via `@agent-name` pattern
- `@prompt-polisher` and `@project-planner` both work the same way from user perspective

**Interface contract:**
```
All agents must:
1. Accept task prompt
2. Return structured response
3. Support same tool permissions
```

**See:** `.claude/agents/` directory for agent implementations

**Application:**
When creating agents, ensure they're interchangeable for their category

---

#### I - Interface Segregation Principle
**"A client should not be forced to depend on methods it does not use."**

**Example from this project:**
- Agents have minimal required operations (no "god interface")
- Skills define only operations they actually provide
- component-finder: 5 operations (not 20 generic operations)

**Counter-example avoided:**
- Could have created massive "Developer Skill Interface" with 50 methods
- Each skill implements only 3-10 methods
- Rejected: Most skills would have 40 unused stubs

**Application:**
Define minimal interfaces - only what's truly needed

---

#### D - Dependency Inversion Principle
**"Depend upon abstractions, not concretions."**

**Example from this project:**
- Agents depend on `CLAUDE.md` abstraction, not concrete project details
- Project memory is interface, specific projects provide implementations
- template/CLAUDE.md.template defines the contract

**How it works:**
```
High-level: Agent needs project context
Abstraction: Read CLAUDE.md file
Low-level: Specific project's CLAUDE.md provides concrete details
```

**See:** `templates/CLAUDE.md.template` for abstraction definition

**Application:**
Depend on interfaces (CLAUDE.md schema) not implementations (specific project details)

---

### Classic Principles

#### DRY - Don't Repeat Yourself
**"Every piece of knowledge must have a single, unambiguous, authoritative representation within a system."**

**Example from this project:**
- Version sync script updates 4 files from single source (`version.json`)
- Single source of truth prevents drift
- `scripts/sync-version.sh` reads version.json → updates README, CLAUDE.md, SETUP_CONTEXT.md

**Counter-example fixed:**
- v4.10.1 removed duplicate JSON catalog
- Skills catalog existed in 2 places (JSON + markdown)
- Fixed: Single markdown file, removed JSON (YAGNI principle applied)

**See:** `scripts/sync-version.sh` for DRY implementation

**Application:**
Before duplicating logic/data, ask: "Can this have a single source of truth?"

---

#### KISS - Keep It Simple, Stupid
**"Simplicity should be a key goal in design, and unnecessary complexity should be avoided."**

**Example from this project:**
- Skills catalog = single markdown file (rejected complex JSON generator)
- Simplest solution that works
- Could have built: JSON → Generator script → Auto-updating system
- Chose: Manual markdown editing (simpler, no maintenance burden)

**See:** v4.10.1 CHANGELOG for rationale

**Decision framework:**
1. Will complexity pay off? (No - catalog rarely changes)
2. Is simple solution sufficient? (Yes - markdown works great)
3. Conclusion: Choose KISS

**Application:**
Start simple. Add complexity only when pain is felt, not anticipated.

---

#### YAGNI - You Aren't Gonna Need It
**"Don't implement something until it is necessary."**

**Example from this project:**
- Removed unused `skills-catalog.json` (v4.10.1)
- Built generator script anticipating frequent catalog changes
- Reality: Catalog stable, generator unused for 6 months
- Fixed: Deleted generator + JSON, kept simple markdown

**See:** Git commit `05715be` for YAGNI application

**Warning signs you're violating YAGNI:**
- "We might need this someday..."
- "This will be useful when..."
- "Just in case..."

**Application:**
Build for today's needs. Tomorrow's needs might never come, or be different than imagined.

---

#### Separation of Concerns (SoC)
**"Different concerns should be handled by different parts of the system."**

**Example from this project:**
- 4-layer architecture separates concerns clearly:
  - Layer 1: Context (CLAUDE.md) - Project knowledge
  - Layer 2: Commands (/test, /build) - Quick operations
  - Layer 3: Skills (testing-workflow) - Domain automation
  - Layer 4: Agents (@coder, @planner) - Complex tasks

**Why it matters:**
- Change commands without affecting agents
- Update context without touching skills
- Each layer has clear responsibility

**See:** `docs/01-fundamentals/03_workflow-integration.md`

**Application:**
When designing systems, ask: "What concerns exist?" then "How can I separate them?"

---

## Context-Specific Principles (This Project)

### Vibe Coding vs Vibe Engineering
**"Choose approach based on context, not personality."**

**When to use Vibe Coding (Speed):**
- Discovery phase (exploring ideas)
- MVPs and prototypes
- Hackathons and experiments
- Throwaway code
- Solo learning projects

**When to use Vibe Engineering (Structure):**
- Production systems
- Business-critical features
- Team projects
- Long-lived codebases
- Complex integrations

**Decision framework (6 dimensions):**
1. **Phase:** Discovery vs Maintenance
2. **Requirements Clarity:** Vague vs Clear
3. **Longevity:** Days vs Years
4. **Risk Level:** Low vs High
5. **Team Size:** Solo vs Team
6. **Timeline:** Hours vs Months

**Example from this project:**
- Early documentation (v1.0): Vibe Coding → fast iteration, learning what works
- Current state (v4.11.0): Vibe Engineering → tested patterns, comprehensive guides

**See:** `docs/01-fundamentals/01_vibe-coding-vs-engineering.md` for complete framework

**Application:**
Don't default to one mode. Consciously choose based on 6 dimensions.

---

### AI-Assisted Coding Principles

#### 1. Trust, but Verify
**"Use Ctrl+O for complex features to see what's actually happening."**

**Why it matters:**
- AI can generate "fake actions" (hardcoded responses that look real)
- Multi-file changes need verification
- Complex logic should be inspected

**When to use Ctrl+O:**
- Changes affecting >2 files
- Database operations
- Authentication/security code
- Complex state management
- API integrations

**Red flags to watch for:**
- Hardcoded console logs instead of actual API calls
- Fake loading states
- Mock data presented as real operations

**See:** `docs/00-start-here/05_anti-patterns.md` for red flag examples

---

#### 2. Detect Fake Actions
**"Watch for hardcoded responses pretending to be real operations."**

**Common fake actions:**
- `console.log("User authenticated")` instead of actual auth
- Hardcoded arrays instead of database queries
- Fake loading spinners (setTimeout with no actual async work)
- Mock API responses that never hit the network

**How to detect:**
1. Check Ctrl+O for tool calls
2. Look for network requests in browser DevTools
3. Verify database changes actually happened
4. Test error cases (do they work?)

**Real-world example:**
- Anti-patterns guide documents 80-day project failure
- 12,000-line file with 10,000 lines of fake operations
- User didn't verify, assumed it worked
- Cost: 2.5 months wasted

**See:** `docs/00-start-here/05_anti-patterns.md` for full story

---

#### 3. Atomic Features
**"One feature at a time, not massive prompts trying to build everything."**

**Anti-pattern:**
"Build a full e-commerce site with user auth, product catalog, shopping cart, checkout, payment processing, inventory management, and admin dashboard."

**Better approach:**
1. "Implement user registration with email/password"
2. "Add product catalog with search"
3. "Implement shopping cart"
4. (etc., one at a time)

**Why atomic wins:**
- Easier to verify each piece works
- Catch issues early
- Can change direction without wasting work
- Build on solid foundation

**Application:**
Break large requests into 3-5 smaller features. Ship incrementally.

---

### Quality-First Architecture
**"Quality gates enable productivity, not inhibit it."**

**Core insight:**
- AI code generates fast but needs quality checks
- Without quality gates: 97% more PRs, 90% more review time, 3x security incidents
- With quality gates: 47% review productivity gain, 66% fewer security incidents

**The productivity glass ceiling:**
- Speed without quality → unsustainable (rework costs exceed gains)
- Speed with quality → sustainable (glass ceiling broken)

**Quality gates in this project:**
1. Security scanner (OWASP top 10, CVE checks)
2. Test generator (ensures coverage)
3. Standards enforcer (learns team preferences)
4. Performance analyzer (catch issues early)

**See:** `docs/00-start-here/11_quality-workflows.md` for complete framework

**Application:**
Invest in quality automation early. It pays back 10x in saved rework.

---

### Algorithmic Efficiency
**"Think Big O notation upfront, not after performance problems appear."**

**10-point checklist:**
1. **Input size awareness** - Will this handle 1M records?
2. **Time complexity bounds** - O(n) or better preferred
3. **Nested loops** - Avoid O(n²), use hash maps for O(n)
4. **Data structure choice** - Array vs Set vs Map matters
5. **Algorithm optimization** - Binary search vs linear search
6. **Space-time tradeoffs** - Cache results vs recompute
7. **Lazy evaluation** - Don't compute until needed
8. **Memoization** - Cache expensive calculations
9. **Profiling** - Measure before optimizing
10. **Edge cases** - Test with 0, 1, and max inputs

**Example patterns:**
```
❌ BAD: for (item in list1) for (item2 in list2)  // O(n²)
✅ GOOD: const set = new Set(list1); list2.filter(x => set.has(x))  // O(n)
```

**See:** `templates/coding-standards.md.template` for detailed checklist

**Application:**
During code review, ask: "What's the time complexity? Can we do better?"

---

### Security Principles (Universal)

**6 Universal Defense Principles (All Package Managers):**

1. **Verify before install**
   - Check package source and maintainer
   - Review download counts and update frequency
   - Check for typosquatting (axios vs axois)

2. **Block automatic scripts**
   - npm: `.npmrc` with `ignore-scripts=true`
   - Python: Prefer wheels over source distributions
   - Never run `npm install` without reviewing packages first

3. **Lock dependencies**
   - npm: `package-lock.json` committed
   - Python: `requirements.txt` with pinned versions
   - Go: `go.sum` committed

4. **Regular audits**
   - npm: `npm audit` weekly
   - Python: `pip-audit` weekly
   - Set up automated checks

5. **Minimal dependencies**
   - Every dependency = attack surface
   - Prefer standard library
   - Question: "Do we really need this?"

6. **Source code inspection**
   - Read code before importing
   - Check for obfuscation
   - Look for network calls in unexpected places

**Threat vectors:**
- Typosquatting (react-native vs react-ntive)
- Dependency confusion (internal name conflicts with public packages)
- Malicious install scripts (post-install hooks)
- Compromised maintainer accounts
- Backdoored dependencies

**See:** `01_global-setup/03_nice-to-have/03_package-security-principles.md`

**Application:**
Treat dependencies as untrusted code. Verify everything.

---

### Verification Principles
**"Ctrl+O is mandatory for multi-file changes."**

**When verification is critical:**
- Changes affecting >2 files
- Database schema modifications
- Authentication/authorization code
- Payment processing
- Data migrations
- Security-sensitive operations

**Systematic verification workflow:**
1. Before: Review what will change (git diff)
2. During: Watch Ctrl+O for tool calls
3. After: Test actual behavior (not just logs)

**Red flags in Ctrl+O:**
- No file write tools called (but code claims to write files)
- Only Read tools (but changes expected)
- Hardcoded responses instead of real operations

**See:** `docs/01-fundamentals/05_verification-debugging.md`

**Application:**
For every complex change, open Ctrl+O. Watch what actually happens.

---

### Agent Design Principles
**"Tasks, not roles."**

**Anti-pattern:**
- `@frontend-developer` (too broad, unclear scope)
- `@backend-engineer` (what does it actually do?)
- `@devops-specialist` (vague responsibilities)

**Better approach:**
- `@react-component-optimizer` (specific task)
- `@api-endpoint-generator` (clear scope)
- `@docker-compose-builder` (focused responsibility)

**Why it matters:**
- Clear expectations (agent knows what to do)
- Easy to compose (combine task-specific agents)
- Testable (verify agent does its ONE job well)

**Agent architecture:**
- Own context window (isolated knowledge)
- System prompt (defines behavior)
- Tool permissions (limited access)
- Model selection (Haiku for orchestration, Opus for architecture, Sonnet for implementation)

**See:** `docs/03-advanced/02_subagent-best-practices.md`

**Application:**
When designing agents, ask: "What specific TASK does this solve?" not "What ROLE does it play?"

---

## Progressive Learning Path

### Beginner Level (Start here)

**Essential reading (1-2 hours):**
1. **Anti-Patterns** (`docs/00-start-here/05_anti-patterns.md`)
   - What NOT to do (prevents 80-day disasters)
   - Real-world failure examples
   - Red flags to watch for

2. **KISS and YAGNI** (this handbook)
   - Simplicity principles
   - When to add complexity (rarely)
   - Examples from this project

3. **Vibe Coding vs Engineering** (`docs/01-fundamentals/01_vibe-coding-vs-engineering.md`)
   - When to use speed vs structure
   - 6-dimension decision framework
   - Context-appropriate methodology

**Practical exercises:**
- Review your last project: Which principles were violated?
- Identify one "future-proofing" feature that was never used (YAGNI)
- Find one complex solution that could be simplified (KISS)

---

### Intermediate Level

**Deep dives (2-3 hours):**
1. **SOLID principles** (this handbook)
   - Study examples from this project
   - Apply to your current codebase
   - Identify violations and refactor

2. **Quality-First Architecture** (`docs/00-start-here/11_quality-workflows.md`)
   - Why quality gates enable speed
   - Implementing automated checks
   - Measuring impact

3. **Verification Principles** (`docs/01-fundamentals/05_verification-debugging.md`)
   - Ctrl+O workflow
   - Detecting fake actions
   - Systematic verification

**Practical exercises:**
- Add quality gate to your project (linting, tests, or security scanner)
- Use Ctrl+O on next AI-generated feature
- Refactor one class to follow Single Responsibility

---

### Advanced Level

**Mastery topics (3-5 hours):**
1. **Security Principles** (`01_global-setup/03_nice-to-have/03_package-security-principles.md`)
   - Supply chain security
   - Package manager hardening
   - Threat modeling

2. **Agent Design** (`docs/03-advanced/02_subagent-best-practices.md`)
   - Task-based architecture
   - Agent composition
   - Model selection strategy

3. **Algorithmic Efficiency** (`templates/coding-standards.md.template`)
   - Big O optimization
   - Data structure selection
   - Profiling and measurement

**Practical exercises:**
- Audit your dependencies (npm audit or pip-audit)
- Design task-specific agent for your workflow
- Optimize one O(n²) algorithm to O(n)

---

## Quick Lookup Table

| Principle | Key Question | When to Apply | See |
|-----------|--------------|---------------|-----|
| **SOLID** | Is my code modular and extensible? | Designing classes/modules | Skills architecture |
| **DRY** | Am I repeating logic/data? | Before duplicating code | sync-version.sh |
| **KISS** | Is this the simplest solution? | Before adding complexity | v4.10.1 decision |
| **YAGNI** | Do I actually need this now? | Before building "future" features | Removed JSON catalog |
| **SoC** | Are concerns properly separated? | Designing system architecture | 4-layer architecture |
| **Vibe Coding** | Should I prioritize speed or structure? | Starting any project | 6-dimension framework |
| **Trust but Verify** | Did I check Ctrl+O? | AI-generated complex features | Anti-patterns guide |
| **Quality-First** | Will quality gates help long-term? | Setting up projects | Quality workflows |
| **Big O** | What's the time complexity? | Writing algorithms | Coding standards |
| **Security** | Is supply chain secure? | Adding dependencies | Package security |
| **Atomic Features** | Am I trying to build too much at once? | Planning AI prompts | Anti-patterns guide |
| **Agent Design** | Is this a task or a role? | Creating custom agents | Agent best practices |

---

## Principles by Category

### Code Organization
- Single Responsibility Principle (SOLID)
- Separation of Concerns
- Interface Segregation Principle (SOLID)

### Code Quality
- DRY (Don't Repeat Yourself)
- KISS (Keep It Simple)
- YAGNI (You Aren't Gonna Need It)

### Extensibility
- Open/Closed Principle (SOLID)
- Dependency Inversion Principle (SOLID)
- Liskov Substitution Principle (SOLID)

### Methodology
- Vibe Coding vs Engineering (context-appropriate)
- Quality-First Architecture

### AI-Assisted Coding
- Trust but Verify (Ctrl+O workflow)
- Detect Fake Actions
- Atomic Features

### Performance
- Algorithmic Efficiency (Big O thinking)
- Profiling before optimizing

### Security
- 6 Universal Defense Principles
- Supply chain security
- Minimal dependencies

### System Design
- Agent Design (tasks, not roles)
- 4-layer architecture
- Model selection strategy

---

## Cross-References

**For detailed examples and context:**

| Topic | File | What You'll Learn |
|-------|------|-------------------|
| **Methodology** | `docs/01-fundamentals/01_vibe-coding-vs-engineering.md` | When to use speed vs structure (900 lines) |
| **Anti-Patterns** | `docs/00-start-here/05_anti-patterns.md` | What NOT to do (80-day failure case study) |
| **Quality** | `docs/00-start-here/11_quality-workflows.md` | Quality gates that enable productivity |
| **Standards** | `templates/coding-standards.md.template` | Algorithmic efficiency checklist (10 points) |
| **Security** | `01_global-setup/03_nice-to-have/03_package-security-principles.md` | Universal supply chain defense (6 principles) |
| **Verification** | `docs/01-fundamentals/05_verification-debugging.md` | Ctrl+O workflow, fake action detection |
| **Agents** | `docs/03-advanced/02_subagent-best-practices.md` | Task-based agent design patterns |
| **Development** | `CLAUDE.md` | Code style & conventions section |
| **Workflow** | `docs/01-fundamentals/03_workflow-integration.md` | 4-layer architecture explained |

---

## Using This Handbook

### Quick Search (Cmd+F)

**Search by principle name:**
- "SOLID" → Foundational principles section
- "YAGNI" → Classic principles section
- "Vibe Coding" → Context-specific principles

**Search by problem:**
- "repeated code" → DRY principle
- "too complex" → KISS principle
- "fake actions" → AI-Assisted coding principles
- "slow algorithm" → Algorithmic efficiency
- "security" → Security principles

**Search by file type:**
- "agent" → Agent Design Principles
- "dependency" → Security Principles
- "testing" → Quality-First Architecture

### Learning Journey

**New to coding principles?**
1. Start with [Beginner Level](#beginner-level-start-here)
2. Read Anti-Patterns guide first (prevents disasters)
3. Focus on KISS and YAGNI (high ROI, easy to apply)

**Experienced developer?**
1. Jump to [Intermediate Level](#intermediate-level)
2. Deep dive into SOLID principles
3. Study Quality-First Architecture

**Team lead?**
1. Review [Advanced Level](#advanced-level)
2. Focus on Security Principles (protect your supply chain)
3. Design team-specific agents (automate workflows)

---

## Maintenance

**This handbook is consolidated from:**
1. `coding-standards.md.template` - Algorithmic efficiency
2. `docs/01-fundamentals/01_vibe-coding-vs-engineering.md` - Methodology
3. `docs/00-start-here/05_anti-patterns.md` - AI-assisted patterns
4. `docs/00-start-here/11_quality-workflows.md` - Quality architecture
5. `.claude/skills/standards-enforcer/SKILL.md` - Dynamic standards
6. `01_global-setup/03_nice-to-have/03_package-security-principles.md` - Security
7. `docs/01-fundamentals/05_verification-debugging.md` - Verification
8. `docs/03-advanced/02_subagent-best-practices.md` - Agent design
9. `CLAUDE.md` - Development conventions

**When source files update:**
- This handbook should be updated to reflect changes
- Cross-references should remain accurate
- Examples should match current project state

**Feedback system:**
- v4.11.0 adds Guide Evolution Framework
- User feedback will inform future revisions
- Report issues via GitHub issue template

---

**Version:** v4.11.0
**Last Updated:** 2025-12-17
**Maintained by:** Project author
**Source files:** 9 documentation files consolidated

---

**Next:** [Workflow Integration](03_workflow-integration.md) | [Anti-Patterns](../00-start-here/05_anti-patterns.md) | [Quick Reference](../00-start-here/09_quick-reference.md)
