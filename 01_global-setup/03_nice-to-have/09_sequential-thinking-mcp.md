# Sequential-Thinking MCP - Structured Reasoning for Complex Tasks

💡 **Category:** nice-to-have (Advanced - Optional)

**Skip if:** You want to keep things simple and don't need structured reasoning analysis.

---

## What Is It?

Sequential-thinking MCP is a structured reasoning tool built into Claude Code that helps you solve complex problems through hypothesis-driven thinking.

**Key difference from normal thinking:**
- **Normal thinking:** Stream-of-consciousness reasoning (fast but can miss edge cases)
- **Sequential thinking:** Structured hypothesis → verify → revise loops (catches more issues)

**Think of it as:** Claude "showing its work" in a systematic way, like a mathematician proving a theorem step-by-step.

---

## Why Use It?

### Token Efficiency Paradox

Counterintuitive fact: Spending MORE tokens upfront on structured thinking saves tokens overall by preventing rework.

**Token math:**
- **Upfront cost:** +500-1000 tokens per analysis
- **Rework savings:** -1,500+ tokens from prevented mistakes
- **Net benefit:** 21-50% token savings on complex tasks

**Real numbers:**
- Without: 1,900 tokens (initial + corrections + fixes)
- With: 1,500 tokens (structured thinking gets it right first time)
- **Savings: 400 tokens (21%)**

### Quality Benefits

1. **Catches edge cases** - Before committing code
2. **Makes reasoning transparent** - You can audit Claude's logic
3. **Enables course correction** - Spot wrong assumptions early
4. **Builds trust** - See exactly how Claude reached conclusions

---

## When to Use

### ✅ USE Sequential-Thinking For:

- **Multi-perspective analyses** (Psychological, Educator, Engineering views)
- **Architecture and design decisions** (file structure, patterns)
- **Complex refactoring** with trade-offs
- **Ambiguous requirements** (need to clarify intent)
- **Problem diagnosis** (understanding root causes)
- **Quality assessments** (evaluating if something meets standards)

### ❌ DON'T Use For:

- **Mechanical updates** (changing file paths, variable renames)
- **Simple fixes** (typos, broken links)
- **Straightforward execution** (git commands, file operations)
- **Well-scoped tasks** (clear input → output, no ambiguity)

**Rule of thumb:** If Claude might get it wrong on first try → Use sequential-thinking

---

## How to Use

Sequential-thinking is already available in Claude Code. Just ask Claude to use it:

### Example Prompts

```
"Use sequential-thinking to analyze whether we should use REST or GraphQL"
```

```
"Think through this step-by-step with sequential-thinking:
Should we refactor now or wait until after the release?"
```

```
"I need a structured analysis with sequential-thinking of our authentication approach"
```

### Claude Will Use It Automatically For:

- Questions requiring multi-perspective coordination
- Complex architecture decisions
- Trade-off analyses
- Ambiguous requirements

**You can also request it explicitly** when you want to see the reasoning process.

---

## Real Example

### Without Sequential-Thinking

```
User: "Should we use REST or GraphQL for our API?"

Claude: "I'd recommend GraphQL because it's more flexible and allows
clients to request exactly what they need..."

User: "But our team doesn't know GraphQL and we need to ship in 2 weeks"

Claude: "Oh, in that case REST would be better since your team already
knows it and time is constrained..."

Result: 1,500 tokens wasted on rework
```

### With Sequential-Thinking

```
User: "Should we use REST or GraphQL for our API?"

Claude: [Uses sequential-thinking]
  Thought 1: Define requirements (what matters most)
  Thought 2: Technical pros/cons (GraphQL wins on flexibility)
  Thought 3: WAIT - need to consider team expertise and timeline
  Thought 4: Team knows REST, 2-week deadline is tight
  Thought 5: REST recommendation (ship faster, lower risk)

Result: Right answer first time (1,000 tokens total)
Savings: 500 tokens (33%)
```

---

## Best Practices

### 1. Use for Complexity

Don't request sequential-thinking for simple tasks. It adds overhead where it's not needed.

**Good:** "Use sequential-thinking to decide our state management approach"
**Overkill:** "Use sequential-thinking to fix this typo"

### 2. Review the Reasoning

Claude shows thought numbers and reasoning steps. Read them!

**Look for:**
- Wrong assumptions (correct them immediately)
- Missing considerations (point them out)
- Logic jumps (ask for clarification)

### 3. Correct Early

If Thought 2 reveals a wrong assumption, say so immediately. Don't wait until the end.

```
You: "In Thought 2, you assumed we're using React. We're actually using Vue."
Claude: [Revises from Thought 2 onward]
```

### 4. Learn Patterns

Watch how Claude structures complex reasoning. Over time, you'll:
- Recognize when to request it
- Spot patterns in problem-solving
- Ask better questions

---

## Integration with Your Workflow

### Add to Your CLAUDE.md

```markdown
## Special Instructions

For complex decisions: Use sequential-thinking to analyze trade-offs before recommending an approach.
```

### Add to Prompts

When asking complex questions, explicitly request:

```markdown
"Use sequential-thinking to evaluate..."
"I need structured reasoning on..."
"Think through this systematically..."
```

---

## Token Impact

### Per Complex Decision

| Approach | Tokens | Result |
|----------|--------|--------|
| Stream thinking | 1,900 | Wrong → corrections → rework |
| Sequential thinking | 1,500 | Right first time |
| **Savings** | **400 (21%)** | Higher quality |

### Over Project Lifetime

- **10 complex decisions** × 400 tokens = 4,000 tokens saved
- **25 complex decisions** × 400 tokens = 10,000 tokens saved (cost of ~3 medium conversations)
- **Payoff:** After 4-5 uses, pays for itself

**Plus:** Better quality decisions = fewer bugs = less debugging time

---

## Common Questions

**Q: Isn't this slower?**
A: Initially yes (+30 seconds), but you save time by not doing rework. Net faster overall.

**Q: When will Claude use it automatically?**
A: For multi-perspective analyses, architecture decisions, and ambiguous requirements. You can also request it explicitly.

**Q: Can I see examples of structured thinking?**
A: Yes! This very guide was planned using sequential-thinking. The analysis is in the plan file at `.claude/plans/`.

**Q: Does this conflict with Claude's built-in thinking mode (Tab toggle)?**
A: No, they're complementary. Built-in thinking shows stream-of-consciousness. Sequential-thinking adds structure on top.

---

## See Also

- [Model Switching](../02_good-to-have/01_model-switching.md) - For token optimization
- [MCP Setup](../02_good-to-have/02_mcp-setup.md) - MCP configuration basics
- [CLAUDE.md Template](../../../templates/CLAUDE.md.template) - How to document complex decisions

---

## Navigation

**🏠 [Back to Setup Index](../README.md)** | **📖 [Global Setup Overview](../../README.md)**

---

*Part of the Claude Code Configuration Template - v3.0.0*
*Sequential-Thinking MCP Guide | Last updated: 2025-12-12*
