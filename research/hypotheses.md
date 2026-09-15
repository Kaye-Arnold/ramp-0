# Hypotheses

These are testable propositions, not assumed conclusions.

## H1 — Lightweight Environment

**Proposition:** Replacing Windows with Linux Mint Xfce will reduce baseline resource overhead and improve selected responsiveness measures.

**Metrics:**

* idle RAM;
* idle CPU utilization;
* median boot time;
* median application launch time.

**Comparison:** B0 versus B1.

**Decision:** H1 is **SUPPORTED** only if Linux achieves both:

* at least **15% lower median idle RAM**; and
* at least **10% lower median boot time**.

Exactly one criterion met = **PARTIALLY SUPPORTED**.

Neither criterion met = **NOT SUPPORTED**.

A required comparison that cannot be validly completed = **INCONCLUSIVE**.

The thresholds are study-specific decision rules and are not universal definitions of Linux performance.

---

## H2 — Memory Pressure and HDD-Backed Swap Reduction

**Proposition:** Enabling zram will reduce HDD-backed swap activity during the defined memory-pressure workload.

### H2 Comparison

**Control:** B2 with zram disabled.

**Intervention:** Equivalent B2 configuration with zram enabled.

The control and intervention must be identical with respect to hardware, operating-system and kernel version, workload, workload parameters, measurement procedure, power configuration, relevant background state, and other controlled conditions.

Only the zram condition is intentionally varied.

The zram state must be independently verified and recorded before every run.

### H2 Primary Criteria

H2 has two primary criteria.

#### Criterion 1 — Disk-Backed Swap Activity

At least **50% reduction** in cumulative bytes written to **non-zram swap devices backed by physical storage** during the primary H2 measurement window.

Swap occupancy is not the primary metric.

Zram traffic is excluded from this metric.

The disk-backed swap device or device set must be explicitly identified before primary data collection begins.

#### Criterion 2 — Physical HDD Writes

At least **20% reduction** in cumulative bytes written to the identified **physical rotational HDD device or devices** during the same primary H2 measurement window.

All write traffic to the identified HDD device or devices is included.

The HDD write metric is measured in bytes rather than I/O-operation count.

### H2 Measurement Definition

For each primary metric, the run-level value is a counter delta:

$$
\Delta Metric = Counter_{end} - Counter_{start}
$$

The start and end counters must correspond to the same defined measurement window.

The exact measurement tool, counter source, physical device identifier(s), unit, byte-conversion method, and collection procedure must be recorded in the experiment protocol **before primary E-003 data collection begins**.

The protocol must not claim an exact tool, counter, or device identifier until that information has been verified from the actual B2 system.

### H2 Measurement Window

The primary H2 measurement window begins when the predefined memory-pressure target is first attained.

The window continues for the predefined fixed hold duration.

The same pressure-target definition and hold duration are used for every valid control and intervention run.

Therefore, all valid primary measurements use an equal-duration measurement window.

An early-stop condition terminates the window before the normal stopping point and prevents that run from qualifying as a valid completed run.

### H2 Workload Requirements

Before primary data collection begins, the memory-pressure workload must have frozen values for:

* memory-allocation target;
* number of workload workers/processes;
* allocation method;
* whether allocated memory is actively touched or retained;
* pressure target;
* hold duration;
* sampling interval;
* maximum experiment duration;
* normal stopping condition;
* early-stop conditions.

A qualitative description such as "high memory usage" is not sufficient.

### H2 Normal Stopping Condition

The normal stopping condition is reached when:

1. the predefined memory-pressure target has been attained; and
2. the predefined hold duration has elapsed; and
3. no predefined early-stop condition has been triggered.

This condition is frozen before primary data collection.

It determines normal execution completion and the end of the normal H2 measurement window.

### H2 Early-Stop Conditions

A run may terminate before normal completion only when a predefined objective condition occurs.

Recognized conditions are:

**Workload failure:** the memory-pressure workload terminates unexpectedly before the normal stopping condition.

**Measurement failure:** a mandatory monitoring process terminates, becomes unavailable, or fails to record a required primary metric for the measurement window.

