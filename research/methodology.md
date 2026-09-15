# Methodology

## 1. Experimental design

RAMP-0 uses two complementary tracks.

### Track A — Cumulative remediation

The actual workstation progresses from B0 → B1 → B2 → individual remediation stages → final workstation.

Cumulative measurements describe the state of the complete system and do not establish isolated causal effects.

### Track B — Isolated intervention experiments

Where RQ2 requires attribution, B2 is restored before a single intervention is tested.

Restoration may use configuration snapshots, service manifests, package-state records, reproducible scripts, documented reversals, or controlled reconstruction/reinstallation.

If reliable restoration is impossible, the result is reported as cumulative rather than isolated.

## 2. Baselines

### B0
Final Windows configuration before migration.

### B1
Fresh Linux Mint Xfce after required updates and before RAMP-specific tuning.

### B2
Stabilized Linux reference configuration used for isolated interventions.

B2 is frozen and documented before isolated experiments begin.

## 3. Attribution rules

- B0 → B1 measures the combined environment transition.
- B2 → isolated intervention measures the tested intervention under defined conditions.
- Sequential measurements describe cumulative state.
- Cumulative measurements must not be reported as isolated causal effects.
- Infeasible isolation must be disclosed.

## 4. Version control

Every baseline and benchmark records exact versions for relevant components, including:

- OS and edition
- Linux kernel
- firmware/BIOS
- graphics driver/stack where identifiable
- compiler/toolchain
- Python
- Node.js
- Java
- Flutter/Dart where relevant
- development environment where benchmarked
- AI runtime
- exact model name and revision/source
- quantization
- benchmark script revision

Any later version change is recorded with the affected intervention/experiment.

## 5. Variables

Potential independent variables:

- operating environment
- memory/swap configuration
- startup/background services
- desktop rendering configuration
- AI runtime
- model size
- model quantization

Dependent variables may include:

- idle RAM
- idle CPU
- disk I/O
- boot time
- application launch time
- compilation time
- peak memory
- zram use
- disk-backed swap
- swap-in/out
- major page faults
- model load time
- prompt-processing rate
- generation throughput
- task completion/correctness
- frame rate/frame time
- concurrent workload completion time

## 6. Model controls

For OS/runtime comparisons, the model, exact revision, quantization, context configuration, prompt and benchmark workload remain fixed.

For model-matrix experiments, model, parameter scale, quantization, file size, context length and runtime may intentionally vary and are analyzed separately.

## 7. Quantitative repetition

Unless a documented experiment-specific protocol justifies otherwise:

- **N = 5 runs per quantitative configuration.**
- Run order is recorded.
- Initial state is restored between runs.
- Cold/warm state is explicit.
- Comparable runs use identical workload inputs.
- Median is the primary statistic.
- Minimum, maximum and raw observations are retained.
- Mean may be reported as secondary information.

A single favourable run cannot establish a quantitative result.

## 8. Reset and cold/warm rules

Cold runs follow the experiment's reboot/process-reset procedure.

Warm runs follow the defined warm-up procedure.

Before an isolated run, restore and verify the reference state, reboot when required, allow stabilization, then execute the workload.

A failed reset invalidates that run for causal comparison until the reference state is restored.

## 9. Memory-pressure measurement

H2 must directly measure initial/peak RAM, zram, disk-backed swap, swap-in/out, major page faults, HDD reads/writes, duration and completion.

The no-zram and zram configurations use the same pressure workload, target condition, duration, stopping rule, application set, run count and power state.

Idle RAM alone cannot establish H2's swapping mechanism.

## 10. Outliers and failed runs

No measurement may be silently discarded.

Any exclusion records the original value, reason, rule and impact on the result.

Failed runs remain part of the research record.

## 11. Final system

The final remediated workstation is benchmarked as a complete system.

These results describe the finished system rather than attributing total change to an individual intervention.

## 12. Evidence classification

Every significant result is labelled Observed, Verified, Inferred or Unverified.

Expected results are never treated as observations.