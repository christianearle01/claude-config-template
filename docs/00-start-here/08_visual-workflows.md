# Visual Workflows Guide

**5 Mermaid diagrams showing how Claude Code workflows actually work**

**Time to read:** 10 minutes
**Purpose:** See the complete workflows visually (complements [Workflow Integration Guide](../01-fundamentals/WORKFLOW_INTEGRATION.md))

---

## Why This Matters

**Without visual workflows:**
- Abstract concepts hard to grasp ("What's the actual sequence?")
- Miss the connections between tools
- Unclear when to use which path
- Can't see the big picture

**With visual workflows:**
- Instant understanding of complete processes
- See tool relationships clearly
- Know decision points (when to branch)
- Reference during actual work

**Time investment:** 10 minutes
**Benefit:** Clear mental model of all major workflows

---

## Workflow #1: New Project Setup

**Scenario:** Starting a fresh project with Claude Code

```mermaid
graph TD
    Start[Start: New Project] --> A{Have Project Idea?}

    A -->|No Code Yet| B["@project-planner Agent"]
    A -->|Have Code| C[Skip Planning]

    B --> D[Tech Stack Recommendations]
    D --> E[CLAUDE.md Draft Created]

    C --> F[Copy .claude/ Config]
    E --> F

    F --> G[Fill in CLAUDE.md]
    G --> H[Document Business Purpose]
    H --> I[Document External APIs]

    I --> J{Need Feature Breakdown?}

    J -->|Yes| K["@initializer Agent"]
    J -->|No| L[Start Coding Directly]

    K --> M[features.json Created]
    M --> N[Confidence Scores Assigned]

    L --> O[Development Loop]
    N --> O

    O --> P["@coder Agent"]
    P --> Q[TDD: Write Test First]
    Q --> R[Implement Feature]
    R --> S["/test Command"]

    S --> T{Tests Pass?}
    T -->|No| Q
    T -->|Yes| U["@quality-reviewer"]

    U --> V[Security + Standards Check]
    V --> W{Issues Found?}

    W -->|Yes| X[Fix Issues]
    X --> S
    W -->|No| Y[commit-readiness-checker]

    Y --> Z[Create Commit]
    Z --> End[Feature Shipped!]

    style Start fill:#e1f5e1
    style End fill:#e1f5e1
    style B fill:#fff4e1
    style K fill:#fff4e1
    style P fill:#fff4e1
    style U fill:#fff4e1
```

**Time:** 15-40 minutes per feature

---

## Workflow #2: Feature Development Loop

**Scenario:** Systematic feature implementation with quality gates

```mermaid
graph LR
    A[Read features.json] --> B{Select Next Feature}

    B --> C[Pick Highest Confidence]
    C --> D["@coder Agent Activates"]

    D --> E[Read CLAUDE.md for Conventions]
    E --> F[TDD Phase 1: Write Failing Test]

    F --> G[Run Test - Should Fail]
    G --> H[TDD Phase 2: Implement Minimum]

    H --> I[Run Test Again]
    I --> J{Test Passes?}

    J -->|No| K[Debug & Fix]
    K --> I

    J -->|Yes| L[TDD Phase 3: Refactor]
    L --> M[Improve Code Quality]

    M --> N["/test Command - Full Suite"]
    N --> O{All Tests Pass?}

    O -->|No| P[Fix Regressions]
    P --> N

    O -->|Yes| Q["@quality-reviewer"]
    Q --> R[Parallel Quality Gates]

    R --> S[Security Scanner]
    R --> T[Test Generator]
    R --> U[Standards Enforcer]

    S --> V{Security OK?}
    T --> W{Coverage OK?}
    U --> X{Standards OK?}

    V -->|No| Y[Fix Security Issues]
    W -->|No| Z[Add Missing Tests]
    X -->|No| AA[Fix Style Issues]

    Y --> R
    Z --> R
    AA --> R

    V -->|Yes| AB{All Gates Pass?}
    W -->|Yes| AB
    X -->|Yes| AB

    AB -->|Yes| AC[Update features.json]
    AC --> AD[Mark Feature Complete]
    AD --> AE[Commit Changes]

    AE --> A

    style D fill:#fff4e1
    style Q fill:#fff4e1
    style R fill:#ffe1e1
```

**Time:** 10-30 minutes per feature (varies by complexity)

---

## Workflow #3: Quality Gates Integration

**Scenario:** @quality-reviewer agent orchestrating parallel checks

