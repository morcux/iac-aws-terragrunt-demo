include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../../modules/vpc"
}

inputs = {
  cidr_block   = "10.0.0.0/16"
  environment  = local.env.locals.environment
}