**Memory safety boundary:** available memory remains below the predefined safety floor continuously for the predefined safety interval. The numerical floor and interval must be frozen before data collection.

**Maximum experiment duration:** the workload reaches the predefined maximum experiment duration without satisfying the normal stopping condition.

**Predefined exclusion condition:** evidence is produced, but a predefined analytical exclusion rule makes the run ineligible for primary analysis.

Every early-stopped run must record:

* triggering condition;
* timestamp;
* relevant measured value;
* applicable threshold;
* execution status;
* analysis-eligibility status;
* classification reason.

Operators must not stop otherwise equivalent runs solely on subjective judgment.

### H2 Run Status Model

Execution status and analysis eligibility are distinct.

#### Execution Status

`completed` — the normal stopping condition was reached.

`failed` — execution terminated before the normal stopping condition because a predefined failure or early-stop condition occurred, including a condition that later triggers a predefined exclusion rule.

#### Analysis Eligibility

`eligible` — the completed run satisfies every validity requirement and may contribute to the primary analysis.

`excluded` — evidence exists, but a predefined exclusion rule prevents the run from contributing to the primary analysis.

A run may therefore be:

* `completed + eligible`;
* `completed + excluded`; or
* `failed + excluded`.

Only `completed + eligible` runs contribute to the primary H2 analysis.

Execution status and analysis eligibility are recorded separately.

A run that stops before the normal stopping condition is recorded as `failed` even if the eventual analysis status is `excluded`.

### H2 Valid Completed Run

A **valid completed run** is a run that satisfies all of the following:

1. The required B2 reference state was verified.
2. The intended zram control or intervention state was verified.
3. All controlled-condition checks passed.
4. The predefined memory-pressure target was reached.
5. The predefined target condition was maintained for the required hold duration.
6. The normal stopping condition was reached.
7. No early-stop failure condition occurred.
8. All mandatory primary measurements were successfully collected for the complete measurement window.
9. No predefined exclusion rule was triggered.
10. The raw evidence required to reconstruct the run-level measurements is present and intact.

Completion alone does not establish validity.

Only a `completed + eligible` run satisfying all validity criteria counts toward N.

### H2 Repetition

The primary analysis uses **exactly five valid completed runs per condition**.

Therefore:

* five valid completed control runs are required;
* five valid completed intervention runs are required.

Failed and excluded runs do not count toward N = 5.

Additional attempts are permitted only when failed or excluded runs prevent five valid observations from being obtained.

Once exactly five valid completed runs have been obtained for a condition, no additional primary run is required for that condition.

Run accounting must distinguish:

| Condition    | Planned | Attempted | Valid Completed | Failed | Excluded |
| ------------ | ------: | --------: | --------------: | -----: | -------: |
| Control      |       5 |           |                 |        |          |
| Intervention |       5 |           |                 |        |          |

Failed and excluded runs remain in the research record.

A run must never be silently removed merely because its result is inconvenient.

### H2 Mandatory Measurements

At minimum, H2 records:

* initial RAM usage;
* peak RAM usage;
* pressure-target attainment;
* zram usage;
* cumulative disk-backed swap-out bytes;
* cumulative swap-in activity;
* major page faults;
* cumulative physical-HDD write bytes;
* workload duration;
* execution status;
* analysis-eligibility status;
* stop reason.

Diagnostic metrics do not replace the two primary H2 criteria.

### H2 Metric Specificity

#### Primary Metric 1

**Cumulative bytes written to non-zram swap devices backed by physical storage during the fixed H2 measurement window.**

The metric must:

* exclude zram traffic;
* identify the measured swap device or device set;
* identify the counter source;
* use bytes;
* record the byte-conversion method;
* be calculated from the counter at the end of the window minus the counter at the beginning of the window.

#### Primary Metric 2

**Cumulative bytes written to the identified physical rotational HDD device or devices during the same fixed H2 measurement window.**

The metric must:

* identify the physical HDD device or device set;
* identify the counter source;
* use bytes;
* use the same measurement-window boundaries as Criterion 1;
* be calculated from the counter at the end of the window minus the counter at the beginning of the window.

