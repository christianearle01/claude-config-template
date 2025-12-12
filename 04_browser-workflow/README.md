# Claude.ai Workflow Optimization by Role

**For:** Users of https://claude.ai/ (web interface)
**Not for:** Claude Code CLI or VS Code Extension users

---

## 🎯 Choose Your Professional Role

Select your role to get optimized Custom Instructions and workflow patterns:

### 🎨 [Your Role Not Listed? Create Your Own](must-have/01_custom-role.md)
**Best for:** Any role not in the priority list (Product Manager, DevOps, Data Scientist, etc.)
**You'll get:** Template generator and guide to create role-specific Custom Instructions

---

### 🛠️ [Software Engineer](must-have/02_software-engineer.md)
**Best for:** Code development, debugging, testing, refactoring
**You'll get:** Custom Instructions for code quality, prompt patterns for common tasks

---

### 🧪 [Quality Assurance Engineer](must-have/03_qa-engineer.md)
**Best for:** Test planning, automation, bug reporting, quality metrics
**You'll get:** Custom Instructions for testing workflows, QA-specific patterns

---

### 📊 [Data Scientist](must-have/04_data-scientist.md)
**Best for:** Data analysis, ML modeling, visualization, statistical analysis
**You'll get:** Custom Instructions for data science, prompt patterns for analysis

---

### ⚙️ [DevOps Engineer](must-have/05_devops-engineer.md)
**Best for:** Infrastructure, CI/CD, deployment, monitoring, automation
**You'll get:** Custom Instructions for DevOps, prompt patterns for infrastructure

---

### 📋 [Product Manager](must-have/06_product-manager.md)
**Best for:** Requirements, user stories, feature planning, stakeholder communication
**You'll get:** Custom Instructions for PM work, prompt patterns for product decisions

---

### ✍️ [Technical Writer](must-have/07_technical-writer.md)
**Best for:** Documentation, API docs, tutorials, user guides
**You'll get:** Custom Instructions for technical writing, prompt patterns for documentation

---

### 🎨 [Frontend Developer](must-have/08_frontend-developer.md)
**Best for:** UI/UX implementation, component development, responsive design
**You'll get:** Custom Instructions for frontend work, prompt patterns for components

---

### 🔒 [Security Engineer](must-have/09_security-engineer.md)
**Best for:** Security analysis, vulnerability assessment, compliance
**You'll get:** Custom Instructions for security work, prompt patterns for security reviews

---

## 📖 How This Works

1. **Choose your role** above (or create custom if not listed)
2. **Copy the Custom Instructions** template
3. **Paste into claude.ai settings** (Settings → Custom Instructions)
4. **Use the prompt patterns** for your daily tasks
5. **Optimize as you go** based on your specific needs

---

## 💡 What Are Custom Instructions?

Custom Instructions on claude.ai let you set persistent context that applies to ALL conversations:
- **Global context** - No need to repeat yourself in every chat
- **Role-specific optimization** - Tailored responses for your job function
- **Token efficiency** - Reduces repetitive context setting

**Location:** claude.ai → Settings → Custom Instructions

### Two Sections:

**Section 1: "What would you like Claude to know about you?"**
- Your role and responsibilities
- Tools and technologies you use
- Your preferences and values
- What you use Claude for

**Section 2: "How would you like Claude to respond?"**
- Response style (concise, detailed, code-first, etc.)
- What to focus on (security, performance, best practices)
- What to avoid or skip
- Output format preferences

---

## 🔄 Difference from Claude Code Template

This directory is specifically for **claude.ai web interface users**.

If you use Claude Code (CLI or VS Code Extension), see:
- [Claude Code Template](../README.md) - Full setup guide
- [CLAUDE.md System](../templates/CLAUDE.md.template) - Project memory

**Key difference:**
- **Claude Code:** Project-specific CLAUDE.md files (different file per codebase)
- **claude.ai:** Global Custom Instructions for your role (applies to ALL chats)

---

## ⚡ Quick Start Example

