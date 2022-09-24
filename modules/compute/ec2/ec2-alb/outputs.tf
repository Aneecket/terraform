output "name" {
  value       = aws_lb.main.*.name
  description = "The ARN suffix of the ALB."
}

output "arn" {
  value       = concat(aws_lb.main.*.arn)
  description = "The ARN of the ALB."
}

output "dns_name" {
  value       = aws_lb.main.*.dns_name
  description = "DNS name of ALB."
}
output "main_target_group_arn" {
  value       = aws_lb_target_group.main.*.arn
  description = "The main target group ARN."
}

output "http_listener_arn" {
  value       = aws_lb_listener.http.*.arn
  description = "The ARN of the HTTP listener."
}

output "https_listener_arn" {
  value       = aws_lb_listener.https.*.arn
  description = "The ARN of the HTTPS listener."
}

output "nhttp_listener_arn" {
  value       = aws_lb_listener.nhttp.*.arn
  description = "The ARN of the HTTP listener."
}

output "nhttps_listener_arn" {
  value       = aws_lb_listener.nhttps.*.arn
  description = "The ARN of the HTTPS listener."
}
output "lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records."
  value       = aws_lb.main.*.zone_id
}





output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = aws_lb_target_group.main.*.arn
}

output "target_group_arn_suffixes" {
  description = "ARN suffixes of our target groups - can be used with CloudWatch."
  value       = aws_lb_target_group.main.*.arn_suffix
}

output "target_group_names" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = aws_lb_target_group.main.*.name
}
