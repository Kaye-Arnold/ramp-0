# Hypotheses

These are testable propositions, not assumed conclusions.

## H1 — Lightweight Environment

**Proposition:** Replacing Windows with Linux Mint Xfce will reduce baseline resource overhead and improve selected responsiveness measures.

**Metrics:** idle RAM, idle CPU utilization, median boot time, median application launch time.

**Comparison:** B0 versus B1.

**Decision:** supported only if Linux achieves both at least **15% lower median idle RAM** and at least **10% lower median boot time**. One criterion met = partially supported.


## H2 — Memory Pressure and HDD Swap Reduction

**Proposition:** zram will reduce HDD-backed swap activity during the defined memory-pressure workload.

**Metrics:** peak RAM, zram usage, disk-backed swap, swap-in, swap-out, major page faults, HDD read/write activity, duration.

**Comparison:** B2 without zram versus equivalent B2 with zram.

**Decision:** supported if zram reduces disk-backed swap usage by at least **50%** and measured HDD write activity by at least **20%**. Neither criterion met = not supported.

## H3 — Background Workload Reduction

**Proposition:** Removing non-essential startup/background workloads will reduce idle system activity without breaking required functions.

**Metrics:** idle CPU, idle RAM, background process count, disk I/O.

**Comparison:** B2 versus isolated service-remediation configuration.

**Decision:** supported if either median idle RAM or median idle CPU falls by at least **10%**, with no required-function failure.

## H4 — Desktop Rendering Efficiency

**Proposition:** Restrained XFCE compositor and visual effects will reduce rendering overhead on Intel HD Graphics 4600.

**Metrics:** CPU utilization during defined desktop workload, rendering/frame-time behaviour where measurable, qualitative stutter observations, functional regressions.

**Comparison:** B2 default/stabilized desktop versus performance-oriented desktop.

**Decision:** supported only if measurable rendering-related overhead decreases with no loss of required desktop functionality. Subjective improvement alone is qualitative evidence.

## H5 — Quantized Local AI Feasibility

**Proposition:** At least one small quantized model configuration will execute the predefined offline workload within the available hardware envelope.

**Metrics:** model load time, peak RAM, prompt-processing rate, generation throughput, task completion, task correctness, system responsiveness.

**Decision:** a configuration is practically usable only when all RQ3 criteria are satisfied.

## H6 — CPU Inference Limitation

**Proposition:** CPU-only inference will remain a dominant performance bottleneck after OS and model optimization.

**Metrics:** generation throughput, CPU utilization, model load time, RAM consumption, responsiveness.

**Decision:** supported if inference is demonstrably CPU-bound, sustained CPU utilization approaches saturation, and generation remains below the practical-use target despite the selected model fitting the intended memory envelope.

## H7 — Workload Contention

**Proposition:** Concurrent local AI inference will measurably degrade development/productivity workload completion time.

**Metrics:** workload completion time, CPU, RAM, AI throughput.

**Comparison:** workload alone versus the same workload with concurrent inference.

**Decision:** supported if concurrent inference increases median workload completion time by at least **15%**.

## Interpretation

Allowed outcomes:

- Supported
- Partially supported
- Not supported
- Inconclusive

A hypothesis is never supported solely because a result appears plausible.