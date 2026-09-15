# Contributing to RAMP-0

RAMP-0 is an empirical systems-engineering study of a constrained legacy workstation.

Repository changes must preserve reproducibility, traceability, evidence integrity, and controlled experimental practice.

## Change Classes

Use the smallest appropriate change class:

- `research` — research questions, hypotheses, methodology, validity criteria
- `experiment` — experimental protocols and experiment artifacts
- `analysis` — data processing, analysis, tables, figures
- `fix` — correction of an identified defect
- `docs` — documentation
- `chore` — repository/tooling maintenance

## Traceability

Every substantive change must have a traceable reason.

Acceptable traceability includes an Issue, experiment identifier, ADR, protocol change, research milestone, or explicit maintenance task.

Do not create artificial issues merely to satisfy this rule.

## Research Integrity

Expected results are not observations.

Measured evidence must remain distinguishable from planned values, expectations, inferred conclusions, and unverified claims.

Failed, excluded, neutral, and negative results must not be silently removed.

## Experimental Changes

Changes affecting hypotheses, thresholds, workloads, measurement methods, stopping rules, exclusion rules, aggregation rules, or validity criteria must be explicitly identified.

Decision rules must not be changed retroactively to improve an outcome.

## Data

Preserve raw evidence.

Derived data must be reproducible from documented processing steps.

Do not commit secrets, credentials, tokens, personal identifiers, hardware serial numbers, MAC addresses, private documents, or unrelated personal files.

## Git

All commits must use an accurate author identity, appropriate commit messages, applicable validation, and cryptographic signing.

Do not rewrite published research history without a documented reason.

Do not force-push `main`.

## Branches

Use short-lived branches for substantive work.

Examples:

- `docs/governance-hardening`
- `experiment/E-003-zram`
- `analysis/H2-results`
- `fix/measurement-script`

## Pull Requests

A substantive pull request must explain:

1. what changed
2. why it changed
3. what evidence supports it
4. how it was validated
5. whether the research protocol is affected
6. whether reproducibility is affected

Do not approve a change merely because it looks reasonable. Verify the evidence and stated scope.

## Core Principle

When evidence is missing, record `NOT VERIFIED` rather than filling the gap with an assumption.
