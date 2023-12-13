output "vpc_id" {
  description = "A03 VPC ID"
  value       = aws_vpc.a03_vpc.id
}

output "web_subnet_id" {
  description = "Public (Web) Subnet ID"
  value       = aws_subnet.web_sn.id
}

output "be_subnet_id" {
  description = "Private (Backend) Subnet ID"
  value       = aws_subnet.be_sn.id
}

output "be_sn_cidr" {
  description = "Backend CIDR"
  value = aws_subnet.be_sn.cidr_block
}

output "db_1_subnet_id" {
  description = "DB_1 Subnet ID"
  value       = aws_subnet.db_1_sn.id
}

output "db_2_subnet_id" {
  description = "DB_2 Subnet ID"
  value       = aws_subnet.db_2_sn.id
}

output "a03_gw_id" {
  description = "A03 Gateway ID"
  value = aws_internet_gateway.a03_gw.id
  
}

output "a03_rt_id" {
  description = "A03 Route Table ID"
  value = aws_route_table.a03_rt.id
}
