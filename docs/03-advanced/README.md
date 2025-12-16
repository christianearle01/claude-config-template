# 03 - Advanced

**Power user techniques and complex workflows**

---

## What's in This Section?

Master advanced Claude Code features for autonomous workflows and maximum productivity.

### 🚀 Advanced Workflows

**[Advanced MCP Workflows](ADVANCED_MCP_WORKFLOWS.md)**
- Supabase MCP integration (database operations)
- Playwright MCP (autonomous UI testing)
- Skills orchestrating multiple MCPs
- The "highest tier" workflow pattern
- **Example:** UI testing chain (Skill + Playwright + Sub-agent)

**[Sub-Agent Best Practices](SUBAGENT_BEST_PRACTICES.md)**
- "Tasks not Roles" principle
- Sub-agent architecture (context, prompts, permissions)
- Examples: code-reviewer, ui-tester, documentation-generator
- ❌ BAD: "frontend-developer" (too broad)
- ✅ GOOD: "react-component-optimizer" (specific task)

**[Conversation Branching](CONVERSATION_BRANCHING.md)**
- Shift+Click branching feature
- When to explore alternatives
- Token impact: prevents context pollution
- Can save 50K+ tokens over project lifetime

**[Vision Optimization](VISION_OPTIMIZATION.md)**
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

1. **[Advanced MCP Workflows](ADVANCED_MCP_WORKFLOWS.md)** - Multi-tool orchestration (20 min)
2. **[Sub-agent Best Practices](SUBAGENT_BEST_PRACTICES.md)** - Task-focused agents (10 min)
3. **[Conversation Branching](CONVERSATION_BRANCHING.md)** - Context management (5 min)
4. **[Vision Optimization](VISION_OPTIMIZATION.md)** - Multimodal efficiency (5 min)

---

## Prerequisites

**Before diving into advanced topics:**
- ✅ Completed [01-Fundamentals](../01-fundamentals/)
- ✅ Understand Skills paradigm
- ✅ Comfortable with Ctrl+O verification
- ✅ Read [Anti-Patterns](../00-start-here/05_anti-patterns.md)

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
