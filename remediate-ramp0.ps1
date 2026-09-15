#requires -Version 5.1
<#!
RAMP-0 repository protocol remediation v2.

Run from the ROOT of the ramp-0 Git repository.
This script is intentionally idempotent for the repository files it owns.
It never commits or pushes.
It creates a timestamped backup before replacing an existing owned file.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Section([string]$Title) {
    Write-Host ""
    Write-Host ('=' * 72) -ForegroundColor Cyan
    Write-Host (" " + $Title) -ForegroundColor Cyan
    Write-Host ('=' * 72) -ForegroundColor Cyan
}

function EnsureDir([string]$RelativePath) {
    $p = Join-Path $RepoRoot $RelativePath
    if (-not (Test-Path -LiteralPath $p -PathType Container)) {
        New-Item -ItemType Directory -Path $p -Force | Out-Null
    }
}

function BackupFile([string]$RelativePath) {
    $src = Join-Path $RepoRoot $RelativePath
    if (Test-Path -LiteralPath $src -PathType Leaf) {
        $dst = Join-Path $BackupRoot $RelativePath
        $parent = Split-Path -Parent $dst
        if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -LiteralPath $src -Destination $dst -Force
    }
}

function WriteFile([string]$RelativePath, [string]$Content) {
    BackupFile $RelativePath
    $p = Join-Path $RepoRoot $RelativePath
    $parent = Split-Path -Parent $p
    if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    [IO.File]::WriteAllText($p, $Content, [Text.UTF8Encoding]::new($false))
    Write-Host "[WRITE] $RelativePath" -ForegroundColor Green
}

Section 'RAMP-0 repository remediation v2'

$RepoRoot = (Get-Location).Path
if (-not (Test-Path -LiteralPath (Join-Path $RepoRoot '.git') -PathType Container)) {
    throw 'Run this script from the root of the ramp-0 Git repository.'
}

