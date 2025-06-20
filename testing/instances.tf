data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.7.20250609.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_instance" "my-instance" {
  ami           = data.aws_ami.ubuntu.id
  subnet_id = aws_subnet.my-subnet-1.id
  instance_type = "t2.micro"
  availability_zone = "us-east-1e"
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  tags = {
    Name = "my-instance"
  }
}

resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}