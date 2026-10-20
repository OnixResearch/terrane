let contracts = import "../../upgrade-trial-contracts.ncl" in

let trial = import "../../upgrade-trial.ncl" in

(trial & {
  source_snapshot | force = trial.source_snapshot & {
    revision | force = "not-a-revision",
  },
}) | contracts.UpgradeTrial
