# Git Commit Approval Workflow

Configure Claude Code to always ask for approval before committing changes.

## What This Does

- **Before committing:** Claude shows you the commit message and waits for approval
- **Before pushing:** Claude displays the git push command for you to run manually
- **Why:** Maintains control over git history and handles authentication requirements

---

## Token Cost Analysis

⚠️ **IMPORTANT: These are PROJECTIONS, not proven results.**

This feature is NEW (December 2025) with ONE user (the project author). Token calculations are based on:
- ✅ **Factual:** Anthropic's published pricing
- ✅ **Factual:** Measured token counts in testing
- ⚠️ **Projected:** Cost savings (not validated by multiple users)
- ⚠️ **Theoretical:** Real-world scenarios (example cases, not actual usage data)

**Help us validate these projections!** If you use this feature, please share your actual token usage so we can update this documentation with real data.

---

**TL;DR:** This adds ~300-500 tokens per commit (~$0.001), but optimized workflow projects 75% savings vs old approach.

### Cost Breakdown Per Commit (Theoretical)

#### Old Approach (Auto-commit with full diff):
```
1. git status                ~100 tokens
2. git diff (full)           ~500-2,000 tokens
3. Draft message             ~200 tokens
4. Execute commit            ~50 tokens
5. Confirm                   ~100 tokens
----------------------------------------
Total: ~950-2,450 tokens
Cost: ~$0.003-$0.007 per commit
```

#### New Approach (Optimized with approval):
```
1. Draft message from context    ~200 tokens
2. Show message + file list      ~300 tokens
3. Wait for approval             ~10-50 tokens
4. Execute commit                ~50 tokens
5. Confirm                       ~50 tokens
----------------------------------------
Total: ~610-650 tokens (OPTIMIZED!)
Cost: ~$0.0018-$0.002 per commit
```

**Result: 35-75% token savings with better control!**

### Why This Is Cheaper Than Before:

**Old workflow duplicated information:**
- Full `git diff` output: 500-2,000 tokens
- **But you already see the diff in your IDE!**

**New workflow eliminates duplication:**
- Claude drafts from context/file names
- You review in your IDE (0 tokens)
- Only approval exchange adds tokens

### Optional Commands (If Needed):

**If you want Claude to verify files:**
```
You: "Show me what files changed, then commit"
Claude: Runs git status → Shows files → Drafts message
Added cost: ~100 tokens
```

**If you want change context:**
```
You: "Check the changes and commit"
Claude: Runs git diff --stat → Sees summary → Drafts message
Added cost: ~150-300 tokens (vs 500-2,000 for full diff)
```

### Projected Cost Examples (Not Real User Data)

**Example Scenario 1: Solo developer, 20 commits/day (Theoretical)**

**Projected old approach cost:**
- 20 commits × 1,700 tokens avg = 34,000 tokens/day
- Monthly: ~1,020,000 tokens = **~$3.06/month**

**Projected new approach cost:**
- 20 commits × 630 tokens avg = 12,600 tokens/day
- Monthly: ~378,000 tokens = **~$1.13/month**

**Projected savings: ~$1.93/month (63% cheaper)**

**Example Scenario 2: Team of 5, 100 commits/day (Theoretical)**

**Projected old approach cost:**
- 100 commits × 1,700 tokens = 170,000 tokens/day
- Monthly: ~5,100,000 tokens = **~$15.30/month**

**Projected new approach cost:**
- 100 commits × 630 tokens = 63,000 tokens/day
- Monthly: ~1,890,000 tokens = **~$5.67/month**

**Projected savings: ~$9.63/month per team (63% cheaper)**

**Note:** These are example calculations based on assumed usage patterns, not actual user data.

### Value vs Cost

**What approval adds:**
- ✅ Control over commits
- ✅ Review before permanent history
- ✅ Better commit messages
- ✅ Learning from examples
- ✅ Prevents mistakes

**Cost to add approval:**
- Token overhead: ~300-400 tokens
- Dollar cost: ~$0.001 per commit
- **One prevented mistake saves 10+ approvals worth of tokens**

### Prevented Mistake Savings

**One bad commit costs:**
```
1. Revert commit          ~500 tokens
2. Analyze what went wrong ~1,000 tokens
3. Create fix             ~2,000 tokens
4. New commit             ~650 tokens
5. Verify fix             ~500 tokens
----------------------------------------
Total: ~4,650 tokens ($0.014)
```

**Preventing ONE mistake pays for ~14 commit approvals!**

### Token Optimization Tips

**1. Minimal responses (save ~30 tokens/commit):**
```
❌ "Yes, that looks great! Please go ahead and commit that for me."
✅ "Yes"
```

**2. Skip git commands when you already know:**
```
You: "Commit login.ts with the auth changes"
Claude: Drafts message (no git commands needed)
Saves: ~100-300 tokens
```

