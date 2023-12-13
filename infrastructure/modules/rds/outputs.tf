output "rds_instance_endpoint" {
  description = "Connection endpoint for RDS instance"
  value       = aws_db_instance.a03_rds.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.a03_rds.id
}

output "rds_address" {
  value = aws_db_instance.a03_rds.address
}
