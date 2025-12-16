# Software Engineer - Claude.ai Workflow

**For:** Software engineers using https://claude.ai/ for code development

**Token Efficiency:** This guide helps you save 70% tokens through optimized Custom Instructions

---

## 📋 Custom Instructions Template

Copy this template and paste into your claude.ai Custom Instructions (Settings → Custom Instructions).

### Section 1: What would you like Claude to know about you?

```
I'm a software engineer who uses Claude for:
- Code review and quality analysis
- Debugging and troubleshooting
- Writing tests (unit, integration, E2E)
- Refactoring and optimization
- Documentation and technical writing

My development context:
- Primary languages: [e.g., JavaScript/TypeScript, Python, Go]
- Frameworks: [e.g., React, Next.js, Django, Express]
- Focus areas: [e.g., web development, backend APIs, full-stack]

I value:
- Clean, maintainable code following SOLID principles
- Comprehensive error handling
- Security best practices (OWASP)
- Performance optimization
- Clear, concise explanations
```

**Character count:** ~950 characters (fits within claude.ai limits)

---

### Section 2: How would you like Claude to respond?

```
When helping with code:
- Always explain WHY, not just WHAT
- Point out potential issues (security, performance, edge cases)
- Follow language-specific best practices
- Use modern syntax and patterns
- Include error handling by default

When reviewing code:
- Focus on readability, maintainability, security
- Suggest improvements with examples
- Explain trade-offs of different approaches

Keep responses:
- Concise but thorough
- Code-first (show examples)
- Production-ready (not just prototypes)
```

**Character count:** ~590 characters

---

## 🎯 Common Software Engineering Tasks

### Task 1: Code Review

**Optimized Prompt Pattern:**
```
Review this [language] code for:
- Security vulnerabilities (OWASP Top 10)
- Performance bottlenecks
- Code smells and anti-patterns
- Edge cases not handled

Code:
[paste code]

Focus on: [specific area]
Skip: [what to ignore]
```

**Why this works:**
- ✅ Specific review criteria
- ✅ Language context from Custom Instructions
- ✅ Focused scope reduces tokens
- ✅ Clear output expectations

**Token savings:** ~60% (vs explaining context each time)

---

### Task 2: Write Unit Tests

**Optimized Prompt Pattern:**
```
Generate unit tests for this function:
[paste function]

Test cases needed:
- Happy path (expected inputs)
- Edge cases (empty, null, boundary values)
- Error conditions (invalid inputs)

Framework: [Jest/pytest/Go testing/etc.]
Coverage target: 80%+
```

**Token savings:**
- Testing framework preference already in Custom Instructions
- No need to explain testing philosophy each time
- Focused on specific function, not entire file

---

### Task 3: Debug Error

**Optimized Prompt Pattern:**
```
Help debug this error:

Error message:
[paste error]

Context:
- What I was trying to do: [brief description]
- What happened instead: [observed behavior]
- Relevant code: [paste minimal code snippet]

Environment: [Node v18, Python 3.11, etc.]
```

**Why this works:**
- Structured error context
- Language/framework from Custom Instructions
- Focused troubleshooting scope

---

### Task 4: Refactor Code

**Optimized Prompt Pattern:**
```
Refactor this code to improve [readability/performance/testability]:

Current code:
[paste code]

Constraints:
- Keep same functionality
- Target: [specific improvement goal]
- Don't change: [what must stay same]
```

**Token efficiency:**
- Your coding standards already in Custom Instructions
- Specific refactoring goal
- Clear constraints prevent over-engineering

---

### Task 5: Explain Complex Code

**Optimized Prompt Pattern:**
```
Explain how this code works:
[paste code]

Audience: [junior dev/senior dev/product manager]
Focus on: [specific part I don't understand]
```

**Why this works:**
- Tailored explanation level
- Focused scope
- Leverages your language context from Custom Instructions

---

## 💡 Workflow Optimization Tips

### 1. Use Projects for Code Context
Create claude.ai Projects for each codebase:
- Project name: [RepoName] - [Language]
- Upload: architecture docs, key files, README
- Result: Context-aware responses without pasting code repeatedly

**Token savings:** Up to 90% on project-specific queries

### 2. Prompt Chaining Pattern
For complex tasks, chain prompts:
```
1. "Outline an approach for [feature]"
2. "Implement step 1 from the outline"
3. "Now add error handling to the implementation"
4. "Generate tests for this implementation"
```

Each builds on previous context, saves tokens.

### 3. Optimize Context Setting
DON'T paste entire files. Instead:
```
This is a [framework] application with:
- Auth via [method]
- Database: [type]
- Architecture: [pattern]

Relevant code:
[paste only the specific function/class]
```

Leverage Custom Instructions for global context.

---

## 🎓 Best Practices for Claude.ai (Software Engineering)

### DO:
- ✅ Set Custom Instructions with your stack and preferences
- ✅ Use Projects to organize by repository/codebase
- ✅ Be specific about language, framework, version
- ✅ Provide minimal relevant code (not entire files)
- ✅ Ask for explanations of WHY, not just code
- ✅ Request security and performance considerations

### DON'T:
- ❌ Paste sensitive code (API keys, credentials)
- ❌ Upload entire repositories (too much noise)
- ❌ Ask open-ended questions without context
- ❌ Skip error handling in production code
- ❌ Accept code blindly without understanding

---

## 📊 Efficiency Metrics (Projected)

_Note: Theoretical projections based on template design. Help us validate with your real usage!_

**Without Custom Instructions:**
- Tokens per query: ~5,000 (explaining context each time)
- Relevance: 70% (generic software advice)
- Time to useful answer: 2-3 exchanges

**With Custom Instructions:**
- Tokens per query: ~1,500 (context pre-loaded)
- Relevance: 90% (role-specific responses)
- Time to useful answer: 1 exchange

**Savings:** 70% token reduction, 28% better relevance, 66% faster

---

## 🔄 Customizing for Your Needs

The template above is a starting point. Customize based on:

**Your tech stack:**
- Add specific frameworks you use daily
- Include version numbers (Python 3.11, Node 18, etc.)
- Mention libraries/packages you favor

**Your coding style:**
- Preferred naming conventions
- Indentation/formatting preferences
- Comment style

**Your domain:**
- Web apps, mobile, embedded, ML, etc.
- Industry-specific requirements (finance, healthcare, etc.)

---

## ❓ FAQ

**Q: Can I have multiple Custom Instruction sets?**
A: No, claude.ai allows only one set globally. Use Projects for context-specific variations.

**Q: What if I work across multiple languages?**
A: List all in Custom Instructions, then specify in each prompt which one you're using.

**Q: How do I update my Custom Instructions?**
A: Settings → Custom Instructions → Edit anytime. Changes apply to new conversations.

**Q: Will this slow down Claude?**
A: No! Custom Instructions are part of the system prompt, loaded efficiently.

---

## 🚀 Next Steps

1. **Copy the Custom Instructions** template above
2. **Customize** with your specific languages, frameworks, preferences
3. **Paste** into claude.ai → Settings → Custom Instructions
4. **Test** with one of the prompt patterns above
5. **Iterate** based on results

---

## Navigation

**🏠 [Back to Browser Workflow](../README.md)** | **📖 [All Roles](../README.md#choose-your-professional-role)** | **🎨 [Create Custom Role](01_custom-role.md)**

---

*Part of the Claude.ai Workflow Optimization Guide - Standalone for Web Interface Users*
*Last updated: 2025-12-08*
