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
resource aws_instance "db_server"{
    ami = "ami-06fd8a495a537da8b"
    instance_type = "t2.micro"
    tags = {
        Name = "DB Server"
    }
    security_groups = []
    user_data = file (install_apache.sh)

}

resource aws_instance "web_server"{
    ami = "ami-06fd8a495a537da8b"
    instance_type = "t2.micro"
    tags = {
        Name = "Web Server"
    }
    security_groups = []
    user_data = file (install_apache.sh)

}

resource aws_eip "web_server_ip" {
    instance = aws_instance.web_server.id
}

variable "ingressrules" {
    type = list(number)
    description = "list of allowed port inbound rules"
    default = [80, 443]
}
variable "egressrules" {
    type = list(number)
    description = "list of allowed port outbound rules"
    default = [80, 443]
}
resource aws_security_group "web traffic" {
    name = "Allow Web Traffic"
    tags = {
        Name = "Web Traffic"
    }

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

resource aws_instance {

}

output "BDIP" {
    value = aws_instance.db_server.private_ip
}

output "WebServerIP" {
    value = aws_eip.web_server_ip.public_ip

}