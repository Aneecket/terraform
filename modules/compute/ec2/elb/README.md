# Description
This module is used to create a standalone EC2 instance in AWS

## Usage

```terraform
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

data "aws_vpc" "selected" {
  id = "vpc-0f1ccde6423193c8c"
}
data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.selected.id
  id = "sg-06348a809b4d71ce8"
}

module "elb" {
  source = "../modules/elb/"

  name = "elb-example"

  subnets         = "subnet-039737e5b61f8311a"
  security_groups = [data.aws_security_group.selected.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
    {
      instance_port     = "8080"
      instance_protocol = "http"
      lb_port           = "8080"
      lb_protocol       = "http"

    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # ELB attachments
  number_of_instances = 1
  instances           = ["i-0f9ee4afc696c1d12"]
}

```
