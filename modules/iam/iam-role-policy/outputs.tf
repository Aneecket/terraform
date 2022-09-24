output "id" {
  description = "The role policy's ID"
  value       = aws_iam_role_policy.this.id
}

output "name" {
  description = "The name of the role policy"
  value       = aws_iam_role_policy.this.name
}

