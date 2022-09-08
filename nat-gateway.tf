resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.nat.id
  subnet_id         = aws_subnet.lab-3-public-subnet-1.id

  tags = {
    Name            = "ngw"
  }

  depends_on        = [aws_internet_gateway.lab-3-ig]
}