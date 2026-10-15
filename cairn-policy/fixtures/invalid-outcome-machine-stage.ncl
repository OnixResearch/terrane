let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
((std.record.remove "schemas" Policy) & {
  schemas | force = std.array.map (fun schema =>
    if schema.id == "outcome-machine" then (std.record.remove "artifacts" schema) & {
      artifacts | force = std.array.map (fun artifact =>
        if artifact.id == "outcome-machine" then artifact & { stage | force = "tasks" } else artifact
      ) schema.artifacts,
    } else schema
  ) Policy.schemas,
}) | Contracts.Policy | Contracts.PolicyIntegrity
