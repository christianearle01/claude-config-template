# Advanced MCP Workflows

**Multi-tool orchestration and autonomous workflows**

---

## Sources & Validation

**Official Claude Code Documentation:**
- MCP Protocol: https://modelcontextprotocol.io ✅ VALIDATED
- Claude Code Documentation: https://docs.claude.com

**Community Insights:**
Analysis from NotebookLLM covering three YouTube sources:
- "Vibe Coding vs AI Augmented Coding": https://www.youtube.com/watch?v=hwEgheORjjs
- "800+ Hours of Claude Code Experience": https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- "Claude Code Agent Skills": https://www.youtube.com/watch?v=CEvIs9y1uog

**Note:** Insights are derived from cross-video analysis. Third-party MCPs (Supabase, Playwright) are community tools, not official Anthropic products.

---

## The Three-Layer Architecture

**Quote from power users:**
> *"Developers are using Skills that orchestrate workflows of multiple MCP tools stitched together"*

### The Pattern

```
Skill (expertise) + MCP (data/tools) + Sub-agent (orchestration)
= Autonomous Workflows
```

**Each layer:**
- **Skill:** Procedural knowledge (how to do something)
- **MCP:** External capabilities (database, browser, APIs)
- **Sub-agent:** Task orchestration (coordinates multiple tools)

**Result:** Claude can perform complex multi-step workflows autonomously

---

## MCP Servers for Advanced Workflows

### Official MCPs (Built-in)

**filesystem**
- Read/write files
- Navigate directory structure
- Search code

**github**
- Create PRs, issues
- Review code
- Manage repositories

**memory**
- Store knowledge graphs
- Build project context
- Retrieve past information

**sequential-thinking**
- Extended reasoning
- Complex problem-solving
- Multi-step planning

---

### Third-Party MCPs (Community)

**⚠️ THIRD-PARTY NOTICE:** These are community-built tools, not official Anthropic products.

**Supabase MCP**
- Database operations
- Schema migrations
- Table creation
- Direct SQL queries

**Playwright MCP**
- Browser automation
- UI testing
- DOM inspection
- Screenshot capture

**Context7 MCP**
- Latest library documentation
- Up-to-date API references
- Community-maintained

**Stripe MCP** (example)
- Payment integration
- Subscription management
- Webhook handling

---

## Example 1: Database Optimization Workflow

### The Setup

**Skill:** `database-optimization/`
```
.claude/skills/database-optimization/
├── SKILL.md              # Optimization expertise
├── query-patterns.md     # Common anti-patterns
└── scripts/
    └── analyze.sql       # Analysis queries
```

**MCP:** Supabase (database access)

**Workflow:**

```markdown
User: "Optimize the user queries in our database"

Claude:
1. Activates database-optimization Skill (automatic)
2. Reads query-patterns.md (knows what to look for)
3. Uses Supabase MCP to inspect actual queries
4. Runs analyze.sql to get performance metrics
5. Identifies N+1 queries and missing indexes
6. Suggests specific optimizations with code examples
7. Can apply fixes via Supabase MCP if approved
```

**Autonomous aspects:**
- Skill selection (automatic)
- Pattern recognition (from Skill knowledge)
- Database inspection (via MCP)
- Analysis (SQL execution via MCP)
- Recommendations (based on Skill expertise)

---

## Example 2: Autonomous UI Testing

### The Setup

**Skill:** `ui-testing/`
```
.claude/skills/ui-testing/
├── SKILL.md              # Testing methodology
├── accessibility.md      # WCAG guidelines
└── examples/
    └── test-results.md   # Example outputs
```

**MCP:** Playwright (browser control)

**Sub-agent:** `ui-reviewer` (task orchestration)

**Workflow:**

```markdown
User: "Test the login component for accessibility"

Claude:
1. Spawns ui-reviewer sub-agent
2. Sub-agent activates ui-testing Skill
3. Skill loads accessibility.md (WCAG standards)
4. Playwright MCP opens browser
5. Sub-agent navigates to login component
6. Inspects DOM for accessibility violations
7. Checks: labels, ARIA attributes, keyboard navigation
8. Takes screenshot of component
9. Compiles detailed report with violations + fixes
```

