variable "db_name" {
    type = string
}
variable "db_username" {
  type = string
}
variable "db_instance_class" {
  type = string
  default = "db.t3.micro"
}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}
variable "db_password" {
  type = string
  sensitive = true
}
variable "environment" {
  type = string
}
variable "vpc_security_group_ids" {
  type = list(string)
}