#!/usr/bin/env node

/**
 * Documentation Quality Validation Hook
 *
 * Validates markdown files before Write/Edit operations to maintain
 * documentation integrity across the claude-config-template project.
 *
 * Checks:
 * - Broken internal links
 * - Version consistency
 * - Markdown formatting
 * - Common documentation errors
 *
 * Usage: Configured in .claude/settings.json as PreToolUse hook
 */

const fs = require('fs');
const path = require('path');

// Read hook input from stdin
const input = JSON.parse(fs.readFileSync('/dev/stdin', 'utf8'));

// Only validate Write/Edit operations on markdown files
if (input.tool !== 'Write' && input.tool !== 'Edit') {
  process.exit(0);
}

const filePath = input.parameters.file_path || '';
if (!filePath.endsWith('.md')) {
  process.exit(0); // Only validate markdown files
}

// Get content being written
const content = input.parameters.content || input.parameters.new_string || '';

// Validation checks
const warnings = [];
const errors = [];

// 1. Check for broken internal links
const linkPattern = /\[([^\]]+)\]\(([^)]+)\)/g;
let match;
while ((match = linkPattern.exec(content)) !== null) {
  const linkTarget = match[2];

  // Check internal markdown links
  if (linkTarget.endsWith('.md') && !linkTarget.startsWith('http')) {
    // Resolve relative to file being edited
    const baseDir = path.dirname(filePath);
    const targetPath = path.resolve(baseDir, linkTarget);

    if (!fs.existsSync(targetPath)) {
      warnings.push(`Broken link: "${match[1]}" → ${linkTarget}`);
    }
  }
}

// 2. Check for version consistency (if modifying version-sensitive files)
const versionPattern = /v?(\d+\.\d+\.\d+)/g;
const versionMatches = [...content.matchAll(versionPattern)];
if (versionMatches.length > 0 && (filePath.includes('README') || filePath.includes('CHANGELOG') || filePath.includes('CLAUDE.md'))) {
  const versions = versionMatches.map(m => m[1]);
  const uniqueVersions = [...new Set(versions)];

  if (uniqueVersions.length > 1) {
    warnings.push(`Multiple versions found: ${uniqueVersions.join(', ')} - verify consistency`);
  }
}

// 3. Check markdown formatting
// Heading hierarchy (no skipping levels)
const headingPattern = /^(#+)\s+(.+)$/gm;
const headings = [];
while ((match = headingPattern.exec(content)) !== null) {
  headings.push(match[1].length);
}

for (let i = 1; i < headings.length; i++) {
  if (headings[i] > headings[i-1] + 1) {
    warnings.push(`Heading hierarchy skip detected (h${headings[i-1]} → h${headings[i]})`);
    break;
  }
}

// 4. Check for unclosed code blocks
const codeBlockCount = (content.match(/```/g) || []).length;
if (codeBlockCount % 2 !== 0) {
  errors.push('Unclosed code block detected (odd number of ```)');
}

// Decision based on findings
if (errors.length > 0) {
  // BLOCK - critical errors
  console.log(JSON.stringify({
    approved: false,
    systemMessage:
      `🚨 Documentation Quality Error\n\n` +
      `Critical issues found in ${path.basename(filePath)}:\n\n` +
      errors.map((e, i) => `${i+1}. ${e}`).join('\n') +
      `\n\nPlease fix before proceeding.`,
    suggestedAction: 'deny'
  }));
  process.exit(1);
}

if (warnings.length > 0) {
  // WARN - but allow
  console.log(JSON.stringify({
    approved: true,
    systemMessage:
      `⚠️  Documentation Quality Warnings\n\n` +
      `Found ${warnings.length} warning(s) in ${path.basename(filePath)}:\n\n` +
      warnings.map((w, i) => `${i+1}. ${w}`).join('\n') +
      `\n\nReview recommended but operation allowed.`
  }));
  process.exit(0);
}

// All checks passed
process.exit(0);
