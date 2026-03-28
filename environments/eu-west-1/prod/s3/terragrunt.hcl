include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../../modules/s3"
}

inputs = {
  bucket_name = "my-app-prod-data"
  environment = local.env.locals.environment
}