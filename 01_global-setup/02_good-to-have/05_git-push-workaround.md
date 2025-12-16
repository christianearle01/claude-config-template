# Git Push Workaround Guide

Why Claude Code displays git push commands instead of executing them, and how to handle it.

---

## The Challenge

Git push requires authentication:
- 🔑 SSH key passphrase entry
- 🎫 GitHub personal access tokens
- 🔐 OAuth credentials
- 📱 2FA verification

These require **interactive input** that Claude Code's sandbox cannot provide for security reasons.

---

## The Solution

Claude will **display the command** for you to run manually:

```bash
# Claude shows:
✅ Changes committed successfully!

To push to GitHub, run:
  git push origin feature-branch

# You run it in your terminal:
$ git push origin feature-branch
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 1.25 KiB | 1.25 MiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To github.com:yourname/yourrepo.git
   a1b2c3d..e4f5g6h  feature-branch -> feature-branch
```

This approach:
- ✅ Respects security boundaries
- ✅ Gives you control over authentication
- ✅ Allows review before pushing
- ✅ No configuration workarounds needed

---

## Workflow Examples

### Standard Push

**You:** "Commit these changes and push to GitHub"

**Claude:**
1. ✅ Shows commit message for approval
2. ✅ After approval, commits the changes
3. **Displays:**
   ```
   ✅ Committed successfully!

   To push these changes, please run:
     git push origin main

   This requires your git credentials.
   ```

**You:** Run the command in your terminal

### Force Push (Dangerous)

**You:** "Force push to main"

**Claude:**
```
⚠️  WARNING: Force push to main branch requested.

This will overwrite remote history and can cause data loss for collaborators.

If you're certain, run:
  git push --force origin main

Recommended safer alternative:
  git push --force-with-lease origin main

The --force-with-lease option only succeeds if the remote branch hasn't
changed since your last fetch, preventing accidental overwrites.
```

### First-Time Push (New Branch)

**You:** "Push this new feature branch"

**Claude:**
```
✅ Branch 'feature-login' created and committed.

To push this new branch to GitHub, run:
  git push -u origin feature-login

The -u flag (--set-upstream) sets up tracking so future pushes
can use just 'git push' without specifying the branch.
```

### Push with Tags

**You:** "Push changes and tags"

**Claude:**
```
✅ Changes committed successfully!

To push changes and tags, run these commands:
  git push origin main
  git push --tags

Or push both at once:
  git push origin main --tags
```

---

## Alternative: Git Aliases

Set up git aliases for common push operations to save typing:

### In your `~/.gitconfig`:

```ini
[alias]
    # Push current branch
    p = "!git push origin $(git branch --show-current)"

    # Force push with lease (safer)
    pf = "!git push --force-with-lease origin $(git branch --show-current)"

    # Push tags
    pt = push --tags

    # Push and set upstream
    pu = "!git push -u origin $(git branch --show-current)"
```

### Or in your `~/.zshrc` / `~/.bashrc`:

```bash
# Git push aliases
alias gp='git push origin $(git branch --show-current)'
alias gpf='git push --force-with-lease origin $(git branch --show-current)'
alias gpt='git push --tags'
alias gpu='git push -u origin $(git branch --show-current)'
```

**Then just use:**
```bash
$ gp          # Push current branch
$ gpf         # Force push with lease
$ gpt         # Push tags
$ gpu         # Push with upstream
```

---

## Why Not Use Hooks?

We considered using PreToolUse hooks to intercept git push, but:

**❌ Hooks can't solve the authentication problem**
- Still requires interactive credential input
- Would just move the problem, not solve it

**❌ Would add complexity without solving root issue**
- More code to maintain
- More points of failure
- Still needs manual intervention

**✅ Displaying commands is simpler and more transparent**
- User sees exactly what needs to run
- No hidden abstractions
- Easy to understand and debug

---

## When Will This Change?

This is a **sandbox security limitation by design**. Possible future options:

### Option 1: Git Credential Helper Integration
Claude Code could integrate with system credential helpers to access stored credentials securely.

**Status:** Would require Claude Code core changes

### Option 2: External Terminal Execution
Claude Code could launch commands in user's external terminal where credentials are available.

**Status:** Feature request - not currently available

### Option 3: User Disables Sandbox (Not Recommended)
Users can disable sandbox for git, but this has security trade-offs.

**Status:** Available but not recommended (see below)

---

## Disabling Sandbox (Not Recommended)

⚠️ **Warning:** This approach has significant risks. Only use if you fully understand the implications.

### Configuration:

```json
// ~/.claude/settings.json
{
  "sandbox": {
    "enabled": true,
    "excludedCommands": ["git"]  // ⚠️ Security risk
  }
}
```

### Risks:

❌ **Claude could accidentally push to wrong branch**
- Typos in branch names
- Confusion between branches
- No review step before push

❌ **No protection against force push mistakes**
- Could overwrite important history
- Could affect collaborators
- Hard to undo

