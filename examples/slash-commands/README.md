# Slash Commands Examples

**Purpose:** Example slash commands for workflow automation

**Based on:** Boris Cherny's (Claude Code creator) workflow patterns

---

## What Are Slash Commands?

**Slash commands** are custom commands you create for Claude Code to automate common workflows. They're markdown files placed in `.claude/commands/` that define multi-step operations.

**Example:**
- Instead of: `git status && git add . && git commit -m "message" && git push`
- You type: `/getit "message"`
- Claude executes all steps automatically

---

## Available Examples

### 1. `/getit` - Git Workflow Automation

**What it does:** Automates git add, commit, push workflow

**Time saved:** 2-3 minutes per commit

**Use when:** Making routine commits to feature branches

**See:** `getit.md`

---

### 2. `/testit` - Test Suite Runner

**What it does:** Auto-detects test framework, runs tests, analyzes failures

**Time saved:** 5-10 minutes per testing cycle

**Use when:** Running tests during development

**See:** `testit.md`

---

### 3. `/verify` - Post-Session Verification

**What it does:** Systematic checklist for security, efficiency, quality

**Time saved:** 10-15 minutes of manual review

**Use when:** Before committing code (end of session)

**See:** `../../.claude/commands/verify.md` (already created)

---

## How to Use These Examples

### Step 1: Read the Example

Open any example file (e.g., `getit.md`) and read:
- What it does
- How to create it
- Usage examples
- Troubleshooting

---

### Step 2: Create in Your Project

Copy the command template from the example to your project:

```bash
# Example: Creating /getit
mkdir -p .claude/commands
cp path/to/examples/slash-commands/getit.md .claude/commands/getit.md

# Or create manually following the template
```

---

### Step 3: Customize

Edit `.claude/commands/getit.md` for your workflow:

```markdown
# Example customization:
# Add branch protection
Before pushing, check current branch:
- If on `main`, ask for confirmation
- If on feature branch, push automatically
```

---

### Step 4: Test

```bash
# In Claude terminal
/getit "test commit"

# Claude will execute the command
```

---

## Creating Your Own Slash Commands

### Template Structure

```markdown
# Command Name - /commandname

When the user types `/commandname [args]`, do this:

1. Step 1 description
2. Step 2 description
3. Step 3 description

**Important notes:**
- Note 1
- Note 2

**Example:**
User: `/commandname arg1 arg2`

Execute:
\`\`\`bash
command --flag arg1 arg2
\`\`\`
```

---

### Example: Custom /deployit Command

Create `.claude/commands/deployit.md`:

```markdown
# Deploy to Staging - /deployit

When the user types `/deployit`, deploy to staging environment:

1. Run `npm run build` to build production assets
2. Check if build succeeded
3. Run `npm run deploy:staging` to deploy
4. Run `curl https://staging.example.com/health` to verify
5. Show deployment URL and status

**Important:**
- Only deploy if all tests pass (/testit first)
- Only deploy from main branch
- Show deployment logs

**Example:**
User: `/deployit`

Execute:
\`\`\`bash
npm run build
npm run deploy:staging
curl https://staging.example.com/health
\`\`\`

Show: "Deployed to https://staging.example.com"
```

---

## Command Ideas

### Development Workflow

- `/lint` - Run linter and auto-fix issues
- `/format` - Format code with prettier/black
- `/build` - Build project and report errors
- `/dev` - Start development server
- `/logs` - Show recent logs with filtering

### Testing & Quality

- `/coverage` - Run tests with coverage report
- `/e2e` - Run end-to-end tests
- `/benchmark` - Run performance benchmarks
- `/security` - Run security audit (npm audit, etc.)

### Git & Deployment

- `/pullrequest` - Create PR with auto-generated description
- `/release` - Create release with changelog
- `/rollback` - Rollback to previous version
- `/sync` - Sync branch with main

### Documentation

- `/docs` - Generate/update documentation
- `/changelog` - Update CHANGELOG.md with recent commits
- `/readme` - Update README.md with project changes

### Utilities

- `/clean` - Clean build artifacts, caches
- `/deps` - Check and update dependencies
- `/env` - Validate environment variables
- `/migrate` - Run database migrations

