variable "name" {
  description = "Name of IAM group"
  type        = string
}




variable "path" {
  description = "Desired path for the IAM user"
  type        = string
  default     = "/"
}



variable "policy_arn" {
  description = "The arn of the policy"
  type        = list(any)
  default     = []
}





