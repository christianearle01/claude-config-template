# Permission Modes Cheat Sheet

A quick reference for Claude Code permission modes - print and keep handy!

---

## 🎯 The Three Modes

### ⏸ Plan Mode (RECOMMENDED for Setup)
**What:** Shows plan BEFORE executing
**When:** Initial setup, learning, complex tasks
**Toggle:** Press `Shift+Tab` until you see `⏸ plan mode on`

**Perfect for:**
- ✅ First-time project setup
- ✅ Learning how Claude works
- ✅ Understanding changes before they happen
- ✅ Team environments
- ✅ Complex refactoring

---

### ❓ Ask Mode (Maximum Safety)
**What:** Asks permission for EVERY tool use
**When:** Production, sensitive operations
**Toggle:** Press `Shift+Tab` until you see `❓ ask mode on`

**Perfect for:**
- ✅ Production deployments
- ✅ Sensitive file operations
- ✅ When you need granular control
- ⚠️  Slower for repetitive tasks

---

### 🔓 AcceptEdits Mode (Speed, Use with Caution)
**What:** Auto-applies changes WITHOUT showing you first
**When:** ONLY after you're comfortable, repetitive tasks
**Toggle:** Press `Shift+Tab` until you see `🔓 acceptEdits mode`

**Perfect for:**
- ✅ Bulk operations (after verifying pattern)
- ✅ Repetitive updates
- ✅ When you know exactly what will happen

**AVOID for:**
- ❌ Initial setup (you won't see what's happening!)
- ❌ Learning phase
- ❌ Complex changes you haven't reviewed
- ❌ Team onboarding

---

## 🔄 How to Switch Modes

### Keyboard Shortcut (Fastest)
```
Press Shift+Tab repeatedly
Watch the indicator at bottom of Claude Code window
```

### Settings File (Permanent)
Edit `.claude/settings.json`:
```json
{
  "permissions": {
    "defaultMode": "plan"
  }
}
```

---

## 📋 Quick Decision Guide

**Ask yourself:**

**"Am I setting up something new?"**
→ Use **Plan Mode** ⏸

**"Do I understand what Claude will do?"**
→ Use **AcceptEdits Mode** 🔓 (for speed)

**"Is this a production/critical change?"**
→ Use **Ask Mode** ❓

**"Am I learning or onboarding?"**
→ Use **Plan Mode** ⏸

---

## 🎓 Learning Path

### Week 1: Setup & Learning
```
Mode: ⏸ Plan Mode
Goal: Understand how Claude works
Benefit: See every change, learn patterns
```

### Week 2-3: Getting Comfortable
```
Mode: ⏸ Plan Mode for new tasks
      🔓 AcceptEdits for familiar patterns
Goal: Balance learning with speed
Benefit: Efficient while still learning
```

### Month 2+: Experienced User
```
Mode: 🔓 AcceptEdits for most tasks
      ⏸ Plan Mode for complex/new tasks
      ❓ Ask Mode for production
Goal: Maximum efficiency with safety
Benefit: Fast workflow, selective control
```

---

## ⚠️ Common Mistakes

### ❌ Mistake 1: Using acceptEdits during setup
**Problem:** You don't see what's being configured
**Solution:** Switch to Plan Mode with Shift+Tab

### ❌ Mistake 2: Staying in ask mode for everything
**Problem:** Too slow, too many interruptions
**Solution:** Use Plan Mode for most tasks

### ❌ Mistake 3: Never switching modes
**Problem:** Missing optimization opportunities
**Solution:** Adapt mode to task complexity

---

## 🚀 Pro Tips

1. **Start every session in Plan Mode**
   Your template already sets this as default!

2. **Switch to AcceptEdits for bulk operations**
   "Update all 50 test files" → Switch to 🔓 first

3. **Use Ask Mode for .env and sensitive files**
   Extra safety for configuration changes

4. **Check your mode before big changes**
   Look at bottom of window, adjust if needed

5. **Team rule: Plan Mode for onboarding**
   New team members should see what's happening

---

## 🔍 Visual Indicators

**Look at the bottom of your Claude Code window:**

```
⏸ plan mode on       ← You're safe! Plans shown first
❓ ask mode on        ← Maximum control
🔓 acceptEdits mode   ← Auto mode (careful!)
```

**Can't see indicator?**
Press `Shift+Tab` to cycle and watch for changes

---

## 📊 Mode Comparison Table

| Feature | Plan Mode | Ask Mode | AcceptEdits |
|---------|-----------|----------|-------------|
| **Shows changes before applying** | ✅ | ✅ | ❌ |
| **Requires approval** | ✅ | ✅ | ❌ |
| **Speed** | Fast | Slow | Fastest |
| **Learning value** | High | High | Low |
| **Setup phase** | ✅ Best | ✅ OK | ❌ Bad |
| **Production phase** | ✅ Good | ✅ Best | ⚠️ Risky |
| **Bulk operations** | ⚠️ OK | ❌ Slow | ✅ Best |

---

## 🎯 Your Default Setup

Your template is pre-configured with:
```json
"defaultMode": "plan"
```

This means:
- ✅ Every new session starts in Plan Mode
- ✅ Safe by default
- ✅ Perfect for learning
- ✅ You can still switch modes with Shift+Tab

---

## 📞 Need Help?

**Mode not working?**
1. Check `.claude/settings.json` for `"defaultMode": "plan"`
2. Press Shift+Tab to manually toggle
3. Run `/doctor` to check configuration

**Not sure which mode to use?**
- When in doubt → Use **Plan Mode** ⏸
- It's the safest and most educational option

---

## 🎉 Remember

**Golden Rule:**
> Start with Plan Mode (⏸), graduate to AcceptEdits (🔓) only when you're comfortable.

**Setup Rule:**
> ALWAYS use Plan Mode during initial setup and onboarding.

**Production Rule:**
> Use Ask Mode (❓) for sensitive operations.

---

**Print this cheat sheet and keep it handy!**

**Quick Access:** Press `Shift+Tab` anytime to see your current mode

---

*Last Updated: 2025-12-04*
*Part of the Claude Code Configuration Template*
