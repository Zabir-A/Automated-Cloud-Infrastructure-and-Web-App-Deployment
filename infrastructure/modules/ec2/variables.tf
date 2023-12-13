variable "project_name" {
  description = "Project name"
  default = "Assignment_3"
}

variable "ami_id" {
    description = "AMI ID"
}

variable "aws_region" {
  description = "AWS Region"
}

provider "aws" {
  region = var.aws_region
}

variable "subnet_id" {
  description = "Subnet ID for EC2 Instance"
  
}

variable "security_group_id" {
  description = "Security Group ID for EC2 Instance"
  
}

variable "ssh_key_name" {
    description = "SSH Key Name"
    default = "acit_4640_desktop"
  
}

variable "mapped_tags" {
  description = "Mapping of tags for EC2 Instance"
  type = map(string)
  default = {}
}