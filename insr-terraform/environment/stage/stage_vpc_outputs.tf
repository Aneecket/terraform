

output "stage_vpc_id" {
  description = "The ID of the VPC"
  value       = module.stage_vpc.vpc_id
}

output "stage_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.stage_subnet.private_subnets
}

output "stage_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.stage_subnet.public_subnets
}

output "stage_intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = module.stage_subnet.intra_subnets
}

output "stage_eks_private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.stage_eks_subnet.private_subnets
}

output "stage_eks_public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.stage_eks_subnet.public_subnets
}

output "stage_eks_intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = module.stage_eks_subnet.intra_subnets
}



