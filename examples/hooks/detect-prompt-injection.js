#!/usr/bin/env node

/**
 * Prompt Injection Detection Hook
 *
 * Scans external content for malicious patterns that attempt to
 * manipulate the AI agent's behavior.
 *
 * Usage: Add to .claude/settings.json:
 * {
 *   "hooks": {
 *     "PreToolUse": {
 *       "command": "node",
 *       "args": [".claude/hooks/detect-prompt-injection.js"],
 *       "matchers": [
 *         "WebFetch(*)",
 *         "WebSearch(*)",
 *         "mcp__brave-search__search(*)",
 *         "mcp__fetch__fetch(*)"
 *       ],
 *       "timeout": 2000
 *     }
 *   }
 * }
 */

const fs = require('fs');

// Read hook input from stdin
const input = JSON.parse(fs.readFileSync('/dev/stdin', 'utf8'));

// Malicious pattern signatures
const MALICIOUS_PATTERNS = [
  // Direct instruction overrides
  /ignore\s+(all\s+)?previous\s+instructions?/gi,
  /disregard\s+(all\s+)?previous\s+(instructions?|commands?)/gi,
  /forget\s+(all\s+)?previous\s+(instructions?|context)/gi,
  /override\s+(all\s+)?previous\s+(instructions?|commands?)/gi,

  // System prompt manipulation
  /you\s+are\s+now\s+(a\s+)?different\s+(ai|assistant|model|bot)/gi,
  /your\s+new\s+(role|purpose|instruction|job)\s+is/gi,
  /system\s*:\s*new\s+(instruction|directive|command|prompt)/gi,
  /reset\s+your\s+(instructions?|programming|system)/gi,

  // Information extraction attempts
  /reveal\s+(your|the)\s+(api\s+key|token|secret|password|credentials?)/gi,
  /show\s+me\s+(your|the)\s+(configuration|settings|env|credentials?|api\s+key)/gi,
  /what\s+(are|is)\s+(your|the)\s+(api|github|secret)\s+(key|token|password)/gi,
  /display\s+(your|the)\s+(token|secret|credential|key)/gi,
  /print\s+(your|the)\s+(api|secret|token|key)/gi,

  // Behavior modification
  /from\s+now\s+on,?\s+you\s+(will|must|should|shall)/gi,
  /override\s+(your|the)\s+(rules|guidelines|instructions|safety)/gi,
  /bypass\s+(security|safety|restrictions?|filters?)/gi,
  /disable\s+(your\s+)?(safety|security|restrictions?|filters?)/gi,

  // Role confusion
  /you\s+are\s+in\s+(debug|developer|admin|root)\s+mode/gi,
  /enable\s+(debug|admin|root|developer)\s+(mode|access|privileges?)/gi,
  /switch\s+to\s+(unrestricted|unfiltered|debug|admin)\s+mode/gi,
  /activate\s+(admin|debug|developer)\s+(mode|access)/gi,

  // Jailbreak attempts
  /do\s+anything\s+now/gi,
  /dan\s+mode/gi,
  /jailbreak/gi,
  /act\s+as\s+if\s+you\s+(have\s+)?no\s+(restrictions?|limits?|guidelines?)/gi,

  // Prompt leaking
  /repeat\s+(your|the)\s+(system\s+)?(prompt|instructions?)/gi,
  /what\s+(are|is)\s+your\s+(system\s+)?(prompt|instructions?)/gi,
  /show\s+me\s+your\s+(system\s+)?(prompt|instructions?)/gi,
];

// Additional suspicious patterns (lower confidence)
const SUSPICIOUS_PATTERNS = [
  // Excessive repetition (potential attack)
  /(.{20,}?)\1{5,}/g,

  // Unusual encoding hints
  /base64|decode|decrypt|deobfuscate/gi,

  // Multiple conflicting instructions
  /(but\s+)?actually\s+ignore/gi,
];

// Check if tool is fetching external content
const isExternalContent =
  input.tool === 'WebFetch' ||
  input.tool === 'WebSearch' ||
  input.tool === 'mcp__brave-search__search' ||
  input.tool === 'mcp__fetch__fetch' ||
  input.tool === 'mcp__context7__get-library-docs';

if (!isExternalContent) {
  // Not external content, allow without scanning
  process.exit(0);
}

// Get content to scan
const content = JSON.stringify(input.parameters).toLowerCase();

// Scan for high-confidence malicious patterns
let detectedMalicious = [];
for (const pattern of MALICIOUS_PATTERNS) {
  const matches = content.match(pattern);
  if (matches) {
    detectedMalicious.push({
      pattern: pattern.source,
      matches: matches.slice(0, 3), // Limit to first 3 matches
      confidence: 'high'
    });
  }
}

// Scan for suspicious patterns
let detectedSuspicious = [];
for (const pattern of SUSPICIOUS_PATTERNS) {
  const matches = content.match(pattern);
  if (matches) {
    detectedSuspicious.push({
      pattern: pattern.source,
      matches: matches.slice(0, 2),
      confidence: 'medium'
    });
  }
}

// Decide action based on detections
if (detectedMalicious.length > 0) {
  // High confidence malicious content - BLOCK
  console.log(JSON.stringify({
    approved: false,
    systemMessage:
      `🚨 SECURITY ALERT: Prompt injection detected!\n\n` +
      `Found ${detectedMalicious.length} high-risk pattern(s):\n` +
      detectedMalicious.map((d, i) =>
        `${i+1}. "${d.matches[0]}" (confidence: ${d.confidence})`
      ).join('\n') +
      `\n\nThis content has been BLOCKED for your safety.\n` +
      `Source: ${input.tool}\n\n` +
      `If this is a false positive, you can:\n` +
      `1. Review the content manually\n` +
      `2. Adjust detection rules in .claude/hooks/detect-prompt-injection.js\n` +
      `3. Temporarily disable the hook if needed`,
    suggestedAction: 'deny'
  }));
  process.exit(1);
}

if (detectedSuspicious.length >= 3) {
  // Multiple suspicious patterns - WARN
  console.log(JSON.stringify({
    approved: true, // Allow but warn
    systemMessage:
      `⚠️  WARNING: Suspicious patterns detected in external content.\n\n` +
      `Found ${detectedSuspicious.length} medium-risk pattern(s):\n` +
      detectedSuspicious.map((d, i) =>
        `${i+1}. Pattern: ${d.pattern.substring(0, 50)}...`
      ).join('\n') +
      `\n\nContent is allowed but review carefully.\n` +
      `Source: ${input.tool}\n\n` +
      `Monitor for unusual behavior and report if necessary.`
  }));
  process.exit(0);
}

// No malicious patterns found - ALLOW
process.exit(0);
