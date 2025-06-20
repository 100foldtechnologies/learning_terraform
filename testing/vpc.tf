resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my-subnet-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.my_subnet_cidr_block
  tags = {
    Name = "my-subnet-1"
  }
}

resource "aws_internet_gateway" "my-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-gw"
  }
}

resource "aws_route_table" "my-rtb" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gw.id
  }

  tags = {
    Name = "my-rtb"
  }
}

resource "aws_route_table_association" "my-rtb-subnet" {
  subnet_id      = aws_subnet.my-subnet-1.id
  route_table_id = aws_route_table.my-rtb.id
}