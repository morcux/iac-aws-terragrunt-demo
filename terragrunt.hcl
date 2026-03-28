locals {
  region_config = read_terragrunt_config(
    find_in_parent_folders("region.hcl")
  )
  region = local.region_config.locals.region
}

remote_state {
  backend = "s3" 
  config = {
    bucket = "my-infra-state"
    key = "${path_relative_to_include()}.tfstate"
    region = local.region
    encrypt = true
    dynamodb_table = "tf-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "${local.region}"
}
EOF
} 