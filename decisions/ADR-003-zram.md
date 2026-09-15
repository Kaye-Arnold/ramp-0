# ADR-003 — zram

## Status

Proposed

## Context

H2 tests whether compressed RAM reduces HDD-backed swap activity during memory pressure.

## Decision

Evaluate zram as an isolated intervention against B2.

## Evidence

[Record evidence after the experiment.]

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

## Trade-offs

[Record benefits, costs, and observed side effects.]

## Reversibility

The intervention must have a documented enable/disable procedure so B2 can be restored for isolated comparison.
