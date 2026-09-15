# RAMP-0 Pull Request

## Change

Describe exactly what changed.

## Reason / Traceability

Reference the relevant Issue, experiment, ADR, protocol change, milestone, or maintenance task.

## Evidence

What evidence supports this change? For a single claim, select one evidence state: these options are mutually exclusive. When evidence is missing or insufficient, use `NOT VERIFIED`.

- [ ] Observed
- [ ] Verified
- [ ] Inferred
- [ ] Unverified / `NOT VERIFIED`

## Validation

Describe the checks or experiments performed.

- [ ] Execution status recorded (`completed` / `failed`)
- [ ] Analysis eligibility recorded (`eligible` / `excluded`)
- [ ] Exclusion reason recorded when applicable
- [ ] Reference to the execution record included
- [ ] Checks or experiments described above

## Research Impact

- [ ] No protocol impact
- [ ] Affects research documentation
- [ ] Affects experimental protocol
- [ ] Affects measurement method
- [ ] Affects decision criteria
- [ ] Affects collected data
- [ ] Affects results
- [ ] Affected protocol controls:
  - [ ] Workload
  - [ ] Stopping rules
  - [ ] Exclusion rules
  - [ ] Aggregation rules
  - [ ] Validity criteria

## Reproducibility

- [ ] Reproducible from repository
- [ ] Not yet reproducible
- [ ] Not applicable

## Integrity Check

- [ ] No secrets or sensitive identifiers added
- [ ] Raw evidence has not been silently altered
- [ ] Failed/excluded results have not been silently removed
- [ ] No unauthorized rewrite of published research history occurred
- [ ] If a rewrite occurred, a documented reason or reference is included per CONTRIBUTING.md
- [ ] All commits in the complete pull request commit range are cryptographically signed; verify the full PR commit range, not only the tip commit
