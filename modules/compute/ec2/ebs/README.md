# Description
This module is used to create an EBS volume in AWS

## Usage

```terraform
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "~/.aws/credentials"
}
module "ebs"{
  source = "../modules/ec2-full/ebs/"
  device_name = "/dev/xvdz"
  type = "gp2"
  size = 10
  az = "ap-south-1a"
  instance_id = "i-08e53aeb6f85417ae"
}

```