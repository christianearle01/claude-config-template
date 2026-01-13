# Terminal-First Setup for Claude Code

**Priority:** ⭐ Good-to-have
**Time:** 10-15 minutes
**Benefit:** 4x memory efficiency, enables parallel workflows

---

## Why Terminal-First?

**Boris Cherny's Insight:** The creator of Claude Code uses terminals exclusively, not IDEs like VS Code or Cursor.

### Memory Efficiency Comparison

**VS Code/Cursor (IDE-based):**
- Base memory: ~800MB
- Per extension: ~200MB
- 5 windows: ~4,000MB (4GB)

**Terminal-based:**
- Per terminal: ~50MB
- 20 terminals: ~1,000MB (1GB)

**Result: 4x memory efficiency enables higher concurrency**

---

## Before vs After

### Without Terminal Setup (VS Code)

```
❌ High memory usage (4GB for 5 windows)
❌ Single session workflow (serial work)
❌ Slow startup time (~10 seconds)
❌ Limited to 5-6 concurrent sessions
```

### With Terminal Setup

```
✅ Low memory usage (1GB for 20 terminals)
✅ Parallel session workflow (concurrent work)
✅ Fast startup time (<1 second)
✅ Can run 10-20+ concurrent sessions
```

**Productivity gain:** 3-4x faster for multi-feature work

---

## Recommended Terminal Tools

### Option 1: Ghostty (Boris's Choice) - **Recommended**

**Why Ghostty:**
- Ultra-fast (GPU-accelerated)
- Low memory footprint
- Native macOS/Linux
- Built for parallel sessions

**Install:**
```bash
# macOS (via Homebrew)
brew install ghostty

# Linux
# See: https://ghostty.org/docs/install
```

**Configuration:**
```bash
# Create config file
mkdir -p ~/.config/ghostty
cat > ~/.config/ghostty/config << 'EOF'
# Performance
font-size = 13
theme = tokyo-night

# Window management
window-padding-x = 8
window-padding-y = 8

# Shell integration
shell-integration-features = true
EOF
```

---

### Option 2: Warp (Modern, AI-powered)

**Why Warp:**
- AI-powered autocomplete
- Beautiful UI
- Great for beginners
- Built-in command palette

**Install:**
```bash
# macOS
brew install --cask warp

# Linux: Download from warp.dev
```

**Setup:**
- Launch Warp
- Sign in (optional but recommended)
- Enable AI features in Settings

---

### Option 3: iTerm2 (Classic, Stable)

**Why iTerm2:**
- Battle-tested
- Extensive customization
- tmux integration
- Stable and reliable

**Install:**
```bash
# macOS only
brew install --cask iterm2
```

**Recommended settings:**
- Preferences → Profiles → Window
  - Columns: 120, Rows: 40
- Preferences → Profiles → Terminal
  - Enable "Unlimited scrollback"

---

## Basic Terminal Setup

### 1. Install Claude Code CLI

```bash
# If not already installed
npm install -g @anthropic-ai/claude-code

# Verify installation
claude --version
```

### 2. Configure Shell Integration

**For Zsh (macOS default):**
```bash
# Add to ~/.zshrc
export CLAUDE_API_KEY="your-api-key-here"
export EDITOR="vim"  # or nano, code, etc.

# Optional: Add aliases
alias c="claude"
alias cc="claude chat"
alias cp="claude plan"
```

**For Bash:**
```bash
# Add to ~/.bashrc
export CLAUDE_API_KEY="your-api-key-here"
export EDITOR="vim"

# Reload
source ~/.bashrc
```

### 3. Test Basic Workflow

```bash
# Start Claude in current directory
claude chat

# Test a simple prompt
"Hello! Can you confirm you're working?"

# Exit
exit
```

---

## Split-Screen Setup

**Boris's recommended layout:**
```
┌─────────────┬─────────────┐
│             │             │
│   Claude    │  npm run    │
│   Terminal  │    dev      │
│             │  (logs)     │
│             │             │
└─────────────┴─────────────┘
```

### Using tmux (Terminal Multiplexer)

**Install tmux:**
```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux
```

**Basic tmux workflow:**
```bash
# Start new session
tmux new -s claude-dev

# Split vertically (left/right)
Ctrl-b %

# Navigate between panes
Ctrl-b ←  # Left pane
Ctrl-b →  # Right pane

# Left pane: Run Claude
claude chat

# Right pane: Run your dev server
npm run dev

# Detach from session (keeps running)
Ctrl-b d

# Reattach later
tmux attach -t claude-dev
```

**Quick tmux cheat sheet:**
```bash
Ctrl-b %     # Split vertical
Ctrl-b "     # Split horizontal
Ctrl-b o     # Switch panes
Ctrl-b x     # Close pane
Ctrl-b d     # Detach session
```

---

## Progressive Adoption Path

**Don't jump to 20 terminals on Day 1!** Follow this progression:

### Week 1: Single Terminal
- Get comfortable with basic Claude commands
- Learn your terminal tool's shortcuts
- Set up split-screen (Claude + logs)

