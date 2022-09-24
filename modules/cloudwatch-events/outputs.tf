
output "event_name" {
  description = "The name of the event rule"
  value       = aws_cloudwatch_event_rule.this[*].id
}

output "event_arn" {
  description = "The event arn"
  value       = aws_cloudwatch_event_rule.this[*].arn
}



