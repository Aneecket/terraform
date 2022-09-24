
output "Stage-AWSServiceRoleForAmazonEKS-role_arn" {
  description = "The ARN assigned by AWS for this role"
  value       = module.Stage-AWSServiceRoleForAmazonEKS.iam_role_arn
}

output "Stage-AWSServiceRoleForAmazonEKS-role_id" {
  description = "The  ID assigned by AWS"
  value       = module.Stage-AWSServiceRoleForAmazonEKS.iam_role_id
}


