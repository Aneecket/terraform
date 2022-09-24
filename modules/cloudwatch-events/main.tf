resource "aws_cloudwatch_event_rule" "this" {
  name                = var.event_name
  description         = var.event_description
  event_pattern       = var.event_pattern
  event_bus_name      = var.event_bus_name
  schedule_expression = var.schedule_expression
  is_enabled          = var.is_enabled
}