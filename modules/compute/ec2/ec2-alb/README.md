# Description
This module is used to create an Application/Network load balancer in AWS

## Usage

```terraform
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

##################################################################
# Data sources to get VPC and subnets
##################################################################
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

##################################################################
# Application Load Balancer
##################################################################
module "alb" {
  source = "../modules/ec2/alb/"

  name = "simple-alb"

  load_balancer_type = "application"

  vpc_id          = data.aws_vpc.selected.id
  security_groups = [data.aws_security_group.selected.id]
  subnets         = data.aws_subnet_ids.all.ids


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
      name = "sample-tg"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = {
        InstanceTargetGroupTag = "SampleITG"
      }
    },
  ]

  tags = {
    Project = "Terraform"
  }

  lb_tags = {
    MyLoadBalancer = "SampleLB"
  }

  target_group_tags = {
    MyGlobalTargetGroupTag = "SampleTG"
  }
}



```