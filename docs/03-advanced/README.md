# 03 - Advanced

**Power user techniques and complex workflows**

---

## What's in This Section?

Master advanced Claude Code features for autonomous workflows and maximum productivity.

### 🚀 Advanced Workflows (Coming Soon)

**ADVANCED_MCP_WORKFLOWS.md** (Commit 8)
- Supabase MCP integration (database operations)
- Playwright MCP (autonomous UI testing)
- Skills orchestrating multiple MCPs
- The "highest tier" workflow pattern
- **Example:** UI testing chain (Skill + Playwright + Sub-agent)

**SUBAGENT_BEST_PRACTICES.md** (Commit 9)
- "Tasks not Roles" principle
- Sub-agent architecture (context, prompts, permissions)
- Examples: code-reviewer, ui-tester, documentation-generator
- ❌ BAD: "frontend-developer" (too broad)
- ✅ GOOD: "react-component-optimizer" (specific task)

**CONVERSATION_BRANCHING.md** (Commit 10)
- Shift+Click branching feature
- When to explore alternatives
- Token impact: prevents context pollution
- Can save 50K+ tokens over project lifetime

**VISION_OPTIMIZATION.md** (Commit 10)
- When to use images vs. text descriptions
- Token comparison: 500-word description vs. image upload
- Examples: architecture diagrams, error screenshots
- Saves 500-2,000 tokens per visual

---

## Why These Are Advanced

**These techniques unlock:**
- Autonomous workflows (Skills + MCPs + Sub-agents)
- Multi-tool orchestration (database + browser + code)
- Context management at scale (branching conversations)
- Efficient multimodal usage (vision optimization)

**Quote from power users:**
> "Developers are using Skills that orchestrate workflows of multiple MCP tools stitched together"

---

## The Three-Layer Architecture

```
Skill (expertise) + MCP (data/tools) + Sub-agent (orchestration)
= Autonomous Workflows
```

**Example: Database Optimization**
- **Skill:** Query optimization expertise
- **MCP:** Supabase (live database access)
- **Sub-agent:** Analysis orchestrator
- **Result:** Autonomous performance tuning

---

## Recommended Reading Order

1. **Advanced MCP Workflows** - Multi-tool orchestration (20 min) ← Coming soon
2. **Sub-agent Best Practices** - Task-focused agents (10 min) ← Coming soon
3. **Conversation Branching** - Context management (5 min) ← Coming soon
4. **Vision Optimization** - Multimodal efficiency (5 min) ← Coming soon

---

## Prerequisites

**Before diving into advanced topics:**
- ✅ Completed [01-Fundamentals](../01-fundamentals/)
- ✅ Understand Skills paradigm
- ✅ Comfortable with Ctrl+O verification
- ✅ Read [Anti-Patterns](../00-start-here/ANTI_PATTERNS.md)

**Without fundamentals, advanced techniques can create:**
- Over-engineered solutions
- Mystery code from autonomous workflows
- Technical debt from complexity

**With fundamentals, advanced techniques create:**
- Powerful autonomous workflows
- Maintainable complexity
- 5-minute updates (vs. 3-4 hours)

---

## Learning Outcome

**After this section, you'll know:**
- ✅ How to orchestrate multiple MCPs via Skills
- ✅ How to create task-focused sub-agents
- ✅ When to branch conversations (context protection)
- ✅ How to use vision efficiently (token savings)
- ✅ The "highest tier" workflow patterns

---

**Previous:** [02-Optimization](../02-optimization/) - Token saving strategies
**Next:** [04-Ecosystem](../04-ecosystem/) - Third-party tools and plugins
