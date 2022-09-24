provider "aws" {
  region = "ap-south-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "insr"

}

terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 3.0"
   }
 }
  backend "s3" {
    encrypt        = false
    bucket         = "insr-terraform-statestore"
    dynamodb_table = "terraform-state-lock-prod"
    region         = "ap-south-1"
    key            = "stage/dynamo.state"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "insr"

  }
}


