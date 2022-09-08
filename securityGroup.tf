# create bastion host (chay duoc)
resource "aws_security_group" "lab-3-bastionhost_i_sg" {
  name                      = "bastionhost_instance_security_group"
  description               = "Security group for setup a bastionhost instance"
  vpc_id                    = aws_vpc.lab-3-vpc.id

  ingress {
    description             = "Bastion Host SG"
    from_port               = 22
    to_port                 = 22
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  ingress {
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
   egress {
    description             = "output from Bastion Host"
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  tags = {
    Name                    = "lab-3-bastionhost_i_sg"
  }
}

# create SG for instance in private subnet (2 instance in 2 AZ same SG) (chay ngon)
resource "aws_security_group" "lab-3-SG-i" {
  name                      = "lab-3-sg-i"
  description               = "Security group for 2 instance in private subnet"
  vpc_id                    = aws_vpc.lab-3-vpc.id

  ingress {
    description             = "connect with bastion host"
    from_port               = 22
    to_port                 = 22
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  ingress {
    description             = "Open port 80"
    from_port               = 80
    to_port                 = 80
    protocol                = "tcp"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  egress {
    description             = "output for instance"
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }
  tags = {
    Name                    = "lab-3-sg-i"
  }
}
resource "aws_security_group" "alb-sg" {
    name                    = "alb-sg"
    description             = "Allow incomming HTTP Connection"
    vpc_id                  = aws_vpc.lab-3-vpc.id
    ingress {
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
}