The exact implementation details are experiment-state facts and must be verified and frozen before E-003 begins.

### H2 Aggregation

The primary analysis is performed only after five valid completed runs are available for both conditions.

For each primary metric, first calculate the run-level counter delta for each valid run.

Then calculate the median of the five valid control-run deltas:

$$
C = Median(C_1,C_2,C_3,C_4,C_5)
$$

and the median of the five valid intervention-run deltas:

$$
I = Median(I_1,I_2,I_3,I_4,I_5)
$$

where each \(C_j\) or \(I_j\) is the corresponding valid run-level delta.

No additional runs are substituted into the primary analysis after five valid completed runs have been obtained for a condition unless the protocol is explicitly amended before their results are used.

### H2 Relative Reduction

For a metric with a non-zero control median:

$$
Reduction(\%) =
\frac{C-I}{C}\times100
$$

A positive value represents a reduction under the intervention condition.

A negative value represents an increase under the intervention condition.

### H2 Criterion 1 Calculation

For disk-backed swap-out bytes:

$$
Reduction_{swap} =
\frac{C_{swap}-I_{swap}}
{C_{swap}}
\times100
$$

Criterion 1 passes when:

$$
Reduction_{swap} \geq 50\%
$$

### H2 Criterion 2 Calculation

For physical-HDD write bytes:

$$
Reduction_{HDD} =
\frac{C_{HDD}-I_{HDD}}
{C_{HDD}}
\times100
$$

Criterion 2 passes when:

$$
Reduction_{HDD} \geq 20\%
$$

### H2 Zero-Control Rule

The zero-control case is resolved before the final H2 decision is recorded.

If:

$$
C=0,\ I=0
$$

the metric has no measured activity in either condition.

**The criterion does not pass.**

If:

$$
C=0,\ I>0
$$

the percentage-reduction calculation is undefined because division by zero is not valid.

**The criterion is INCONCLUSIVE.**

If:

$$
C>0
$$

the normal relative-reduction formula is applied.

This rule is frozen before the final results are examined.

### H2 Decision Rule

| Criterion 1             | Criterion 2         | H2 Decision             |
| ----------------------- | ------------------- | ----------------------- |
| Pass                    | Pass                | **SUPPORTED**           |
| Pass                    | Fail                | **PARTIALLY SUPPORTED** |
| Fail                    | Pass                | **PARTIALLY SUPPORTED** |
| Fail                    | Fail                | **NOT SUPPORTED**       |
| Undefined / invalid     | Any                 | **INCONCLUSIVE**        |
| Any                     | Undefined / invalid | **INCONCLUSIVE**        |
| Insufficient valid runs | Any                 | **INCONCLUSIVE**        |

A `PARTIALLY SUPPORTED` result must not be promoted to `SUPPORTED` using diagnostic metrics, qualitative observations, or subjective assessment.

### H2 Reset

Before each subsequent run:

1. terminate the previous workload;
2. restore the required B2 and control/intervention state;
3. verify zram state;
4. verify relevant system configuration;
5. verify that no previous workload process remains active;
6. verify the monitoring environment;
7. record reset verification;
8. begin the next run only after the required reference state is confirmed.

Resetting the experimental state must not delete, overwrite, or modify previously collected evidence.

### H2 Exclusions

A run may be excluded only because:

* a predefined exclusion rule was triggered; or
* a demonstrable data-integrity problem prevents valid interpretation.

The exclusion rule must not depend on whether the observed result strengthens or weakens H2.

Every exclusion records:

* original result;
* reason;
* applicable rule;
* supporting evidence;
* effect on analysis.

---

## H3 — Background Workload Reduction

**Proposition:** Removing non-essential startup/background workloads will reduce idle system activity without breaking required functions.

**Metrics:**

* idle CPU utilization;
* idle RAM;
* background process count;
* disk I/O.

**Comparison:** B2 versus the isolated service-remediation configuration.

**Decision:** H3 is **SUPPORTED** only if the relative reduction in either median idle RAM or median idle CPU is at least **10%**, computed as:

