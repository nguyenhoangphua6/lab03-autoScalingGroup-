resource "aws_lb_target_group" "lab-3-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             =  5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  name                  = "lab-3-tg"
  port                  = 80
  protocol              = "HTTP"
  target_type           = "instance" 
  vpc_id                = aws_vpc.lab-3-vpc.id
  tags = {
        Name            = "lab-3-tg"
    }
}

resource "aws_lb" "lab-3-alb" {
    name                = "lab-3-alb"
    internal            = false
    ip_address_type     = "ipv4"
    load_balancer_type  = "application"
    security_groups     = [aws_security_group.alb-sg.id]
    subnets             = [aws_subnet.lab-3-public-subnet-1.id,aws_subnet.lab-3-public-subnet-2.id]
    tags = {
        Name            = "lab-3-alb"
    }
}

resource "aws_lb_listener" "lab-3-alb-listener" {
    load_balancer_arn   = aws_lb.lab-3-alb.arn
    port                = 80
    protocol            = "HTTP"
    default_action {
      target_group_arn  = aws_lb_target_group.lab-3-tg.arn
      type              = "forward"
    }
}
# resource "aws_lb_target_group_attachment" "lab-3-ec2_attach" {
#   count                 = 2
#   target_group_arn      = aws_lb_target_group.lab-3-tg.arn
#   target_id             = aws_instance.lab-3-webserver-1.id
# }
