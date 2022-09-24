

output "instance_profile_arn" {
  description = "IAM instance profile arn"
  value       = element(concat(aws_iam_instance_profile.this.*.arn, [""]), 0)
}

output "instance_profile_id" {
  description = "The  ID assigned by AWS"
  value       = element(concat(aws_iam_instance_profile.this.*.id, [""]), 0)
}


