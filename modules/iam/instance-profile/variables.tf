variable "name" {
  description = "Name of IAM instance profile"
  type        = string
}



variable "path" {
  description = "Desired path for the IAM instance profile"
  type        = string
  default     = "/"
}

variable "role_name" {
  description = "The role name to be attached"
  type        = string
  default     = ""
}





