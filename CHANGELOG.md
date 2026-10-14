# Changelog

## Unreleased

- Published independently derived public dependency sources and replaced Terrane's reachable private Nix inputs with immutable public revisions; original private histories remain withheld.
- Replaced the stale private Trellis UCAN consumer profile with exact public Terrane source identities and maintained fail-closed compatibility fixtures. Historical proof artifacts, signed receipts and license grants remain unchanged.
- Recorded current-source proof/profile observations separately from pending historical-provider re-admission and incompatible native lifecycle policy; source publication is not release admission.
- Named the clean public project **Terrane** (formerly Trellis), while preserving the Rust crate name `verified-logic` and the historical versioned consumer-profile identities.
- Prepared portable contributor commands, confidential vulnerability reporting guidance, immutable CI action pins, a smaller consumer crate archive, and scoped crate-level proof claims for public release review.
- Added the Cairn policy projection's upstream AGPL notice, license text, pinned Nickel authoring inputs, and checked source import; removed two unreferenced planning documents while retaining Tracey requirements and proof/evidence contracts.

## v0.2.0 - 2026-05-16

This release is a major proof-surface and model-coverage expansion since `v0.1.0`.

### Highlights

- Expanded the library to 575 verified/modelled modules with 10101 Verus proofs, 4587 tests, and 1894 Tracey requirements.
- Reduced and documented the remaining trusted/proof-gap boundary inventory to 16 explicit sites.
- Landed broad domain primitive coverage across arithmetic, storage, concurrency, distributed systems, UCAN/web-of-trust, kernel/OS, compiler, GPU, graph, geometry, filesystem, network, observability, and composite facade models.
- Closed multiple former proof gaps by replacing trusted bridges with verified executable/modelled decompositions, including Nix version comparison slices, UCAN DID/CID/signature structure, graph/topological/reachability helpers, cache and memory models, and composite facade traceability.
- Completed and archived the OpenSpec backlog; the active OpenSpec queue is empty at release cut.

### Verification baseline

The release candidate is expected to pass the maintained repository gate:

```sh
CARGO_TARGET_DIR="$PWD/target/release-verification" ./scripts/verify.rs
```

plus clean OpenSpec status and a clean jj/git worktree.
