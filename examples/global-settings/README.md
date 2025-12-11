# Global Settings Examples

Copy these to `~/.claude/settings.json` to apply configuration across all projects on your machine.

---

## git-approval-settings.json

**Full Protection** configuration that:
- ✅ Requires approval before git commits
- ✅ Blocks auto-execution of git push/merge/rebase
- ✅ Protects against destructive operations (reset, rm -rf)
- ✅ Prevents accidental .env file modifications
- ✅ Shows full plans before making changes

### Installation:

**Option 1: Use the wizard (Recommended)**
```bash
cd /path/to/claude-config-template
./scripts/setup-git-workflow.sh
# Choose option 1 (Full Protection)
```

**Option 2: Copy manually**
```bash
# Backup existing settings first
cp ~/.claude/settings.json ~/.claude/settings.json.backup

# Copy example settings
cp examples/global-settings/git-approval-settings.json ~/.claude/settings.json

# Restart Claude Code
```

**Option 3: Merge with existing settings**
```bash
# Edit your existing settings file
nano ~/.claude/settings.json

# Add the "permissions" section from git-approval-settings.json
```

### Behavior:

**Before:**
```
You: "Commit these changes"
Claude: *automatically commits without showing you first*
```

**After:**
```
You: "Commit these changes"
Claude: "Here's my drafted commit message:

'Add user authentication feature

- Implemented login/logout endpoints
- Added JWT token validation
- Created user session management

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>'

Files to be committed:
- src/auth/login.ts (new)
- src/auth/middleware.ts (modified)

Should I proceed with this commit?"

You: "Yes"
Claude: *commits after your approval*

Claude: "✅ Commit successful!

To push these changes, please run:
  git push origin main"
```

---

## Configuration Details

### Permission Mode: `plan`

Shows a complete plan before executing any changes. This includes:
- File modifications
- Git operations
- Command executions
- Configuration changes

You review the plan and approve/deny before anything happens.

### Never Auto-Approve Patterns:

These operations ALWAYS require manual approval, even in less strict permission modes:

**Git Operations:**
- `Bash(git commit*)` - All commit operations
- `Bash(git push*)` - All push operations
- `Bash(git merge*)` - All merge operations
- `Bash(git rebase*)` - All rebase operations
- `Bash(git reset --hard*)` - Hard resets only
- `Bash(git checkout -b*)` - Creating new branches

**Destructive Operations:**
- `Bash(rm -rf*)` - Recursive force deletion

**Sensitive Files:**
- `Write(**/.env*)` - Writing .env files
- `Edit(**/.env*)` - Editing .env files

### Sandbox Configuration:

The `excludedCommands` list allows these commands to run outside the sandbox:
- `git` - Required for commit approval workflow
- `docker` - Container operations
- `npm` - Package management
- `python`, `pytest`, `pip` - Python development

**Note:** Excluding from sandbox doesn't mean auto-execution. Commands in `neverAutoApprove` still require your approval.

---

## Other Configuration Options

If Full Protection feels too restrictive, see these alternatives:

### Commit-Only Protection (Faster)

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

**Use wizard:** `./scripts/setup-git-workflow.sh` → Choose option 2

**Best for:** Solo developers who trust Claude with file edits but want commit control

### Minimal Protection (Fastest)

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

**Use wizard:** `./scripts/setup-git-workflow.sh` → Choose option 3

**Best for:** Experienced users who want maximum speed with essential safety

---

## Troubleshooting

### "Settings not taking effect"

**Solution:** Restart Claude Code. Settings are only loaded on startup.

### "JSON syntax error"

**Solution:** Validate your settings file:
```bash
python -m json.tool ~/.claude/settings.json
```

Common errors:
- Trailing comma on last property
- Missing comma between properties
- Unquoted strings

### "Want different settings per project"

**Solution:** Create `.claude/settings.json` in your project root. Project settings override global settings.

Example:
```json
// Project: .claude/settings.json
{
  "permissions": {
    "defaultMode": "acceptEdits"  // Overrides global "plan" mode
  }
}
```

### "Need to restore old settings"

**Solution:** The wizard creates backups automatically:
```bash
cp ~/.claude/settings.json.backup ~/.claude/settings.json
```

---

## Related Documentation

- **Setup Wizard:** `../../scripts/setup-git-workflow.sh`
- **Git Approval Guide:** `../../01_global-setup/good-to-have/04_git-approval-workflow.md`
- **Git Push Workaround:** `../../01_global-setup/good-to-have/05_git-push-workaround.md`
- **Permission Modes:** `../../01_global-setup/must-have/03_permission-modes.md`
- **Security Guide:** `../../01_global-setup/nice-to-have/01_security-guide.md`

---

## Quick Start

**Recommended:** Just run the wizard and let it guide you:

```bash
./scripts/setup-git-workflow.sh
```

Claude can also help you choose! Just ask:
```
"Help me set up git commit approval"
```

---

[← Back to Examples](../) | [Setup Guide →](../../01_global-setup/good-to-have/04_git-approval-workflow.md)
