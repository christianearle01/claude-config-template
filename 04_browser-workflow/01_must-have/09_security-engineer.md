# Security Engineer - Claude.ai Workflow

**For:** Security engineers using https://claude.ai/ for security analysis

**Token Efficiency:** Save 70% tokens through optimized Custom Instructions and security-focused prompts

---

## 📋 Custom Instructions Template

Copy this template and paste into your claude.ai Custom Instructions (Settings → Custom Instructions).

### Section 1: What would you like Claude to know about you?

```
I'm a security engineer who uses Claude for:
- Security code review and vulnerability assessment
- Threat modeling and risk analysis
- Security testing and penetration testing guidance
- Compliance and audit preparation
- Security documentation and policies

My security context:
- Focus areas: [application security/cloud security/network security/pentesting]
- Frameworks: OWASP, NIST, CIS Benchmarks, [ISO 27001/SOC 2/etc.]
- Tools: [Burp Suite, Metasploit, static analysis tools, SIEM]
- Languages: [Python, Go, Bash for security automation]

I value:
- Defense in depth and layered security
- Threat-based prioritization
- Security by design (shift-left)
- Clear risk communication to stakeholders
- Compliance and regulatory adherence
```

**Character count:** ~910 characters

---

### Section 2: How would you like Claude to respond?

```
When helping with security reviews:
- Follow OWASP Top 10 and security best practices
- Identify both vulnerabilities and root causes
- Prioritize by risk (CVSS scoring or custom framework)
- Suggest remediation with code examples
- Consider compliance requirements

When analyzing threats:
- Use structured methodologies (STRIDE, PASTA, etc.)
- Consider attack vectors and threat actors
- Think like an attacker
- Provide defense strategies

Keep responses:
- Risk-focused with clear severity ratings
- Actionable with specific remediation steps
- Compliance-aware
```

**Character count:** ~680 characters

---

## 🎯 Common Security Engineering Tasks

### Task 1: Security Code Review

**Optimized Prompt Pattern:**
```
Review this code for security vulnerabilities:
[paste code]

Language: [language]
Context: [web app/API/service/etc.]

Check for:
- OWASP Top 10 (injection, XSS, auth issues, etc.)
- Sensitive data exposure
- Insecure configurations
- Business logic vulnerabilities

Compliance: [PCI-DSS/HIPAA/GDPR/etc. if applicable]
```

**Token savings:** ~65% (security frameworks pre-defined in Custom Instructions)

---

### Task 2: Threat Modeling

**Optimized Prompt Pattern:**
```
Perform threat modeling for:
[describe system/application/feature]

Architecture:
- Components: [list]
- Data flows: [describe]
- Trust boundaries: [internal/external/etc.]

Methodology: [STRIDE/PASTA/custom]

Identify:
- Threat actors and motivations
- Attack vectors
- Mitigation strategies
- Residual risks
```

**Why this works:**
- Structured threat analysis
- Security context from Custom Instructions
- Actionable mitigation strategies

---

### Task 3: Vulnerability Assessment

**Optimized Prompt Pattern:**
```
Assess vulnerabilities in:
[paste scan results, code, or system description]

Prioritize by:
- Exploitability
- Business impact
- Data sensitivity

Provide:
- Severity rating (Critical/High/Medium/Low)
- Remediation steps
- Compensating controls if fix is delayed
```

**Token efficiency:**
- Your risk framework already in Custom Instructions
- Specific prioritization criteria
- Actionable remediation

---

### Task 4: Security Test Plan

**Optimized Prompt Pattern:**
```
Create security test plan for:
[describe application/feature]

Testing types needed:
- [SAST/DAST/penetration testing/etc.]

Include:
- Test scenarios (authentication, authorization, input validation, etc.)
- Tools to use
- Expected findings categories
- Success criteria
```

**Why this works:**
- Security testing approach from Custom Instructions
- Comprehensive test coverage
- Clear success metrics

---

### Task 5: Compliance Review