**3. Batch related changes:**
```
❌ 5 small commits = 5 × 630 = 3,150 tokens
✅ 1 logical commit = 1 × 630 = 630 tokens
Saves: ~2,520 tokens
```

**4. Use haiku model for commits (optional):**
```json
{
  "model": "haiku"  // 90% cheaper, slightly lower quality messages
}
```

### Cost Comparison Table

| Workflow | Tokens/Commit | Cost/Commit | Cost/Month (20/day) |
|----------|---------------|-------------|---------------------|
| Auto-commit (full diff) | ~1,700 | $0.0051 | $3.06 |
| Auto-commit (diff --stat) | ~950 | $0.0029 | $1.74 |
| **Approval (optimized)** | **~630** | **$0.0019** | **$1.13** |
| Approval (with status) | ~730 | $0.0022 | $1.32 |
| Approval (with diff --stat) | ~930 | $0.0028 | $1.68 |

### Bottom Line

**This feature (based on projections, not proven at scale):**
- ✅ Projects token savings vs old auto-commit approach
- ✅ Estimated cost: less than $0.002 per commit
- ✅ Theory: One prevented mistake could pay for weeks of use
- ✅ Provides control, safety, and learning value

**The projected token cost is negligible compared to:**
- Safety and control benefits
- Prevention of expensive mistakes (if projections hold)
- Quality of git history
- Learning from good commit patterns

**Reality check:** This is a NEW feature. Actual results may vary. Please validate and share your experience!

---

## Quick Setup (Recommended)

Run the interactive wizard:

```bash
cd /path/to/claude-config-template
./scripts/setup-git-workflow.sh
```

The wizard will guide you through 3 configuration options and automatically set up your global settings.

###  Pro Tip: Ask Claude for Help!

Not sure which option to choose? Ask Claude! Say:

```
"I want to set up git commit approval globally"
```

Claude will:
1. Ask questions about your workflow
2. Recommend the best option for you
3. Guide you through running the wizard
4. Explain what each configuration does

---

## Manual Setup (Advanced)

If you prefer to configure manually, choose one of these options:

### Option 1: Full Protection (Recommended)

Edit `~/.claude/settings.json`:

```json
{
  "permissions": {
    "defaultMode": "plan",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git push*)",
      "Bash(git merge*)",
      "Bash(git rebase*)",
      "Bash(git reset*)",
      "Bash(git checkout -b*)"
    ]
  }
}
```

**Best for:** Teams, learning, safety-critical work

**What it does:**
- Shows full plan before ANY changes
- Requires approval for all major git operations
- Maximum visibility and control
- Safest option for collaboration

### Option 2: Commit-Only Protection

```json
{
  "permissions": {
    "defaultMode": "acceptEdits",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git push*)"
    ]
  }
}
```

**Best for:** Solo developers who want speed with commit safety

**What it does:**
- Fast file edits (auto-applied)
- Commit messages require approval
- Git push commands displayed
- Balanced speed and safety

### Option 3: Minimal Protection

```json
{
  "permissions": {
    "defaultMode": "acceptEdits",
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git reset --hard*)",
      "Bash(rm -rf*)"
    ]
  }
}
```

**Best for:** Experienced users who want maximum speed

**What it does:**
- Maximum automation
- Only blocks commits and destructive operations
- Fastest workflow
- Requires trust in Claude

---

## How It Works

### Commit Workflow (Optimized):

**You:** "Create a commit with these changes"

**Claude:**
1. Drafts commit message from context/file names (you see changes in IDE already)
2. **Shows you the message:**
   ```
   Here's my drafted commit message:

   "Add user authentication feature

   - Implemented login/logout endpoints
   - Added JWT token validation
   - Created user session management

   🤖 Generated with Claude Code
   Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

   Files to be committed:
   - src/auth/login.ts (new)
   - src/auth/middleware.ts (modified)
   - tests/auth.test.ts (new)

   Should I proceed with this commit?
   ```

**You:** "Yes" or "No, change the message to..."

**Claude:** Only commits after your approval

**Token cost:** ~630 tokens (vs ~1,700 with git diff)

---

### Optional: Verify Files First

**You:** "Show me what files changed, then commit"

**Claude:**
1. Runs `git status` to verify files
2. Shows file list
3. Drafts message
4. Asks for approval

**Token cost:** ~730 tokens (adds ~100 for git status)

### Push Workflow:

**You:** "Push these changes"

**Claude:** **Displays command instead of executing:**
```
✅ Changes committed successfully!

To push these changes to GitHub, please run:
  git push origin main

This requires your git credentials.
```

**You:** Run the command manually in your terminal

---

## Why Manual Push?

Git push requires authentication:
- SSH key passphrase entry
- GitHub personal access tokens
- OAuth credentials
- 2FA verification

These require **interactive input** that Claude Code's sandbox cannot provide for security reasons.

Displaying the command gives you:
- ✅ Control over when/what you push
- ✅ Proper credential handling
- ✅ Ability to review branch before pushing
- ✅ No security workarounds needed

