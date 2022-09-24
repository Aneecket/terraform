resource "aws_cloudwatch_event_target" "this" {
  #count = var.create_event_target ? 1 : 0
  #rule      = aws_cloudwatch_event_rule.this.name
  rule      = var.target_rule
  target_id = var.target_id
  arn       = var.event_target_arn
  role_arn  = var.event_target_role_arn
  dynamic "input_transformer" {
    #for_each = var.input_template
    for_each = var.input_template != "" ? [1] : []
    content {
      input_paths    = var.input_paths
      input_template = var.input_template
    }

  }
}

