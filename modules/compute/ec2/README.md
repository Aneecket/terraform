# Description
The modules in this directory can be used to create ec2 and its associated resources

## Usage

``` terraform
provider "aws" {
region = "ap-south-1"
shared_credentials_file = "~/.aws/credentials"
profile = "devops"
}

data "aws_vpc" "selected" {
id = "vpc-0c049085dcbc54c6e"
}

data "aws_subnet_ids" "public" {
vpc_id = data.aws_vpc.selected.id

tags = {
"Tier" = "Public"
}
}

data "aws_ami" "amazon_linux" {
most_recent = true
owners      = ["amazon"]

filter {
name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
}

filter {
name = "owner-alias"

    values = [
      "amazon",
    ]
}
}


locals {
user_data = <<EOF
#!/bin/bash
echo "Test Terraform!"
EOF
}



module "key" {
source = "../modules/ec2-full/key-pair"

key_name   = "terra"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"

tags = {
External = "yes"
}
}

module "sg"{
source = "../modules/ec2-full/sg/"
vpc_id = data.aws_vpc.selected.id
name          = "security-group-terra"
ingress_with_cidr_blocks = [
{
rule        = "https-443-tcp"
cidr_blocks = "2.2.2.2/32,30.30.30.30/32"
},
]
tags = {
Environment = "Dev"
Department = "SRE"
}
egress_with_cidr_blocks = [
{
rule        = "all-all"
cidr_blocks = "0.0.0.0/0"
},
]
}


module "alb" {
source = "../modules/ec2-full/ec2-alb/"
name = "terra-alb"
load_balancer_type = "application"
vpc_id          = data.aws_vpc.selected.id
security_groups = module.sg.this_security_group_id
subnets         = data.aws_subnet_ids.public.ids
http_tcp_listeners = [

      {
        port               = 80
        protocol           = "HTTP"
        target_group_index = 0
        action_type        = "forward"
      },
    ]

    target_groups = [
      {
        name = "terra-tg"
        backend_protocol     = "HTTP"
        backend_port         = 80
        target_type          = "instance"
        health_check = {
          enabled             = true
          interval            = 30
          path                = "/health"
          port                = "80"
          protocol            = "HTTP"
        }
        tags = {
          InstanceTargetGroupTag = "SampleITG"
        }
      },
    ]

}



module "asg" {
source = "../modules/ec2-full/ec2-asg/"

name = "terra-asg"


lc_name = "terra-lc"
image_id = data.aws_ami.amazon_linux.id
instance_type = "t2.micro"
security_groups = module.sg.this_security_group_id
associate_public_ip_address = true
recreate_asg_when_lc_changes = true
target_group_arns = module.alb.target_group_arns
key_name = module.key.this_key_pair_key_name
user_data = base64encode(local.user_data)
root_block_device = [
{
volume_size = "50"
volume_type = "gp2"
delete_on_termination = true
},
]



# Auto scaling group
name_prefix = "asg"
vpc_zone_identifier = data.aws_subnet_ids.public.ids
health_check_type = "EC2"
min_size = 0
max_size = 1
desired_capacity = 1

tags = [
{
key = "Environment"
value = "dev"
propagate_at_launch = true
},
]
}
```
