variable "redis_with_replication_enabled" {
  description = ""
  default = true
  type        = bool
}
variable "availability_zone" {
  description = ""
  type        = string
}
variable "cluster_id" {
  description = ""
  type        = string
}
variable "tags_all" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}
variable "az_mode" {
  default = ""
  description = "null"
  type        = string
}
variable "at_rest_encryption_enabled" {
  description = ""
  default = null
  type        = string
}
variable "auto_minor_version_upgrade" {
  description = ""
  default = null
  type        = string
}
variable "automatic_failover_enabled" {
  description = ""
  default = null
  type        = string
}
variable "num_node_groups" {
  description = ""
  default = null
  type        = string
}
variable "replicas_per_node_group" {
  description = ""
  default = null
  type        = string
}
variable "engine" {
  description = ""
  type        = string
}
variable "engine_version" {
  description = ""
  type        = string
}
variable "maintenance_window" {
  description = ""
  type        = string
}
variable "multi_az_enabled" {
  description = ""
  default = null
  type        = string
}
variable "node_type" {
  description = ""
  type        = string
}
variable "number_cache_clusters" {
  description = ""
  default = null
  type        = string
}
variable "num_cache_nodes" {
  description = ""
  default = null
  type        = string
}
variable "parameter_group_name" {
  description = ""
  type        = string
}
variable "port" {
  description = ""
  type        = string
}
variable "replication_group_description" {
  description = ""
  default = null
  type        = string
}
variable "replication_group_id" {
  description = ""
  default = null
  type        = string
}
variable "security_group_ids" {
  description = ""
  type        = list(string)
  default     = []
}
variable "snapshot_retention_limit" {
  description = ""
  type        = string
}
variable "snapshot_window"{
  description = ""
  type        = string
}
variable "transit_encryption_enabled" {
  description = ""
  default = null
  type        = string
}
variable "description" {
  description = ""
  type        = string
}
variable "name" {
  description = ""
  type        = string
}
variable "subnet_ids" {
  description = ""
  type        = list(string)
  default     = []
}