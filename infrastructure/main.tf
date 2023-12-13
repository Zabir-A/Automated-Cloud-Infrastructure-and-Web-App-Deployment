# A3 Main TF File (Modules)

module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
    aws_region = "us-west-2"
}

module "public_sg" {
    source = "./modules/security_group"
    sg_name = "public_sg"
    sg_description = "Web Security Group Rules"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    ingress_rules = [
        {
            description = "HTTP Access"
            ip_protocol = "tcp"
            from_port   = 80
            to_port     = 80
            cidr_ipv4   = "0.0.0.0/0"
            rule_name   = "http_rule"
        },

        {
            description = "HTTPS Access"
            ip_protocol = "tcp"
            from_port   = 443
            to_port     = 443
            cidr_ipv4   = "0.0.0.0/0"
            rule_name   = "https_rule"
        },
        
        {
            description = "SSH from home"
            ip_protocol = "tcp"
            from_port   = 22
            to_port     = 22
            cidr_ipv4   = var.home_net
            rule_name   = "ssh_home_rule"
        },

        {
                
            description = "SSH from BCIT"
            ip_protocol = "tcp"
            from_port   = 22
            to_port     = 22
            cidr_ipv4   = var.bcit_net
            rule_name   = "ssh_bcit_rule"
        }
    ]
    egress_rules = [
        {
            description = "Allow outbound traffic"
            ip_protocol = "-1"
            from_port   = 0
            to_port     = 0
            cidr_ipv4   = "0.0.0.0/0"
            rule_name   = "allow_all_rule"
        }
    ]
}

module "private_sg" {
    source = "./modules/security_group"
    sg_name = "private_sg"
    sg_description = "Backend Security Group Rules"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    ingress_rules = [
        {
            description = "SSH from home"
            ip_protocol = "tcp"
            from_port   = 22
            to_port     = 22
            cidr_ipv4   = var.home_net
            rule_name   = "ssh_home_be_rule"
        },
        {
            description = "SSH from BCIT"
            ip_protocol = "tcp"
            from_port   = 22
            to_port     = 22
            cidr_ipv4   = var.bcit_net
            rule_name   = "ssh_bcit_be_rule"
        },
        {
            description = "Allow all traffic from VPC"
            ip_protocol = "-1"
            from_port   = 0
            to_port     = 0
            cidr_ipv4   = var.vpc_cidr
            rule_name   = "all_traffic_be_rule"
        }
    ]
    egress_rules = [
        {
            description = "Allow all outbound traffic"
            ip_protocol = "-1"
            from_port   = 0
            to_port     = 0
            cidr_ipv4   = "0.0.0.0/0"
            rule_name   = "allow_all_outbound_be_rule"
        }
    ]
}

module "db_sg" {
    source = "./modules/security_group"
    sg_name = "db_sg"
    sg_description = "RDS Security Group"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    ingress_rules = [
        {
            description = "MySQL access from Private Subnet"
            ip_protocol = "tcp"
            from_port = 3306
            to_port = 3306
            cidr_ipv4 = module.vpc.be_sn_cidr
            rule_name = "mysql_traffic_from_rule"
        }
    ]
    egress_rules = [
        {
            description = "MySQL access to Private Subnet"
            ip_protocol = "tcp"
            from_port = 3306
            to_port = 3306
            cidr_ipv4 = module.vpc.be_sn_cidr
            rule_name = "mysql_traffic_to_rule"
        }
    ]
}


module "web_ec2_instance" {
    source = "./modules/ec2"
    project_name = var.project_name
    aws_region = var.aws_region
    ami_id = var.ami_id
    subnet_id = module.vpc.web_subnet_id
    security_group_id = module.public_sg.sg_id
    ssh_key_name = var.ssh_key_name
    mapped_tags = {
        Name = "Web"
        Project = var.project_name
    }
}

module "backend_ec2_instance" {
    source = "./modules/ec2"
    project_name = var.project_name
    aws_region = var.aws_region
    ami_id = var.ami_id
    subnet_id = module.vpc.be_subnet_id
    security_group_id = module.private_sg.sg_id
    ssh_key_name = var.ssh_key_name
    mapped_tags = {
        Name = "Backend"
        Project = var.project_name
    }
}

module "rds_ec2_instance" {
    source = "./modules/rds"
    db_sn_ids = [module.vpc.db_1_subnet_id, module.vpc.db_2_subnet_id]
    db_allocated_storage = var.db_allocated_storage
    db_instance_class = var.db_instance_class
    db_security_group_id = [module.db_sg.sg_id]
}

resource "local_file" "inventory_file" {
  content = <<EOF
web:
  hosts:
    ${module.web_ec2_instance.ec2_instance_public_dns}
backend:
  hosts:
    ${module.backend_ec2_instance.ec2_instance_public_dns}
EOF
  filename = "../service/inventory/inventory.yml"
}



resource "local_file" "group_vars_file" {
  content = <<EOF
web_ec2_public_dns: ${module.web_ec2_instance.ec2_instance_public_dns}
backend_ec2_public_dns: ${module.backend_ec2_instance.ec2_instance_public_dns}
db_endpoint: ${module.rds_ec2_instance.rds_address}
EOF

  filename = "../service/group_vars/group_variables.yml"
}
