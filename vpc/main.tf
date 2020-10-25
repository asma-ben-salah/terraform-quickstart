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

variable "name" {
    type = string
    description = "Set a VPC Name please"
    default = "VPC1"
}

resource "aws_vpc" "vpc1"{
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = var.name
    }
}

