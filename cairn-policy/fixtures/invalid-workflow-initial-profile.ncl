let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
((std.record.remove "schemas" Policy) & {
  schemas | force = std.array.filter (fun schema => schema.id != "outcome-machine") Policy.schemas,
}) | Contracts.Policy | Contracts.PolicyIntegrity
