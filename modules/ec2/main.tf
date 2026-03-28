resource "aws_instance" "this" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
  
    tags = {
      Name = "${var.environment}-web"
    }
}