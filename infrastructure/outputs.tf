output "vpc_id" {
    value = module.vpc.vpc_id
}

output "web_subnet_id" {
    value = module.vpc.web_subnet_id
}

output "be_sn_id" {
    value = module.vpc.be_subnet_id
}

output "db_1_subnet_id" {
    value = module.vpc.db_1_subnet_id
}

output "db_2_subnet_id" {
    value = module.vpc.db_2_subnet_id
}

output "ig_id" {
    value = module.vpc.a03_gw_id
}

output "rt_id" {
    value = module.vpc.a03_rt_id
}

output "web_sg_id" {
    value = module.public_sg.sg_id
}

output "be_sg_id" {
    value = module.private_sg.sg_id
}

output "db_sg_id" {
  value = module.db_sg.sg_id
}

output "web_ec2_instance_id" {
    value = module.web_ec2_instance.ec2_instance_id
}

output "web_ec2_instance_public_ip" {
    value = module.web_ec2_instance.ec2_instance_public_ip
}

output "web_ec2_instance_public_dns" {
    value = module.web_ec2_instance.ec2_instance_public_dns
}

output "backend_ec2_instance_id" {
    value = module.backend_ec2_instance.ec2_instance_id
}

output "backend_ec2_public_ip" {
    value = module.backend_ec2_instance.ec2_instance_public_ip
}

output "backend_ec2_public_dns" {
    value = module.backend_ec2_instance.ec2_instance_public_dns
}

output "rds_endpoint" {
    value = module.rds_ec2_instance.rds_instance_endpoint
}

output "rds_address" {
    value = module.rds_ec2_instance.rds_address
}

output "rds_instance_id" {
    value = module.rds_ec2_instance.rds_instance_id
}

