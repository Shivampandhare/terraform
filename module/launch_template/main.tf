variable "image_id" {}
variable "instance_type" {}
variable "keypair" {}

resource "aws_launch_template" "temp"{
    name = "my-launch-template"
    description = "My Launch Template"
    image_id = var.image_id
    instance_type = var.instance_type  
    key_name = var.keypair
    user_data = filebase64("./app.sh")
    ebs_optimized              = true
    update_default_version     = true
    network_interfaces {
            associate_public_ip_address = true
            security_groups      = ["sg-0d816d31c26401c48"]
        }
    block_device_mappings {
    device_name = "/dev/sda1"
     ebs {
         volume_size = 10   
         delete_on_termination = true
         volume_type = "gp2"
      }
    }
    monitoring {
      enabled = true
    }

    tag_specifications {
     resource_type = "instance"
     tags = {
        Name = "myasg"
      }
    }
}

output "temp_id" {
    value  = aws_launch_template.temp.id
}

output "version_latest" {
    value = aws_launch_template.temp.latest_version
}