### Week 2-3: Two Terminals
- Terminal 1: Feature development
- Terminal 2: Bug fixes or refactoring
- Practice switching between contexts

### Month 1: Three Terminals
- Terminal 1: Main feature work
- Terminal 2: Tests or documentation
- Terminal 3: Quick experiments or debugging

### Month 2+: Scale Up (Only if Needed)
- Add more terminals for parallel work
- Most developers never need more than 3-5
- 10+ terminals only for complex multi-feature projects

⚠️ **Warning:** More terminals ≠ more productivity. Start small, scale only when you hit limits.

---

## Common Layouts

### Layout 1: Development + Monitoring (Beginner)
```
┌─────────────┬─────────────┐
│   Claude    │  Dev Server │
│   (main)    │   (logs)    │
└─────────────┴─────────────┘
```

### Layout 2: Dual Development (Intermediate)
```
┌─────────────┬─────────────┐
│   Claude 1  │   Claude 2  │
│  (Feature)  │   (Tests)   │
└─────────────┴─────────────┘
```

### Layout 3: Triple Workflow (Advanced)
```
┌───────┬───────┬───────┐
│Claude1│Claude2│Claude3│
│Feature│ Bugs  │  Docs │
└───────┴───────┴───────┘
```

---

## Memory & Cost Awareness

### Memory Budget

**Before scaling up terminals, check your system:**
```bash
# macOS: Check available memory
vm_stat | grep "Pages free" | awk '{print $3 * 4096 / 1024 / 1024 " MB"}'

# Linux: Check free memory
free -h
```

**Rule of thumb:**
- Each terminal: ~50MB
- Each Claude session: ~100-200MB active
- Budget: 500MB per active terminal session

**System requirements for multi-terminal:**
- 8GB RAM: 3-5 terminals max
- 16GB RAM: 5-10 terminals comfortable
- 32GB RAM: 10-20 terminals possible

### API Cost Budget

**Important:** Parallel terminals = parallel API costs

**Cost scaling:**
- 1 terminal: ~$20/month (typical usage)
- 3 terminals: ~$60/month
- 5 terminals: ~$100/month
- 10 terminals: ~$200/month

**Budget wisely:**
- Track usage with `claude usage`
- Set billing alerts in Anthropic dashboard
- Use cheaper models (Haiku) for routine work

---

## Troubleshooting

### Terminal is slow or laggy

**Check:**
```bash
# See what's using memory
top -o MEM

# Close unused Claude sessions
ps aux | grep claude | grep -v grep
```

**Fix:**
- Close terminals you're not actively using
- Reduce scrollback buffer size
- Disable unnecessary terminal features

### Can't see terminal output clearly

**Adjust font size:**
- Ghostty: Edit ~/.config/ghostty/config
- Warp: Settings → Appearance → Font Size
- iTerm2: Preferences → Profiles → Text

**Recommended:**
- Font size: 12-14pt
- Font: "SF Mono", "Menlo", "Monaco", or "JetBrains Mono"
- Line height: 1.2-1.3

### Lost track of which terminal does what

**Solution 1: Name your terminals**
```bash
# In each terminal, set title
echo -e "\033]0;Claude - Feature Work\007"
```

**Solution 2: Use tmux with named windows**
```bash
# Create named windows
tmux new -s dev
Ctrl-b ,    # Rename window
# Enter: "Feature", "Tests", "Docs"
```

**Solution 3: Document in CLAUDE.md**
```markdown
## Terminal Layout
- Terminal 1 (left): Main feature development
- Terminal 2 (middle): Test writing
- Terminal 3 (right): Server logs (npm run dev)
```

---

## Next Steps

**After terminal setup:**

1. ✅ **Learn Plan Mode** (Shift+Tab twice)
   - See: `docs/01-fundamentals/02_skills-paradigm.md`

2. ✅ **Create /verify command**
   - See: `.claude/commands/verify.md`

3. ✅ **Try split-screen workflow**
   - One terminal: Claude
   - Other terminal: Your dev server

4. ✅ **Scale gradually**
   - Week 1: Single terminal
   - Month 1: 2-3 terminals
   - Only add more when you need them

---

## Related Guides

- **Parallel Terminals (Advanced):** `docs/02-optimization/06_parallel-terminals.md`
- **Split-Screen Setup:** `docs/02-optimization/07_split-screen-setup.md`
- **High-Concurrency (Expert):** `docs/03-advanced/09_high-concurrency-workflows.md`
- **Quick Reference:** `docs/00-start-here/09_quick-reference.md`

---

## Summary

**Key Takeaways:**

✅ Terminals are 4x more memory-efficient than IDEs
✅ Enables parallel workflows (3-4x productivity for multi-feature work)
✅ Start with 1 terminal, scale to 2-3 gradually
✅ Most developers never need more than 3-5 terminals
✅ Budget for API costs (5 terminals = 5x costs)

**Recommended tool:** Ghostty (Boris's choice) or Warp (beginner-friendly)

**Next action:** Set up split-screen with Claude + dev server logs

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.1
**Based on:** Boris Cherny's Claude Code workflow
