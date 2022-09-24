output "id" {
  description = "The user policy's ID"
  value       = aws_iam_user_policy.this.id
}

output "name" {
  description = "The name of the user policy"
  value       = aws_iam_user_policy.this.name
}