**Optimized Prompt Pattern:**
```
Review for [PCI-DSS/HIPAA/SOC 2/GDPR/etc.] compliance:
[paste architecture/code/policy]

Requirements:
- [specific sections/controls]

Check for:
- Control implementation
- Evidence requirements
- Gaps and remediation
```

**Token savings:** ~70% (compliance frameworks pre-loaded)

---

## 💡 Workflow Optimization Tips

### 1. Create Projects by Application/System
- Project: [AppName] - Security Review
- Upload: Architecture diagrams, data flow diagrams, threat models
- Result: Context-aware security analysis

**Token savings:** Up to 85% on application-specific security work

### 2. Security Review Prompt Chaining Pattern
```
1. "Perform threat model for [system]"
2. "Review code for identified threats"
3. "Create penetration test plan"
4. "Draft remediation recommendations"
```

Each step builds on previous context.

### 3. Incident Response Workflow
```
1. "Analyze this security incident: [description]"
2. "Identify attack vector and indicators of compromise"
3. "Suggest containment and remediation steps"
4. "Draft incident report and lessons learned"
```

Systematic, token-efficient incident handling.

---

## 🎓 Best Practices for Claude.ai (Security Engineering)

### DO:
- ✅ Specify your security focus and frameworks in Custom Instructions
- ✅ Request OWASP/NIST-compliant analysis
- ✅ Ask for risk-based prioritization
- ✅ Include compliance context when relevant
- ✅ Use Projects for system-specific security work
- ✅ Request both vulnerabilities and remediation

### DON'T:
- ❌ Share production credentials or secrets
- ❌ Skip risk assessment of findings
- ❌ Accept generic security advice without context
- ❌ Ignore compliance requirements
- ❌ Over-rely on automated tools alone
- ❌ Deploy fixes without testing

---

## 📊 Efficiency Metrics (Projected)

_Note: Theoretical projections based on template design. Help us validate with your real usage!_

**Without Custom Instructions:**
- Tokens per query: ~5,100 (explaining security frameworks, compliance, tools)
- Review quality: 65% (may miss framework-specific issues)
- Time to useful answer: 2-3 exchanges

**With Custom Instructions:**
- Tokens per query: ~1,550 (context pre-loaded)
- Review quality: 92% (framework-compliant, risk-prioritized)
- Time to useful answer: 1 exchange

**Savings:** 70% token reduction, 42% better quality, 66% faster

---

## 🔄 Customizing for Your Needs

Tailor the template for your specific security work:

**Your security focus:**
- Add specific security domains (API security, container security, etc.)
- Include penetration testing methodologies
- Mention security automation tools

**Your compliance:**
- Industry regulations (PCI-DSS, HIPAA, GDPR, etc.)
- Security frameworks (ISO 27001, SOC 2, NIST CSF)
- Audit requirements

**Your workflow:**
- Security testing cadence
- Vulnerability management process
- Incident response procedures

---

## ❓ FAQ

**Q: Should I include specific vulnerability details in Custom Instructions?**
A: No! Keep it general. Use Projects for system-specific threat models and security assessments.

**Q: Can I use this for different security domains?**
A: Yes! List your primary domain in Custom Instructions, specify in each prompt which area to focus on.

**Q: How do I handle proprietary security tooling?**
A: Describe tool categories generally in Custom Instructions, keep proprietary details in specific prompts.

**Q: Will this help with security awareness training?**
A: Yes! The clear risk communication focus helps with creating training materials and stakeholder briefings.

---

## 🚀 Next Steps

1. **Copy the Custom Instructions** template above
2. **Customize** with your specific security focus, frameworks, compliance needs
3. **Paste** into claude.ai → Settings → Custom Instructions
4. **Test** with one of the prompt patterns (try Task 1: Security Code Review)
5. **Iterate** based on your security workflow

---

## Navigation

**🏠 [Back to Browser Workflow](../README.md)** | **📖 [All Roles](../README.md#choose-your-professional-role)** | **🎨 [Create Custom Role](01_custom-role.md)**

---

*Part of the Claude.ai Workflow Optimization Guide - Security Engineering Workflows*
*Last updated: 2025-12-08*
