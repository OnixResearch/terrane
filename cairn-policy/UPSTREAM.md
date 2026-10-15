# Cairn policy base

`generated/cairn-policy.base.json` is copied byte-for-byte from
`cairn-policy/generated/cairn-policy.json` in the independent
[OnixResearch/Cairn](https://github.com/OnixResearch/cairn) repository at
revision `b6759012db4dab0158936e995b7bad39ac10465b`. Both files have Git
blob ID `57d1f8194930ceacde797af4b53f90ad1daeac18`.

At the pinned revision, Cairn's `docs/licensing.md` assigned
`AGPL-3.0-or-later` to unmarked lifecycle material. Cairn subsequently granted
an additional license choice covering these **exact historical blobs**; the
[grant shipped with Terrane](LICENSING.md) records Cairn commit
`d2c1dd7867350b787cfffe0e311fd20115238339`. Terrane selects MIT for the
copied Nickel inputs and generated projection, with
[Cairn's MIT text and notice](../LICENSES/Cairn-MIT.txt). The original
[AGPL text](../LICENSES/AGPL-3.0-or-later.txt) remains available for the prior
license option and the pinned-source import check. Terrane's `MPL-2.0` package
metadata does not relicense Cairn's bytes.

Terrane overlays its traceability and optional stack-evidence gates in
`default.ncl`. The base supplies the workflow, machine, lifecycle-store,
registry, guidance, collaboration, and receipt policy shapes. The copied
projection establishes source identity only; it does not transfer Cairn
correctness, policy soundness, evidence truth, or release authority.

## Current authoring compatibility

The current Terrane overlay targets the independent public
[Cairn source](https://github.com/OnixResearch/cairn-public) at
`acb4c3d2cb90b231e07a6b71115c79adde46349c`. It derives an
`outcome-machine` profile from the historical `spec-driven` profile, retaining
its bounds, delta-spec requirements, task links, and non-claims. The added
design-stage `outcome-machine.json` review is required by that profile's design
and tasks artifacts. The workflow and guidance catalogs admit the new profile;
the gate receipt field catalog additionally declares `policy_selection`.
Both maintained traceability profiles explicitly retain `assurance_level = "declared"`
and `anchor_kind = "exact_marker_bytes"`, as required by the public CLI and the
historical base. Typed negative fixtures reject missing assurance, verification
overclaims, and line-number anchors; no marker becomes a verified proof claim.

Only `generated/cairn-policy.json` is regenerated from this current authoring
overlay. Neither the immutable base projection nor the licensed
`upstream-source/` blobs are refreshed or relabelled. Existing changes keep
their selected workflow; adding the required profile does not select it for
every change or waive any native gate.

Use the pinned public Cairn CLI with the reviewed Nickel cohort to export and
check the current policy from Terrane's root:

```sh
cairn policy export --source cairn-policy/default.ncl --output cairn-policy/generated/cairn-policy.json
cairn policy export --source cairn-policy/default.ncl --output cairn-policy/generated/cairn-policy.json --check
```

Source export is not native lifecycle acceptance. Fresh native validation,
proposal/design/tasks gates, and authorized sync/archive remain separate
requirements; the historical reproduction procedure below is unchanged.

## Preferred form and checked source import

Cairn authors this policy in Nickel, **not** in generated JSON. At the pinned
revision the complete transitive import closure of `cairn-policy/default.ncl`
is `default.ncl` (Git blob `0d04be0a1d3fbe3fa94157aab68cd75c7e3dccb6`),
`contracts.ncl` (`293e587cff35e80c6b089cb5c4a2b12d6996a621`),
`lifecycle-store-contracts.ncl` (`ea7becf0212d09af78e6c9f777d60c2e2a0086de`),
and `nominal-evidence-identities.ncl`
(`ba2c825f194bc82759d0eae916bb31912d435bae`). Exact pinned copies live
in [`upstream-source/`](upstream-source/); Trellis's own `default.ncl` and
`contracts.ncl` are an overlay, not replacements for Cairn's authoring source.
Run from Trellis's root with a Cairn Git checkout containing the pinned commit:

```sh
python3 cairn-policy/sync-cairn-source.py --upstream ../cairn --import
python3 cairn-policy/sync-cairn-source.py --upstream ../cairn
```

The first command copies *only missing* pinned Nickel inputs and then checks
them; it refuses changed files instead of overwriting local work. The second
checks imported Nickel bytes, the copied base projection, and license text
against Git objects at that revision without writing. Neither command
regenerates the JSON.
The immutable generated base is Git blob `57d1f8194930ceacde797af4b53f90ad1daeac18`.

## Export toolchain and review boundary

At the pinned revision, `cairn policy export` in
`crates/cairn-cli/src/policy.rs` (`7a480c3eed34442d13d1f0cc96c4501cb5276262`)
runs `nickel export --format json`, independently runs `nickel-export` in
`crates/cairn-cli/src/nickel_export_boundary.rs`
(`627c5a0a78c64f865e0fd92ed9c4d06118c9bb5f`), requires byte/diagnostic
parity, validates policy through `cairn-core` and Cairn's semantic checks,
checks invalid fixtures, then serializes using `serde_json::to_string_pretty`
with a trailing newline. It is **not** equivalent to simply redirecting
Nickel's JSON stdout into `cairn-policy.base.json`.

The pinned Cairn `flake.nix` (`93a4a43defa37dd505b6494083795d2c44740667`)
wraps the CLI with `pkgs.nickel` and `nickel-export` on `PATH`; its `flake.lock`
(`4cb40c06a705d9463ce3db975b5d2657338114ae`) pins nixpkgs to
`d233902339c02a9c334e7e593de68855ad26c4cb` (Nickel CLI 1.16.0 as
declared by the exporter), and nickel-export to
`257fafc1c746f1faf156207043a4c826bfb16d49`. Cairn's `Cargo.toml`
(`2dc14f5c0d74373b4d98bcc7913d2e605707c82c`) and `Cargo.lock`
(`96d21612c54fd5cceb6a0953a51c1f53db692b24`) pin its Rust dependency
graph, including `nickel-export-core`. To independently recreate and compare
the projection, use a *clean checkout at the exact Cairn revision*, with its
own flake and lock; from that checkout run:

```sh
nix run path:$PWD#cairn -- policy export --check
git hash-object cairn-policy/generated/cairn-policy.json
```

Expect Git blob `57d1f8194930ceacde797af4b53f90ad1daeac18` from the second
command and compare the output bytes to Terrane's
`cairn-policy/generated/cairn-policy.base.json` with `cmp`. This is an
executable procedure, **not a claim that it has been run for this distribution**.
Terrane's source import contains the pinned Nickel inputs but does *not*
bundle the Cairn CLI/exporter Rust source, its transitively required modules
and third-party packages, or the evaluator sources/lock closure. The
[additional grant](LICENSING.md) permits distributing the named copied files
under MIT without treating the CLI and exporter as relicensed. Reproduction
from the pinned Cairn revision still requires access to Cairn's private Git
history and separately identified toolchain; the blobs bundled here remain
locally inspectable. The grant does not establish chain of title, source
correctness, policy soundness, or release eligibility.
