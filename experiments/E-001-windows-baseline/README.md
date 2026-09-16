# Experiment E-001

## Title

Windows B0 Baseline: Resource Utilization, Boot Performance, and Application Launch

## Status

PLANNED

## Research Question

RQ1 — What is the effect of replacing the existing Windows environment with a Linux Mint Xfce environment on resource utilization and system responsiveness?

E-001 establishes the quantitative B0 reference required for the later B0 → B1 comparison.

## Hypothesis

H1 — Replacing Windows with Linux Mint Xfce will reduce baseline resource overhead and improve selected responsiveness measures.

H1 is evaluated using median idle RAM and median boot time, with application-launch and idle-CPU measurements retained as supporting baseline observations.

## Objective

Establish a reproducible quantitative baseline for the final Windows configuration immediately before migration.

## Reference State

B0 — Final Windows configuration before migration.

No performance optimization, debloating, service modification, registry modification, driver update, or other remediation is performed before B0 data collection.

## Intervention / Comparison

None.

E-001 is a baseline characterization experiment. The resulting B0 measurements are compared later with B1.

## Software Versions

Record exact versions before primary measurement.

| Component | Version |
|---|---|
| OS | Windows 10 Pro 22H2 / build 19045 |
| Power plan | Balanced |
| Git | Record installed version |
| VS Code | Record installed version |
| Python | Record installed version |
| Benchmark script | N/A for protocol-only baseline unless introduced by later approved change |

## Controlled Conditions

- HP ProBook 640 G1 remains connected to AC power.
- No intentional Windows remediation is performed before B0 completion.
- No new benchmark software is installed.
- No Windows Update, driver update, or configuration change is intentionally initiated during B0 collection.
- Network state is recorded.
- Background applications not required for the experiment remain closed.
- Security software remains in its normal state.
- Exact date/time is recorded.
- The machine is rebooted before each boot benchmark run.
- Idle measurement begins only after the defined post-logon stabilization period.
- Application-launch runs begin from a defined process-absent state.
- All five valid observations use the same workload and measurement procedure.

## Workload

### Idle workload

After normal Windows logon:

1. Keep the workstation connected to AC power.
2. Do not intentionally launch user applications.
3. Allow a fixed stabilization period of 10 minutes.
4. Record idle CPU, idle RAM, active process count, filesystem bytes written/sec, and filesystem bytes read/sec for a fixed 60-second observation window.
5. Sample once per second.
6. Calculate the median of the 60 observations for each primary idle metric.
7. Repeat for five valid runs, with a reboot before each run.

The idle workload records the workstation in its normal Windows desktop state rather than an artificially minimized process state.

### Boot workload

A boot run begins with a controlled Windows restart. Boot Duration is obtained from the resulting Microsoft-Windows-Diagnostics-Performance Event ID 100 record corresponding to that restart.

The primary boot measurement is the Windows Diagnostics-Performance boot duration recorded for the corresponding boot event.

The same event source and extraction method are used for every run.

Five valid boot observations are required.

### Application-launch workload

The selected application is Windows Notepad because it is present in the B0 environment and does not require installation or additional configuration.

Before each launch:

1. Ensure no Notepad process is running.
2. Start Notepad using the same executable.
3. Start timing immediately before process launch.
4. Stop timing when the Notepad main window is created and has a valid window handle.
5. Record elapsed milliseconds.
6. Close Notepad.
7. Restore the required process-absent state before the next attempt.

Five valid application-launch observations are required.

## Run Procedure

### General

1. Verify B0 configuration.
2. Verify AC power.
3. Record timestamp.
4. Record environment/software versions.
5. Verify no intentional remediation has occurred.
6. Perform the applicable workload.
7. Record raw observations.
8. Record anomalies or failures.
9. Preserve the raw evidence.
10. Repeat until five valid observations exist for each quantitative configuration.

### Idle run

1. Reboot Windows.
2. Log in normally.
3. Wait exactly 10 minutes.
4. Start the 60-second idle observation.
5. Record one sample per second.
6. Calculate median CPU, RAM, process count, filesystem bytes written/sec, and filesystem bytes read/sec.
7. Mark the run valid only if the complete observation window is captured without measurement failure.

### Boot run

1. Reboot according to the defined boot procedure.
2. Identify the corresponding Diagnostics-Performance boot event.
3. Record the boot duration.
4. Verify that the event belongs to the current boot.
5. Repeat until five valid boot observations exist.

### Application-launch run

1. Verify Notepad is not running.
2. Start the launch stopwatch.
3. Launch Notepad.
4. Stop timing when the main window handle is available.
5. Record elapsed time.
6. Close Notepad.
7. Verify process termination.
8. Repeat until five valid launch observations exist.

