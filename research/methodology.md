# Methodology

## Experimental Design

RAMP-0 uses a staged intervention model:

```text
Baseline
   ↓
Intervention
   ↓
Measurement
   ↓
Comparison
   ↓
Decision
```

The experimental hardware remains unchanged during the primary study.

## Baseline

Before remediation, the following are recorded where measurable:

* Operating system
* CPU configuration
* Memory utilization
* Storage state
* CPU idle utilization
* Boot time
* Application launch behaviour
* Development workload performance
* Local inference performance, where applicable

## Independent Variables

Potential interventions include:

* Operating system
* Desktop environment configuration
* Startup services
* Memory/swap configuration
* Storage configuration
* Desktop effects
* AI runtime
* Model size
* Model quantization

## Dependent Variables

Measurements may include:

* Idle RAM
* Idle CPU utilization
* Disk utilization
* Boot time
* Application launch time
* Compilation time
* Model load time
* Prompt processing rate
* Generation rate
* Memory consumption
* Gaming frame rate
* Subjective usability observations

## Controlled Conditions

Where practical, comparisons should use:

* The same hardware
* The same workload
* The same test data
* The same display resolution
* The same power state
* The same model
* The same measurement procedure

## Measurement Principle

A claimed improvement must be supported by an observable measurement.

Where precise measurement is unavailable, the result must be explicitly labelled as qualitative rather than quantitative.

## Repetition

Performance measurements should be repeated where practical to reduce the influence of transient system conditions.

Results should report the measurement method and, where meaningful, repeated observations rather than a single favourable run.
