# RAMP-0
## Resource-Aggressive Maximization of a Legacy Workstation

> **Can disciplined software and operating-system remediation recover meaningful performance and usability from legacy hardware under a strict $0 budget?**

RAMP-0 is an empirical systems-engineering case study investigating how far zero-cost software and operating-system remediation can improve a constrained legacy workstation.

### Experimental platform

**HP ProBook 640 G1**

- Intel Core i5-4310M
- 2 physical cores / 4 logical processors
- 16 GB RAM
- Intel HD Graphics 4600
- 500 GB-class mechanical HDD

The hardware remains fixed throughout the primary experiment.

### Constraint

**Hardware expenditure: $0**

No hardware replacement is permitted during the primary experiment.

### Target workloads

- Software development
- Office and productivity work
- General GUI computing
- Lightweight gaming
- CPU-only local LLM inference

### Research questions

**RQ1.** What is the effect of replacing the existing Windows environment with a Linux Mint Xfce environment on resource utilization and system responsiveness?

**RQ2.** Which individual post-installation remediation interventions produce measurable improvements against a defined Linux reference configuration?

**RQ3.** Can an aggressively quantized CPU-only language model provide practically useful offline assistance on the experimental hardware?

**RQ4.** What measurable trade-offs emerge when programming, productivity, gaming, and local AI workloads compete for the same constrained hardware?

### Experimental design

RAMP-0 uses two tracks:

1. **Cumulative remediation:** records the actual progression from Windows to the final optimized workstation.
2. **Isolated intervention experiments:** restore a defined Linux reference state and vary one intervention when causal attribution is required.

### Baselines

| State | Definition |
|---|---|
| B0 | Final Windows configuration before migration |
| B1 | Fresh Linux Mint Xfce after required updates and before RAMP tuning |
| B2 | Stabilized Linux reference used for isolated interventions |

### Evidence policy

- **Observed** — directly measured or recorded.
- **Verified** — checked against an authoritative or repeatable source.
- **Inferred** — reasoned from observations.
- **Unverified** — insufficient evidence currently exists.

Expected performance is never presented as measured performance. Failed, neutral and negative interventions are retained.

### Principle

> **Optimize aggressively. Measure conservatively. Never let the claim outrun the evidence.**

### Status

**Phase 0 — Experimental protocol and baseline preparation**

No final performance claims have been made.

### Privacy

Machine identifiers, product IDs, serial numbers, MAC addresses, credentials, personal files and other sensitive information are excluded from the public research record.