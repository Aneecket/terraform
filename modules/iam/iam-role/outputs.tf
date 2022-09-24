output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = element(concat(aws_iam_role.this.*.arn, [""]), 0)
}


output "iam_role_id" {
  description = " ID of IAM role"
  value       = element(concat(aws_iam_role.this.*.id, [""]), 0)
}

output "iam_role_name" {
  description = " ID of IAM role"
  value       = element(concat(aws_iam_role.this.*.name, [""]), 0)
}

