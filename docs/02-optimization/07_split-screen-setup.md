# Split-Screen Setup for Claude Code

**Priority:** ⭐ Good-to-have (All users, Week 1+)
**Time:** 15-30 minutes
**Benefit:** Real-time feedback, reduced context switching

---

## What is Split-Screen Setup?

**Split-screen** means dividing your terminal into multiple panes, allowing you to see Claude Code and your development output (logs, tests, builds) simultaneously.

**Key Benefit:** Real-time feedback loop without switching windows.

---

## Before vs After

### Without Split-Screen

```
Claude Terminal           npm run dev Terminal
┌─────────────┐          ┌─────────────┐
│  Ask Claude │          │   Server    │
│  Get answer │          │   Logs      │
│  Switch → → → → → → → →│   (hidden)  │
│  Check logs │          │             │
│  Switch ← ← ← ← ← ← ← ←│             │
│  Ask Claude │          │             │
└─────────────┘          └─────────────┘

Context switches: 6+ per session
Time lost: 30-60 seconds per switch
```

### With Split-Screen

```
┌─────────────┬─────────────┐
│   Claude    │  npm run    │
│             │    dev      │
│  Ask Q      │             │
│  Get answer │  [log] ...  │
│  See error  │  [ERROR]    │
│  Fix it     │  [SUCCESS]  │
│             │             │
└─────────────┴─────────────┘

Context switches: 0
Time lost: 0 seconds
Visual: Instant feedback
```

---

## Boris Cherny's Recommended Layout

**Creator of Claude Code uses:**

```
┌──────────────────────┬──────────────────────┐
│                      │                      │
│    Claude Terminal   │   Dev Server Logs   │
│                      │                      │
│  • Code generation   │  • npm run dev      │
│  • Questions         │  • pytest --watch   │
│  • Plan mode         │  • cargo run        │
│  • /verify           │  • Real-time errors │
│                      │                      │
└──────────────────────┴──────────────────────┘
```

**Why this works:**
- Left side: Active thinking (Claude)
- Right side: Passive monitoring (logs)
- No window switching
- Instant error visibility

---

## Tool Comparison

### Option 1: tmux (Most Popular)

**Pros:**
- Works everywhere (macOS, Linux, SSH)
- Extremely stable
- Detachable sessions (survives disconnects)
- Highly customizable

**Cons:**
- Learning curve for shortcuts
- Default keybindings can conflict

**Best for:** Professional developers, remote work

---

### Option 2: screen (Older, Simpler)

**Pros:**
- Pre-installed on most systems
- Simpler than tmux
- Stable and reliable

**Cons:**
- Less feature-rich than tmux
- Fewer active users (smaller community)

**Best for:** Quick SSH sessions, minimal setup

---

### Option 3: Native Terminal (iTerm2, Warp, Ghostty)

**Pros:**
- No additional software needed
- Better mouse support
- Native UI integration

**Cons:**
- Panes don't persist across restarts
- No detachable sessions

**Best for:** Local development, beginners

---

## Quick Start: tmux

### Installation

```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux

# Fedora
sudo dnf install tmux

# Verify installation
tmux -V
```

---

### Basic Split-Screen Workflow

```bash
# 1. Start new tmux session
tmux new -s claude-dev

# You're now inside tmux!

# 2. Split vertically (left/right)
Ctrl-b %

# 3. Navigate to right pane
Ctrl-b →

# 4. Start your dev server
npm run dev
# or: pytest --watch
# or: cargo run

# 5. Navigate back to left pane
Ctrl-b ←

# 6. Start Claude
claude chat

# Now you have Claude on left, logs on right!
```

---

### Essential tmux Shortcuts

**Prefix key:** `Ctrl-b` (press this before every command)

#### Pane Management
```
Ctrl-b %     Split vertically (left/right)
Ctrl-b "     Split horizontally (top/bottom)
Ctrl-b ←     Go to left pane
Ctrl-b →     Go to right pane
Ctrl-b ↑     Go to upper pane
Ctrl-b ↓     Go to lower pane
Ctrl-b o     Cycle through panes
Ctrl-b x     Close current pane (confirm with 'y')
Ctrl-b z     Zoom pane (toggle fullscreen)
```

#### Session Management
```
Ctrl-b d     Detach from session (keeps running)
Ctrl-b ?     Show all keybindings (quit with 'q')
```

