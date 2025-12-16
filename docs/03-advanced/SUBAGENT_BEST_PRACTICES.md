# Sub-Agent Best Practices

**Task-focused agents, not role-based agents**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Task tool (sub-agent spawning): Official Claude Code feature ✅ VALIDATED
- Claude Code Documentation: https://docs.claude.com

**Community Insights:**
Analysis from NotebookLLM covering three YouTube sources:
- "Vibe Coding vs AI Augmented Coding": https://www.youtube.com/watch?v=hwEgheORjjs
- "800+ Hours of Claude Code Experience": https://www.youtube.com/watch?v=Ffh9OeJ7yxw
- "Claude Code Agent Skills": https://www.youtube.com/watch?v=CEvIs9y1uog

**Note:** Insights are derived from cross-video analysis about what works vs. what doesn't in sub-agent design.

---

## The Core Principle: Tasks, Not Roles

### ❌ Bad: Role-Based Agents

```yaml
---
name: frontend-developer
description: Acts as a frontend developer
---
```

**Why it fails:**
- Too broad and vague
- Unclear what it actually does
- Poor results from Claude
- Doesn't focus on specific task

---

### ✅ Good: Task-Focused Agents

```yaml
---
name: react-component-optimizer
description: Optimizes React components for performance by identifying unnecessary re-renders
---
```

**Why it works:**
- Specific, clear task
- Measurable outcome
- Claude knows exactly what to do
- Focused expertise

---

## Sub-Agent Architecture

### How Sub-Agents Work

**Each sub-agent has:**
1. **Own context window** - Prevents context pollution
2. **Own system prompt** - Task-specific instructions
3. **Custom tool permissions** - Security (can restrict tools)
4. **Different model** - Can use Haiku for speed, Sonnet for quality

**Example spawn:**
```
Main conversation
    ↓
Spawns: code-reviewer (sub-agent)
    ↓
Sub-agent has fresh context
    ↓
Sub-agent completes task
    ↓
Returns results to main
```

---

## Task-Focused Examples

### Example 1: Code Review Agent

```yaml
---
name: code-reviewer
description: Reviews code for security, performance, and maintainability issues
allowed-tools: Read, Grep, Glob
---

# Code Reviewer

## Task
Review code changes for:
- Security vulnerabilities (SQL injection, XSS, exposed secrets)
- Performance issues (N+1 queries, memory leaks)
- Code quality (naming, structure, duplication)

## Process
1. Read changed files
2. Check against security checklist
3. Identify performance anti-patterns
4. Suggest specific improvements

## Output Format
- List of issues found
- Severity (critical, high, medium, low)
- Specific code location
- Suggested fix with code example
```

**Task:** Specific code review
**Not:** "Be a code reviewer" (too vague)

---

### Example 2: UI Testing Agent

```yaml
---
name: ui-tester
description: Tests UI components for accessibility and responsiveness
allowed-tools: Read, Playwright
---

# UI Tester

## Task
Test UI components for:
- WCAG accessibility compliance
- Responsive design (mobile, tablet, desktop)
- Keyboard navigation
- Screen reader compatibility

## Process
1. Open component in browser (Playwright)
2. Run accessibility checks
3. Test responsive breakpoints
4. Verify keyboard navigation
5. Generate test report

## Output Format
- Pass/fail for each criterion
- Screenshots of issues
- Specific WCAG violations
- Recommended fixes
```

**Task:** Specific UI testing
**Not:** "Be a QA engineer" (too broad)

---

### Example 3: Documentation Generator

```yaml
---
name: docs-generator
description: Generates API documentation from code comments and type signatures
allowed-tools: Read, Grep, Write
---

# Documentation Generator

## Task
Generate API docs from:
- JSDoc/TSDoc comments
- Type signatures
- Function parameters
- Return types

## Process
1. Read source files
2. Extract comments and types
3. Generate markdown documentation
4. Include usage examples
5. Create table of contents

## Output Format
- Markdown files in docs/ directory
- Organized by module
- Includes examples
- Searchable reference
```

**Task:** Specific documentation generation
**Not:** "Be a technical writer" (too vague)

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Role-Based Agents

```yaml
# ❌ DON'T DO THIS
---
name: backend-engineer
description: Acts as a backend software engineer
---
```

**Problem:** What does a "backend engineer" actually do? Too vague.

**Better:**
```yaml
# ✅ DO THIS INSTEAD
---
name: api-endpoint-generator
description: Generates REST API endpoints following OpenAPI spec
---
```

---

### Anti-Pattern 2: Multi-Purpose Agents

```yaml
# ❌ DON'T DO THIS
---
name: full-stack-agent
description: Handles frontend, backend, database, and DevOps tasks
---
```

**Problem:** Trying to do too much, results will be mediocre.

**Better:** Create multiple task-focused agents:
```yaml
# ✅ DO THIS INSTEAD
---
name: api-endpoint-generator
description: Generates backend API endpoints
---

---
name: react-component-builder
description: Creates React components from designs
---

---
name: database-schema-designer
description: Designs database schemas following normalization rules
---
```

---

### Anti-Pattern 3: Vague Descriptions

```yaml
# ❌ DON'T DO THIS
---
name: helper
description: Helps with coding tasks
---
```

**Problem:** Claude doesn't know what "helps" means.

**Better:**
```yaml
# ✅ DO THIS INSTEAD
---
name: error-debugger
description: Debugs runtime errors by analyzing stack traces and suggesting fixes
---
```

---

## Sub-Agent vs. Skill: When to Use What

### Use Sub-Agent When:
- ✅ One-off task automation
- ✅ Explicit invocation preferred
- ✅ Simple, stateless operation
- ✅ Task doesn't need supporting files

