output "registry_id" {
  value       = aws_ecr_repository.this.registry_id
  description = "Registry ID"
}

output "repository_name" {
  value       = aws_ecr_repository.this.name
  description = "Name of first repository created"
}

output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "URL of first repository created"
}
