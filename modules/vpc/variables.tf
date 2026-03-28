variable "cidr_block" {
    type = string
}

variable "environment" {
    type = string
}

variable "public_subnet_cidr" {
    type = string
    default = "10.0.1.0/24"
}