## Repetition

N = 5 valid observations per quantitative configuration.

Report:

- planned runs
- attempted runs
- valid runs
- failed runs
- excluded runs

Failed and excluded runs remain in the research record.

## Reset Procedure

For boot measurements, reboot before each run.

For idle measurements, reboot before each run and allow the fixed 10-minute stabilization period.

For application-launch measurements, close Notepad and verify process termination before beginning the next run.

A failed reset invalidates the corresponding run until the required state is restored.

## Measurements

| Metric | Unit | Measurement method |
|---|---|---|
| Idle RAM | MB | CIM `Win32_OperatingSystem`; `UsedPhysicalMemory_MB = (TotalVisibleMemorySize - FreePhysicalMemory) / 1024` |
| Idle CPU | % | `Get-Counter "\Processor Information(_Total)\% Processor Time"` sampled once per second |
| Active process count | count | Windows process enumeration |
| Idle filesystem bytes written/sec; Idle filesystem bytes read/sec | bytes/sec | `FileSystem Disk Activity(_Total)\FileSystem Bytes Written` and `FileSystem Disk Activity(_Total)\FileSystem Bytes Read` |
| Boot duration | ms | Microsoft-Windows-Diagnostics-Performance Event ID 100; record `Boot Duration` from the event corresponding to the current restart |
| Notepad launch time | ms | Process launch to valid main-window handle |

## Primary H1 Metrics

The following two metrics determine H1:

1. Median idle RAM.
2. Median boot time.

The H1 decision rule is defined in `research/hypotheses.md`.

Idle CPU and application-launch timing are supporting B0 observations unless another approved protocol explicitly assigns them primary status.

## Raw Data

Unreviewed raw evidence belongs in:

`baseline/windows/raw/E-001/`

The raw record must preserve the original observations required to reconstruct each reported value.

## Pre-data Protocol Amendment - Measurement Infrastructure Validation

**Date:** 2026-09-16

**Status:** Approved before primary B0 data collection

### Reason

During pre-data measurement-infrastructure validation, the originally specified conventional Windows Performance Counter categories for physical memory and physical/logical disk activity were not available on this installation. Alternative native Windows measurement mechanisms were tested before any primary E-001 observations were collected.

### Amendments

1. **Idle RAM**
   - The conventional Windows Performance Counter mechanism for the intended RAM measurement was unavailable on this installation.
   - Idle RAM is therefore measured using `Win32_OperatingSystem` CIM values.
   - Defined calculation:
     `UsedPhysicalMemory_MB = (TotalVisibleMemorySize - FreePhysicalMemory) / 1024`
   - `TotalVisibleMemorySize` and `FreePhysicalMemory` are retained in raw evidence.

2. **Idle disk activity**
   - Conventional `PhysicalDisk` and `LogicalDisk` counter sets were unavailable.
   - The verified native `FileSystem Disk Activity` counter set is used for the supporting filesystem-I/O metric.
   - Defined counters:
     - `\FileSystem Disk Activity(_Total)\FileSystem Bytes Written`
     - `\FileSystem Disk Activity(_Total)\FileSystem Bytes Read`
   - These are reported as filesystem read/write activity in bytes/sec and are **not** interpreted as physical-device throughput.

3. **Boot measurement**
   - Microsoft-Windows-Diagnostics-Performance Event ID 100 was verified using an elevated Windows PowerShell session.
   - Boot measurement is frozen to controlled Windows restart runs.
   - `Boot Duration` from the corresponding Event ID 100 record is the recorded boot metric.

### Integrity

This amendment was made during measurement-infrastructure validation, before primary E-001 B0 data collection. It is not based on observed E-001 outcome values. Historical Diagnostics-Performance Event ID 100 records observed during validation are not included as E-001 primary runs.

## Results

Populate only after valid B0 collection is complete.

Report:

- five valid observations for each required metric;
- median;
- minimum;
- maximum;
- mean where useful;
- raw observations;
- anomalies;
- failed runs;
- exclusions and reasons.

## Decision

E-001 does not independently determine H1.

E-001 establishes B0 measurements used in the later B0 → B1 H1 comparison.

## Anomalies

Record every material deviation from the defined procedure.

## Limitations

This is a single-system baseline.

Windows boot-event timing measures the Windows performance event definition rather than an independently observed user-perceived readiness time.

Application launch measures process/window initialization for Notepad and should not be generalized to all applications.

## Evidence Classification

Environment facts: Observed / Verified where independently checked.

Measurements: Observed.

Derived medians and percentages: Inferred from recorded observations.

Unverified claims must be explicitly marked `NOT VERIFIED`.
