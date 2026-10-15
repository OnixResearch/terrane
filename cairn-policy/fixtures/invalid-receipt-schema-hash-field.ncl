let Contracts = import "../contracts.ncl" in
let Policy = import "../default.ncl" in
((std.record.remove "receipt_schemas" Policy) & {
  receipt_schemas | force = std.array.map (fun schema =>
    if schema.command == "gate" then schema & {
      hash_fields | force = ["missing_hash_field"],
    } else schema
  ) Policy.receipt_schemas,
}) | Contracts.Policy | Contracts.PolicyIntegrity
