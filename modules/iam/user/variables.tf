
variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}


variable "policy_arn" {
  description = "The arn of the policy"
  type        = list(any)
  default     = []
}



variable "enable_access_key" {
  description = "To enable programmetic access"
  type        = bool
  default     = false
}



variable "groups" {
  description = "The groups to be member of "
  type        = list(any)
  default     = []
}



variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
  type        = string
  default     = null
}

