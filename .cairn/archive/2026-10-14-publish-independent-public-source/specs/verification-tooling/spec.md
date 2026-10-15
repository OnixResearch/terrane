# Public Source Admission Delta

## ADDED Requirements

### Requirement: Public Immutable Verification Inputs
r[verification-tooling.public-source]

Terrane MUST select anonymously fetchable immutable source inputs for its maintained verification and consumer-profile paths. Current source identities MUST be measured and checked against the selected public revision, with fresh execution and negative controls before current provider receipts are admitted. The maintained governing policy MUST be admitted by the pinned public Cairn CLI and retain declared-only traceability with exact-marker-byte anchors. Store integrity repairs MUST restore the original admitted content identities from trusted inputs without changing toolchain pins. Publication MUST NOT expose original private ancestry, relabel historical receipts, weaken exact source/profile admission, or imply release eligibility.

#### Scenario: Public source and consumer profile agree

- GIVEN an independently published immutable Terrane source that passes its configured production Verus profile
- WHEN the maintained consumer profile is generated and checked against that exact source
- THEN its repository, revision, file identities, feature decision and bounded non-claims agree and an aligned consumer report passes

#### Scenario: Stale or altered public binding is rejected

- GIVEN a consumer with a stale revision, changed artifact identity, unsupported feature, incomplete module set or weakened non-claim
- WHEN compatibility or strict provider admission runs
- THEN it rejects the mismatch without selecting a private fallback or altering historical evidence

#### Scenario: Maintained governing policy is admitted without historical mutation

- GIVEN the pinned public Cairn CLI and the maintained overlay over its immutable licensed historical base
- WHEN current policy export, semantic fixtures and native lifecycle gates run
- THEN required initial profiles and declared-only exact-byte traceability are admitted, invalid workflow/authority/anchor boundaries are rejected, and historical policy inputs remain unchanged
