# Description
This module is used to create a standalone EC2 instance in AWS

## Usage

```terraform
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

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

module "ec2" {
  source = "../modules/ec2-stdlone/"

  instance_count = 1

  name          = "example-normal"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = "subnet-039737e5b61f8311a"
  vpc_security_group_ids      = ["sg-06348a809b4d71ce8"]
  associate_public_ip_address = true


  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 5
      encrypted   = true
    }
  ]

  tags = {
    "Env"      = "Private"
    "Location" = "Secret"
  }
}


```
