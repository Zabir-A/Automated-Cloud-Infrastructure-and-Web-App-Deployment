variable "db_engine_version" {
  description = "DB Engine Version"
  default     = "5.7"
}

variable "db_instance_class" {
  description = "Intance Type for RDS"
  default     = "db.t2.micro"
}

variable "db_allocated_storage" {
  description = "Allocated Storage (GB)"
  type = number
  default     = 5
}

variable "db_identifier" {
  description = "Name of DB"
  type = string
  default = "a03-rds-instance"
}

variable "db_sn_ids" {
  description = "List of Subnet ID's for RDS DB Subnet Group"
  type = list(string)
  
}

variable "db_username" {
  description = "DB Username"
  type = string
  default = "root"
}

variable "db_password" {
  description = "DB Password"
  type = string 
  default = "Password"
}


variable "db_security_group_id" {
  description = "List of Security Group ID's for RDS Security group"
  type = list(string)
}
