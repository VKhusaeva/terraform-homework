provider "aws" {
  region = var.region
}

resource "aws_vpc" "kaizen" {
  cidr_block = var.vpc_cidr[0].cidr
  enable_dns_support = var.vpc_cidr[0].dns_support
  enable_dns_hostnames = var.vpc_cidr[0].dns_hostnames
  tags = {
    Name = "kaizen"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnets[0].cidr
  availability_zone = var.subnets[0].az

  tags = {
    Name = var.subnets[0].name
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnets[1].cidr
  availability_zone = var.subnets[1].az

  tags = {
    Name = var.subnets[1].name
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnets[2].cidr
  availability_zone = var.subnets[2].az

  tags = {
    Name = var.subnets[2].name
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.kaizen.id
  cidr_block        = var.subnets[3].cidr
  availability_zone = var.subnets[3].az

  tags = {
    Name = var.subnets[3].name
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.kaizen.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = var.route_table_names[0]
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.kaizen.id

  tags = {
    Name = var.route_table_names[1]
  }
}

resource "aws_route_table_association" "public1_assoc" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_assoc" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private1_assoc" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private2_assoc" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_instance" "ubuntu_instance" {
  ami                         = "ami-0aff18ec83b712f05"
  instance_type               = var.ec2_instances[0].type
  subnet_id                   = aws_subnet.public1.id
  vpc_security_group_ids      = [aws_security_group.kaizen_sg.id]
  associate_public_ip_address = true
  user_data = file("apache.sh")

  tags = {
    Name = var.ec2_instances[0].name
  }
}

resource "aws_instance" "amazon_instance" {
  ami                         = "ami-078701cc0905d44e4" 
  instance_type               = var.ec2_instances[1].type
  subnet_id                   = aws_subnet.public2.id
  vpc_security_group_ids      = [aws_security_group.kaizen_sg.id]
  associate_public_ip_address = true
  user_data = file("httpd.sh")

  tags = {
    Name = var.ec2_instances[1].name
  }
}

output "ec2_instance_ips" {
  value = [aws_instance.ubuntu_instance.public_ip, aws_instance.amazon_instance.public_ip]
}
