provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.test_sg.id]
  subnet_id              = var.subnet_id

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Allow HTTP from Leumi proxy"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.leumi_proxy_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "test_eip" {
  instance = aws_instance.test.id
  vpc      = true
}