---

## Best Practices

### 1. Single Responsibility

**Good:**
```
/testit - Runs tests only
/format - Formats code only
```

**Bad:**
```
/everything - Tests, formats, builds, deploys (too much)
```

---

### 2. Clear Naming

**Good:**
```
/getit - Git workflow (get it done)
/testit - Run tests
/deployit - Deploy
```

**Bad:**
```
/x - Unclear what it does
/do - Too generic
```

---

### 3. Confirmation for Destructive Actions

**Good:**
```markdown
If deploying to production:
- Ask: "⚠️ Deploy to production? (yes/no)"
- Wait for confirmation
- Then deploy
```

**Bad:**
```markdown
Deploy immediately without asking
```

---

### 4. Error Handling

**Good:**
```markdown
If build fails:
- Show error message
- Suggest: "Run /testit to check tests"
- Don't continue to deployment
```

**Bad:**
```markdown
If build fails, deploy anyway
```

---

### 5. Feedback at Each Step

**Good:**
```markdown
1. Building... ✅ Build complete
2. Running tests... ✅ 52 passing
3. Deploying... ✅ Deployed to staging
```

**Bad:**
```markdown
(Silent execution, no feedback until end)
```

---

## Integration Patterns

### Chained Commands

**Pattern:** One command calls another

```markdown
# /shipit command
When user types `/shipit`:

1. Run `/testit` to ensure tests pass
2. If tests pass, run `/verify` to check quality
3. If verify passes, run `/getit` to commit
4. Show: "Ready for review!"
```

---

### Conditional Execution

**Pattern:** Different actions based on context

```markdown
# /deployit command
Check current branch:
- If main → Deploy to production (with confirmation)
- If staging → Deploy to staging (no confirmation)
- If feature → Error: "Cannot deploy from feature branch"
```

---

### Progressive Disclosure

**Pattern:** Start simple, add complexity over time

**Week 1:**
```markdown
/testit
- Just run tests
- Show pass/fail
```

**Week 2:**
```markdown
/testit
- Run tests
- Show pass/fail
- Analyze failures (new!)
```

**Week 3:**
```markdown
/testit
- Run tests
- Show pass/fail
- Analyze failures
- Suggest fixes (new!)
- Auto-fix with confirmation (new!)
```

---

## Troubleshooting

### "Command doesn't work"

**Check:**
1. File location: `.claude/commands/commandname.md` (correct path?)
2. File name: Must match command (getit.md for /getit)
3. Markdown format: Properly formatted?
4. Claude restart: Try restarting Claude session

---

### "Command does wrong thing"

**Solution:** Refine instructions in .md file

```markdown
# Before (ambiguous)
Run tests

# After (specific)
Run: npm test
Parse output for pass/fail counts
Show summary in format: "✅ X passing, ❌ Y failing"
```

---

### "Command is too slow"

**Solution:** Optimize steps

```markdown
# Before (slow)
1. Run full test suite
2. Run full lint check
3. Run full type check

# After (fast)
1. Run only changed files' tests
2. Skip lint (assume pre-commit hook handles it)
3. Skip types (assume editor shows type errors)
```

---

## Related Guides

- **Boris Cherny's Workflow:** `docs/00-start-here/09_quick-reference.md#boris-chernys-workflow`
- **Verify Command:** `.claude/commands/verify.md` (built-in example)
- **Terminal Setup:** `01_global-setup/02_good-to-have/04_terminal-setup.md`
- **Split-Screen:** `docs/02-optimization/07_split-screen-setup.md`

---

## Summary

**Key Takeaways:**

✅ **Slash commands = workflow automation** (multi-step operations in one command)
✅ **Examples provided:** /getit (git), /testit (tests), /verify (quality)
✅ **Easy to create:** Markdown file in `.claude/commands/`
✅ **Customizable:** Adapt to your workflow
✅ **Chainable:** Commands can call other commands

**Quick Start:**

1. Read examples (getit.md, testit.md)
2. Create `.claude/commands/getit.md` in your project
3. Copy template from example
4. Test with `/getit "test message"`
5. Customize for your needs

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.2
**Example Collection:** Part of Boris Cherny's workflow automation
