

output "lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.eks-nlb.arn
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.eks-nlb.dns_name
}



output "http_tcp_listener_arns" {
  description = "The ARN of the TCP and HTTP load balancer listeners created."
  value       = module.eks-nlb.http_listener_arn
}




output "target_group_arns" {
  description = "ARNs of the target groups. Useful for passing to your Auto Scaling group."
  value       = module.eks-nlb.target_group_arns
}

output "target_group_arn_suffixes" {
  description = "ARN suffixes of our target groups - can be used with CloudWatch."
  value       = module.eks-nlb.target_group_arn_suffixes
}

output "target_group_names" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = module.eks-nlb.target_group_names
}

