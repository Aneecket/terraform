variable "name" {
  description = "The name of the policy"
  type        = string
  default     = ""
}

variable "user" {
  description = "User for which the policy belongs to."
  type        = string
  default     = ""
}


variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}

