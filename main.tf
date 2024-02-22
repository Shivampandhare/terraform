provider "aws" {
    region = "ap-south-1"
}

module "launch_template" {
    source                     = "./module/launch_template/"
    image_id                   = "ami-06b72b3b2a773be2b"
    instance_type              = "t2.micro"
    keypair                    = "key"
}

module "lb" {
    source                    = "./module/lb/"
}

module "asg" {
    source                     = "./module/ASG/"
    id                         = module.launch_template.temp_id
    version_latest             = module.launch_template.version_latest
    target_group_arns          = module.lb.target_group_arns
}
