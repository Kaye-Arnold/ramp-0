# ADR-002 — Filesystem

## Status

Proposed

## Context

The experimental workstation uses a mechanical HDD and currently boots in Legacy BIOS mode. The primary study requires a stable, reproducible filesystem configuration while avoiding unnecessary firmware or partitioning changes.

## Decision

Use an MBR partition table compatible with the existing Legacy BIOS configuration.

Use ext4 for the Linux filesystem.

Use the Linux Mint installer defaults for ext4 mount behavior unless a deliberate experimental intervention changes them.

Do not introduce a separate swap partition for the primary B1/B2 baseline. zram is evaluated separately as the H2 memory-pressure intervention.

B1 and B2 must use the same partitioning and filesystem configuration.

## Evidence

This decision is proposed before installation. The actual installed partition table, filesystem, mount configuration and bootloader state will be recorded after deployment.

## Trade-offs

A simple MBR/ext4 configuration minimizes additional experimental variables and is appropriate to the existing firmware mode. The study therefore does not evaluate GPT versus MBR as an independent variable.