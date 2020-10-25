terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
region = "eu-west-1"
}
variable "ingressrules" {
    type = list(number)
    description = "list of allowed port inbound rules"
    default = [80, 443]
}
variable "egressrules" {
    type = list(number)
    description = "list of allowed port outbound rules"
    default = [80, 443, 25]
}
resource "aws_instance" "ec2"{
    ami = "ami-06fd8a495a537da8b"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    tags = {
        Name = "first_instance"
    }
 
}

resource "aws_security_group" "webtraffic"{
    name = "Allow Trafic"
    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}


