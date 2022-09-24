locals {
  environment_map = var.variables == null ? [] : [var.variables]
}

resource "aws_lambda_function" "this" {

  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }

  function_name                  = var.function_name
  description                    = var.description
  handler                        = var.handler
  memory_size                    = var.memory_size
  package_type                   = var.package_type
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = var.role
  runtime                        = var.runtime
  layers                         = var.layers
  # First Method
  # s3_bucket                      = "noon-lambda-zip-storage-bucket" # Common Bucket to store the lambda functions
  # s3_key                         = var.s3_key
  # Second Method
  # source_code_hash               = filebase64sha256("function.zip")
  source_code_hash               = var.source_code_hash 
  kms_key_arn                    = var.kms_key_arn
  timeout                        = var.timeout

  tracing_config {
    mode = "PassThrough"
  }

  vpc_config {
    security_group_ids           = var.security_group_ids
    subnet_ids                   = var.subnet_ids
  }

  tags                           = var.tags
  tags_all                       = var.tags_all 

}