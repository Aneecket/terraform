//locals {
//  this_launch_configuration_name = var.launch_configuration == "" && var.create_lc ? concat(aws_launch_configuration.this.*.name, [""])[0] : ""
//  this_autoscaling_group_id                        = concat(aws_autoscaling_group.this.*.id, [""])[0]
//  this_autoscaling_group_name                      = concat(aws_autoscaling_group.this.*.name, [""])[0]
//  this_launch_template_name = var.launch_template== "" && var.create_lt ? concat(aws_launch_template.this.*.name, [""])[0] : ""
//}

output "this_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = aws_launch_configuration.this.*.id
}
output "this_launch_template_name" {
  description = "The name of the launch configuration"
  value       = aws_launch_template.this.*.id
}

output "this_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = aws_autoscaling_group.this.*.id
}

output "this_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = aws_autoscaling_group.this.*.name
}


