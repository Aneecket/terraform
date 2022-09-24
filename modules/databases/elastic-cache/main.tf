# Elastic Cache Replication Cluster Config:
resource "aws_elasticache_cluster" "this" {
  
  count = var.redis_with_replication_enabled == true ? 1 : 0
  availability_zone    = var.availability_zone 
  cluster_id           = var.cluster_id
  replication_group_id = aws_elasticache_replication_group.this[count.index].replication_group_id
  tags                 = var.tags
  tags_all             = var.tags_all
}

# Elastic Cache Without Replication Cluster Config:
resource "aws_elasticache_cluster" "this_without_replication" {
  
  count = var.redis_with_replication_enabled == false ? 1 : 0
  availability_zone        = var.availability_zone 
  cluster_id               = var.cluster_id
  tags                     = var.tags
  tags_all                 = var.tags_all
  az_mode                  = var.az_mode
  engine                   = var.engine
  engine_version           = var.engine_version
  maintenance_window       = var.maintenance_window
  node_type                = var.node_type
  num_cache_nodes          = var.num_cache_nodes
  parameter_group_name     = var.parameter_group_name
  port                     = var.port
  security_group_ids       = var.security_group_ids
  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window
  subnet_group_name        = aws_elasticache_subnet_group.this.name
}

# Elastic Cache Replication Group Config:
resource "aws_elasticache_replication_group" "this" {

  count = var.redis_with_replication_enabled == true ? 1 : 0
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = var.automatic_failover_enabled

  # Either 'cluster_mode' or 'number_cache_clusters' is needed
  # cluster_mode {
  #   num_node_groups         = var.num_node_groups
  #   replicas_per_node_group = var.replicas_per_node_group
  # }

  engine                        = var.engine
  engine_version                = var.engine_version
  maintenance_window            = var.maintenance_window
  multi_az_enabled              = var.multi_az_enabled
  node_type                     = var.node_type
  number_cache_clusters         = var.number_cache_clusters
  parameter_group_name          = var.parameter_group_name
  port                          = var.port
  replication_group_description = var.replication_group_description
  replication_group_id          = var.replication_group_id
  security_group_ids            = var.security_group_ids
  snapshot_retention_limit      = var.snapshot_retention_limit
  snapshot_window               = var.snapshot_window
  transit_encryption_enabled    = var.transit_encryption_enabled
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  tags                          = var.tags
  tags_all                      = var.tags_all

}
# Elastic Cache Subnet Group: Only 2 subnet groups found across 3 Elastic Cache clusters
resource "aws_elasticache_subnet_group" "this" {

  description = var.description
  name        = var.name
  subnet_ids  = var.subnet_ids
  
}