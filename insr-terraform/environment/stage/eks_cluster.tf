module "stage_eks_cluster" {


  source = "../../../modules/compute/eks/eks_cluster"
  vpc_id = module.stage_vpc.vpc_id
  subnet_ids              = module.stage_eks_subnet.private_subnets
  kubernetes_version      = "1.22"
  oidc_provider_enabled   = false
  endpoint_public_access  = false
  endpoint_private_access = true
  cluster_encryption_config_enabled = false
  enabled_cluster_log_types         = null
  eks_cluster_name                  = "stage-eks-insr"
  eks_cluster_role_arn   = data.terraform_remote_state.iam.outputs.Stage-AWSServiceRoleForAmazonEKS-role_arn
  eks_security_group_ids = [data.terraform_remote_state.sg.outputs.stage-eks-ControlPlaneSecurityGroup_security_group_id[0]]
  eks_cluster_tags = {
    Entity  = "stage-eks"
    Env     = "stage"
    Name    = "stage-eks-insr"
    Subteam = "clusterops"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}


