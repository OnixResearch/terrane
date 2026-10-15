let Contracts = import "contracts.ncl" in
let Base = import "generated/cairn-policy.base.json" in
# Current authoring compatibility for public Cairn acb4c3d2cb90b231e07a6b71115c79adde46349c.
# The licensed historical base and upstream-source bytes remain immutable.
let TrellisOutcomeMachineSchemas = std.array.map (fun schema => schema & {
  id | force = "outcome-machine",
  description | force = "Spec-driven lifecycle with repeatable-capability and completion-evidence obligations",
  artifacts | force = std.array.map (fun artifact =>
    if artifact.id == "design" then artifact & {
      requires | force = artifact.requires @ ["outcome-machine"],
      apply_prerequisites | force = artifact.apply_prerequisites @ ["artifact:outcome-machine"],
    } else if artifact.id == "tasks" then artifact & {
      requires | force = artifact.requires @ ["outcome-machine"],
      constraints | force = artifact.constraints @ ["Include completion-evidence and fresh-state tasks."],
    } else artifact
  ) schema.artifacts @ [{
    id = "outcome-machine",
    generates = "outcome-machine.json",
    output_path = "outcome-machine.json",
    path_kind = "file",
    structural_admission = "outcome_machine",
    requires = ["proposal"],
    stage = "design",
    instruction_template = "Complete outcome-machine.json for {{change}} with one admitted route, tracked inputs, checks, authority facts, and completion state.",
    constraints = ["Use cairn.outcome-machine-review.v1.", "Replace every placeholder before the design gate.", "Record observed evidence before sync or archive."],
    apply_prerequisites = ["gate:proposal"],
    skipped = false,
    skip_satisfies_dependencies = false,
  }],
  required_non_claims | force = schema.required_non_claims @ [
    "outcome-machine profile conformance does not prove product value, evidence truth, semantic correctness, reuse quality, maintenance quality, or release eligibility",
    "recorded completion and fresh-state references prove only admitted structure and identity, not that the referenced claim is true",
  ],
}) (std.array.filter (fun schema => schema.id == "spec-driven") Base.schemas) in
let TrellisTraceabilityPolicy = {
  default_profile = "trellis-rust",
  profiles = [
    {
      id = "cairn-default",
      requirement_sources = [
        { root = ".cairn/specs", source_kind = "accepted_specs", extensions = ["md"] },
      ],
      evidence_sources = [
        { root = "src", source_kind = "rust_source", extensions = ["rs"] },
        { root = "scripts", source_kind = "tool_source", extensions = ["rs", "sh"] },
        { root = "cairn-policy", source_kind = "nickel_source", extensions = ["ncl"] },
      ],
      marker_verbs = ["impl", "verify", "depends", "related"],
      assurance_level = "declared",
      anchor_kind = "exact_marker_bytes",
    },
    {
      id = "trellis-rust",
      requirement_sources = [
        { root = "docs/requirements.md", source_kind = "requirements_doc", extensions = ["md"] },
      ],
      evidence_sources = [
        { root = "src", source_kind = "rust_source", extensions = ["rs"] },
        { root = "tests", source_kind = "rust_source", extensions = ["rs"] },
      ],
      marker_verbs = ["impl", "verify", "depends", "related"],
      assurance_level = "declared",
      anchor_kind = "exact_marker_bytes",
    },
  ],
} in
let TrellisStackProvenanceGate = {
  mode = "optional",
  allowed_claim_scopes = ["stack_provenance.v1.lifecycle_policy_conformance"],
  accepted_valence_policy_hashes = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"],
  required_boundary = "Cairn consumed Valence and Mantle stack provenance receipts for lifecycle and release policy conformance only; it did not prove source-code correctness, Valence verifier soundness, Mantle build correctness, or Trellis or Octet proof validity",
} in
let TrellisFunctionAddressGate = {
  mode = "optional",
  allowed_claim_scopes = ["function_address.v1.lifecycle_policy_conformance"],
  accepted_valence_policy_hashes = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"],
  required_roles = [
    "function-address-evidence-sidecar",
    "valence-function-address-evidence-profile",
    "kamacite-function-address-receipt",
  ],
  required_schemas = [
    "valence.function-address-evidence.v1",
    "function-address-evidence-v1",
    "kamacite.function-address-receipt.v1",
  ],
  required_boundary = "Cairn consumed Valence, Mantle, and Kamacite function-address evidence for lifecycle and release policy conformance only; it did not prove Rust semantic correctness, compiler correctness, whole-program safety, verifier soundness, or release eligibility",
} in
(Base & {
  name | force = "trellis-default",
  schemas | force = Base.schemas @ TrellisOutcomeMachineSchemas,
  workflow_profile_policy = {
    allowed_profiles | force = Base.workflow_profile_policy.allowed_profiles @ ["outcome-machine"],
  },
  agent_guidance_policy = {
    known_profiles | force = Base.agent_guidance_policy.known_profiles @ ["outcome-machine"],
    known_artifacts | force = Base.agent_guidance_policy.known_artifacts @ ["outcome-machine"],
  },
  receipt_schemas | force = std.array.map (fun schema =>
    if schema.command == "gate" then schema & {
      top_level_keys | force = schema.top_level_keys @ ["policy_selection"],
    } else schema
  ) Base.receipt_schemas,
  traceability_policy | force = TrellisTraceabilityPolicy,
  stack_provenance_gate | force = TrellisStackProvenanceGate,
  function_address_gate | force = TrellisFunctionAddressGate,
}) | Contracts.Policy | Contracts.PolicyIntegrity
