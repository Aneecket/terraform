output "fqdn" {
  description = "The fqdn of the record"
  value       = aws_route53_record.default.*.fqdn
}