$readmePath = Join-Path $RepoRoot 'README.md'
$hasRampMarker = (Test-Path -LiteralPath $readmePath -PathType Leaf) -and ((Get-Content -LiteralPath $readmePath -TotalCount 1) -eq '# RAMP-0')
$remoteUrl = git config --get remote.origin.url
$hasRampRemote = ($LASTEXITCODE -eq 0) -and ($remoteUrl -match '(?i)(^|[/\\_.-])ramp-0([/\\_.-]|$)')
if (-not ($hasRampMarker -or $hasRampRemote)) {
    $confirmation = Read-Host 'RAMP-0 marker/remote not found. Type RAMP-0 to confirm this is the intended repository'
    if ($confirmation -cne 'RAMP-0') {
        throw 'Repository identity could not be verified; no files were changed.'
    }
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$BackupRoot = Join-Path $RepoRoot ".ramp0-backup-$stamp"
New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null

Write-Host "[OK] Repo:    $RepoRoot" -ForegroundColor Green
Write-Host "[OK] Backup:  $BackupRoot" -ForegroundColor Green

Section 'Creating directory structure'
$dirs = @(
    'research','hardware','baseline','baseline\windows','baseline\windows\raw','baseline\linux','baseline\linux\raw',
    'remediation\01-os','remediation\02-memory','remediation\03-storage','remediation\04-services',
    'remediation\05-desktop','remediation\06-local-ai',
    'benchmarks\boot','benchmarks\memory','benchmarks\cpu','benchmarks\development','benchmarks\office','benchmarks\gaming','benchmarks\inference',
    'experiments\E-001-windows-baseline','experiments\E-002-linux-baseline','experiments\E-003-memory-pressure',
    'experiments\E-004-service-remediation','experiments\E-005-desktop-remediation','experiments\E-006-ai-model-matrix',
    'experiments\E-007-workload-contention',
    'data\raw','data\processed','results\tables','results\figures','scripts','decisions',
    'docs\architecture','docs\screenshots','docs\technical-report'
)
foreach ($d in $dirs) { EnsureDir $d }

Section 'Writing research protocol'

WriteFile 'README.md' @'
# RAMP-0
## Resource-Aggressive Maximization of a Legacy Workstation

> **Can disciplined software and operating-system remediation recover meaningful performance and usability from legacy hardware under a strict `$0 budget?**

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

**Hardware expenditure: `$0**

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
'@

WriteFile 'research\research-questions.md' @'
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

The experiment uses one fixed HP ProBook 640 G1 under a strict **`$0 hardware expenditure constraint**.

No hardware replacement is permitted during the primary experiment.

Results are treated as a single-system case study and are not automatically generalizable.

## Study completion criteria

The study is complete when required baselines, intervention records, raw data, reproducible analysis and limitations have been documented and unsupported claims removed.
'@

WriteFile 'research\hypotheses.md' @'
# Hypotheses

These are testable propositions, not assumed conclusions.

## H1 — Lightweight Environment

**Proposition:** Replacing Windows with Linux Mint Xfce will reduce baseline resource overhead and improve selected responsiveness measures.

**Metrics:** idle RAM, idle CPU utilization, median boot time, median application launch time.

**Comparison:** B0 versus B1.

**Decision:** supported only if Linux achieves both at least **15% lower median idle RAM** and at least **10% lower median boot time**. One criterion = partially supported. Neither = not supported.

## H2 — Memory Pressure and HDD Swap Reduction

**Proposition:** zram will reduce HDD-backed swap activity during the defined memory-pressure workload.

**Metrics:** peak RAM, zram usage, disk-backed swap, swap-in, swap-out, major page faults, HDD read/write activity, duration.

**Comparison:** B2 without zram versus equivalent B2 with zram.

**Decision:** supported if zram reduces disk-backed swap usage by at least **50%** and measured HDD write activity by at least **20%**. One criterion = partially supported. Neither = not supported.

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
'@

WriteFile 'research\methodology.md' @'
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
'@

WriteFile 'research\experimental-protocol.md' @'
# RAMP-0 Experimental Protocol

This is the operational lab manual.

## 1. Environment record

Before each experiment record date/time, power state, OS/version, kernel, CPU state, RAM, storage, graphics stack and relevant software/runtime/model versions.

## 2. Reference states

| ID | Meaning |
|---|---|
| B0 | Final Windows baseline |
| B1 | Fresh Linux Mint Xfce baseline |
| B2 | Stabilized Linux reference |

## 3. General procedure

1. Restore the required state.
2. Verify the configuration.
3. Reboot/reset as specified.
4. Stabilize for the defined period.
5. Execute the workload.
6. Capture raw measurements.
7. Record anomalies/failures.
8. Repeat until N is complete.

## 4. Default repetition

**N = 5 quantitative runs per configuration.**

## 5. Boot benchmark

Define the start point and readiness point. Record elapsed time for five comparable runs.

## 6. Idle benchmark

After stabilization measure RAM, CPU, disk activity and active processes. Repeat five times.

## 7. Application launch

Define the application set, starting state, launch action and readiness condition. Repeat five comparable runs per configuration.

## 8. Development workload

Record project, toolchain, clean/incremental state, compilation time and test time. Keep workload identical for comparisons.

## 9. Memory-pressure workload

Compare B2 without zram against B2 with zram.

Record initial/peak RAM, zram usage, traditional swap, swap-in/out, major page faults, HDD reads/writes, duration and completion.

The exact pressure workload, target condition, duration and stopping rule are fixed before the experiment is run.

## 10. Local AI workload

Record runtime version, model name/revision/source, quantization, context size, runtime settings, load time, prompt processing, generation throughput, peak RAM, CPU utilization, task completion, correctness and responsiveness.

## 11. AI task set

The final task set must be fixed before benchmarking. Candidate classes:

- code explanation
- bug identification
- small function implementation
- test generation
- offline technical explanation

Correctness criteria are fixed before scoring.

## 12. Practical AI rule

A configuration is practically usable only if mandatory tasks complete, task-specific correctness criteria are met, median generation throughput is at least 5 tokens/second, no system failure occurs, and basic interaction remains possible.

## 13. Gaming

For each selected title record version, resolution, graphics settings, launch configuration, test scene, duration and FPS/frame time where measurable. Keep settings fixed across comparisons.

## 14. Concurrent workload

Compare the defined development/productivity workload alone against the same workload with concurrent local inference. Record completion time, CPU, RAM and AI throughput.

## 15. Failure handling

Retain failed runs. Record experiment ID, run ID, timestamp, configuration, failure, suspected cause and whether the reference state was compromised.

## 16. Raw data schema

Each quantitative row should contain at least:

`experiment_id, run_id, timestamp, configuration, software_version, workload, metric, value, unit, notes`

Raw data goes in `data/raw/`. Derived data goes in `data/processed/`.

## 17. Reporting

Report N, median, min, max, mean where useful, raw observations, anomalies and exclusions.

## 18. Reproducibility

The repository must preserve enough information to reconstruct the environment, workload, configuration, measurement procedure and raw observations.
'@

WriteFile 'research\threats-to-validity.md' @'
# Threats to Validity

## Internal validity

Transient processes, thermal variation, power management, memory state and HDD behaviour may affect measurements. Repetition and explicit reset procedures reduce but do not eliminate this risk.

## External validity

This is a single HP ProBook 640 G1 case study. Results should not automatically generalize to other systems.

## Measurement validity

Tools and workload definitions influence measurements. Exact methods are recorded.

## Storage variability

Mechanical HDD performance can vary with disk state, fragmentation, temperature, caching and concurrent I/O.

## Software version drift

Kernel, graphics stack, compiler, runtime, application, AI runtime and model changes can affect results. Relevant versions are recorded.

## Hardware health

Operational SMART status is evidence of observed condition at baseline, not a guarantee of future reliability.

## Researcher bias

Successful interventions may be easier to notice than unsuccessful ones. Failed, neutral and negative interventions are therefore retained.

## Single-system limitation

The strongest value of this case study is its methodology, engineering reasoning and evidence trail rather than population-level generalization.

## Threshold sensitivity

Decision thresholds are study-specific operational rules, not universal definitions of performance or usability.

## Causal attribution

Cumulative improvements cannot establish isolated intervention causality. Isolated causal claims require the isolated-intervention protocol.

## AI evaluation

Token throughput alone does not establish usefulness. AI evaluation therefore combines performance, task completion, correctness, memory and responsiveness.
'@

# -------------------------------------------------------------------------
# HARDWARE / BASELINE
# -------------------------------------------------------------------------

WriteFile 'hardware\hardware-inventory.md' @'
# Experimental Hardware Inventory

| Component | Specification |
|---|---|
| Manufacturer | Hewlett-Packard |
| Model | HP ProBook 640 G1 |
| CPU | Intel Core i5-4310M @ 2.70 GHz |
| CPU cores | 2 physical / 4 logical |
| RAM | 16 GB |
| GPU | Intel HD Graphics 4600 |
| Storage | ST500LM021-class mechanical HDD |
| Architecture | x86-64 |
| Firmware mode | Legacy BIOS |

## Privacy boundary

Do not publish device IDs, product IDs, serial numbers, MAC addresses, credentials, personal files or other unique identifiers.
'@

WriteFile 'hardware\firmware-state.md' @'
# Firmware State

| Property | Baseline |
|---|---|
| BIOS Mode | Legacy |
| Secure Boot | Unsupported |
| Virtualization in Firmware | Disabled |
| BIOS Family | L78 |
| BIOS Version | 01.43 |
| BIOS Date | 2018-01-25 |

No BIOS/UEFI architecture conversion is part of the primary experiment.
'@

WriteFile 'hardware\health-diagnostics.md' @'
# Hardware Health Diagnostics

## HDD

The pre-remediation Windows diagnostic reported the ST500LM021 as operational according to the available SMART/WMI observation.

Interpretation: **Observed: operational at baseline.**

This is not a guarantee of future reliability or performance consistency.

## CPU

The processor is an Intel Core i5-4310M from the Haswell generation. AVX2 capability is relevant to CPU-side inference benchmarking.

## RAM

Installed memory: **16 GB**.
'@

WriteFile 'baseline\windows\notes.md' @'
# Windows Baseline Notes

Record the final Windows condition before migration.

Required:

- date/time
- Windows edition/version/build
- CPU state
- RAM state
- storage state
- GPU/driver state
- firmware mode
- virtualization state
- idle RAM
- idle CPU
- idle disk activity
- boot timing
- selected application launch timing
- benchmark-relevant software versions

Do not publish product IDs, device IDs, MAC addresses, serial numbers or credentials.
Raw unreviewed evidence belongs in `baseline/windows/raw/`.
'@

WriteFile 'baseline\linux\notes.md' @'
# Linux Baseline Notes

## B1

Fresh Linux Mint Xfce after required updates and before RAMP-specific tuning.

## B2

Stabilized Linux reference used for isolated intervention experiments.

Record distribution/version, kernel, firmware, graphics stack, CPU/RAM/storage state, active services, startup state and benchmark-relevant software versions.

Do not publish unique machine identifiers.
'@

# -------------------------------------------------------------------------
# DATA / RESULTS / EXPERIMENT TEMPLATE
# -------------------------------------------------------------------------

WriteFile 'data\README.md' @'
# Experimental Data

`data/raw/` contains original observations and should not be silently overwritten.

`data/processed/` contains derived datasets generated from raw observations.

Machine identifiers, credentials and personal files remain outside the public repository.

> **Raw evidence is preserved; processed evidence is derived.**
'@

WriteFile 'results\README.md' @'
# Results

Results are derived from experimental data.

Every quantitative result should be traceable:

`experiment → raw data → processing → reported result`

No major result should exist only as a manually typed number.
'@

$experimentTemplate = @'
# Experiment E-XXX

## Title

[Title]

## Status

PLANNED

## Research Question

[RQ]

## Hypothesis

[H]

## Objective

[What this experiment determines.]

## Reference State

[B0 / B1 / B2 / other]

## Intervention / Comparison

[ ]

## Software Versions

| Component | Version |
|---|---|
| OS | |
| Kernel | |
| Runtime | |
| Tool | |
| Model | |
| Benchmark script | |

## Controlled Conditions

-
-
-
## Workload

[Exact workload]

## Run Procedure

1.
2.
3.

## Repetition

N = 5 unless an alternative is explicitly justified.

## Reset Procedure

[Exact reset/recovery procedure]

## Measurements

| Metric | Unit | Tool |
|---|---|---|
| | | |

## Raw Data

`data/raw/`

## Results

[Populate after measurement.]

## Decision

SUPPORTED / PARTIALLY SUPPORTED / NOT SUPPORTED / INCONCLUSIVE

## Anomalies

[ ]

## Limitations

[ ]

## Evidence Classification

Observed / Verified / Inferred / Unverified
'@

foreach ($name in @(
    'E-001-windows-baseline','E-002-linux-baseline','E-003-memory-pressure',
    'E-004-service-remediation','E-005-desktop-remediation','E-006-ai-model-matrix','E-007-workload-contention'
)) {
    $file = "experiments\$name\README.md"
    if (-not (Test-Path -LiteralPath (Join-Path $RepoRoot $file) -PathType Leaf)) {
        WriteFile $file $experimentTemplate
    }
}

# -------------------------------------------------------------------------
# ADRs
# -------------------------------------------------------------------------

WriteFile 'decisions\ADR-001-linux-mint-xfce.md' @'
# ADR-001 — Linux Mint Xfce

## Status

Accepted for experimentation

## Context

The workstation needs a lightweight graphical environment while retaining usability for programming, productivity, gaming and local AI.

## Decision

Use Linux Mint Xfce as the primary remediation environment.

## Alternatives

Linux Mint Cinnamon; Debian Xfce; MX Linux Xfce; KDE Plasma; other lightweight environments.

## Evidence

[Record authoritative and experimental evidence.]

## Trade-offs

[Record.]

## Experimental consequence

RQ1 measures the combined Windows → Linux Mint Xfce environment transition.
'@

WriteFile 'decisions\ADR-002-filesystem.md' @'
# ADR-002 — Filesystem

## Status

Proposed

## Context

The experimental platform uses a mechanical HDD.

## Decision

Use ext4 for the Linux system and home filesystems, with the conventional separate `/boot` partition only if required by the installer. Use GPT partitioning with one ext4 root filesystem, one ext4 home filesystem, and a swapfile disabled during the B2 measurements; zram is evaluated separately in E-003. Keep mount options at the Linux Mint defaults, including `relatime`, for B1 and B2.

## Evidence

[Record evidence before finalizing.]

## Trade-offs

[Record.]
'@

WriteFile 'decisions\ADR-003-zram.md' @'
# ADR-003 — zram

## Status

Proposed

## Context

H2 tests whether compressed RAM reduces HDD-backed swap activity during memory pressure.

## Decision

Evaluate zram as an isolated intervention against B2.

## Measurement

The primary evaluation is defined in `experiments/E-003-memory-pressure/`.

## Control

B2 without zram is the control. Keep the ext4 mount configuration, power state, application set, workload inputs and software versions unchanged between configurations. Disable zram and verify that no zram device is active before each control run.

## Intervention

Enable one zram device using the selected Linux Mint zram configuration, record its algorithm and size, and verify the active compressed-swap device before each intervention run. Do not change any other B2 setting.

## Workload

Use the same memory-pressure workload for both configurations: start from the stabilized desktop, launch the defined application set, allocate memory until the pre-defined pressure target is reached, hold that target for the fixed duration, then complete the workload. Record initial and peak RAM, zram usage, disk-backed swap, swap-in/out, major page faults, HDD reads/writes, duration and completion.

## Reset procedure

After every run, stop the workload and applications, disable zram, turn off any remaining swap device, clear the recorded state, reboot, restore B2, verify the control or intervention configuration, and allow the defined stabilization period before the next run.

## Pass/fail criteria

Compare five valid runs per configuration using medians. Pass H2 when zram reduces disk-backed swap usage by at least 50% and measured HDD write activity by at least 20%; one threshold met is a partial pass, and neither threshold met is a fail. Retain failed runs and report planned, valid, failed and excluded runs separately.
'@

WriteFile 'decisions\ADR-004-local-ai-runtime.md' @'
# ADR-004 — Local AI Runtime

## Status

Proposed

## Context

Local inference must fit the CPU and RAM limits of the experimental system.

## Decision

Evaluate a reproducible CPU-oriented inference runtime using a quantized model format.

## Evidence

[Record runtime evidence.]

## Trade-offs

[Record.]
'@

WriteFile 'decisions\ADR-005-model-selection.md' @'
# ADR-005 — Model Selection

## Status

Proposed

## Context

The study prioritizes programming assistance and offline operation on constrained hardware.

## Decision

Start with a small coding-oriented model candidate and evaluate alternatives through the model matrix.

## Control rule

The model remains fixed during OS/runtime comparisons and varies only in the model-selection experiment.

## Evidence

[Record exact model source/revision and quantization.]
'@

# -------------------------------------------------------------------------
# GITIGNORE
# -------------------------------------------------------------------------

WriteFile '.gitignore' @'
# RAMP-0 public research repository

# Raw/unreviewed local inventory
/hardware/raw/
/baseline/windows/raw/
/baseline/linux/raw/

# Secrets and credentials
.env
.env.*
*.pem
*.key
*.p12
*.pfx
credentials.json
secrets.json
token.json
tokens.json

# Machine identifiers
device-identifiers.txt
mac-addresses.txt
serial-numbers.txt
product-ids.txt

# Editors / OS
.vscode/
.idea/
*.swp
*.swo
Thumbs.db
.DS_Store

# Python
__pycache__/
*.py[cod]
.venv/
venv/
env/

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# VM/disk images/installers
*.iso
*.img
*.raw
*.vdi
*.vmdk
*.qcow2

# Temporary/generated
*.tmp
*.temp
*.bak
~*

# Local remediation backups
.ramp0-backup-*/
'@

# -------------------------------------------------------------------------
# LOCAL RAW POLICY + KEEPERS
# -------------------------------------------------------------------------

$rawPolicy = @'
# Local Raw Inventory

This directory is intentionally ignored by Git.

Use it for unreviewed local machine inventory before sanitization.

Never publish device IDs, product IDs, serial numbers, MAC addresses, credentials, authentication tokens or personal files.

Sanitize evidence before moving anything into the public repository.
'@
WriteFile 'hardware\raw\README.txt' $rawPolicy
WriteFile 'baseline\windows\raw\README.txt' $rawPolicy
WriteFile 'baseline\linux\raw\README.txt' $rawPolicy

foreach ($d in @('data\raw','data\processed','results\tables','results\figures','docs\screenshots')) {
    $keeper = Join-Path $d '.gitkeep'
    if (-not (Test-Path -LiteralPath $keeper -PathType Leaf)) {
        New-Item -ItemType File -Path $keeper -Force | Out-Null
    }
}

# -------------------------------------------------------------------------
# FINAL VALIDATION
# -------------------------------------------------------------------------

Section 'Validation'

Write-Host '[1/4] Git status' -ForegroundColor Cyan
git status --short
$gitStatusExit = $LASTEXITCODE
if ($gitStatusExit -ne 0) { throw "git status --short failed with exit code $gitStatusExit." }

Write-Host ''
Write-Host '[2/4] Whitespace validation' -ForegroundColor Cyan
git diff --check
$gitDiffCheckExit = $LASTEXITCODE
if ($gitDiffCheckExit -ne 0) { throw "git diff --check failed with exit code $gitDiffCheckExit." }

Write-Host ''
Write-Host '[3/4] Changed paths' -ForegroundColor Cyan
git diff --name-only
$gitNameOnlyExit = $LASTEXITCODE
if ($gitNameOnlyExit -ne 0) { throw "git diff --name-only failed with exit code $gitNameOnlyExit." }

Write-Host ''
Write-Host '[4/4] Repository root' -ForegroundColor Cyan
Write-Host $RepoRoot

Write-Host ''
Write-Host '============================================================' -ForegroundColor Green
Write-Host ' RAMP-0 PROTOCOL REMEDIATION COMPLETE' -ForegroundColor Green
Write-Host '============================================================' -ForegroundColor Green
Write-Host ''
Write-Host 'No commit or push was performed.' -ForegroundColor Yellow
Write-Host "Backup: $BackupRoot" -ForegroundColor Yellow
Write-Host ''
Write-Host 'Review with:' -ForegroundColor Cyan
Write-Host '  git diff -- README.md'
Write-Host '  git diff -- research/'
Write-Host '  git diff -- .gitignore'
Write-Host '  git status'
Write-Host ''
Write-Host 'After review, commit with:' -ForegroundColor Cyan
Write-Host '  git add .'
Write-Host '  git commit -m "research: operationalize experimental protocol"'
Write-Host '  git push'
