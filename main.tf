# setup terraform default :))
terraform {
  required_providers {
    aws = {
      source                  = "hashicorp/aws"
      version                 = "~> 4.16"
    }
  }
  required_version            = ">= 1.2.0"
}
provider "aws" {
  region = var.AWS_REGION
}

# create bastionHost instance
resource "aws_instance" "lab-3-bastionhost_i" {
  ami                         = "ami-0b89f7b3f054b957e"
  instance_type               = "t2.micro"
  key_name                    = "lab-st-phunguyen-ap-southeast-1"
  subnet_id                   = aws_subnet.lab-3-public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.lab-3-bastionhost_i_sg.id]
  associate_public_ip_address = true
  tags = {
    Name                      = "lab-3-bastionhost_i"
  }
}


# #create instance in private subnet 1
# resource "aws_instance" "lab-3-webserver-1" {
#   ami                         = "ami-0b89f7b3f054b957e"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.lab-3-private-subnet-1.id
#   key_name                    = "lab-st-phunguyen-ap-southeast-1"
#   vpc_security_group_ids      = [aws_security_group.lab-3-SG-i.id]
#   tags = {
#    Name                       = "lab-3-webserver-1"
#   }
#   user_data = <<EOF
#         #!/bin/bash
#         sudo amazon-linux-extras install nginx1
#         sudo systemctl enable nginx
#         sudo service nginx start
#         cd /usr/share/nginx/html
#         sudo chmod 777 index.html
#         echo "<html>
#         <body>
#         <p>hostname is: $(hostname)</p>
#         </body>
#         </html>" > index.html
#                 EOF
# }
# #create instance in private subnet 2
# resource "aws_instance" "lab-3-webserver-2" {
#   ami     = "ami-0b89f7b3f054b957e"
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.lab-3-private-subnet-2.id
#   key_name                    = "lab-st-phunguyen-ap-southeast-1"
#   vpc_security_group_ids = [aws_security_group.lab-3-SG-i.id]
#   tags = {
#    Name = "lab-3-webserver-2"
#   }
#   user_data = <<EOF
#         #!/bin/bash
#         sudo amazon-linux-extras install nginx1
#         sudo systemctl enable nginx
#         sudo service nginx start
#         cd /usr/share/nginx/html
#         sudo chmod 777 index.html
#         echo "<html>
#         <body>
#         <p>hostname is: $(hostname)</p>
#         </body>
#         </html>" > index.html
#                 EOF
# }

# resource "aws_instance" "i_temp" {
#   ami     = "ami-0b89f7b3f054b957e"
#   instance_type = "t2.micro"
#   key_name                    = "lab-st-phunguyen-ap-southeast-1"
#   vpc_security_group_ids = [aws_security_group.lab-3-SG-i.id]
#   user_data = <<EOF
#         #!/bin/bash
#         sudo amazon-linux-extras install nginx1
#         sudo systemctl enable nginx
#         sudo service nginx start
#         cd /usr/share/nginx/html
#         sudo chmod 777 index.html
#         echo "<html>
#         <body>
#         <p>hostname is: $(hostname)</p>
#         </body>
#         </html>" > index.html
#                 EOF
# }
