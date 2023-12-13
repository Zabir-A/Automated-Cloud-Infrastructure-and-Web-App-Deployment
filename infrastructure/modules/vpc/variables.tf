variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "project_name" {
  description = "Project name"
  default = "Assignment_3"
}

variable "vpc_cidr" {
  description = "A03 VPC CIDR"
  default     = "192.168.0.0/16"
}

variable "be_sn_cidr" {
  description = "Private Subnet CIDR"
  default     = "192.168.1.0/24"
}

variable "web_sn_cidr" {
  description = "Public Subnet CIDR"
  default     = "192.168.2.0/24"
}

variable "db_1_sn_cidr" {
    description = "DB_1 Subnet"
    default = "192.168.3.0/24"
  
}

variable "db_2_sn_cidr" {
    description = "DB_2 Subnet"
    default = "192.168.4.0/24"
  
}

variable "home_net" {
  description = "Home CIDR"
  default = "99.199.29.59/32"
}

variable "bcit_net" {
  description = "BCIT CIDR"
  default = "142.232.0.0/16"
 
}

variable "default_route"{
  description = "Default route"
  default     = "0.0.0.0/0"
}