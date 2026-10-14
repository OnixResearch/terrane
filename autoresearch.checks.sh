#!/usr/bin/env bash
set -euo pipefail
export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-target/autoresearch-verified-logic}"
cargo test --quiet
cargo clippy --all-targets -- -D warnings
./scripts/verus.sh src/lib.rs
./scripts/check-ensures.rs
tracey query uncovered
tracey query untested
