include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../../modules/rds"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "vpc-mock-12345"
    public_subnet_id = "subnet-mock-67890"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

dependency "security_group" {
  config_path = "../security_group"

  mock_outputs = {
    sg_id = "sg-mock-12345"
  }

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  db_name = "mydb"
  db_username = "admin"
  db_instance_class = "db.t3.micro"
  subnet_ids = dependency.vpc.outputs.public_subnet_ids
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_security_group_ids = [dependency.security_group.outputs.sg_id]
  environment = local.env.locals.environment
}