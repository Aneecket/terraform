
output "msk_config_arn" {
  description = "MSK configuration arn to be used with MSK"
  value       = aws_msk_configuration.this.arn
}


output "msk_config_revision" {
  description = "MSK configuration revision"
  value       = aws_msk_configuration.this.latest_revision
}

