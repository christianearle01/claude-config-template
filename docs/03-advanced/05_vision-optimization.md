# Vision Optimization

**When to use images vs. text descriptions**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Vision capability: Official Claude feature ✅ VALIDATED
- Multimodal support: Supported in all Claude models

**Note:** Vision is a core Claude feature, not Claude Code-specific.

---

## When to Use Vision

### ✅ Use Images For:

**1. Architecture Diagrams**
- System design diagrams
- Database schemas
- Component relationships
- Flowcharts

**Token comparison:**
- Text description: 500-1,000 tokens
- Image upload: ~200 tokens (+ instant understanding)
- **Savings:** 300-800 tokens

---

**2. Error Screenshots**
- Stack traces from terminal
- Browser console errors
- IDE error messages
- Crash reports

**Benefit:** Visual context Claude can analyze directly

---

**3. UI Mockups**
- Design comp from Figma
- Wireframes
- Layout screenshots
- Style guides

**Use case:** "Implement this component from the screenshot"

---

**4. Complex Data Visualizations**
- Charts and graphs
- Network diagrams
- Performance metrics
- Analytics dashboards

**Why:** Easier to show than describe

---

### ❌ Use Text For:

**1. Code Snippets**
- Already in text format
- Better for Claude to analyze as text
- Easier to reference specific lines

---

**2. Simple Concepts**
- "The button should be blue" (no image needed)
- "Add validation to email field" (clear from text)

---

**3. Sensitive Information**
- API keys or secrets visible in screenshots
- User data (PII)
- Proprietary code

---

## Token Savings Examples

### Example 1: Database Schema

**Text description (500 tokens):**
```
We have a users table with columns: id (UUID), email (string),
created_at (timestamp). It has a one-to-many relationship with
posts table. Posts has: id (UUID), user_id (foreign key to users),
title (string), content (text), published_at (timestamp).
There's also a comments table with...
```

**Image alternative:**
- Upload schema diagram screenshot
- ~200 tokens
- **Savings:** 300 tokens + clearer understanding

---

### Example 2: Error Debugging

**Text description (800 tokens):**
```
I'm getting an error that says "Cannot read property 'map' of
undefined" at line 42 of UserList.tsx. The stack trace shows it's
coming from the render method, and the error happens when trying
to iterate over the users array...
```

**Image alternative:**
- Screenshot of terminal with full stack trace
- ~200 tokens
- **Savings:** 600 tokens + full context

---

## How to Use Vision in Claude Code

### Method 1: Drag and Drop

```
1. Take screenshot (Cmd+Shift+4 on Mac, Win+Shift+S on Windows)
2. Drag image into Claude Code chat
3. Add text prompt: "Implement this component"
```

---

### Method 2: File Path Reference

```
You: Analyze the error in @screenshot.png
```

Claude reads the image and provides analysis.

---

## Best Practices

### 1. Combine Image + Text

**Good:**
```
Here's the architecture diagram [image].
Please implement the UserService following this design.
```

**Why:** Image provides structure, text provides specific instructions

---

### 2. Annotate Images When Needed

**Before sending:**
- Add arrows/circles to highlight specific parts
- Use screenshot tools with annotation (macOS Preview, Windows Snip & Sketch)

**Example:** Circle the error line in a stack trace screenshot

---

### 3. Resolution Matters

**Too low:** Hard to read text in image
**Too high:** Larger file size (no benefit)
**Sweet spot:** Readable text, ~1-2 MB max

---

## Common Use Cases

### Use Case 1: "Implement This Design"

```
[Upload Figma screenshot]

Prompt: "Implement this login component in React.
Use Tailwind CSS for styling."
```

**Result:** Claude builds component matching design

---

### Use Case 2: "Debug This Error"

```
[Upload terminal screenshot with stack trace]

Prompt: "Why is this error happening and how do I fix it?"
```

**Result:** Claude analyzes full stack trace, suggests fix

---

### Use Case 3: "Explain This Diagram"

```
[Upload architecture diagram]

Prompt: "Explain how data flows through this system"
```

**Result:** Claude walks through the architecture

---

### Use Case 4: "Match This Style"

```
[Upload screenshot of existing component]

Prompt: "Create a similar component but for product cards"
```

**Result:** Claude matches visual style

---

## Token Cost Comparison

| Content Type | Text Tokens | Image Tokens | Savings |
|--------------|-------------|--------------|---------|
| Simple UI | 300-500 | ~200 | 100-300 |
| Error screenshot | 500-800 | ~200 | 300-600 |
| Architecture diagram | 800-1,500 | ~200 | 600-1,300 |
| Complex mockup | 1,000-2,000 | ~200 | 800-1,800 |

**Average savings:** 500-1,000 tokens per image

---

## When Text Is Better

### 1. Code Review

**Better as text:**
```javascript
// Before
function getUserData() {
  return fetch('/api/users').then(r => r.json())
}

// After (with error handling)
async function getUserData() {
  try {
    const response = await fetch('/api/users')
    if (!response.ok) throw new Error('Failed to fetch')
    return await response.json()
  } catch (error) {
    console.error(error)
    return []
  }
}
```

**Why:** Claude can reference specific lines, suggest edits

---

### 2. Configuration Files

**Better as text:**
```json
{
  "compilerOptions": {
    "strict": true,
    "target": "ES2020"
  }
}
```

**Why:** Can be edited directly, copy-paste friendly

---

## Summary

**Vision Optimization Core Principles:**

1. **Use images for visual content** - Diagrams, errors, designs
2. **Use text for code** - Better for analysis and editing
3. **500-1,000 token savings** - Per image vs. text description
4. **Combine image + text** - Image shows context, text gives instructions
5. **Annotate when helpful** - Highlight specific areas

**The outcome:**
- ✅ Faster communication (show don't tell)
- ✅ 500-1,000 tokens saved per image
- ✅ Better understanding (visual context)
- ✅ Reduced back-and-forth (clearer requirements)

**Best practice:**
> Use images for anything visual (diagrams, errors, designs). Use text for code and configuration. Combine both for maximum clarity.

---

**See also:**
- [Keyboard Shortcuts](../01-fundamentals/KEYBOARD_SHORTCUTS.md) - Efficient workflows
- [Conversation Branching](CONVERSATION_BRANCHING.md) - Context management
