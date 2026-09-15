# RAMP-0

## Resource-Aggressive Maximization of a Legacy Workstation

> **Can disciplined software and operating-system remediation recover meaningful performance and usability from legacy hardware under a strict $0 budget?**

RAMP-0 is an empirical systems-engineering case study investigating the practical limits of software-based optimization on a constrained legacy workstation.

The experimental platform is an **HP ProBook 640 G1** equipped with:

* Intel Core i5-4310M
* 2 physical cores / 4 logical processors
* 16 GB RAM
* Intel HD Graphics 4600
* 500 GB-class mechanical HDD

The hardware remains fixed throughout the primary experiment.

## Constraint

**Hardware expenditure: $0**

The objective is to maximize practical usability without purchasing replacement hardware.

## Target Workloads

* Software development
* Office and productivity work
* General GUI computing
* Lightweight gaming
* CPU-only local LLM inference

## Research Questions

**RQ1.** How much can operating-system remediation reduce resource overhead on legacy hardware?

**RQ2.** Which remediation interventions contribute most to measurable system responsiveness?

**RQ3.** Can aggressively quantized CPU-only local inference remain practically useful on constrained hardware?

**RQ4.** What trade-offs emerge when development, productivity, gaming, and local AI workloads share the same machine?

## Experimental Method

The project follows a controlled:

**baseline → intervention → measurement → comparison**

workflow.

Each intervention is documented with:

1. Context
2. Hypothesis
3. Intervention
4. Measurement
5. Result
6. Limitations
7. Status

Results are recorded from the actual experimental machine rather than estimated from theoretical specifications.

## Evidence Policy

RAMP-0 distinguishes between:

* **Observed** — directly measured or recorded
* **Verified** — independently checked against an authoritative source or repeatable test
* **Inferred** — reasoned from observed evidence
* **Unverified** — currently unsupported

The project does not treat expected improvements as measured results.

## Current Status

**Phase 0 — Experimental setup and baseline capture**

No final performance claims have been made.

## Repository Structure

```text
research/       Research questions, hypotheses, methodology and validity
hardware/       Hardware, firmware and diagnostic records
baseline/       Pre/post remediation measurements
remediation/    Individual system interventions
benchmarks/     Workload-specific measurements
data/           Raw and processed experimental data
results/        Tables and figures
scripts/        Reproducible measurement utilities
decisions/      Architecture and engineering decision records
docs/           Supporting technical documentation
```

## Project Principle

> **Optimize aggressively. Measure conservatively. Never let the claim outrun the evidence.**
