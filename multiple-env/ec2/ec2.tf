variable "instances_names" {
    type = list(string)
}

resource "aws_instance" "server" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    count = length(var.instances_names)
    tags = {
        Name = var.instances_names[count.index]
    }
}

output "private_ip" {
    value = [aws_instance.server.*.private_ip]
}