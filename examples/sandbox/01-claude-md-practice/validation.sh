#!/bin/bash

# Validation script for CLAUDE.md Practice Sandbox
# Checks if user's CLAUDE.md meets minimum requirements

echo "🔍 Validating your CLAUDE.md..."
echo ""

CLAUDE_FILE="starter-files/CLAUDE.md"
PASS_COUNT=0
TOTAL_CHECKS=6

# Check 1: File exists
if [ -f "$CLAUDE_FILE" ]; then
    echo "✅ Check 1/6: CLAUDE.md exists"
    ((PASS_COUNT++))
else
    echo "❌ Check 1/6: CLAUDE.md not found"
    echo "   Create starter-files/CLAUDE.md to begin"
    exit 1
fi

# Check 2: Contains business purpose
if grep -qi "business purpose\|what does this" "$CLAUDE_FILE"; then
    echo "✅ Check 2/6: Business purpose documented"
    ((PASS_COUNT++))
else
    echo "❌ Check 2/6: Missing business purpose section"
    echo "   Add 'What Does This Application Do?' or 'Business Purpose'"
fi

# Check 3: Lists API endpoints
ENDPOINT_COUNT=$(grep -c "/api/" "$CLAUDE_FILE")
if [ "$ENDPOINT_COUNT" -ge 3 ]; then
    echo "✅ Check 3/6: API endpoints documented ($ENDPOINT_COUNT found)"
    ((PASS_COUNT++))
else
    echo "❌ Check 3/6: Missing API endpoints (found $ENDPOINT_COUNT, need 3)"
    echo "   Document /api/users, /api/posts, /api/auth"
fi

# Check 4: Mentions tech stack
if grep -qi "express\|node" "$CLAUDE_FILE"; then
    echo "✅ Check 4/6: Tech stack mentioned"
    ((PASS_COUNT++))
else
    echo "❌ Check 4/6: Tech stack not documented"
    echo "   Add Tech Stack section with Express, Node.js"
fi

# Check 5: Documents Twilio
if grep -qi "twilio\|sms" "$CLAUDE_FILE"; then
    echo "✅ Check 5/6: Twilio/SMS documented"
    ((PASS_COUNT++))
else
    echo "❌ Check 5/6: Twilio integration not mentioned"
    echo "   Document why Twilio is used (urgent task notifications)"
fi

# Check 6: File is concise (<500 lines)
LINE_COUNT=$(wc -l < "$CLAUDE_FILE")
if [ "$LINE_COUNT" -lt 500 ]; then
    echo "✅ Check 6/6: File is concise ($LINE_COUNT lines)"
    ((PASS_COUNT++))
else
    echo "⚠️  Check 6/6: File is long ($LINE_COUNT lines)"
    echo "   Consider reducing to <500 lines (focus on WHAT not HOW)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Results: $PASS_COUNT/$TOTAL_CHECKS checks passed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$PASS_COUNT" -eq "$TOTAL_CHECKS" ]; then
    echo "🎉 Perfect! Your CLAUDE.md is ready!"
    echo "   Compare with solution/CLAUDE.md to see best practices"
elif [ "$PASS_COUNT" -ge 4 ]; then
    echo "✅ Good work! Fix remaining items for 100%"
else
    echo "⚠️  Needs improvement. Review solution/CLAUDE.md for guidance"
fi

exit 0
