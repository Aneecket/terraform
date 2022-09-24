locals {
  enabled = var.enabled

  cluster_encryption_config = {
    resources        = var.cluster_encryption_config_resources
    provider_key_arn = local.enabled && var.cluster_encryption_config_enabled && var.cluster_encryption_config_kms_key_id == "" ? join("", aws_kms_key.cluster.*.arn) : var.cluster_encryption_config_kms_key_id
  }
}

data "aws_ami_ids" "eks_ami_v20" {
  owners = ["602401143452"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.20-v20211206"]
  }
}

data "aws_partition" "current" {
  count = local.enabled ? 1 : 0
}

//resource "aws_cloudwatch_log_group" "default" {
//  count             = local.enabled && length(var.enabled_cluster_log_types) > 0 ? 1 : 0
//  name              = var.log_group_name
//  retention_in_days = var.cluster_log_retention_period
//  tags              = var.log_group_tags
//}

resource "aws_kms_key" "cluster" {
  count                   = local.enabled && var.cluster_encryption_config_enabled && var.cluster_encryption_config_kms_key_id == "" ? 1 : 0
  description             = "EKS Cluster Encryption Config KMS Key"
  enable_key_rotation     = var.cluster_encryption_config_kms_key_enable_key_rotation
  deletion_window_in_days = var.cluster_encryption_config_kms_key_deletion_window_in_days
  policy                  = var.cluster_encryption_config_kms_key_policy
  tags                    = var.kms_tags
}

resource "aws_kms_alias" "cluster" {
  count         = local.enabled && var.cluster_encryption_config_enabled && var.cluster_encryption_config_kms_key_id == "" ? 1 : 0
  name          = var.kms_name
  target_key_id = join("", aws_kms_key.cluster.*.key_id)
}

resource "aws_eks_cluster" "default" {
  count                     = local.enabled ? 1 : 0
  name                      = var.eks_cluster_name
  tags                      = var.eks_cluster_tags
  role_arn                  = var.eks_cluster_role_arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  dynamic "encryption_config" {
    for_each = var.cluster_encryption_config_enabled ? [local.cluster_encryption_config] : []
    content {
      resources = lookup(encryption_config.value, "resources")
      provider {
        key_arn = lookup(encryption_config.value, "provider_key_arn")
      }
    }
  }

  vpc_config {
    security_group_ids      = var.eks_security_group_ids
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
  }


//  depends_on = [
//    aws_cloudwatch_log_group.default
//  ]
}

resource "aws_iam_openid_connect_provider" "default" {
  count = (local.enabled && var.oidc_provider_enabled) ? 1 : 0
  url   = join("", aws_eks_cluster.default.*.identity.0.oidc.0.issuer)

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}
