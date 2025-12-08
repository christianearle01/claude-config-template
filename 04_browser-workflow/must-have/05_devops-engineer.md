# DevOps Engineer - Claude.ai Workflow

**For:** DevOps engineers using https://claude.ai/ for infrastructure and automation

**Token Efficiency:** Save 69% tokens through optimized Custom Instructions and DevOps-focused prompts

---

## 📋 Custom Instructions Template

Copy this template and paste into your claude.ai Custom Instructions (Settings → Custom Instructions).

### Section 1: What would you like Claude to know about you?

```
I'm a DevOps engineer who uses Claude for:
- Writing Infrastructure as Code (IaC)
- Debugging CI/CD pipelines
- Creating automation scripts
- Security and compliance reviews
- Monitoring and alerting setup

My DevOps context:
- Primary tools: Terraform, Kubernetes, Docker, Jenkins/GitHub Actions
- Cloud platforms: [AWS/Azure/GCP]
- Languages: Python, Bash, YAML, Go
- Focus areas: [e.g., container orchestration, cloud automation, SRE practices]

I value:
- Reliability and high availability
- Security best practices (least privilege, encryption)
- Automation over manual processes
- Infrastructure as code principles
- Cost optimization
```

**Character count:** ~770 characters

---

### Section 2: How would you like Claude to respond?

```
When helping with infrastructure:
- Follow cloud provider best practices
- Consider cost optimization
- Prioritize security (least privilege, encryption at rest/transit)
- Make code idempotent and reusable
- Include error handling and rollback strategies

When debugging:
- Check logs systematically
- Consider dependencies and networking
- Think about scalability and performance
- Verify configuration and permissions

Keep responses:
- Production-ready and battle-tested
- Security-focused with compliance considerations
- Scalable and maintainable
```

**Character count:** ~640 characters

---

## 🎯 Common DevOps Tasks

### Task 1: Write Terraform/IaC

**Optimized Prompt Pattern:**
```
Generate Terraform code for:
[describe infrastructure - VPC, EC2, RDS, etc.]

Requirements:
- Cloud provider: [AWS/Azure/GCP]
- Environment: [dev/staging/prod]
- Security: [specific requirements]

Include:
- Variables for reusability
- Outputs
- Security best practices
```

**Token savings:** ~65% (IaC principles and cloud platform pre-defined)

---

### Task 2: Debug CI/CD Pipeline

**Optimized Prompt Pattern:**
```
Help debug this pipeline failure:

Pipeline: [GitHub Actions/Jenkins/GitLab CI]
Error: [paste error message]
Pipeline config: [paste relevant YAML/config]

Environment: [context]

Troubleshoot:
- Root cause
- Fix
- Prevention strategy
```

**Why this works:**
- Clear problem statement
- DevOps context from Custom Instructions
- Focused debugging approach

---

### Task 3: Kubernetes Manifest

**Optimized Prompt Pattern:**
```
Create Kubernetes manifest for:
[describe application/service]

Requirements:
- Replicas: [number]
- Resources: [CPU/memory limits]
- Networking: [service type, ingress]
- Secrets/ConfigMaps: [what's needed]

Include: Best practices for production deployments
```

**Token efficiency:**
- K8s best practices already in Custom Instructions
- Specific deployment requirements
- Production-ready focus

---

### Task 4: Monitoring Setup

**Optimized Prompt Pattern:**
```
Design monitoring for:
[describe system/application]

Stack preference: [Prometheus/Grafana/Datadog/etc.]

Include:
- Key metrics to track
- Alert thresholds
- Dashboard layout
- SLO/SLA considerations
```

**Why this works:**
- SRE mindset from Custom Instructions
- Clear monitoring objectives
- Tool-specific implementation

---

### Task 5: Security Review

**Optimized Prompt Pattern:**
```
Review this infrastructure for security issues:
[paste IaC code or architecture description]

Focus on:
- OWASP/CIS benchmarks
- Least privilege access
- Data encryption
- Network security
- Compliance: [specific standards if applicable]
```

