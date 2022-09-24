

output "stage-eks-cluster-id" {
description = "EKS cluster id"
value = module.stage_eks_cluster.*.eks_cluster_id
}


output "stage-eks-cluster-endpoint" {
description = "EKS endpoint"
value = module.stage_eks_cluster.*.eks_cluster_endpoint
}

