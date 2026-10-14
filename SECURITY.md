# Security policy

Terrane is a research library. A Verus result covers the selected source, contracts, assumptions, trusted boundaries, and verifier cohort; it is not a security guarantee for an integrating system. See [the proof-gap inventory](docs/proof-gap-sites.tsv) before relying on a particular API.

## Supported code

Please report vulnerabilities affecting the current `main` branch or the latest tagged release, including runtime code, proof assumptions, and verification tooling. Older versions are not guaranteed security backports.

## Private reporting

Report vulnerabilities through [GitHub private vulnerability reporting](https://github.com/OnixResearch/terrane/security/advisories/new). Include the affected revision, impact, reproduction steps, and any relevant trust assumptions. Do not include live credentials or publish exploit details in an issue or discussion.

The repository owner must enable private vulnerability reporting before publishing source in this public repository. If the reporting link is unavailable, do not post details publicly; the maintainer needs to provide a private reporting channel first. Coordinate disclosure with the maintainers after they have had an opportunity to assess and address the report. No response-time or backport commitment is implied.