**The chain:**
```
User Request
    ↓
Sub-agent (ui-reviewer)
    ↓
Skill (ui-testing knowledge)
    ↓
MCP (Playwright browser control)
    ↓
Detailed Report
```

---

## Example 3: Full-Stack Feature Implementation

### The Setup

**Skill:** `full-stack-feature/`
```
.claude/skills/full-stack-feature/
├── SKILL.md              # Implementation patterns
├── database-design.md    # Schema best practices
├── api-patterns.md       # Endpoint conventions
└── examples/
    └── complete-flow.md  # End-to-end examples
```

**MCPs Used:**
- Supabase (database)
- GitHub (code commits)
- Stripe (payments, if needed)

**Workflow:**

```markdown
User: "Add user subscription feature"

Claude (autonomous workflow):
1. Activates full-stack-feature Skill
2. Analyzes requirements using Skill knowledge
3. Designs database schema (following database-design.md)
4. Uses Supabase MCP to create migration
5. Generates API endpoints (following api-patterns.md)
6. Integrates Stripe for payments (if Stripe MCP available)
7. Writes test suite
8. Creates PR via GitHub MCP
```

**Skills orchestrating multiple MCPs:**
- Database design → Supabase MCP
- API patterns → Code generation
- Payment integration → Stripe MCP
- Code submission → GitHub MCP

---

## Pattern: Skills + MCPs for Team Governance

### Team Code Standards Skill

```
.claude/skills/company-standards/
├── SKILL.md              # Core standards
├── typescript-style.md   # TS conventions
├── api-design.md         # API patterns
├── security-checklist.md # Security requirements
└── examples/
    ├── good-api.ts
    └── bad-api.ts
```

**How it works:**
1. New developer clones repo
2. Git pulls Skills folder
3. Claude automatically applies team standards
4. Every code review follows company-standards Skill
5. Institutional knowledge transferred instantly

**Quote:**
> *"Teams use Skills for governance: code standards, organizational best practices, internal tools"*

---

## How to Build Advanced Workflows

### Step 1: Identify the Workflow

**Questions:**
- What's the repeatable process?
- What external tools/data are needed?
- Can this be autonomous or needs human approval?

**Example:**
- Process: Database optimization
- External: Database access (Supabase MCP)
- Autonomy: Analysis autonomous, changes need approval

---

### Step 2: Create the Skill

```yaml
---
name: database-optimization
description: Analyzes and optimizes database queries for performance
---

# Database Optimization Skill

## Instructions

When analyzing database performance:
1. Check for N+1 queries
2. Identify missing indexes
3. Look for inefficient joins
4. Suggest query rewrites

## Anti-Patterns to Detect

- SELECT * (overfetching)
- Missing WHERE indexes
- Cartesian products
- Subqueries that could be joins
```

---

### Step 3: Install Required MCPs

```bash
# Example: Supabase MCP
# (Installation command from MCP documentation)
```

**Document in SKILL.md:**
```markdown
## Requirements

This Skill requires:
- Supabase MCP (database access)
```

---

### Step 4: Test the Workflow

```markdown
User: "Analyze database performance"

Expected:
1. Skill activates automatically
2. MCP connects to database
3. Analysis runs
4. Report generated with specific recommendations
```

---

### Step 5: Refine and Document

**Add to SKILL.md:**
- Examples of successful analyses
- Common issues and solutions
- How to interpret results

---

## Advanced Patterns

### Pattern 1: MCP Chain

```
User Request
    ↓
Skill (expertise)
    ↓
MCP 1 (fetch data)
    ↓
Skill (analyze data)
    ↓
MCP 2 (take action)
    ↓
Skill (verify result)
    ↓
MCP 3 (commit changes)
```

**Example:** Fetch from database → Analyze → Update code → Commit to GitHub

---

### Pattern 2: Parallel MCP Usage

```
Skill
  ↓
  ├─→ MCP 1 (Supabase: get user data)
  ├─→ MCP 2 (Stripe: get subscription data)
  └─→ MCP 3 (GitHub: get recent commits)
  ↓
Skill (combine all data → generate report)
```