```mermaid
graph TD
    Start[Feature Implementation Complete] --> A["@quality-reviewer Invoked"]

    A --> B[Detect Project Phase]
    B --> C{Phase Type?}

    C -->|Development| D[Run: Security + Tests + Standards]
    C -->|Review| E[Run: Security + Standards]
    C -->|Testing| F[Run: Tests + Standards]
    C -->|Deployment| G[Run: All Gates + Performance]

    D --> H[Parallel Execution Starts]
    E --> H
    F --> H
    G --> H

    H --> I[Gate 1: Security Scanner]
    H --> J[Gate 2: Test Generator]
    H --> K[Gate 3: Standards Enforcer]

    I --> L{OWASP Top 10 Check}
    L -->|Issues Found| M[Report: SQL Injection]
    L -->|Issues Found| N[Report: XSS Vulnerabilities]
    L -->|Issues Found| O[Report: Auth Bypass]
    L -->|Clean| P[Security: PASS]

    J --> Q{Coverage Check}
    Q -->|<80%| R[Generate Missing Tests]
    Q -->|≥80%| S[Testing: PASS]

    K --> T{Standards Check}
    T -->|Violations| U[Report Style Issues]
    T -->|Clean| V[Standards: PASS]

    M --> W[Aggregate Results]
    N --> W
    O --> W
    P --> W
    R --> W
    S --> W
    U --> W
    V --> W

    W --> X{All Gates Pass?}

    X -->|No| Y[Show Issues with Fixes]
    Y --> Z["@coder Agent Fixes"]
    Z --> A

    X -->|Yes| AA[Quality Report: SUCCESS]
    AA --> AB[Proceed to Commit]

    style A fill:#fff4e1
    style H fill:#ffe1e1
    style AA fill:#e1f5e1

    style I fill:#e1f0ff
    style J fill:#e1f0ff
    style K fill:#e1f0ff
```

**Time:** 15-30 seconds (parallel execution)

---

## Workflow #4: Team Onboarding

**Scenario:** Deploying Claude Code to your development team

```mermaid
graph TD
    Start[Team Lead Decides to Deploy] --> A[Week 0: Preparation]

    A --> B[Fork claude-config-template]
    B --> C[Customize CLAUDE.md.template]
    C --> D[Add Team Coding Standards]
    D --> E[Configure Team MCP Servers]

    E --> F[Week 1: Pilot Phase]
    F --> G{Select 2-3 Pilot Users}

    G --> H[Pilot User 1: Pair Programming]
    G --> I[Pilot User 2: Observe Setup]
    G --> J[Pilot User 3: Self-Service]

    H --> K[Measure Setup Time]
    I --> K
    J --> K

    K --> L[Collect Feedback Forms]
    L --> M{Issues Found?}

    M -->|Yes| N[Week 2: Refinement]
    M -->|No| O[Week 3: Full Rollout]

    N --> P[Update Documentation]
    P --> Q[Simplify Pain Points]
    Q --> R[Test with 1 Pilot User]
    R --> S{Improved?}

    S -->|No| N
    S -->|Yes| O

    O --> T[Announce to Full Team]
    T --> U[Office Hours Setup]
    U --> V[Onboard 3-5 Users/Week]

    V --> W[Monitor Adoption Metrics]
    W --> X{80%+ Adoption?}

    X -->|No| Y[Address Blockers]
    Y --> Z[1-on-1 Support]
    Z --> V

    X -->|Yes| AA[Week 4+: Optimization]
    AA --> AB[Monthly Feedback Sessions]
    AB --> AC[Share Success Stories]
    AC --> AD[Update Templates]

    AD --> AE[Continuous Improvement Loop]

    style Start fill:#e1f5e1
    style F fill:#fff4e1
    style N fill:#ffe1e1
    style O fill:#fff4e1
    style AA fill:#e1f5e1
```

**Time:** 4+ weeks for full team deployment

---

## Workflow #5: Troubleshooting Decision Tree

**Scenario:** Something isn't working, what do you check?

