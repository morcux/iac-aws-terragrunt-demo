
variable "subnet_id" {
    type = string
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "environment" {
    type = string
}

variable "vpc_security_group_ids" {
  type = list(string)
}