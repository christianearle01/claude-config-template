

# Community Patterns Examples

**Purpose:** This document provides templates and examples for documenting external community patterns. Use these as guides when adding new patterns to the External Perspectives skill.

**Last Updated:** 2025-12-19
**Version:** 4.20.0

---

## How to Use This Document

1. **Find the template** for the category you want to add
2. **Copy the template structure**
3. **Fill in your research** following the format
4. **Add to SKILL.md** in the appropriate operation
5. **Update research progress tracker** in SKILL.md

---

## Contribution Guidelines

**What makes a good pattern:**
- ✅ **Real-world proven** - Used in production by actual teams/tools
- ✅ **Well-documented** - Clear source (YouTube link, blog post, repo)
- ✅ **Comparable** - Can map to our existing approach
- ✅ **Actionable** - Users can apply or learn from it
- ✅ **Honest** - Shows both benefits AND trade-offs

**What to avoid:**
- ❌ Theoretical patterns (not proven in practice)
- ❌ Marketing claims without implementation details
- ❌ Patterns without clear sources
- ❌ One-sided comparisons (show trade-offs, not just benefits)

---

## Pattern Template

Use this structure for all new patterns:

```markdown
### Operation X: [Pattern Name] ([VALIDATION/ADOPTION/ENHANCEMENT/OBSERVE])

**User Query Examples:**
- "[Example question 1]"
- "[Example question 2]"
- "[Example question 3]"

**Confidence:** [🟢 High/🟡 Medium/🔴 Low] ([0-1.0]) - [Why this confidence level]

**Skill Response:**

#### Community Pattern: [Pattern Name]

**Source:** [Tool/Person/Company] - [Specific video/article/repo link]
**Pattern:** [One-line summary]

**Description:**
[2-3 paragraphs explaining the pattern, how it works, what problem it solves]

**Benefits:**
1. [Benefit 1]
2. [Benefit 2]
3. [Benefit 3]

**Our Equivalent Implementation:**

| Community Approach | Our Implementation | Status |
|--------------------|-------------------|--------|
| [Their pattern] | [Our equivalent] | ✅/⏳/❌ |

**Alignment Analysis:**

[✅ Aligned / ⚠️ Partial / ❌ Divergent] - [Explanation]

**Specific Mappings:**
- [Community concept A] = [Our implementation X]
- [Community concept B] = [Our implementation Y]

**What We Learn:**
- [Learning 1]
- [Learning 2]

**Gap Analysis:** [None / Gap description / Intentional difference]

**When to Apply This Pattern:**
- [Use case 1]
- [Use case 2]

**Why This Matters:**
[1-2 paragraphs explaining significance]

**Next Step:**
[Actionable recommendation]
```

---

## Example Pattern 1: Compounding Engineering Loop (Completed)

### Operation 2: Compounding Engineering Loop (VALIDATION PATTERN) ✅

**User Query Examples:**
- "What workflow frameworks are AI-native companies using?"
- "How do successful teams structure their AI development process?"
- "Is our CLAUDE.md approach aligned with industry practices?"

**Confidence:** 🟢 High (0.92) - Well-established pattern, validated across multiple sources

**Skill Response:**

#### Community Pattern: Compounding Engineering Loop

**Source:** Dan Shipper (Every) - "How to build an AI native company (even if your company is 50 years old)"
**Link:** https://www.youtube.com/watch?v=MGzymaYBiss
**Pattern:** Plan → Delegate → Assess → Codify

**Description:**

AI-native companies use a 4-step compounding loop where each cycle makes the next feature easier to build:

1. **Plan** - Define what needs to be built, break down complexity, identify dependencies
2. **Delegate** - Hand off implementation to AI agents with clear instructions
3. **Assess** - Review quality, functionality, test coverage, alignment with intent
4. **Codify** - Save lessons, patterns, and fixes to prompt libraries for future reuse

The critical insight: **Codify is the "money step"**. This is where temporary bug fixes become permanent knowledge. Teams that skip codification don't get compound benefits - each task starts from scratch.

**Benefits:**
1. **Compound Learning** - Each cycle improves future cycles
2. **Team Knowledge Sharing** - Codified patterns accessible to everyone
3. **Reduced Rework** - Solved problems stay solved
4. **Faster Onboarding** - New team members inherit accumulated wisdom
5. **Context Preservation** - Future AI interactions leverage past learnings

**Our Equivalent Implementation:**

| Community Step | Our Implementation | Status |
|----------------|-------------------|--------|
| **Plan** | features.json (task breakdown, dependencies, test criteria) | ✅ Implemented (v3.6.0) |
| **Delegate** | Skills system (19 specialized agents), commands | ✅ Implemented (v3.5.0+) |
| **Assess** | quality-reviewer, deployment-readiness, testing-workflow | ✅ Implemented (v3.7.0, v4.19.0) |
| **Codify** | CLAUDE.md, coding-standards.md, skill definitions | ✅ Implemented (core philosophy) |

