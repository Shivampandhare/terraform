resource "aws_lb" "alb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application" 
  ip_address_type    = "ipv4"
  security_groups    = ["sg-0d816d31c26401c48"] 
  subnets            = ["subnet-0eec4a2c46ae78670","subnet-0aea4844b4f6561ec"]
}

resource "aws_lb_target_group" "tg" {
  name     = "target-group-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0cbebf387297e9740"

  health_check {
    path = "/"
  }

}

output "target_group_arns" {
    value   = aws_lb_target_group.tg.arn
}