variable "domain_name" {
  description = ""
  type        = string
}
variable "elasticsearch_version" {
  description = ""
  type        = string
}
variable "instance_count" {
  description = ""
  type        = string
}
variable "instance_type" {
  description = ""
  type        = string
}
variable "tags_all" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}
variable "access_policies" {
  description = ""
  type        = string
}
variable "tls_security_policy" {
  description = ""
  type        = string
}
variable "ebs_options_volume_size" {
  description = ""
  type        = string
}
variable "cloudwatch_log_group_arn" {
  description = ""
  type        = string
}
variable "security_group_ids" {
  description = ""
  type        = list(string)
  default     = []
}
variable "subnet_ids" {
  description = ""
  type        = list(string)
  default     = []
}