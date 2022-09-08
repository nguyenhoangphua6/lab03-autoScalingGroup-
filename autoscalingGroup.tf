
resource "aws_launch_template" "lab-3-i-temp" {
  name_prefix                   = "lab-3-i-temp"
  image_id                      =  "ami-0b89f7b3f054b957e"
  instance_type                 = "t2.micro"
  user_data                     = "${filebase64("user_data.sh")}" 
  key_name                      = "lab-st-phunguyen-ap-southeast-1"
  vpc_security_group_ids        = [aws_security_group.lab-3-SG-i.id]
}

resource "aws_autoscaling_group" "lab-3-asg" {
    name                        = "lab-3-asg"
    min_size                    = 1
    max_size                    = 3
    desired_capacity            = 2
    health_check_grace_period   = 300
    health_check_type           = "ELB"
    force_delete                = true
    target_group_arns           = [ aws_lb_target_group.lab-3-tg.arn ]
    launch_template {
      id                        = aws_launch_template.lab-3-i-temp.id
      version                   = "$Latest"
    }
    vpc_zone_identifier         = [aws_subnet.lab-3-private-subnet-1.id,aws_subnet.lab-3-private-subnet-2.id ]
    timeouts {
        delete                  = "5m"
  }
}