**Use case:** Dashboard generation from multiple sources

---

### Pattern 3: Conditional MCP Selection

```
Skill analyzes problem
    ↓
If database issue → Use Supabase MCP
If UI issue → Use Playwright MCP
If API issue → Use Context7 MCP
```

**Intelligence:** Skill decides which MCP to use based on context

---

## Real-World Use Cases

### Use Case 1: Automated Code Review

**Skills + MCPs:**
- code-review Skill (standards knowledge)
- github MCP (fetch PR)
- sequential-thinking MCP (deep analysis)

**Workflow:**
```
1. Developer creates PR
2. User: "Review PR #123"
3. Claude fetches PR via GitHub MCP
4. Applies code-review Skill standards
5. Uses sequential-thinking for complex logic
6. Posts review comments via GitHub MCP
```

---

### Use Case 2: Database Migration Generator

**Skills + MCPs:**
- schema-design Skill (best practices)
- Supabase MCP (database access)

**Workflow:**
```
1. User: "Add user_preferences table"
2. Skill designs schema (following best practices)
3. Generates migration SQL
4. Applies via Supabase MCP (with approval)
5. Verifies migration succeeded
```

---

### Use Case 3: Performance Debugging

**Skills + MCPs:**
- performance-optimization Skill
- Playwright MCP (browser profiling)
- Supabase MCP (query analysis)

**Workflow:**
```
1. User: "Why is the dashboard slow?"
2. Playwright MCP opens dashboard
3. Captures performance metrics
4. Supabase MCP analyzes database queries
5. Skill correlates frontend + backend data
6. Identifies: N+1 query causing slowness
7. Suggests specific fix with code
```

---

## Best Practices

### 1. Skills Provide Expertise, MCPs Provide Tools

**Good:**
- Skill knows WHAT to do
- MCP provides HOW to do it

**Bad:**
- Putting tool usage in Skill (should be abstracted)

---

### 2. Document MCP Dependencies

```markdown
# SKILL.md

## Requirements

- Supabase MCP (database operations)
- GitHub MCP (code submissions)

## Installation

See docs/04-ecosystem/05_third-party-mcps.md for MCP setup
```

---

### 3. Start Simple, Add Complexity

**Phase 1:** Single Skill + Single MCP
**Phase 2:** Single Skill + Multiple MCPs
**Phase 3:** Multiple Skills + Multiple MCPs + Sub-agents

---

### 4. Test Each Layer Independently

```
1. Test Skill alone (does it have right expertise?)
2. Test MCP alone (does it connect/work?)
3. Test integration (do they work together?)
```

---

## Limitations and Considerations

### When NOT to Use Advanced Workflows

- **Simple tasks** - Don't over-engineer
- **One-off operations** - Not worth setup time
- **Learning phase** - Master basics first

### Security Considerations

- **MCPs have access** - Be careful what MCPs can do
- **Approve changes** - Don't auto-execute destructive operations
- **Audit logs** - Review what MCPs actually did

### Cost Considerations

- **More MCPs = more tokens** - Each MCP adds context
- **Complex workflows = more requests** - Multiple tool calls
- **Balance cost vs. automation** - Sometimes manual is cheaper

---

## Summary

**Advanced MCP Workflows Core Principles:**

1. **Three-layer architecture** - Skill + MCP + Sub-agent
2. **Skills provide expertise** - Procedural knowledge
3. **MCPs provide tools** - External capabilities
4. **Autonomous workflows** - Multi-step processes
5. **Team governance** - Share Skills via git

**The outcome:**
- ✅ Autonomous multi-tool workflows
- ✅ Team knowledge sharing (Skills)
- ✅ Complex tasks automated
- ✅ Maintainable and documentable

**Quote that captures it:**
> *"Developers are using Skills that orchestrate workflows of multiple MCP tools stitched together"*

---

**See also:**
- [Skills Paradigm](../00-start-here/08_skills-paradigm.md) - Skills architecture
- [Sub-agent Best Practices](02_subagent-best-practices.md) - Task-focused agents
- [Third-Party MCPs](../04-ecosystem/05_third-party-mcps.md) - Community tools
