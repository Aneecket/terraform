output "this_ebs_arn" {
  description = "The ARN of the ebs volume"
  value       = concat(aws_ebs_volume.this.*.arn, [""])[0]
}

output "this_ebs_id" {
  description = "The volume ID."
  value       = concat(aws_ebs_volume.this.*.id, [""])[0]
}