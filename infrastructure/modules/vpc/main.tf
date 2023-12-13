# A3 VPC

provider "aws" {
    region = var.aws_region
}

resource "aws_vpc" "a03_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "a03_vpc"
    Project = var.project_name
  }
}

# Private Subnet (Backend)
resource "aws_subnet" "be_sn" {
  vpc_id            = aws_vpc.a03_vpc.id
  cidr_block        = var.be_sn_cidr
  # Enabled for Ansible ssh playbook
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"

  tags = {
    Name = "be_sn"
    Project = var.project_name
  }
}

# Public Subnet (Web)
resource "aws_subnet" "web_sn" {
  vpc_id                  = aws_vpc.a03_vpc.id
  cidr_block              = var.web_sn_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "web_sn"
    Project = var.project_name
  }
}

# DB_1 Subnet
resource "aws_subnet" "db_1_sn" {
    vpc_id = aws_vpc.a03_vpc.id
    cidr_block = var.db_1_sn_cidr
    availability_zone = "us-west-2a"

    tags = {
      Name = "db_1_sn"
      Project = var.project_name
    }
}

# DB_1 Subnet
resource "aws_subnet" "db_2_sn" {
    vpc_id = aws_vpc.a03_vpc.id
    cidr_block = var.db_2_sn_cidr
    availability_zone = "us-west-2b"

    tags = {
      Name = "db_2_sn"
      Project = var.project_name
    }
}


# Gateway
resource "aws_internet_gateway" "a03_gw" {
  vpc_id = aws_vpc.a03_vpc.id
  
  tags = {
    Name = "a03_gw"
    Project = var.project_name
  }
}

# Routetable & Associations
resource "aws_route_table" "a03_rt" {
  vpc_id = aws_vpc.a03_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.a03_gw.id
  }

  tags = {
    Name = "a03_rt"
    Project = var.project_name
  }
}

resource "aws_route_table_association" "a03_web_rta" {
  subnet_id      = aws_subnet.web_sn.id
  route_table_id = aws_route_table.a03_rt.id
}

resource "aws_route_table_association" "a03_be_rta" {
  subnet_id      = aws_subnet.be_sn.id
  route_table_id = aws_route_table.a03_rt.id
}

resource "aws_route_table_association" "a03_db_1_rta" {
  subnet_id      = aws_subnet.db_1_sn.id
  route_table_id = aws_route_table.a03_rt.id
}

resource "aws_route_table_association" "a03_db_2_rta" {
  subnet_id      = aws_subnet.db_2_sn.id
  route_table_id = aws_route_table.a03_rt.id
}