
output "group_name" {
  description = "IAM group name"
  value       = element(concat(aws_iam_group.this.*.name, [var.name]), 0)
}

output "group_arn" {
  description = "IAM group arn"
  value       = element(concat(aws_iam_group.this.*.arn, [""]), 0)
}

output "group_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = element(concat(aws_iam_group.this.*.unique_id, [""]), 0)
}


