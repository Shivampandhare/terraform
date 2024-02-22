variable "target_group_arns" {}
variable "id" {}
variable "version_latest" {}

resource "aws_autoscaling_group" "asg" {
  Name                      = "myasg-"
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 2
  vpc_zone_identifier       =["subnet-0eec4a2c46ae78670","subnet-0aea4844b4f6561ec"]
  target_group_arns         = [var.target_group_arns]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_template {
    id          = var.id
    version     = var.version_latest
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup = 120
      min_healthy_percentage = 50
    }
    triggers = [ "desired_capacity" ]
  }
}

resource "aws_autoscaling_policy" "avg_cpu_policy" {
  name                   = "avg-cpu-policy"
  policy_type = "TargetTrackingScaling"     
  autoscaling_group_name = aws_autoscaling_group.asg.id 
  estimated_instance_warmup = 180
  # CPU Utilization is above 30
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 30.0
  }  

}