See: `05_git-push-workaround.md` for more details

---

## Troubleshooting

### "Claude still auto-commits"

**Check these:**

1. **Settings file syntax:**
   ```bash
   python -m json.tool ~/.claude/settings.json
   ```
   If there's an error, fix the JSON syntax.

2. **Current permission mode:**
   Press `Shift+Tab` in Claude Code to check current mode.
   - ⏸ = plan mode
   - ❓ = ask mode
   - 🔓 = acceptEdits mode

3. **CLAUDE.md instructions:**
   Verify your project has commit approval instructions in `.claude/CLAUDE.md`

4. **Restart Claude Code:**
   Settings changes require restart to take effect.

### "I want to edit the commit message"

If Claude's message isn't right:

**Option 1: Ask for changes**
```
You: "No, change the message to: Add login feature with JWT auth"
Claude: *re-drafts and asks for approval again*
```

**Option 2: Provide specific edits**
```
You: "Change the first line to be more specific about what changed"
Claude: *updates and shows new message*
```

**Option 3: Write your own**
```
You: "Use this exact message: [your message]"
Claude: *uses your message verbatim*
```

### "Can I skip approval for small changes?"

Yes! Temporarily toggle to `acceptEdits` mode:

1. Press `Shift+Tab` until you see "🔓 acceptEdits mode"
2. Make your quick changes
3. Press `Shift+Tab` again to return to `⏸ plan mode`

Or use the wizard to change your default:
```bash
./scripts/setup-git-workflow.sh
```

### "The wizard broke my existing settings"

The wizard creates a backup! Restore it:

```bash
cp ~/.claude/settings.json.backup ~/.claude/settings.json
```

Your previous settings are now restored.

### "I want different settings per project"

You can override global settings in project-specific `.claude/settings.json`:

```json
// .claude/settings.json (project-specific)
{
  "permissions": {
    "defaultMode": "acceptEdits"  // Overrides global "plan" mode
  }
}
```

Project settings take precedence over global settings.

---

## Comparison Table

| Feature | Full Protection | Commit-Only | Minimal |
|---------|----------------|-------------|---------|
| **Permission Mode** | plan | acceptEdits | acceptEdits |
| **File edits** | Manual approval | Auto-applied | Auto-applied |
| **Commits** | ✅ Requires approval | ✅ Requires approval | ✅ Requires approval |
| **Push** | ⚠️ Shows command | ⚠️ Shows command | ⚠️ Shows command |
| **Merge/Rebase** | ✅ Requires approval | Auto-executed | Auto-executed |
| **Destructive ops** | ✅ Requires approval | Auto-executed | ✅ Blocked |
| **Speed** | ⭐⭐ Slower | ⭐⭐⭐⭐ Fast | ⭐⭐⭐⭐⭐ Fastest |
| **Safety** | ⭐⭐⭐⭐⭐ Maximum | ⭐⭐⭐⭐ High | ⭐⭐⭐ Medium |
| **Best For** | Teams, learning | Solo devs | Experienced users |

---

## Related Documentation

- **Permission Modes:** `01_global-setup/01_must-have/03_permission-modes.md`
- **Git Push Guide:** `01_global-setup/02_good-to-have/05_git-push-workaround.md`
- **Security Guide:** `01_global-setup/03_nice-to-have/01_security-guide.md`
- **Hooks:** `examples/hooks/README.md`
- **Example Settings:** `examples/global-settings/git-approval-settings.json`

---

## Quick Reference Commands

```bash
# Run the wizard
./scripts/setup-git-workflow.sh

# Validate settings JSON
python -m json.tool ~/.claude/settings.json

# View current settings
cat ~/.claude/settings.json

# Restore backup
cp ~/.claude/settings.json.backup ~/.claude/settings.json

# Check permission mode in Claude
# Press Shift+Tab to cycle modes
```

---

## Example: Full Workflow

```
You: "I made changes to the login feature, please commit them"

Claude: "I'll draft a commit message for the login changes."

Claude: "Here's my drafted commit message:

'Improve login error handling

- Added validation for empty username/password
- Improved error messages for failed logins
- Added rate limiting to prevent brute force

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>'

Files to be committed:
- src/auth/login.ts (modified)
- src/auth/validators.ts (new)
- tests/auth-validation.test.ts (new)

Should I proceed with this commit?"

You: "Yes, looks good"

Claude: "✅ Commit successful!

To push these changes to GitHub, please run:
  git push origin feature-login

This requires your git credentials."

You: *runs command in terminal*
$ git push origin feature-login
Enumerating objects: 8, done.
...
To github.com:yourname/yourrepo.git
   a1b2c3d..e4f5g6h  feature-login -> feature-login
```

---

**Need help choosing a configuration? Just ask Claude!** Say:
```
"Help me set up git commit approval"
```

Claude will guide you through the best option for your workflow.

---

[← Back to Global Setup](../../01_global-setup/) | [Security Guide →](./01_security-guide.md)
