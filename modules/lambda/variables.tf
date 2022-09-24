variable "function_name" {
  description = ""
  type        = string
}
variable "description" {
  description = ""
  type        = string
  default = ""
}
variable "handler" {
  description = ""
  type        = string
}
variable "memory_size" {
  description = ""
  type        = string
}
variable "package_type" {
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
variable "role" {
  description = ""
  type        = string
}
variable "s3_key" {
  description = ""
  type        = string
  default     = ""
}
variable "timeout" {
  description = ""
  type        = string
}
variable "reserved_concurrent_executions" {
  description = ""
  type        = string
}
variable "runtime" {
  description = ""
  type        = string
}
variable "source_code_hash" {
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
variable "variables" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = null
}
variable "kms_key_arn" {
  description = ""
  type        = string
  default     = ""
}
variable "layers" {
  description = ""
  type        = list(string)
  default     = []
}
