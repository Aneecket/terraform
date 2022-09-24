module "eks_managed_node_group" {
  source = "../../../modules/eks-managed-node-group"

  name            = "stage-eks"
  cluster_version = "1.22"

  vpc_id     = module.stage_vpc.vpc_id
  subnet_ids = module.stage_eks_subnet.private_subnets
 vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.stage-eks-worker-nodes-sg_security_group_id[0]] 
  // The following variables are necessary if you decide to use the module outside of the parent EKS module context.
  // Without it, the security groups of the nodes are empty and thus won't join the cluster.
  #cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id

  min_size     = 1
  max_size     = 3
  desired_size = 2
  #ami_type = "AL2_ARM_64"
  ami_type = "AL2_x86_64"
  instance_types = ["m6a.large"]
  capacity_type  = "SPOT"
  key_name = "gibpl"
  create_security_group = false

  cluster_endpoint = module.stage_eks_cluster.eks_cluster_endpoint 
  cluster_name = module.stage_eks_cluster.eks_cluster_id
  cluster_security_group_id = data.terraform_remote_state.sg.outputs.stage-eks-ControlPlaneSecurityGroup_security_group_id[0]
  create = true
  

  disk_size = 20
  ebs_optimized = true

  iam_role_additional_policies = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"]
  #create_iam_role = false
  #iam_role_arn = data.terraform_remote_state.iam.outputs.stage-AWSServiceRoleForAmazonEKSNodegroup-role_arn
  labels = {
    Environment = "stage"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

    #  update_config = {
    #       max_unavailable            = 1 
    #    }


#  taints = {
#    dedicated = {
#      key    = "dedicated"
#      value  = "gpuGroup"
#      effect = "NO_SCHEDULE"
#    }
#  }

  tags = {
    Environment = "stage"
    Terraform   = "true"
    billing	= "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}


