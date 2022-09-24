resource "aws_elasticsearch_domain" "this" {

  domain_name = var.domain_name
  elasticsearch_version = var.elasticsearch_version
  tags = var.tags
  tags_all =var.tags_all 

  access_policies = var.access_policies


  cluster_config {
    dedicated_master_count   = "0"
    dedicated_master_enabled = "false"
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    warm_enabled             = "false"
    zone_awareness_enabled   = "false"
  }

  snapshot_options {
    automated_snapshot_start_hour = "23"
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  advanced_security_options {
    enabled                        = "false"
    internal_user_database_enabled = "false"
  }

  domain_endpoint_options {
    custom_endpoint_enabled = "false"
    enforce_https           = "false"
    tls_security_policy     = var.tls_security_policy
  }

  ebs_options {
    ebs_enabled = "true"
    iops        = "0"
    volume_size = var.ebs_options_volume_size
    volume_type = "gp2"
  }

  encrypt_at_rest {
    enabled = "false"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
    enabled                  = "true"
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  node_to_node_encryption {
    enabled = "false"
  }

  vpc_options {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
}
