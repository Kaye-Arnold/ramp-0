# RAMP-0 Research Governance

## 1. Purpose

This document defines the controls used to preserve the scientific and engineering integrity of RAMP-0.

RAMP-0 is a single-system empirical study. Results are interpreted for the tested workstation and experimental conditions and are not automatically generalized to other hardware.

## 2. Evidence States

### Observed

Directly measured or directly recorded evidence.

### Verified

Observed evidence checked against the defined verification procedure.

### Inferred

A conclusion derived from observed or verified evidence.

### Unverified

A claim for which sufficient evidence has not yet been established.

Unverified claims must not be presented as established facts.

## 3. Source Authority

Primary evidence takes precedence over assumptions or generated summaries.

Repository documents describe the study but do not replace original measurement evidence.

## 4. Experimental Integrity

Before primary data collection, the applicable protocol should define:

- hypothesis
- control and intervention
- workload
- metrics
- measurement method
- observation window
- repetition count
- aggregation method
- stopping conditions
- exclusion conditions
- decision thresholds
- validity requirements

Changes made after data collection must be explicitly versioned and must not silently alter interpretation rules for previously collected data.

## 5. Causal Attribution

A cumulative system transition may establish an environmental effect but does not independently establish the causal effect of every individual intervention.

Individual interventions should therefore use isolated comparisons where causal attribution is required.

## 6. Run Integrity

Execution status and analysis eligibility are separate attributes.

A failed execution must not be silently converted into a valid result.

An excluded observation must retain its original execution record and exclusion reason.

## 7. Data Provenance

The preferred chain is:

raw evidence
→ processing
→ derived data
→ analysis
→ result
→ conclusion

Derived values should be reproducible from recorded source data and documented processing logic.

## 8. Negative Results

RAMP-0 does not require every intervention to improve performance.

Neutral, negative, failed, and unsupported outcomes remain valid study results when the associated measurements are valid.

## 9. Scope Control

The primary study constraint is `$0` hardware expenditure.

No paid hardware upgrade may be introduced and represented as part of the `$0` remediation outcome.

## 10. Reproducibility

A competent reader should be able to determine:

- what system state was tested
- what was changed
- why it was changed
- how it was measured
- what evidence was collected
- how the result was calculated
- how the final decision followed from predefined rules

## 11. Decision Authority

Experimental outcomes are governed by the applicable protocol and recorded evidence.

Documentation convenience, visual appearance, or expected performance must never override measured evidence.

## 12. Integrity Rule

When evidence is insufficient, record:

`NOT VERIFIED`

rather than silently substituting an assumption.
