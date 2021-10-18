provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "maquina_nodejs" {
  subnet_id                   = "subnet-0e4c840c1e240f521"
  ami                         = "ami-054a31f1b3bf90920"
  instance_type               = "t2.micro"
  key_name                    = "key-dev-gabriel"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-nodejs-gabriel"
  }
    vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}

output "aws_instance_e_ssh" {
  value = aws_instance.maquina_nodejs.public_dns
}