Here's what Custom Instructions look like (Software Engineer example):

**Section 1:**
```
I'm a software engineer who uses Claude for:
- Code review and debugging
- Writing tests
- Technical documentation

Primary languages: JavaScript, Python
Frameworks: React, FastAPI
I value: Clean code, security, performance
```

**Section 2:**
```
When helping with code:
- Explain WHY, not just WHAT
- Point out security/performance issues
- Include error handling
- Use modern syntax

Keep responses: Concise, code-first, production-ready
```

---

## 🌟 Benefits of Role-Based Custom Instructions

### 1. Token Efficiency
**Without Custom Instructions:**
```
You: "Review this JavaScript code"
Claude: [Asks about: language, framework, preferences, focus areas...]
Tokens: ~5,000
```

**With Custom Instructions:**
```
You: "Review this code"
Claude: [Already knows: JavaScript, React, your preferences]
Tokens: ~1,500
```

**Savings:** 70% token reduction (projected)

### 2. Consistent Quality
- Claude remembers your preferences across ALL conversations
- No need to repeat context in every chat
- Responses tailored to your specific role

### 3. Faster Workflow
- Skip the context-setting phase
- Get straight to work
- Claude adapts to YOUR workflow, not generic advice

---

## 📊 Efficiency Metrics (Projected)

_Note: These are theoretical projections. Help us validate with your real usage!_

| Metric | Without Custom Instructions | With Custom Instructions | Improvement |
|--------|---------------------------|-------------------------|-------------|
| Tokens per query | ~5,000 | ~1,500 | 70% reduction |
| Time to useful answer | 2-3 exchanges | 1 exchange | 66% faster |
| Response relevance | 70% | 90% | +28% |
| User satisfaction | 7/10 | 9/10 | +29% |

---

## 🎓 Best Practices

### DO:
- ✅ Be specific about your role and tools
- ✅ Include your preferences and values
- ✅ Update Custom Instructions as your work evolves
- ✅ Use Projects for codebase-specific context
- ✅ Provide examples in your instructions

### DON'T:
- ❌ Put sensitive information in Custom Instructions
- ❌ Make instructions too long (keep under 2000 chars per section)
- ❌ Use vague descriptions ("I'm a developer" → "I'm a Python backend developer")
- ❌ Forget to test and iterate

---

## 🔍 When to Use Projects vs Custom Instructions

**Custom Instructions** (Global, applies to ALL chats):
- Your professional role
- Tools and technologies you always use
- General preferences and response style
- Skills and expertise level

**Projects** (Specific to one topic/codebase):
- Specific codebase or application
- Project-specific requirements
- Architecture docs and README files
- API specs and schemas

**Best combo:** Custom Instructions set your role → Projects add specific context

---

## ❓ FAQ

**Q: Can I change my Custom Instructions?**
A: Yes! Settings → Custom Instructions → Edit anytime. Changes apply to new conversations.

**Q: Can I have multiple sets for different roles?**
A: No, claude.ai allows only ONE set globally. Use Projects for context variations.

**Q: What if my role changes?**
A: Update your Custom Instructions to reflect your new role or responsibilities.

**Q: How long should my Custom Instructions be?**
A: Aim for 1000-1500 characters per section. claude.ai limits to ~2000 chars per section.

**Q: Will this work with Claude Code?**
A: No. This is specifically for claude.ai web interface. For Claude Code, use [CLAUDE.md](../templates/CLAUDE.md.template).

---

## 🚀 Get Started

1. Click your role above
2. Follow the guide to copy your Custom Instructions template
3. Start using optimized prompts in claude.ai
4. Share your experience to help validate our projections!

---

## Navigation

**🏠 [Back to Main Template](../README.md)** | **📖 [Quick Reference](../docs/00-start-here/QUICK_REFERENCE.md)**

---

*Part of the Claude Code Configuration Template - v2.6.0*
*Browser Workflow for claude.ai Users | Last updated: 2025-12-08*
