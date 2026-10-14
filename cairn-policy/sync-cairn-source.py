#!/usr/bin/env python3
"""Import/check Cairn's exact pinned Nickel policy input closure without changing JSON."""

import argparse
import subprocess
import sys
from pathlib import Path

REVISION = "b6759012db4dab0158936e995b7bad39ac10465b"
BASE_BLOB = "57d1f8194930ceacde797af4b53f90ad1daeac18"
SOURCES = (
    "default.ncl",
    "contracts.ncl",
    "lifecycle-store-contracts.ncl",
    "nominal-evidence-identities.ncl",
)
POLICY = Path(__file__).resolve().parent


def git(repo: Path, *args: str) -> bytes:
    return subprocess.check_output(("git", "-C", str(repo), *args))


def verify(repo: Path, relative: str, destination: Path, import_source: bool) -> None:
    original = git(repo, "show", f"{REVISION}:{relative}")
    expected_blob = git(repo, "rev-parse", f"{REVISION}:{relative}").decode().strip()
    actual_blob = subprocess.check_output(("git", "hash-object", "--stdin"), input=original).decode().strip()
    if actual_blob != expected_blob:
        raise ValueError(f"Git object mismatch: {relative}")
    if destination.is_symlink() or destination.parent.is_symlink():
        raise ValueError(f"refusing symlinked pinned source path: {destination}")
    if import_source and not destination.exists():
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(original)
    if not destination.is_file() or destination.is_symlink() or destination.read_bytes() != original:
        raise ValueError(f"missing or modified pinned source: {destination}")
    print(f"{relative}: {expected_blob}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--upstream", required=True, type=Path, help="Cairn checkout containing the pinned Git commit")
    parser.add_argument("--import", dest="import_source", action="store_true", help="copy missing pinned Nickel source files")
    args = parser.parse_args()
    repo = args.upstream.resolve()
    if git(repo, "rev-parse", f"{REVISION}^{{commit}}").decode().strip() != REVISION:
        raise ValueError("expected pinned Cairn commit is unavailable")
    for name in SOURCES:
        verify(repo, f"cairn-policy/{name}", POLICY / "upstream-source" / name, args.import_source)
    upstream_json = git(repo, "show", f"{REVISION}:cairn-policy/generated/cairn-policy.json")
    local_json = (POLICY / "generated/cairn-policy.base.json").read_bytes()
    if upstream_json != local_json:
        raise ValueError("Trellis base projection differs from pinned Cairn output")
    blob = subprocess.check_output(("git", "hash-object", "--stdin"), input=local_json).decode().strip()
    if blob != BASE_BLOB:
        raise ValueError("pinned generated projection Git blob ID differs")
    license_bytes = git(repo, "show", f"{REVISION}:LICENSES/AGPL-3.0-or-later.txt")
    if (POLICY.parent / "LICENSES/AGPL-3.0-or-later.txt").read_bytes() != license_bytes:
        raise ValueError("upstream AGPL license text differs")
    print(f"generated/cairn-policy.base.json: {blob}; license text: exact pinned bytes")


if __name__ == "__main__":
    try:
        main()
    except (OSError, subprocess.CalledProcessError, ValueError) as error:
        sys.exit(str(error))