❌ **Authentication still requires workarounds**
- SSH keys need to be unlocked
- HTTPS tokens need to be cached
- Credentials need to be available

❌ **Less visibility into git operations**
- Commands happen in background
- Harder to catch errors
- No chance to review before execution

### Recommendation:

**Keep sandbox enabled.** The small inconvenience of running `git push` manually is worth the safety and transparency it provides.

---

## Comparison: Manual vs Automatic Push

| Aspect | Manual Push (Recommended) | Auto Push (Sandbox Disabled) |
|--------|--------------------------|------------------------------|
| **Security** | ✅ Secure | ⚠️ Risk of mistakes |
| **Control** | ✅ Full control | ❌ Automated |
| **Visibility** | ✅ Clear commands | ⚠️ Background execution |
| **Authentication** | ✅ Native git auth | ⚠️ Requires setup |
| **Accidental pushes** | ✅ Impossible | ❌ Possible |
| **Force push safety** | ✅ You review first | ❌ Auto-executed |
| **Setup required** | ✅ None | ⚠️ Disable sandbox |
| **Recommended** | ✅ Yes | ❌ No |

---

## Common Questions

### Q: Can Claude push to a different branch than I asked?

**A:** No. Claude shows you the exact command with the exact branch name. You execute it yourself, so you can verify the branch before pushing.

### Q: What if I'm pushing sensitive code?

**A:** Manual push is better! You can:
- Review the branch name
- Double-check you're on the right remote
- Verify you're not pushing to public accidentally
- Cancel if anything looks wrong

### Q: Can I automate this with a script?

**A:** Yes, but be careful:
```bash
# Example: Auto-push current branch after commits
git config --global alias.commit-and-push '!git commit "$@" && git push origin $(git branch --show-current)'

# Use with:
git commit-and-push -m "My message"
```

But this removes the safety of reviewing commits before pushing.

### Q: Why doesn't git credential helper work?

**A:** Credential helpers work fine! The issue isn't credentials - it's that Claude's sandbox can't execute the push command at all due to security restrictions. When you run the command yourself, your credential helper works normally.

### Q: Can I use GitHub CLI instead?

**A:** Yes! `gh` commands work the same way:
```
Claude shows:
  gh pr create --title "My PR" --body "Description"

You run it:
  $ gh pr create --title "My PR" --body "Description"
```

---

## Best Practices

### 1. Review Before Pushing

Always read the command Claude shows before running it:
- ✅ Branch name is correct
- ✅ Remote name is correct (usually `origin`)
- ✅ No typos or unexpected flags

### 2. Use Aliases for Speed

Set up aliases (see above) to reduce typing while maintaining control.

### 3. Don't Skip Commit Reviews

Even though you need to push manually, don't skip the commit approval step. Review commit messages before they enter history.

### 4. Use Force-With-Lease Instead of Force

If you need to force push:
```bash
# ❌ Dangerous
git push --force origin main

# ✅ Safer
git push --force-with-lease origin main
```

`--force-with-lease` only succeeds if no one else has pushed to the branch since your last fetch.

### 5. Keep Credentials Cached

Configure git to remember credentials temporarily:
```bash
# Cache credentials for 1 hour
git config --global credential.helper 'cache --timeout=3600'

# Or use system keychain (macOS)
git config --global credential.helper osxkeychain
```

---

## Troubleshooting

### "Permission denied (publickey)"

**Problem:** SSH key not configured or not loaded

**Solution:**
```bash
# Check if SSH key is loaded
ssh-add -l

# Add your SSH key
ssh-add ~/.ssh/id_ed25519

# Or add permanently to config
ssh-add --apple-use-keychain ~/.ssh/id_ed25519  # macOS

# Test GitHub connection
ssh -T git@github.com
```

### "Authentication failed"

**Problem:** HTTPS credentials not configured

**Solution:**
```bash
# Use GitHub CLI to authenticate (easiest)
gh auth login

# Or create a personal access token
# Settings → Developer settings → Personal access tokens
# Then use it as password when prompted
```

### "fatal: The current branch has no upstream branch"

**Problem:** New branch not tracking remote

**Solution:**
```bash
# Use -u flag to set upstream
git push -u origin branch-name

# Future pushes can omit branch name
git push
```

---

## Related Documentation

- **Git Approval Workflow:** `04_git-approval-workflow.md`
- **Security Guide:** `01_security-guide.md`
- **Permission Modes:** `../../01_must-have/03_permission-modes.md`
- **Sandbox Configuration:** `../../.claude/settings-explained.json`

---

## Summary

**Why manual push?**
- Security: Sandbox can't access credentials
- Safety: You review before pushing
- Transparency: Clear what's happening

**How to make it easier?**
- Use git aliases
- Cache credentials
- Review commands Claude shows

**Should I disable sandbox?**
- No - risks outweigh benefits
- Manual push is safer and clearer

---

**Remember:** The extra 2 seconds to run `git push` manually is a small price for the safety and control it provides.

---

[← Git Approval Workflow](./04_git-approval-workflow.md) | [Security Guide →](./01_security-guide.md)