#### Useful Commands
```bash
tmux ls                    # List all sessions
tmux attach -t claude-dev  # Reattach to session
tmux kill-session -t name  # Kill specific session
```

---

## Quick Start: screen

### Installation

```bash
# Usually pre-installed, but if not:

# macOS
brew install screen

# Ubuntu/Debian
sudo apt install screen

# Verify
screen -v
```

---

### Basic Split-Screen Workflow

```bash
# 1. Start new screen session
screen -S claude-dev

# 2. Split vertically (left/right)
Ctrl-a |

# 3. Navigate to right pane
Ctrl-a Tab

# 4. Start your dev server
npm run dev

# 5. Navigate back to left pane
Ctrl-a Tab

# 6. Start Claude
claude chat
```

---

### Essential screen Shortcuts

**Prefix key:** `Ctrl-a` (press this before every command)

```
Ctrl-a |     Split vertically
Ctrl-a S     Split horizontally
Ctrl-a Tab   Cycle through panes
Ctrl-a X     Close current pane
Ctrl-a d     Detach from session
Ctrl-a ?     Show help (quit with 'q')
```

---

## Quick Start: Native Terminal (iTerm2)

### Using iTerm2 Built-in Splits

**Keyboard Shortcuts:**

```
Cmd-D        Split vertically (left/right)
Cmd-Shift-D  Split horizontally (top/bottom)
Cmd-[        Go to left/upper pane
Cmd-]        Go to right/lower pane
Cmd-Opt-←    Go to left pane
Cmd-Opt-→    Go to right pane
Cmd-W        Close current pane
```

**Workflow:**

1. Open iTerm2
2. Press `Cmd-D` to split vertically
3. Left pane: Start Claude (`claude chat`)
4. Right pane: Start dev server (`npm run dev`)
5. Navigate with `Cmd-[` and `Cmd-]`

---

## Common Layouts

### Layout 1: Vertical Split (Most Common)

```
┌──────────────────────┬──────────────────────┐
│                      │                      │
│    Claude Code       │   Dev Server Logs   │
│    (Active work)     │   (Monitoring)      │
│                      │                      │
│  50% width           │   50% width         │
│                      │                      │
└──────────────────────┴──────────────────────┘

tmux: Ctrl-b %
screen: Ctrl-a |
iTerm2: Cmd-D
```

**When to use:** Most professional work
**Benefit:** Side-by-side comparison, instant feedback

---

### Layout 2: Horizontal Split

```
┌─────────────────────────────────────────────┐
│                                             │
│            Claude Code (70%)                │
│            (Active work)                    │
│                                             │
├─────────────────────────────────────────────┤
│                                             │
│        Dev Server Logs (30%)                │
│        (Monitoring)                         │
└─────────────────────────────────────────────┘

tmux: Ctrl-b "
screen: Ctrl-a S
iTerm2: Cmd-Shift-D
```

**When to use:** Short logs, more vertical code space
**Benefit:** More lines visible in Claude pane

---

### Layout 3: Triple Pane (Advanced)

```
┌──────────────┬──────────────┬──────────────┐
│              │              │              │
│   Claude     │   Tests      │   Logs       │
│   (Code)     │ (Coverage)   │ (Feedback)   │
│              │              │              │
│  33% width   │  33% width   │  33% width   │
│              │              │              │
└──────────────┴──────────────┴──────────────┘

tmux workflow:
1. Ctrl-b %  (split into 2)
2. Ctrl-b →  (move to right)
3. Ctrl-b %  (split right pane into 2)
```

**When to use:** Complex development (feature + tests + logs)
**Benefit:** Maximum visibility

---

### Layout 4: Quad Pane (Expert)

```
┌──────────────────────┬──────────────────────┐
│                      │                      │
│    Claude Code       │    Test Output       │
│    (50% height)      │    (50% height)      │
│                      │                      │
├──────────────────────┼──────────────────────┤
│                      │                      │
│   Dev Server Logs    │   Build Output       │
│   (50% height)       │   (50% height)       │
│                      │                      │
└──────────────────────┴──────────────────────┘

tmux workflow:
1. Ctrl-b %  (vertical split)
2. Ctrl-b "  (horizontal split on left)
3. Ctrl-b →  (move to right)
4. Ctrl-b "  (horizontal split on right)
```

**When to use:** Complex projects (API + frontend + tests)
**Benefit:** Monitor everything simultaneously

---

## Recommended Configuration: tmux

### Create ~/.tmux.conf