$$
\frac{\text{baseline median} - \text{optimized median}}{\text{baseline median}} \times 100
$$

with the result being at least **10%** for either idle RAM or idle CPU, and with no required function failing.

A result satisfying only the numerical criterion without functional preservation does not support H3.

A result that satisfies neither numerical nor functional requirements is **NOT SUPPORTED**.

An invalid or incomplete comparison is **INCONCLUSIVE**.

---

## H4 — Desktop Rendering Efficiency

**Proposition:** Restrained XFCE compositor and visual effects will reduce rendering overhead on Intel HD Graphics 4600.

**Metrics:**

* CPU utilization during the defined desktop workload;
* rendering or frame-time behaviour where measurable;
* qualitative stutter observations;
* functional regressions.

**Comparison:** B2 default/stabilized desktop configuration versus the performance-oriented desktop configuration.

**Decision:** H4 is **SUPPORTED** only when the primary rendering-overhead metric—**median frame time during the fixed desktop-workload observation window**—decreases by at least **15%** relative to the B2 baseline, computed as:

$$
\frac{\text{baseline median frame time} - \text{optimized median frame time}}{\text{baseline median frame time}} \times 100 \geq 15\%
$$

and required desktop functionality remains intact.

The same scripted workload, observation window, and frame-time measurement method must be frozen before data collection begins for both baseline and optimized runs. Invalid or inconclusive frame-time results cannot qualify as **SUPPORTED**.

Subjective improvement by itself is qualitative evidence and is insufficient to establish H4.

---

## H5 — Quantized Local AI Feasibility

**Proposition:** At least one small quantized model configuration will execute the predefined offline workload within the available hardware envelope.

**Metrics:**

* model load time;
* peak RAM;
* prompt-processing rate;
* generation throughput;
* task completion;
* task correctness;
* system responsiveness.

**Comparison:** Defined model configurations under the fixed offline workload.

**Decision:** A configuration is considered practically usable only when all applicable RQ3 criteria are satisfied:

1. all mandatory offline tasks complete;
2. outputs satisfy task-specific correctness criteria;
3. median generation throughput is at least **5 tokens/second** for the defined coding workload;
4. no system-level failure occurs;
5. basic workstation interaction remains possible during inference.

The 5 tokens/second threshold is a study-specific decision rule, not a universal definition of useful local inference.

---

## H6 — CPU Inference Limitation

**Proposition:** CPU-only inference will remain a dominant performance bottleneck after OS and model optimization.

**Metrics:**

* generation throughput;
* CPU utilization;
* model load time;
* RAM consumption;
* responsiveness.

**Decision:** H6 is **SUPPORTED** only when, during the same predefined observation window for the fixed coding workload, all of the following are demonstrated:

1. the selected model fits within the protocol-defined memory envelope for the intended model class;
2. median CPU utilization on the active inference process remains at or above **90%** during the measured observation window, indicating sustained CPU saturation;
3. the proportion of the observation window with CPU utilization at or above **85%** is at least **80%**; and
4. median generation throughput remains below the practical-use target of **5 tokens/second** for the same workload.

If the model does not fit the intended memory envelope, CPU utilization does not remain at or above the required saturation threshold, or generation throughput meets or exceeds **5 tokens/second**, then H6 is **NOT SUPPORTED**.

Required workstation functionality must remain intact; any required-function failure means H6 is not supported.

An invalid, incomplete, or inconclusive CPU-inference measurement is **INCONCLUSIVE**.

The observation window, model-memory envelope, CPU-saturation threshold, and practical-use generation-throughput target must be frozen before data collection begins.

The proposition must be supported by measured evidence rather than by hardware assumptions alone.

---

## H7 — Workload Contention

**Proposition:** Concurrent local AI inference will measurably degrade development/productivity workload completion time.

**Metrics:**

* workload completion time;
* CPU utilization;
* RAM usage;
* AI throughput.

**Comparison:** Defined workload alone versus the same workload with concurrent local inference.

