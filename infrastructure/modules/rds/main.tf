# A3 RDS Instance & Subnet Group

resource "aws_db_subnet_group" "db_sn_group" {
  name = "db_sn_group"
  subnet_ids = var.db_sn_ids
  tags = {
    Name = "DB Subnet Group"
  }
}


resource "aws_db_instance" "a03_rds" {
  allocated_storage    = var.db_allocated_storage
  identifier = var.db_identifier
  engine               = "mysql"
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_sn_group.name
  vpc_security_group_ids = var.db_security_group_id
  skip_final_snapshot  = true
}
