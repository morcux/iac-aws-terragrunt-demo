variable "vpc_id" {
  type = string
}
variable "ingress_port" {
  type = number
  default = 80
}
variable "environment" {
  type = string
}