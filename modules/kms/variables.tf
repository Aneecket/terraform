variable "description" {
  description = "Key Description"
  type        = string
  default = ""
}
variable "enable_key_rotation" {
  description = "Specify true/false"
  type        = bool
}
variable "is_enabled" {
  description = "Specify true/false"
  type        = bool
}
variable "policy" {
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
variable "alias_name" {
  description = ""
  type        = string
}
