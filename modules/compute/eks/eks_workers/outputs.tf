output "launch_configuartion_name" {
  description = "The ID of the launch template"
  value       = module.autoscaling_group.this_launch_configuration_name
}
output "autoscaling_group_id" {
  description = "The AutoScaling Group ID"
  value       = module.autoscaling_group.this_autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "The AutoScaling Group name"
  value       = module.autoscaling_group.this_autoscaling_group_name
}
output "workers_role_arn" {
  description = "ARN of the worker nodes IAM role"
  value       = local.workers_role_arn
}

output "workers_role_name" {
  description = "Name of the worker nodes IAM role"
  value       = local.workers_role_name
}
