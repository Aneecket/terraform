

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    encrypt        = false
    bucket         = "insr-terraform-statestore"
    dynamodb_table = "terraform-state-lock-prod"
    region         = "ap-south-1"
    key            = "stage/iam-resources.state"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "insr"
}
}

data "terraform_remote_state" "stage" {
  backend = "s3"

  config = {
    encrypt        = false
    bucket         = "insr-terraform-statestore"
    dynamodb_table = "terraform-state-lock-prod"
    region         = "ap-south-1"
    key            = "stage/staging.state"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "insr"

}
}

