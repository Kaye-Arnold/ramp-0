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

**N = 5 valid quantitative runs per configuration.** Five is the target number of valid completed runs, not the number of planned attempts. Report planned attempts, valid runs, failed runs and excluded runs separately for every configuration. Failed runs remain in the research record and are not silently discarded; an excluded run must include its original data, reason, rule and impact.

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

experiment_id, run_id, timestamp, configuration, software_version, workload, metric, value, unit, notes

Raw data goes in data/raw/. Derived data goes in data/processed/.

## 17. Reporting

Report N, median, min, max, mean where useful, raw observations, anomalies and exclusions.

## 18. Reproducibility

The repository must preserve enough information to reconstruct the environment, workload, configuration, measurement procedure and raw observations.