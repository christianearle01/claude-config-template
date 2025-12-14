---
name: skill-template-generator
description: Generates SKILL.md structure interactively. Auto-activates when users ask to create a skill, need skill template, or want skill generation help. Accelerates skill creation with interactive questions.
allowed-tools: Read, Write
---

# Skill Template Generator

## Purpose & Activation

**What it does:** Interactive skill generation with templates and examples.

**When it activates:**
- "Create a skill for X"
- "Generate skill template"
- "Help me build a skill"

**Operations:**
- Ask clarifying questions
- Generate SKILL.md structure
- Add example queries
- Create supporting files

**Token Savings:** 600 tokens/skill creation (projected)

---

## How It Works

**User:** "Create a skill for database optimization"

**Generator:**
```
I'll help create database-optimization skill!

Questions:
1. What queries will users ask? (give 3-5 examples)
2. What data source? (logs, config, metrics)
3. What insights? (slow queries, index suggestions)

[Interactive Q&A]

Generating skill structure...
✅ .claude/skills/database-optimization/SKILL.md created
✅ Example queries added
✅ Operations defined

Ready to use!
```

---

**Skill Version:** 3.4.0
