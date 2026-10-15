let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
((std.record.remove "traceability_policy" Policy) & {
  traceability_policy = (std.record.remove "profiles" Policy.traceability_policy) & {
    profiles | force = std.array.map (fun profile =>
      if profile.id == "trellis-rust" then profile & { anchor_kind | force = "line_number" } else profile
    ) Policy.traceability_policy.profiles,
  },
}) | Contracts.Policy | Contracts.PolicyIntegrity