Add these settings for better UX:

```bash
# ~/.tmux.conf

# Enable mouse support (easier pane selection)
set -g mouse on

# Start window numbering at 1 (easier to reach)
set -g base-index 1

# Increase scrollback buffer
set-option -g history-limit 10000

# Split panes using | and - (more intuitive)
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Switch panes using Alt-arrow (no prefix needed!)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Reload config with Ctrl-b r
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Better status bar
set -g status-style bg=black,fg=white
set -g status-left '[#S] '
set -g status-right '%Y-%m-%d %H:%M'
```

**Apply changes:**
```bash
tmux source-file ~/.tmux.conf
```

---

## Practical Use Cases

### Use Case 1: Web Development

**Setup:**
```
┌──────────────────────┬──────────────────────┐
│   Claude Code        │   npm run dev        │
│                      │                      │
│ "Add login button    │ [webpack] compiled   │
│  to header"          │ [hot-reload] success │
│                      │                      │
│ *generates code*     │ → See changes live!  │
└──────────────────────┴──────────────────────┘
```

**Benefit:** Instant feedback on code changes

---

### Use Case 2: Python Development

**Setup:**
```
┌──────────────────────┬──────────────────────┐
│   Claude Code        │   pytest --watch     │
│                      │                      │
│ "Fix authentication  │ FAILED test_login.py │
│  bug in login.py"    │ AssertionError: ...  │
│                      │                      │
│ *generates fix*      │ PASSED test_login.py │
└──────────────────────┴──────────────────────┘
```

**Benefit:** See test results immediately

---

### Use Case 3: Rust Development

**Setup:**
```
┌──────────────────────┬──────────────────────┐
│   Claude Code        │   cargo watch        │
│                      │                      │
│ "Refactor Parser     │ Compiling myapp...   │
│  to use references"  │ error[E0106]: ...    │
│                      │                      │
│ *adjusts code*       │ Finished dev build   │
└──────────────────────┴──────────────────────┘
```

**Benefit:** Catch compiler errors in real-time

---

### Use Case 4: API Development

**Setup (Triple Pane):**
```
┌──────────┬──────────┬──────────┐
│ Claude   │  Server  │   curl   │
│          │          │          │
│ "Add GET │ [server] │ $ curl   │
│  /users  │ listening│ /users   │
│  endpoint│ port 3000│          │
│          │          │ [200 OK] │
└──────────┴──────────┴──────────┘
```

**Benefit:** Test API while developing

---

## Keyboard Navigation Tips

### tmux: Fast Pane Switching

**Default navigation:**
```bash
Ctrl-b ←  # Slow: prefix + arrow
```

**Better navigation** (add to ~/.tmux.conf):
```bash
bind -n M-Left select-pane -L    # Alt-Left (no prefix!)
bind -n M-Right select-pane -R   # Alt-Right
```

**Best navigation** (for power users):
```bash
bind h select-pane -L   # Ctrl-b h (vim-style)
bind j select-pane -D   # Ctrl-b j
bind k select-pane -U   # Ctrl-b k
bind l select-pane -R   # Ctrl-b l
```

---

### iTerm2: Fast Pane Switching

**Preferences → Keys → Key Bindings:**

Add custom shortcuts:
```
Opt-h  → Select Split Pane on Left
Opt-j  → Select Split Pane Below
Opt-k  → Select Split Pane Above
Opt-l  → Select Split Pane on Right
```

**Now you can switch with Alt+h/j/k/l (vim-style)**

---

## Troubleshooting

### "tmux: command not found"

**Solution:** Install tmux
```bash
# macOS
brew install tmux

# Linux
sudo apt install tmux  # Debian/Ubuntu
sudo dnf install tmux  # Fedora
```

---

### "Panes are too small"

**Solution 1: Resize panes**
```bash
# tmux
Ctrl-b :  # Enter command mode
resize-pane -L 10  # Move divider left 10 characters
resize-pane -R 10  # Move divider right

# Or use mouse (if enabled)
# Just drag the divider
```

**Solution 2: Use fewer panes**
- 2 panes usually optimal (Claude + logs)
- 3+ panes can feel cramped on smaller screens

---

### "Text is too small in split panes"

**Solution 1: Increase terminal font size**
- iTerm2: Cmd-+ (increase), Cmd-- (decrease)
- Ghostty: Edit ~/.config/ghostty/config
- Warp: Settings → Appearance → Font Size

