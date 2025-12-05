# Claude Code Optimization Guide

## Quick Wins Checklist
- [ ] Using parallel tool calls when operations are independent
- [ ] Reading files before editing them
- [ ] Using specialized tools (Read/Edit/Grep) instead of bash commands
- [ ] Providing specific context in prompts instead of vague requests
- [ ] Breaking large tasks into todos with TodoWrite
- [ ] Using Task tool for complex exploration instead of manual searching

## 1. Tool Efficiency Maximization

### Parallel Execution
**DO**: Call multiple independent tools in ONE message
```
✓ Read 3 files in parallel if all needed
✓ Run git status, git diff, git log in parallel
✓ Search multiple patterns simultaneously
```

**DON'T**: Make sequential calls when parallel would work
```
✗ Read file 1, wait, read file 2, wait, read file 3
✗ Run git status, wait, run git diff
```

### Tool Selection
- **File reading**: Use `Read` (not `cat` or `bash`)
- **File searching**: Use `Glob` for patterns (not `find` or `ls`)
- **Content searching**: Use `Grep` (not `bash grep`)
- **File editing**: Use `Edit` for exact replacements (not `sed`)
- **Complex exploration**: Use `Task` with Explore agent (not manual Grep/Glob loops)

### When to Use Task Tool
- Searching for something that might take multiple attempts
- Exploring unfamiliar codebases
- Complex analysis requiring multiple file reads
- Research that doesn't have a specific target file

## 2. Prompt Crafting Excellence

### The 5 Golden Rules
1. **Be Specific**: "Fix the validation in LoginForm.tsx line 45" vs "fix the login"
2. **Provide Context**: Share error messages, file paths, relevant code
3. **State Constraints**: "Don't modify tests" or "Keep existing API structure"
4. **Show Examples**: "Like how we did it in UserForm.tsx"
5. **Define Success**: "Should validate email format and show error below field"

### Effective Prompt Patterns
**Vague**: "Make the app faster"
**Optimized**: "The dashboard loads in 3s, should be <1s. Profile shows ProductList re-renders 50+ times. Optimize using React.memo and useMemo."

**Vague**: "Add a feature for users"
**Optimized**: "Add email notification toggle in Settings page (settings/profile.tsx). Store in user preferences table. Use existing NotificationService pattern from app/services/."

### Context Loading
- Reference specific files: "Looking at app/leadprosper_client.py..."
- Include error messages in full
- Mention relevant patterns: "Using the same pattern as QuoteWizard integration..."

## 3. Project Setup Optimization

### CLAUDE.md Best Practices
Your current file is good! Consider adding:
- **Critical Paths**: Files that change frequently
- **Gotchas**: Common mistakes or edge cases
- **Decision Log**: Why certain approaches were chosen
- **Performance Notes**: Known bottlenecks or optimization opportunities

### Slash Commands to Consider
Create commands for repeated tasks:
- `/test-integration [vendor]` - Run vendor integration tests
- `/check-mappings [vendor]` - Validate CSV field mappings
- `/deploy-checklist` - Pre-deployment verification steps
- `/new-vendor [name]` - Scaffold new vendor integration

### Hooks Opportunities
- **pre-commit**: Check for sensitive data in lead_logs.txt
- **post-tool**: Remind about testing after API changes
- **user-prompt-submit**: Expand abbreviations or add context

### MCP Servers
Consider installing:
- Database MCP for direct DB queries
- HTTP testing MCP for API endpoint testing
- File watcher MCP for monitoring changes

## 4. Workflow Optimization

### Task Planning
- Use `TodoWrite` for tasks with 3+ steps
- Break down complex features into concrete steps
- Mark todos as in_progress BEFORE starting work
- Complete todos IMMEDIATELY after finishing

### Git Workflow
- Use parallel bash calls for git commands:
  ```
  git status && git diff && git log -5 (in one call)
  ```
- Read changes before committing
- Follow existing commit message style
- Don't commit commented-out code or logs with real data

### Testing Workflow
1. Make changes
2. Run specific tests (don't run full suite if unnecessary)
3. Fix issues immediately
4. Verify in production-like environment

### Agent Coordination
- Use Explore agent for "where is..." questions
- Use Plan agent for architectural decisions
- Don't re-read large CSV files (already in context)
- Reference existing patterns (LeadProsper as template)

## Current Project-Specific Optimizations

### Your Insurance Lead Platform
1. **Vendor Integration Pattern**: Always reference `app/leadprosper_client.py` as template
2. **Form Mappings**: CSV files already loaded - don't re-parse
3. **Testing**: Use `app/test_leadprosper.py` pattern for new vendors
4. **Security**: Double-check lead_logs.txt before commits

### Quick Command Reference
```bash
# Efficient git workflow
git status && git diff && git log --oneline -5

# Test specific integration
python app/test_leadprosper.py

# Check for sensitive data
grep -r "real_email\|real_phone" lead_logs.txt
```

## Proactive Optimization Triggers

I'll suggest optimizations when I notice:
- Sequential tool calls that could be parallel
- Bash commands instead of specialized tools
- Vague prompts that could be more specific
- Missing context that would improve results
- Opportunities to use slash commands or hooks
- TodoWrite would help track progress
- Task tool would be more efficient than manual search
- Project setup could be enhanced

## How to Use This Guide
1. **Before starting work**: Skim relevant sections
2. **During conversations**: I'll reference specific sections when relevant
3. **Weekly**: Review checklist and add new patterns you've discovered
4. **When stuck**: Check if prompt crafting tips would help

---
*Last updated: 2025-12-04*
*This guide evolves with your project - update it as you discover new optimizations!*