**Example:** code-reviewer sub-agent

---

### Use Skill When:
- ✅ Reusable expertise needed
- ✅ Complex workflows with multiple steps
- ✅ Team governance and standards
- ✅ Needs supporting files (scripts, examples)
- ✅ Automatic invocation desired

**Example:** code-review Skill with security-checklist.md, performance-patterns.md, examples/

---

## Tool Permissions (Security)

### Restrict Tools by Task

```yaml
---
name: safe-code-reader
description: Reads and analyzes code without making changes
allowed-tools: Read, Grep, Glob
---
```

**Why:** Agent can't accidentally write/delete files

---

### Full Tool Access (When Needed)

```yaml
---
name: feature-implementer
description: Implements complete features including code, tests, and docs
# No allowed-tools = access to all tools
---
```

**When:** Agent needs to create/modify files

---

## Model Selection

### Use Haiku for Simple Tasks

```yaml
---
name: file-finder
description: Finds files matching a pattern
model: haiku
---
```

**Why:** Fast, cheap, good enough for simple tasks

---

### Use Sonnet for Complex Tasks

```yaml
---
name: architecture-planner
description: Designs software architecture for complex systems
model: sonnet
---
```

**Why:** Better reasoning, worth the cost

---

### Use Opus Rarely

```yaml
---
name: critical-security-auditor
description: Deep security analysis for production systems
model: opus
---
```

**Why:** Highest quality, highest cost - only when necessary

---

## Real-World Sub-Agent Examples

### 1. Commit Message Generator

```yaml
---
name: commit-message-generator
description: Generates conventional commit messages from git diff
allowed-tools: Bash
model: haiku
---

# Task
Generate commit messages following Conventional Commits spec

# Process
1. Run git diff --staged
2. Analyze changes
3. Determine type (feat, fix, docs, refactor, etc.)
4. Write concise description
5. Format as: type(scope): description

# Example Output
feat(auth): add JWT token refresh logic
```

---

### 2. Test Case Generator

```yaml
---
name: test-case-generator
description: Generates unit tests for a given function
allowed-tools: Read, Write
model: sonnet
---

# Task
Generate comprehensive unit tests

# Process
1. Read function source code
2. Identify edge cases
3. Generate test cases covering:
   - Happy path
   - Edge cases
   - Error conditions
4. Write tests using project's test framework

# Output
Test file with 80%+ code coverage
```

---

### 3. Performance Analyzer

```yaml
---
name: performance-analyzer
description: Analyzes code for performance bottlenecks
allowed-tools: Read, Grep
model: sonnet
---

# Task
Identify performance issues

# Process
1. Read source files
2. Look for:
   - N+1 database queries
   - Unnecessary re-renders (React)
   - Memory leaks
   - Inefficient algorithms
3. Suggest optimizations

# Output
- List of issues with severity
- Code examples of problems
- Suggested fixes
```

---

## Best Practices

### 1. Specific Task Names

**Bad:** `helper`, `agent`, `assistant`
**Good:** `code-reviewer`, `test-generator`, `docs-builder`

---

### 2. Clear Descriptions

**Template:**
```
[Action] [Target] for/by [Purpose/Method]
```

**Examples:**
- "Reviews code for security vulnerabilities"
- "Generates API docs from JSDoc comments"
- "Optimizes database queries by identifying N+1 patterns"

---

### 3. Document in Project

```markdown
# CLAUDE.md

## Sub-Agents Available

- `code-reviewer` - Reviews code for issues
- `test-generator` - Creates unit tests
- `docs-builder` - Generates API documentation

Usage: Spawn via Task tool when needed
```

---

### 4. Test Before Sharing

```
1. Create sub-agent
2. Test with real tasks
3. Refine based on results
4. Document usage patterns
5. Share with team
```

---

## FAQ

**Q: Sub-agent vs. Skill - which should I use?**
A: Sub-agent for simple automation, Skill for reusable expertise with supporting files.

**Q: Can sub-agents spawn other sub-agents?**
A: Yes, but keep nesting shallow (2 levels max) to avoid confusion.

**Q: Should I create many sub-agents or few?**
A: Start with 2-3 task-focused agents. Add more only when you have a clear repeated need.

**Q: Can sub-agents access my CLAUDE.md?**
A: They can if you grant file read permissions. Otherwise they start with clean context.

**Q: How do I debug a sub-agent that's not working?**
A: Use Ctrl+O to see the prompt sent to the sub-agent. Refine the agent's instructions based on what you see.

---

## Summary

**Sub-Agent Best Practices Core Principles:**

1. **Tasks, not roles** - Specific tasks, not vague roles
2. **Clear descriptions** - What it does, not what it "is"
3. **Tool permissions** - Restrict to minimum needed
4. **Model selection** - Haiku for simple, Sonnet for complex
5. **Test and refine** - Iterate based on real usage

**The outcome:**
- ✅ Effective task automation
- ✅ Predictable results
- ✅ Cost-efficient (right model for task)
- ✅ Secure (restricted tools)

**Key quote:**
> *"Official docs say this but users emphasize it strongly. Prevents common mistake of role-based agents."*

**Examples of good task-focused agents:**
- code-reviewer (not "software engineer")
- test-generator (not "QA engineer")
- docs-builder (not "technical writer")
- api-endpoint-generator (not "backend developer")

---

**See also:**
- [Skills Paradigm](../01-fundamentals/SKILLS_PARADIGM.md) - When to use Skills vs. Agents
- [Advanced MCP Workflows](ADVANCED_MCP_WORKFLOWS.md) - Orchestrating sub-agents with MCPs
- [Custom Agents Guide](../../01_global-setup/03_nice-to-have/04_custom-agents.md) - How to create agents
