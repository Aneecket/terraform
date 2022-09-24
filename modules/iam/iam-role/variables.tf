variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}


variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}


variable "role_name" {
  description = "IAM role name"
  type        = string

}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}


variable "assume_role_policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}


variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}


variable "managed_policy_arns" {
  description = "List of managed policy arns"
  type        = list(any)
  default     = []
}

variable "inline_policy" {
  description = "List of inline policy"
  type        = list(any)
  default     = []
}


