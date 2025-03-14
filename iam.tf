
# Fetch the latest Ubuntu AMI dynamically
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Canonical (Ubuntu) owner ID
}

# Create an EC2 Instance
resource "aws_instance" "example_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "example-instance"
  }
}

# Allocate an Elastic IP
resource "aws_eip" "example_eip" {
  instance = aws_instance.example_instance.id
}
