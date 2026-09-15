# ADR-003 - zram

## Status

Proposed

## Context

H2 tests whether compressed RAM reduces HDD-backed swap activity during memory pressure.

## Decision

Evaluate zram as an isolated intervention against B2.

## Evidence

[Record evidence after the experiment.]

## Measurement

The primary evaluation is defined in:

experiments/E-003-memory-pressure/

## Trade-offs

[Record benefits, costs, and observed side effects.]

## Reversibility

The intervention must have a documented enable/disable procedure so B2 can be restored for isolated comparison.
