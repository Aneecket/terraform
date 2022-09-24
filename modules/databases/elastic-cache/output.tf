output "aws_elasticache_cluster_id" {
  value = aws_elasticache_cluster.this.*.id
}
output "aws_elasticache_cluster_id_without_replication" {
  value = aws_elasticache_cluster.this_without_replication.*.id
}
output "aws_elasticache_replication_group_id" {
  value = aws_elasticache_replication_group.this.*.id
}
output "aws_elasticache_subnet_group_id" {
  value = aws_elasticache_subnet_group.this.id
}