**Solution 2: Use horizontal split**
- Horizontal split = more width for each pane
- Better for wide code

---

### "Can't scroll in tmux panes"

**Solution 1: Enter copy mode**
```bash
Ctrl-b [  # Enter copy mode
↑↓        # Scroll with arrow keys
q         # Quit copy mode
```

**Solution 2: Enable mouse support**
Add to ~/.tmux.conf:
```bash
set -g mouse on
```

Then scroll with mouse wheel!

---

### "Lost my session after closing terminal"

**With tmux:** Sessions survive terminal closes!
```bash
# List all sessions
tmux ls

# Reattach to session
tmux attach -t claude-dev
```

**Without tmux:** Sessions die with terminal
- This is why tmux is recommended for long-running work

---

## Integration with Other Workflows

### Split-Screen + Plan Mode

**Pattern:**
```
┌──────────────────────┬──────────────────────┐
│   Claude (Plan)      │   Codebase Explorer  │
│                      │                      │
│ Shift+Tab Shift+Tab  │ $ rg "function login"│
│ "Plan authentication │ → found 3 matches    │
│  refactor..."        │                      │
│                      │ [code context]       │
└──────────────────────┴──────────────────────┘
```

**Benefit:** Plan with codebase visibility

---

### Split-Screen + /verify

**Pattern:**
```
┌──────────────────────┬──────────────────────┐
│   Claude             │   Test Results       │
│                      │                      │
│ /verify              │ $ npm test           │
│                      │ ✓ 47 passing         │
│ ✅ Security: Pass     │ ✗ 2 failing          │
│ ✅ Tests: Pass        │                      │
└──────────────────────┴──────────────────────┘
```

**Benefit:** Verify while seeing actual test output

---

## Advanced: Persistent Workspace

### Create Startup Script

Save this as `~/scripts/claude-workspace.sh`:

```bash
#!/bin/bash
# claude-workspace.sh - Start split-screen Claude workspace

# Check if session already exists
tmux has-session -t claude-dev 2>/dev/null

if [ $? != 0 ]; then
  # Create new session
  tmux new-session -d -s claude-dev

  # Split vertically
  tmux split-window -h -t claude-dev

  # Select left pane
  tmux select-pane -t claude-dev:0.0

  # Send claude command to left pane
  tmux send-keys -t claude-dev:0.0 'claude chat' C-m

  # Select right pane
  tmux select-pane -t claude-dev:0.1

  # Send dev server command to right pane
  tmux send-keys -t claude-dev:0.1 'npm run dev' C-m
fi

# Attach to session
tmux attach-t claude-dev
```

**Make executable:**
```bash
chmod +x ~/scripts/claude-workspace.sh
```

**Usage:**
```bash
~/scripts/claude-workspace.sh
```

**One-line launcher!**

---

## Success Metrics

### How to Know It's Working

**Week 1:**
- ✅ No longer switching windows to check logs
- ✅ Catching errors within seconds (not minutes)
- ✅ Comfortable navigating between panes

**Week 2+:**
- ✅ Real-time feedback feels natural
- ✅ Development speed increased
- ✅ Less time debugging "what happened?"

---

## Related Guides

- **Terminal Setup:** `01_global-setup/02_good-to-have/04_terminal-setup.md`
- **Parallel Terminals:** `docs/02-optimization/06_parallel-terminals.md`
- **Quick Reference:** `docs/00-start-here/09_quick-reference.md`
- **Model Selection:** `01_global-setup/02_good-to-have/01_model-switching.md`

---

## Summary

**Key Takeaways:**

✅ **Split-screen = real-time feedback** (Claude + logs side-by-side)
✅ **tmux is recommended** (persistent sessions, works everywhere)
✅ **Vertical split most common** (left: Claude, right: logs)
✅ **Mouse support helps** (enable in ~/.tmux.conf)
✅ **Start simple** (2 panes), scale to 3-4 only if needed

**Recommended First Step:**

```bash
# 1. Install tmux
brew install tmux

# 2. Create simple config
echo "set -g mouse on" > ~/.tmux.conf

# 3. Start session
tmux new -s claude-dev

# 4. Split (Ctrl-b %)
# 5. Left: claude chat
# 6. Right: npm run dev

# Done! You now have split-screen Claude workflow.
```

---

**Last Updated:** 2026-01-13
**Version:** 5.1.0-alpha.2
**Based on:** Boris Cherny's Claude Code workflow