**Alignment Analysis:**

✅ **Perfect Alignment** - We're already doing exactly what AI-native companies recommend!

This is powerful **external validation** that our architectural choices align with industry leaders. Our approach wasn't inspired by Dan Shipper's framework (we developed it independently), which makes this convergence even more meaningful.

**Specific Mappings:**
- Community: "Prompt libraries" → Our: CLAUDE.md, coding-standards.md, skill definitions
- Community: "Task planning" → Our: features.json with explicit test criteria
- Community: "Agent delegation" → Our: Skills system (19 agents) + commands (4 commands)
- Community: "Quality assessment" → Our: quality-reviewer, deployment-readiness agents
- Community: "Session journal" → Our: progress.md (tracks what worked, what didn't)

**What We Learn:**
- Our "document everything" philosophy isn't over-engineering - it's the foundation of compounding returns
- The iterative loop structure (Plan → Delegate → Assess → Codify → repeat) matches our workflow
- **Codify differentiates high-performing teams** - Those who skip it don't compound knowledge
- Explicit artifacts (files, not just memory) enable knowledge sharing across team members and time

**Gap Analysis:** None - We're aligned on both philosophy and implementation

**When to Apply This Pattern:**
- **Every project should follow this loop** - It's not optional, it's foundational
- **Especially valuable for teams** - Codification enables knowledge sharing without meetings
- **Critical for long-running projects** - Compound benefits accumulate over months/years
- **After solving any non-trivial problem** - If it took effort to solve, codify the solution

**Why This Matters:**

When users see `[RESEARCH NEEDED]` placeholders in this skill, they might think "this project is incomplete." This pattern shows our foundational approach aligns with AI-native industry leaders.

Our architecture (CLAUDE.md + features.json + skills + progress.md) isn't arbitrary - it implements the compounding loop that successful AI-native companies use.

**Next Step:**

Continue codifying patterns as you discover them. Each time you solve a problem or make a decision, ask: "Should this go in CLAUDE.md or coding-standards.md?" If yes, you're building compound value. If no, you're losing an opportunity for future acceleration.

---

## Example Pattern 2: Pre-Task Complexity Scoring (Completed)

### Operation 3: Pre-Task Complexity Scoring (ADOPTION PATTERN) ✅

**User Query Examples:**
- "How do I set user expectations before starting work?"
- "Should I estimate task difficulty upfront?"
- "What's the community pattern for pre-work assessment?"

**Confidence:** 🟢 High (0.88) - Proven pattern in Auto Claude with demonstrated user value

**Skill Response:**

#### Community Pattern: Pre-Task Complexity Scoring

**Source:** Auto Claude (open-source AI coding tool)
**Link:** https://www.youtube.com/watch?v=s9nt8xaXFdg
**Pattern:** Assign Simple/Medium/Complex + confidence score BEFORE starting work

**Description:**

Auto Claude analyzes tasks before execution and provides upfront assessment:

- **Complexity Level:** Simple (<50 lines, single file) / Medium (<300 lines, multi-file) / Complex (architectural changes)
- **Confidence Score:** 0-100% likelihood of successful completion without user intervention
- **Time Estimate:** Projected duration based on historical data and complexity
- **Risk Flags:** Potential blockers, missing dependencies, ambiguous requirements identified before work starts

This creates a "contract" with the user: "Here's what you're asking for, here's how complex it is, here's my confidence I can deliver."

**Benefits:**
1. **Sets User Expectations** - No surprises ("this will take 5 min" vs "this is a 2-hour task requiring architectural decisions")
2. **Enables Better Planning** - User can decide if now is the right time or if they need to block out focused time
3. **Reduces Frustration** - User knows what they're getting into before committing
4. **Metacognitive Training** - Over time, users learn to assess difficulty themselves (transferable skill)
5. **Resource Allocation** - High-complexity + low-confidence tasks might need human pairing or breaking down

**Our Equivalent Implementation:**

| Community Approach | Our Implementation | Status |
|--------------------|--------------------|--------|
| Pre-task complexity scoring | Confidence scoring AFTER work (deployment-readiness, quality-reviewer) | ⏳ Partial |
| Time estimation upfront | No time estimates | ❌ Missing |
| Risk identification before work | Some agents identify risks during work, not before | ⏳ Partial |

**Alignment Analysis:**

⚠️ **Partial Alignment** - We score confidence, but AFTER work is complete, not BEFORE

**Gap:** We don't set user expectations upfront, which can lead to:
- User starts task thinking it's a 5-minute fix, takes 2 hours (frustration + broken flow)
- User doesn't know if they have time to complete it in current session
- Missed opportunity to suggest breaking down complex tasks before starting
- No chance to clarify ambiguous requirements before wasting tokens on wrong approach

**What We Learn:**
- **Predictive confidence** (before) complements our **retrospective confidence** (after)
- Both perspectives are valuable - before helps planning, after validates quality
- Pre-task assessment is inexpensive (few tokens) but high-value (prevents wasted work)

**Gap Analysis:**

This IS a gap we should address. Our agents are capable of pre-task analysis but don't consistently do it.

**Recommendation: Adopt This Pattern**

Add pre-task assessment to agent workflows. Example implementation for coder agent:

```markdown
## Pre-Task Assessment (Run BEFORE implementation)

1. **Complexity Analysis:**
   - Count files to modify/create
   - Estimate total lines of code
   - Identify architectural changes
   - → Score: Simple (0.90+) / Medium (0.70-0.89) / Complex (<0.70)

2. **Risk Identification:**
   - Missing information → Flag: "Need user clarification on [X]"
   - External dependencies → Flag: "Requires API key / database / service"
   - Merge conflicts possible → Flag: "Files being modified by others"
   - Knowledge gaps → Flag: "Unfamiliar pattern, lower confidence"

3. **Time Projection:**
   - Simple: 5-15 minutes
   - Medium: 15-60 minutes
   - Complex: 1+ hours → Suggest: "Break into subtasks?"

4. **Output to User:**
   ```
   📊 Pre-Task Assessment:
   Complexity: [Level]
   Confidence: [Score]%
   Estimated Time: [Duration]
   Risks: [List if any]

   Recommendation: [Proceed / Break Down / Clarify First]
   ```
```

**When to Apply:**
- Before every non-trivial implementation (not for typo fixes)
- When user asks "how long will this take?"
- When task description is ambiguous
- When multiple implementation approaches are possible

**Why This Matters:**

This enhances our quality-first philosophy by adding **predictive** quality checks (before work) to our existing **retrospective** quality checks (after work).

It's also educational - teaching users to think about task complexity before diving in is a valuable meta-skill for software development beyond AI coding.

**Next Step:**

1. Add pre-task assessment pattern to coder agent template
2. Update project-planner agent (already does some of this, formalize it)
3. Document in agent best practices
4. Consider adding to quality-reviewer as "pre-work risk assessment"

---

## Category Template: Context Management

**Pattern Name:** [e.g., "Cursor's Semantic Code Indexing"]

**Source:** [Tool name + link]

**What They Do:**
[Describe their approach to managing codebase context, file selection, token optimization]

**Our Approach:**
[Describe our CLAUDE.md + MCP optimization + skills approach]

**Comparison:**

| Dimension | Community | Ours | Analysis |
|-----------|-----------|------|----------|
| Context Storage | [Their method] | CLAUDE.md (file-based) | [Trade-offs] |
| File Selection | [Their method] | Skills + MCP | [Trade-offs] |
| Token Optimization | [Their method] | Prompt caching + MCP | [Trade-offs] |

**Gaps:**
- [What we're missing]
- [What they're missing]

**Recommendation:** [Adopt / Observe / Intentional Difference]

---

## Category Template: Workflow Automation

**Pattern Name:** [e.g., "Aider's Automated Git Workflow"]

**Source:** [Tool name + link]

**What They Do:**
[Describe their git automation, commit patterns, testing loops]

**Our Approach:**
[Describe our /release command, commit-readiness-checker, deployment-readiness]

**Comparison:**

| Dimension | Community | Ours | Winner |
|-----------|-----------|------|--------|
| Commit automation | [Their approach] | User approval required | [Context-dependent] |
| Test integration | [Their approach] | quality-reviewer, testing-workflow | [Analysis] |
| Deployment validation | [Their approach] | deployment-readiness | [Analysis] |

**Trade-offs:**
- Speed vs Safety: [Analysis]
- Automation vs Human Review: [Analysis]

**Recommendation:** [When to use their approach vs ours]

---

## Category Template: Prompt Strategies

**Pattern Name:** [e.g., "Fabric's Prompt Optimization Framework"]

**Source:** [Daniel Miessler / Tool name + link]

**What They Do:**
[Describe prompt structure, optimization techniques, patterns]

**Our Approach:**
[Describe our prompt-polisher, prompt patterns guide, prompting fundamentals]

**Alignment Check:**

| Pattern | Fabric | Our Equivalent | Status |
|---------|--------|----------------|--------|
| [Pattern 1] | [Their version] | [Our version] | ✅/⚠️/❌ |
| [Pattern 2] | [Their version] | [Our version] | ✅/⚠️/❌ |

**Validation:**
- [Where we align - confirms we're on right track]
- [Where we differ - intentional or gap?]

**Recommendation:** [Continue current approach / Adjust based on their patterns]

---

## Category Template: Integration Patterns

**Pattern Name:** [e.g., "Multi-Tool Workflow Orchestration"]

**Source:** [Community examples + link]

**What They Do:**
[Describe how teams combine multiple AI tools (Cursor + Aider, etc.)]

**Our Approach:**
[Describe our integration patterns from v4.18.0, agent orchestration]

**Comparison:**

| Scenario | Community Combo | Our Approach | Analysis |
|----------|----------------|--------------|----------|
| [Use case 1] | [Tool A + Tool B] | [Our pattern] | [Trade-offs] |
| [Use case 2] | [Tool C + Tool D] | [Our pattern] | [Trade-offs] |

**When Multi-Tool Wins:**
- [Scenarios where combining tools is better]

**When Single-Tool Wins:**
- [Scenarios where our integrated approach is better]

**Recommendation:** [Context-specific guidance]

---

## Category Template: Team Collaboration

**Pattern Name:** [e.g., "Tacit Knowledge Sharing via Repo Indexing"]

**Source:** [Company/Tool + link]

**What They Do:**
[Describe how teams share AI patterns, onboarding, knowledge transfer]

**Our Approach:**
[Describe our CLAUDE.md sharing, template inheritance (v4.0.0-v4.2.0), team patterns]

**Comparison:**

| Dimension | Community | Ours | Analysis |
|-----------|-----------|------|----------|
| Knowledge sharing | [Their method] | CLAUDE.md templates | [Trade-offs] |
| Onboarding | [Their method] | Setup wizards + templates | [Trade-offs] |
| Standardization | [Their method] | coding-standards.md | [Trade-offs] |

**Team Size Implications:**
- Solo: [Which approach works better]
- Small team (2-5): [Which approach works better]
- Medium team (6-20): [Which approach works better]

**Recommendation:** [Context-specific guidance]

---

## Research Workflow

**When researching a new pattern:**

1. **Watch/Read Source** - YouTube video, blog post, documentation
2. **Take Notes:**
   - What problem does it solve?
   - How does it work (technically)?
   - What are the benefits?
   - What are the trade-offs?
   - Who is this for (team size, use case)?

3. **Map to Our Approach:**
   - Do we do something similar?
   - What's our equivalent (if any)?
   - Where do we align?
   - Where do we differ (gap or intentional)?

4. **Analyze Alignment:**
   - ✅ Aligned - We're doing the same thing (validation)
   - ⚠️ Partial - We're partially aligned (enhancement opportunity)
   - ❌ Divergent - We intentionally differ (document why)

5. **Determine Action:**
   - VALIDATION - We're on the right track, no changes needed
   - ADOPTION - We should adopt this pattern
   - ENHANCEMENT - We should improve our existing approach
   - OBSERVE - Different philosophy, document trade-offs

6. **Write Pattern:**
   - Use template above
   - Include source link
   - Show honest comparison (trade-offs, not just benefits)
   - Provide actionable recommendation

7. **Add to SKILL.md:**
   - Copy pattern to appropriate operation
   - Update research progress tracker
   - Update confidence scores if needed

---

## Quality Standards

**Every pattern should answer:**
- ✅ What problem does this solve?
- ✅ How does it work?
- ✅ What are the benefits AND trade-offs?
- ✅ How does it compare to our approach?
- ✅ When should someone use this pattern?
- ✅ What's the next actionable step?

**Avoid:**
- ❌ Marketing language ("revolutionary", "game-changing")
- ❌ One-sided comparisons (only benefits, no trade-offs)
- ❌ Vague recommendations ("consider adopting")
- ❌ Unsourced claims ("everyone is doing this")

**Aim for:**
- ✅ Honest, balanced analysis
- ✅ Clear source attribution
- ✅ Actionable recommendations
- ✅ Educational value (teach the WHY, not just the WHAT)

---

## Contribution Template

When you research a new pattern and want to add it:

1. Copy the appropriate category template above
2. Fill in all sections with your research
3. Add source link (YouTube timestamp if applicable)
4. Test your pattern by asking: "Could someone apply this?"
5. Add to SKILL.md in appropriate operation
6. Update research progress tracker
7. Commit with message: "Add [Pattern Name] to external-perspectives"

---

**Document Version:** 4.20.0
**Last Updated:** 2025-12-19
**Contributors:** Template created by v4.20.0 release, patterns added incrementally
**Need Help?** See SKILL.md for examples of completed patterns (Operations 2-5)
