output "stage-eks-lb-sg_security_group_id" {
  description = "The SG Id assigned by AWS"
  value       = module.stage-eks-lb-sg.this_security_group_id
}

output "stage-eks-ControlPlaneSecurityGroup_security_group_id" {
  description = "The SG Id assigned by AWS"
  value       = module.stage-eks-ControlPlaneSecurityGroup.this_security_group_id
}

output "stage-eks-worker-nodes-sg_security_group_id" {
  description = "The SG Id assigned by AWS"
  value       = module.stage-eks-worker-nodes-sg.this_security_group_id
}


