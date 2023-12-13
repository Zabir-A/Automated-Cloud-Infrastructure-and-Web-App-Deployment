output "ec2_instance_public_dns" {
  description = "EC2 instance Public DNS"
  value       = aws_instance.ec2_instance.public_dns
}

output "ec2_instance_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.ec2_instance.public_ip
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.ec2_instance.id
}


