# Description
This module is used to create an Auto scaling group in AWS

## Usage

```terraform
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

data "aws_vpc" "selected" {
  id = "vpc-0f1ccde6423193c8c"
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.selected.id
  id = "sg-06348a809b4d71ce8"
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

######
# Launch configuration and autoscaling group
######
module "ec2" {
  source = "path to modules"

  name = "example-with-ec2"

  lc_name = "example-lc"

  image_id                     = data.aws_ami.amazon_linux.id
  instance_type                = "t2.micro"
  security_groups              = [data.aws_security_group.selected.id]
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  user_data = base64encode(local.user_data)

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = "50"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  name_prefix                  = "example-asg"
  vpc_zone_identifier       = data.aws_subnet_ids.all.ids
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "terraform"
      propagate_at_launch = true
    }
  ]

  tags_as_map = {
    extra_tag1 = "extra_value1"
    extra_tag2 = "extra_value2"
  }
}

```