**Decision:** H7 is **SUPPORTED** if concurrent inference increases median workload completion time by at least **15%**.

A result below that threshold is **NOT SUPPORTED** unless another explicitly defined decision rule applies.

An invalid or incomplete comparison is **INCONCLUSIVE**.

The threshold is a study-specific operational rule.

---

# Cross-Hypothesis Experimental Rules

## Reference States

| State | Definition                                                                   |
| ----- | ---------------------------------------------------------------------------- |
| B0    | Final Windows configuration before migration                                 |
| B1    | Fresh Linux Mint Xfce after required updates and before RAMP-specific tuning |
| B2    | Stabilized Linux reference configuration used for isolated interventions     |

B0 → B1 measures the combined environment transition.

B2 → isolated intervention measures the specified intervention under defined conditions.

Sequential measurements describe cumulative system state.

Cumulative measurements must not be presented as isolated causal effects.

If reliable restoration to B2 is not possible, the result must be reported as cumulative rather than falsely attributed to an isolated intervention.

## Quantitative Repetition

Unless an experiment-specific protocol explicitly specifies otherwise:

* quantitative comparisons use five valid observations per configuration;
* run order is recorded;
* the initial state is restored between comparable runs;
* cold/warm state is explicit where relevant;
* comparable runs use identical workload inputs;
* median is the primary statistic;
* minimum, maximum, and raw observations are retained;
* mean may be reported as secondary information.

A single favourable run cannot establish a quantitative conclusion.

Where an experiment specifies an exact valid-run count, that experiment-specific rule takes precedence over this default.

## Version Control

Every baseline and quantitative experiment records exact relevant versions, including where applicable:

* operating system and edition;
* Linux kernel;
* firmware/BIOS;
* graphics driver or stack;
* compiler/toolchain;
* Python;
* Node.js;
* Java;
* Flutter/Dart;
* development environment;
* AI runtime;
* exact model name and revision/source;
* quantization;
* benchmark or experiment-script revision.

A later relevant version change must be recorded against the affected experiment.

## Reset and Experimental State

Before an isolated experiment, the required reference state is restored and verified.

Reboot or stabilization occurs where the experiment defines it.

A failed reset prevents valid causal comparison until the reference state is restored.

Reset operations must preserve previously collected evidence.

## Evidence Policy

Evidence is classified as:

**Observed** — directly measured or recorded.

**Verified** — independently checked against an authoritative or repeatable source.

**Inferred** — reasoned from observations but not directly measured.

**Unverified** — insufficient evidence currently exists.

Expected performance is never reported as measured performance.

Failed, neutral, negative, and excluded results are retained.

## Data Integrity

No measurement may be silently discarded.

Every failed or excluded run remains represented in the research record.

Any exclusion must preserve the original observation and document:

* reason;
* applicable rule;
* evidence;
* impact on analysis.

Raw evidence is retained separately from derived analysis.

## Scope and Generalization

RAMP-0 is a single-system case study conducted under a strict **$0 hardware-expenditure constraint**.

No hardware replacement is permitted during the primary experiment.

Results describe the tested HP ProBook 640 G1 configuration and are not automatically generalizable to other systems.

Study-specific decision thresholds are operational rules, not universal definitions of performance, usability, or hardware capability.

## Causal Attribution

Cumulative system improvement does not establish the isolated causal effect of an individual intervention.

An isolated causal claim requires:

1. a defined reference state;
2. a defined intervention;
3. controlled conditions;
4. a reproducible workload;
5. valid repeated measurements;
6. documented analysis.

Where isolation is infeasible, the limitation must be disclosed.

## Experimental Integrity

Hypotheses, thresholds, validity criteria, workload definitions, stopping rules, exclusion rules, aggregation methods, and decision rules are frozen before primary data collection begins.

A change made after primary data collection begins must be explicitly versioned and documented as a protocol change.

Results must not be used to retroactively modify the rules that determine whether those same results are valid.

## Study Completion

The study is considered complete when required baselines, intervention records, raw data, reproducible analyses, evidence classifications, and limitations have been documented and unsupported claims have been removed.
