variable "instance_number" {
    type = number
}
module "ec2" {
    source = "./ec2"
    server_names = ["nginx","apache"]
}

output "private_ips" {
    value = module.ec2.private_ip
}

resource "aws_instance" "ec2" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    count = var.instance_number
}