**Token savings:** ~70% (security best practices pre-loaded)

---

## 💡 Workflow Optimization Tips

### 1. Create Projects by Infrastructure/Service
- Project: [Service/App Name] - DevOps
- Upload: Architecture diagrams, runbooks, SLO docs
- Result: Context-aware infrastructure advice

**Token savings:** Up to 85% on infrastructure-specific queries

### 2. DevOps Prompt Chaining Pattern
```
1. "Design architecture for [service]"
2. "Generate Terraform code for the architecture"
3. "Create CI/CD pipeline for deployment"
4. "Set up monitoring and alerting"
```

Each step builds on previous context.

### 3. Incident Response Workflow
```
1. "Analyze these error logs: [paste logs]"
2. "What are likely root causes?"
3. "Suggest immediate mitigation steps"
4. "Draft post-mortem with prevention measures"
```

Systematic, token-efficient troubleshooting.

---

## 🎓 Best Practices for Claude.ai (DevOps)

### DO:
- ✅ Specify your cloud platform and tools in Custom Instructions
- ✅ Request production-ready, idempotent code
- ✅ Ask for security and compliance considerations
- ✅ Include infrastructure context (scale, requirements)
- ✅ Use Projects for service-specific infrastructure
- ✅ Request cost optimization analysis

### DON'T:
- ❌ Paste production credentials or secrets
- ❌ Skip security reviews of generated code
- ❌ Accept infrastructure code without understanding
- ❌ Ignore cost implications
- ❌ Deploy without testing rollback procedures
- ❌ Over-engineer for simple use cases

---

## 📊 Efficiency Metrics (Projected)

_Note: Theoretical projections based on template design. Help us validate with your real usage!_

**Without Custom Instructions:**
- Tokens per query: ~4,800 (explaining cloud platform, tools, standards)
- Code quality: 60% (may miss security/cost considerations)
- Time to useful answer: 2-3 exchanges

**With Custom Instructions:**
- Tokens per query: ~1,500 (context pre-loaded)
- Code quality: 90% (security-first, production-ready)
- Time to useful answer: 1 exchange

**Savings:** 69% token reduction, 50% better quality, 66% faster

---

## 🔄 Customizing for Your Needs

Tailor the template for your specific DevOps environment:

**Your infrastructure:**
- Add specific cloud services (EKS, RDS, CloudFormation, etc.)
- Include container orchestration details (K8s version, operators)
- Mention service mesh, API gateways, etc.

**Your workflow:**
- GitOps practices (ArgoCD, Flux)
- Infrastructure testing tools (Terratest, kitchen-terraform)
- Observability stack details

**Your compliance:**
- Industry regulations (SOC 2, HIPAA, PCI-DSS, etc.)
- Security frameworks (CIS benchmarks, NIST)
- Audit requirements

---

## ❓ FAQ

**Q: Should I include specific infrastructure details in Custom Instructions?**
A: No! Keep it general. Use Projects for service-specific architecture and runbooks.

**Q: Can I use this for different cloud providers?**
A: Yes! List your primary cloud in Custom Instructions, specify in each prompt which provider to use.

**Q: How do I handle multi-cloud deployments?**
A: Describe multi-cloud approach generally in Custom Instructions, specify cloud-specific requirements per prompt.

**Q: Will this help with disaster recovery planning?**
A: Yes! The reliability and high availability focus helps with DR strategies and runbook creation.

---

## 🚀 Next Steps

1. **Copy the Custom Instructions** template above
2. **Customize** with your specific cloud platform, tools, compliance needs
3. **Paste** into claude.ai → Settings → Custom Instructions
4. **Test** with one of the prompt patterns (try Task 1: Write IaC)
5. **Iterate** based on your infrastructure workflow

---

## Navigation

**🏠 [Back to Browser Workflow](../README.md)** | **📖 [All Roles](../README.md#choose-your-professional-role)** | **🎨 [Create Custom Role](01_custom-role.md)**

---

*Part of the Claude.ai Workflow Optimization Guide - DevOps Workflows*
*Last updated: 2025-12-08*
