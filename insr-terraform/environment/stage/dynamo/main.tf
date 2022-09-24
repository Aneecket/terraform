resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "stage-vault"
  read_capacity  = 2
  write_capacity = 1
    hash_key       = "Path"
    range_key      = "Key"
    attribute  {
      name = "Path"
      type = "S"
    }
    attribute  {
      name = "Key"
      type = "S"
    }

  tags = {
    Name        = "stage-vault"
    Environment = "stage"
    billing     = "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}


