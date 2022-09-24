


resource "aws_msk_cluster" "this" {
  broker_node_group_info {
    az_distribution = var.az_distribution
    client_subnets  = var.client_subnets
    ebs_volume_size = var.ebs_volume_size
    instance_type   = var.instance_type
    security_groups = var.security_groups
  }

  cluster_name = var.cluster_name

  configuration_info {
    arn      = var.config_info_arn
    revision = var.config_info_revision
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn

    encryption_in_transit {
      client_broker = var.encryption_tranist_client_broker
      in_cluster    = var.encryption_tranist_cluster
    }
  }

  enhanced_monitoring = var.enhanced_monitoring
  kafka_version       = var.kafka_version

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled = var.enable_cloudwatch_logs
        log_group = var.enable_cloudwatch_logs ? var.cloudwatch_log_group : null
      }

      firehose {
        enabled = var.enable_firehose
      }

      s3 {
        bucket  = var.bucket_name
        enabled = var.enable_bucket
        prefix  = var.bucket_prefix
      }
    }
  }

  number_of_broker_nodes = var.number_of_broker_nodes

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.enable_jmx_exporter_broker
      }

      node_exporter {
        enabled_in_broker = var.enable_node_exporter_broker
      }
    }
  }

  tags = var.tags
}
