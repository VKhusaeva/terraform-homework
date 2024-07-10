provider "aws" {
  region = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH, HTTP, and HTTPS traffic"

  ingress {
    from_port   = var.ports[0]
    to_port     = var.ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ports[1]
    to_port     = var.ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ports[2]
    to_port     = var.ports[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "Homework4"
  }
}