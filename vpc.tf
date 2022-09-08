#Step 1: create vpc
resource "aws_vpc" "lab-3-vpc" {
  cidr_block              = "10.0.0.0/16"
  tags = {
    Name                  = "lab-3-vpc"
  }
}
#Step 2: create 2 public subnet in 1a and 1b
resource "aws_subnet" "lab-3-public-subnet-1" {
  vpc_id                  = aws_vpc.lab-3-vpc.id
  cidr_block              = "10.0.0.0/18"
  map_public_ip_on_launch = true
  availability_zone = "ap-southeast-1a"
  tags = {
    Name                  = "lab-3-public-subnet-1"
  }
}
resource "aws_subnet" "lab-3-public-subnet-2" {
  vpc_id                  = aws_vpc.lab-3-vpc.id
  cidr_block              = "10.0.64.0/18"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"
  tags = {
    Name                  = "lab-3-public-subnet-2"
  }
}
#Step 3: create 2 private subnet in 1a and 1b
resource "aws_subnet" "lab-3-private-subnet-1" {
  vpc_id                  = aws_vpc.lab-3-vpc.id
  cidr_block              = "10.0.128.0/18"
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-1a"
  tags = {
    Name                  = "lab-3-private-subnet-1"
  }
}
resource "aws_subnet" "lab-3-private-subnet-2" {
  vpc_id                  = aws_vpc.lab-3-vpc.id
  cidr_block              = "10.0.192.0/18"
  map_public_ip_on_launch = false
  availability_zone       = "ap-southeast-1b"
  tags = {
    Name                  = "lab-3-private-subnet-2"
  }
}