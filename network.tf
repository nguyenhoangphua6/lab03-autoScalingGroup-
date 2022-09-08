#step 5 create internet gateway
resource "aws_internet_gateway" "lab-3-ig" {
  vpc_id                    = aws_vpc.lab-3-vpc.id
  tags = {
    Name                    = "lab-3-ig"
  }
}
#step 4: Create route table and connect to subnet
# note: All public subnet connect to 1 route table
# note : 1 private subnet connect to 1 route table
resource "aws_route_table" "lab-3-rt-public" {
  vpc_id                    = aws_vpc.lab-3-vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_internet_gateway.lab-3-ig.id
  }
  tags = {
        Name                = "lab-3-rt-public"
    }
}
resource "aws_route_table" "lab-3-rt-private-1" {
  vpc_id                    = aws_vpc.lab-3-vpc.id
  route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_nat_gateway.ngw.id
  }
  tags = {
        Name                = "lab-3-rt-private-1"
    }
}

resource "aws_route_table" "lab-3-rt-private-2" {
  vpc_id                    = aws_vpc.lab-3-vpc.id
    route {
    cidr_block              = "0.0.0.0/0"
    gateway_id              = aws_nat_gateway.ngw.id
  }
  tags = {
        Name                = "lab-3-rt-private-2"
    }
}

# connection write here 
resource "aws_route_table_association" "lab-3-rt-public-connection-1" {
  subnet_id                 = aws_subnet.lab-3-public-subnet-1.id
  route_table_id            = aws_route_table.lab-3-rt-public.id
}

resource "aws_route_table_association" "lab-3-rt-public-connection-2" {
  subnet_id                 = aws_subnet.lab-3-public-subnet-2.id
  route_table_id            = aws_route_table.lab-3-rt-public.id
}
resource "aws_route_table_association" "lab-3-route-table-private-connection-1" {
  subnet_id                 = aws_subnet.lab-3-private-subnet-1.id
  route_table_id            = aws_route_table.lab-3-rt-private-1.id
}
resource "aws_route_table_association" "lab-3-route-table-private-connection-2" {
  subnet_id                 = aws_subnet.lab-3-private-subnet-2.id
  route_table_id            = aws_route_table.lab-3-rt-private-2.id
}