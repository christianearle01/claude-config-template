# /getit - Git Workflow Automation

**Purpose:** Automate the complete git workflow (add, commit, push) in one command

**Priority:** ⭐ Good-to-have (saves 2-3 minutes per commit)
**Benefit:** Reduces multi-step git operations to one command

---

## What It Does

`/getit` automates this workflow:

```bash
# Without /getit (6 commands)
git status
git add .
git commit -m "your message"
git push
git status
# Check remote for confirmation
```

```bash
# With /getit (1 command)
/getit "your commit message"
```

---

## How to Create This Command

### Step 1: Create Command File

Create `.claude/commands/getit.md` in your project:

```markdown
# Git Workflow Automation - /getit

When the user types `/getit [message]`, perform the complete git workflow:

1. Run `git status` to show current state
2. Run `git add .` to stage all changes
3. Run `git commit -m "[message]" with Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>`
4. Run `git push` to push to remote
5. Run `git status` to confirm push

**Important:**
- If no message provided, draft a commit message based on changes
- If git push fails, explain credentials setup (first-time only)
- Always show git status before and after

**Example:**
User: `/getit "Add user authentication"`

Execute:
\`\`\`bash
git status
git add .
git commit -m "Add user authentication

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git push
git status
\`\`\`
```

---

### Step 2: Test the Command

```bash
# In Claude terminal
/getit "Test commit message"

# Claude will execute all git commands automatically
```

---

## Usage Examples

### Example 1: Simple Commit

**User:**
```
/getit "Fix login bug"
```

**Claude executes:**
```bash
$ git status
On branch main
Changes not staged for commit:
  modified:   src/auth/login.js

$ git add .

$ git commit -m "Fix login bug

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
[main a1b2c3d] Fix login bug
 1 file changed, 5 insertions(+), 2 deletions(-)

$ git push
Enumerating objects: 5, done.
To github.com:user/repo.git
   d4e5f6g..a1b2c3d  main -> main

$ git status
On branch main
Your branch is up to date with 'origin/main'.
nothing to commit, working tree clean
```

---

### Example 2: No Message (Auto-generate)

**User:**
```
/getit
```

**Claude:**
```
I see you've modified:
- src/auth/login.js (fixed validation)
- src/auth/login.test.js (added tests)

Suggested commit message:
"Add validation and tests for login function"

Should I proceed with this message? (yes/no)
```

**User:**
```
yes
```

**Claude executes git workflow with drafted message.**

---

### Example 3: First-Time Push (Credentials)

**User:**
```
/getit "Initial commit"
```

**Claude executes, push fails:**
```bash
$ git push
fatal: could not read Username for 'https://github.com': terminal prompts disabled
```

**Claude explains:**
```
⚠️ First-time git push detected.

You need to set up credentials:

Option 1: SSH (Recommended)
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ cat ~/.ssh/id_ed25519.pub
# Add this key to GitHub: Settings → SSH Keys

Option 2: Personal Access Token
1. GitHub → Settings → Developer Settings → Personal Access Tokens
2. Generate token with 'repo' scope
3. Use token as password when pushing

After setup, run: /getit "Initial commit" again
```

---

## Advanced Usage

### Add Branch Checking

Modify `.claude/commands/getit.md` to check branch:

```markdown
Before pushing, check current branch:
- If on `main` or `master`, ask for confirmation: "⚠️ Pushing to main. Continue? (yes/no)"
- If on feature branch, push without confirmation
```

---

### Add Pre-commit Hooks

```markdown
After staging, run pre-commit hooks:
\`\`\`bash
npm run lint   # If package.json has lint script
npm test       # If package.json has test script
\`\`\`

If hooks fail, ask: "Hooks failed. Force commit anyway? (yes/no)"
```

---

### Add Commit Message Validation

```markdown
Validate commit message follows Conventional Commits:
- feat: new feature
- fix: bug fix
- docs: documentation
- test: tests

If invalid format, suggest correction.
```

---

## Limitations

**Security Considerations:**

❌ **Don't use /getit for:**
- Committing sensitive files (.env, credentials)
- Pushing to main without review
- Large binary files
- Generated code without review

✅ **Safe to use for:**
- Feature branches
- Small incremental changes
- Well-reviewed code
- Documentation updates

---

## Integration with Other Workflows

### /getit + /verify

**Pattern: Verify before commit**

```
1. Make changes
2. /verify (check security, efficiency, tests)
3. Fix any issues found
4. /getit "commit message"
```

**Benefit:** Ensure quality before committing

---

### /getit + Plan Mode

**Pattern: Plan → Implement → Commit**

```
1. Shift+Tab Shift+Tab (Plan Mode)
2. Implement approved plan
3. /getit "Implement [feature] as planned"
```

**Benefit:** Commit message references approved plan

---

## Related Commands

- **`/verify`** - Post-session verification (`.claude/commands/verify.md`)
- **`/testit`** - Run test suite (see `examples/slash-commands/testit.md`)

---

## Troubleshooting

### "git push fails every time"

**Solution:** Check remote tracking

```bash
# Check if branch tracks remote
git branch -vv

# If no remote tracking, set it
git push -u origin main
```

---

### "/getit commits files I don't want"

**Solution:** Use .gitignore

```bash
# Add to .gitignore
node_modules/
.env
*.log
.DS_Store
```

Then `/getit` will skip these files automatically.

---

### "Commit messages are too generic"

**Solution:** Modify `.claude/commands/getit.md` to analyze changes:

```markdown
Before drafting commit message:
1. Run `git diff --cached` to see staged changes
2. Analyze what changed (new feature, bug fix, refactor)
3. Draft specific message based on actual changes
```

---

## Alternative: Git Aliases

If you prefer native git over slash commands:

```bash
# Add to ~/.gitconfig
[alias]
    getit = "!f() { git add . && git commit -m \"$1\" && git push; }; f"

# Usage
git getit "commit message"
```

**Trade-off:**
- ✅ Works outside Claude
- ❌ No AI assistance
- ❌ No error explanations

---

## Success Metrics

### How to Know It's Working

**Week 1:**
- ✅ Using `/getit` for routine commits
- ✅ Saving 2-3 minutes per commit
- ✅ No longer manually running git commands

**Week 2+:**
- ✅ Muscle memory for `/getit`
- ✅ Commit frequency increased (easier = more frequent)
- ✅ Git workflow feels effortless

---

## Summary

**Key Takeaways:**

✅ **One command:** Replaces 6 git commands
✅ **Time savings:** 2-3 minutes per commit
✅ **Error handling:** Claude explains issues
✅ **Safe:** Still shows what's being committed

**Recommended Setup:**

1. Create `.claude/commands/getit.md` (copy template above)
2. Test with `/getit "test message"`
3. Customize for your workflow
4. Use for routine commits (not critical deployments)

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.2
**Example Command:** Part of Boris Cherny's workflow automation
