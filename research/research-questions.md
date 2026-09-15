# Research Questions

## Primary Research Question

**How much practical performance and usability can be recovered from a constrained legacy workstation through zero-cost operating-system and software remediation?**

## RQ1 — Environment Transition

**What is the effect of replacing the existing Windows environment with a Linux Mint Xfce environment on resource utilization and system responsiveness?**

RQ1 evaluates the combined Windows → Linux Mint Xfce transition. It does not independently attribute differences to Linux, Xfce, drivers or another individual component.

## RQ2 — Intervention Effectiveness

**Which individual post-installation remediation interventions produce measurable improvements when compared against a defined Linux reference configuration?**

RQ2 uses isolated intervention experiments where practical. The cumulative remediation track is reported separately.

## RQ3 — Local AI Feasibility

**Under a fixed offline workload, can a quantized CPU-only language model provide practically useful assistance on the experimental hardware?**

A model configuration is considered practically usable only when all of these conditions are met:

1. All mandatory offline tasks complete.
2. Outputs satisfy task-specific correctness criteria.
3. Median generation throughput is at least **5 tokens/second** for the defined coding workload.
4. No system-level failure occurs.
5. Basic workstation interaction remains possible during inference.

The 5 tokens/second threshold is a study decision rule, not a universal definition of useful local inference.

## RQ4 — Workload Trade-offs

**What measurable resource and responsiveness trade-offs emerge when programming, productivity, gaming, and local AI workloads compete for the same constrained hardware?**

## Scope

The experiment uses one fixed HP ProBook 640 G1 under a strict **$0 hardware expenditure constraint**.

No hardware replacement is permitted during the primary experiment.

Results are treated as a single-system case study and are not automatically generalizable.

## Study completion criteria

The study is complete when required baselines, intervention records, raw data, reproducible analysis and limitations have been documented and unsupported claims removed.