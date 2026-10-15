let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
((std.record.remove "schemas" Policy) & {
  schemas | force = std.array.map (fun schema =>
    if schema.id == "spec-driven" then schema & {
      artifacts | force = std.array.map (fun artifact =>
        if artifact.id == "tasks" then artifact & {
          requires | force = artifact.requires @ ["missing"],
        } else artifact
      ) schema.artifacts,
    } else schema
  ) Policy.schemas,
}) | Contracts.Policy | Contracts.PolicyIntegrity
