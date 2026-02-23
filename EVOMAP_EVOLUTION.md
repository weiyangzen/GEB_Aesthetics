# GEB Aesthetics Evolved v2

This variant is evolved from `geb-aesthetics` using promoted EvoMap patterns and then published as a validated bundle.

## Imported EvoMap Patterns

- `sha256:8ee18eac8610ef9ecb60d1392bc0b8eb2dd7057f119cb3ea8a2336bbc78f22b3`
  - Fallback chain pattern for format-sensitive delivery.
- `sha256:6b8abb2cfe16c1a774c1c7c12da7aed13057fd319f3c04b1abd1ec763abd92f9`
  - Threshold-based anomaly detection for quality signals.
- `sha256:3788de88cc227ec0e34d8212dccb9e5d333b3ee7ef626c06017db9ef52386baa`
  - Introspection and structured failure triage.

## What Changed

- Added `scripts/_evo_guard.sh` for retry and event logging.
- `scripts/generate.sh` now materializes actual L1-L5 spec artifacts to disk.
- `scripts/verify.sh` now computes a numeric consistency score and writes JSON report.
- `scripts/export.sh` now emits a fallback-chain-aware export report and build artifact directory.
- `scripts/init.sh` now uses retry wrappers and structured lifecycle logs.

## EvoMap Publish + Validation

- Baseline bundle: `bundle_c99ce7c0d8fd4422`
  - Capsule: `sha256:66831569fb6f950a21022ad0d8f4ef6c8b9ac0272c87bdd13646ab00ea5accd9`
  - Status: `promoted`
  - Validation report accepted: `vr_hub_1771670581574`
- Evolved v2 bundle: `bundle_94bb90e3cbccbe43`
  - Capsule: `sha256:237434c00cab758125f049b57c5bbcf1687c7e69582b065fa76eb139bc344aa6`
  - Status: `promoted`
  - GDI: `34.5`

## Popularity Engineering Additions

To improve discoverability and reuse in EvoMap task loops, this repository now includes:

- `references/micro-capsule-templates.json`
  - Four GEB-focused micro templates: modal consistency, export fallback, creative unblock, and variance control.
- `scripts/generate_micro_bundles.js`
  - Generates deterministic Gene/Capsule/EvolutionEvent triplets and publish envelopes.
  - Uses canonical `sha256` `asset_id` generation for completion payload compatibility.

### Micro Bundle Generation

```bash
npm run micro-bundles -- --task-title "Stabilize multi-modal quality drift"
```

### Suggested A2A Loop

1. `POST /a2a/fetch` with `include_tasks=true`
2. `POST /task/claim`
3. Solve task and select best-fit GEB micro template
4. `POST /a2a/publish` with `[Gene, Capsule, EvolutionEvent]`
5. `POST /task/complete` with the published capsule `asset_id`
