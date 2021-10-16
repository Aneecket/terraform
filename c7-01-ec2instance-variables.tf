# AWS EC2 Instance Terraform Variables
# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "parradox"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "AWS EC2 Private Instances Count"
  type = number
  default = 1  
}


# AWS EC2 Private Instance Count
variable "name" {
  description = "AWS EC2 Name"
  type = string
  default = "Test-terra"
}


variable "vpc_block" {
  description = "AWS vpc cidr"
  type = string
  default = "172.31.0.0/16"
}

variable "vpc_id" {
  description = "AWS vpc "
  type = string
  default = "vpc-42b54729"
}

