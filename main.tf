provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

# Create a Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"  # Valid AZ for us-east-1
  tags = {
    Name = "MySubnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "MyInternetGateway"
  }
}

# Create a Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  # Route all traffic to the Internet Gateway
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "my_route_table_assoc" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create a Security Group for the EC2 Instance
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  # Allow inbound SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (restrict in production)
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySecurityGroup"
  }
}

# Create an EC2 Instance
resource "aws_instance" "my_instance" {
  ami           = "ami-04b4f1a9cf54c11d0"  # Amazon Linux 2 AMI (change as needed)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]  # Corrected parameter
  tags = {
    Name = "MyEC2Instance"
  }
}

# Create an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "400-fold-bucket"  # Change to a unique bucket name
  acl    = "private"
  tags = {
    Name = "MyS3Bucket"
  }
}

# Create an IAM User
resource "aws_iam_user" "my_user" {
  name = "my_non_root_user"
}

# Attach the AdministratorAccess Policy to the IAM User
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.my_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create an Elastic IP and Associate it with the EC2 Instance
resource "aws_eip" "my_eip" {
  instance = aws_instance.my_instance.id
  tags = {
    Name = "MyElasticIP"
  }
}