```mermaid
graph TD
    Start{What's Not Working?} --> A[Claude Code Won't Start]
    Start --> B[Settings Not Loading]
    Start --> C[CLAUDE.md Not Found]
    Start --> D[MCP Servers Not Appearing]
    Start --> E[Commands Not Working]
    Start --> F[Git Approval Not Triggering]

    A --> A1[Run: claude --version]
    A1 --> A2{Version Shows?}
    A2 -->|No| A3[Reinstall: curl -fsSL code.claude.com/install.sh sh]
    A2 -->|Yes| A4[Run: /doctor]
    A4 --> A5[Follow Diagnostic Output]

    B --> B1[Check File Location]
    B1 --> B2[~/.claude/settings.json exists?]
    B2 -->|No| B3[Create from template]
    B2 -->|Yes| B4[Validate JSON Syntax]
    B4 --> B5[python -m json.tool settings.json]
    B5 --> B6{Valid JSON?}
    B6 -->|No| B7[Fix Syntax Errors]
    B6 -->|Yes| B8[Restart Claude Code]

    C --> C1[Check Filename]
    C1 --> C2[Must be: CLAUDE.md all caps]
    C2 --> C3[Check Location]
    C3 --> C4[Must be in project root]
    C4 --> C5[NOT in .claude/ directory]
    C5 --> C6[Test: Ask 'What does this app do?']

    D --> D1[Check ~/.claude.json]
    D1 --> D2[mcpServers section exists?]
    D2 -->|No| D3[Add MCP server config]
    D2 -->|Yes| D4[Run: /mcp]
    D4 --> D5{Servers Listed?}
    D5 -->|No| D6[Check npx installation]
    D5 -->|Yes| D7[Servers Working!]

    E --> E1[Check .claude/commands/]
    E1 --> E2[Command files exist?]
    E2 -->|No| E3[Create command.md files]
    E2 -->|Yes| E4[Check file format]
    E4 --> E5[Must end with .md]
    E5 --> E6[Restart Claude Code]

    F --> F1[Check settings.json]
    F1 --> F2[neverAutoApprove array exists?]
    F2 -->|No| F3[Add git commit blocking]
    F2 -->|Yes| F4[Run test commit]
    F4 --> F5{Asks for approval?}
    F5 -->|No| F6[Check permission mode]
    F6 --> F7[Press Shift+Tab to check mode]
    F5 -->|Yes| F8[Working correctly!]

    style Start fill:#e1f0ff
    style A3 fill:#ffe1e1
    style B7 fill:#ffe1e1
    style D3 fill:#fff4e1
    style E3 fill:#fff4e1
    style F3 fill:#fff4e1
    style D7 fill:#e1f5e1
    style F8 fill:#e1f5e1
```

**Time:** 2-10 minutes to diagnose and fix

---

## How to Use These Diagrams

### During Planning
- **Reference Workflow #1** - Understand new project setup sequence
- **Reference Workflow #4** - Plan team rollout strategy

### During Development
- **Reference Workflow #2** - Follow TDD feature loop
- **Reference Workflow #3** - Understand quality gates

### During Troubleshooting
- **Reference Workflow #5** - Debug issues systematically

### Print and Keep Handy
Export these diagrams and keep them visible:
1. GitHub: View in README (renders Mermaid)
2. VS Code: Use Mermaid Preview extension
3. Print: Screenshot and print for desk reference

---

## Legend

**Node Colors:**
- 🟢 Green = Start/Success/Completion
- 🟡 Yellow = Agent/Tool invocation
- 🔴 Red = Error state/Parallel execution
- 🔵 Blue = Information/Check

**Node Shapes:**
- Rectangle = Action/Process
- Diamond = Decision point
- Rounded = Start/End
- Parallelogram = Input/Output

---

## Next Steps

### Understand the Flows Deeply

**Option A: Read Full Workflow Guide (15 min)**
→ [Workflow Integration Guide](../01-fundamentals/WORKFLOW_INTEGRATION.md) - Detailed explanations

**Option B: Try a Workflow (30 min)**
→ [New Project Setup](../../docs/00-start-here/personas/06_planning-new-project.md) - Follow Workflow #1

**Option C: Master Quality Gates (20 min)**
→ [Quality Workflows Guide](../00-start-here/QUALITY_WORKFLOWS.md) - Deep dive on Workflow #3

**Having trouble?** Ask Claude: "Walk me through [specific workflow from diagram]"

---

## ✅ You've Completed: Visual Workflows

**What you learned:**
- 5 complete workflows visualized (setup, development, quality, team, troubleshooting)
- Decision points (when to branch, what to check)
- Tool relationships (how agents, skills, commands connect)
- Troubleshooting paths (systematic debugging)

**Next logical step:**

**Option A: Deep Dive on One Workflow (15 min)**
→ Pick one diagram → Read corresponding detailed guide

**Option B: Practice a Workflow (30 min)**
→ Try Workflow #1 or #2 on a real project

**Option C: Master Your Weak Spot (varies)**
→ Identify which workflow confuses you → Study that one deeply

---

**Estimated next step time:** 15-30 minutes (depending on choice)
**Last Updated:** 2025-12-16
