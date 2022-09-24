variable "name" {
  description = "The name of the policy"
  type        = string

}

variable "role" {
  description = "Role for which the policy belongs to."
  type        = string

}


variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string

}

