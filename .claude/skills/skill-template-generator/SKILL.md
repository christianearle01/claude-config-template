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

## Key Operations

### Operation 1: Interactive Skill Generation

**User Query:**
> "Create a skill for database optimization"

**Confidence:** 🟢 High (0.86)
- Clear skill creation intent
- Template structure known
- Interactive Q&A guides user

**Skill Response:**
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

**Why This Matters:**
- Blank SKILL.md template is intimidating → Interactive Q&A removes paralysis
- Structured questions ensure complete skill definition (no missing sections)
- Generated examples provide starting point for customization
- **Quick win:** Answer 3 questions, get complete SKILL.md in < 5 minutes

**Next Step:** After generation, test skill by asking sample query (validates activation triggers)

---

**Skill Version:** 3.4.0
