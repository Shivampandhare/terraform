variable "image_id" {}
variable "instance_type" {}
variable "keypair" {}


resource "launch_template" "temp"{
    name = "my-launch-template"
    description = "My Launch Template"
    image_id = var.image_id
    instance_type = var.instance_type    
    vpc_security_group_ids     = "sg-0d816d31c26401c48"
    key_name = var.keypair
    version = "$Latest"
    user_data = filebase64("${path.module}/app.sh")
    ebs_optimized              = true
    update_default_version     = true
    network_interfaces {
            associate_public_ip_address = true
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
    value  = launch_template.temp.id
}

output "version" {
    value = launch_template.temp.latest_version
}