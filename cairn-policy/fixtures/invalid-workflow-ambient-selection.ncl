let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
(Policy & {
  workflow_profile_policy = {
    forbidden_selection_sources | force = std.array.filter (fun source => source != "environment") Policy.workflow_profile_policy.forbidden_selection_sources,
  },
}) | Contracts.Policy | Contracts.PolicyIntegrity
