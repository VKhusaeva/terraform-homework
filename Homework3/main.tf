provider aws {
    region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "bastion"
  public_key = file("~/.ssh/id_rsa.pub")
}

data "aws_ami" "linux" {
  most_recent      = true
  owners           = ["amazon"]
 
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
 
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
 
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
 
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"
  count = 3
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.secgr.id]
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  
  tags = {
    Name = "web-${count.index + 1}"
  }

  user_data = file("apache.sh")
}

output ec2 {
    value = aws_instance.web[0].public_ip
}