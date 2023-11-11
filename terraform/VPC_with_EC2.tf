provider "aws" {
  region = var.location
}

//create EC2 instance  w
resource "aws_instance" "metha-server" {
  ami                    = var.os-name
  key_name               = var.key
  instance_type          = var.instance-type
  associate_public_ip_address = true 
  subnet_id              = aws_subnet.metha-subnet.id
  vpc_security_group_ids = [aws_security_group.metha-aws_security_group.id]
}

//create VPC
resource "aws_vpc" "metha-vpc" {
  cidr_block = var.vpc-cidr
}

//create the subnet
resource "aws_subnet" "metha-subnet" {
  vpc_id     = aws_vpc.metha-vpc.id
  cidr_block = var.subnet1-cidr

  tags = {
    Name = "metha-subnet"
  }
}

//create internet gateway
resource "aws_internet_gateway" "metha-gateway" {
  vpc_id = aws_vpc.metha-vpc.id

  tags = {
    Name = "metha-gateway"
  }

}

//create route table
resource "aws_route_table" "metha-route_table" {
  vpc_id = aws_vpc.metha-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.metha-gateway.id
  }
  tags = {
    Name = "metha-route_table"
  }
}

//associate subnet with the route table
resource "aws_route_table_association" "metha-aws_route_table_association" {
  subnet_id      = aws_subnet.metha-subnet.id
  route_table_id = aws_route_table.metha-route_table.id
}

//create security group
resource "aws_security_group" "metha-aws_security_group" {
  name        = "metha-aws_security_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.metha-vpc.id

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "metha-aws_security_group"
  }
}