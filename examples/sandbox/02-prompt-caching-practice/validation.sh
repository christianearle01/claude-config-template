#!/bin/bash
echo "🔍 Validating prompt caching structure..."
CLAUDE_FILE="starter-files/CLAUDE.md"

if [ ! -f "$CLAUDE_FILE" ]; then
    echo "❌ CLAUDE.md not found"
    exit 1
fi

# Check token count (approximate: 4 chars per token)
CHAR_COUNT=$(wc -c < "$CLAUDE_FILE")
TOKEN_EST=$((CHAR_COUNT / 4))

if [ "$TOKEN_EST" -ge 1024 ]; then
    echo "✅ File size adequate for caching ($TOKEN_EST tokens est.)"
else
    echo "❌ File too small ($TOKEN_EST tokens est., need 1024+)"
fi

# Check structure
if grep -q "Tech Stack\|Architecture" "$CLAUDE_FILE" | head -200; then
    echo "✅ Stable content appears first"
else
    echo "⚠️  Put stable content (Tech Stack, Architecture) at top"
fi

echo "✅ Validation complete!"
