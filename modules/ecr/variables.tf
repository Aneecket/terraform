variable "repository_name" {
  description = "Repo Name of ECR"
  type        = string
}


variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`"
}

variable "enable_lifecycle_policy" {
  type        = bool
  description = "Set to false to prevent the module from adding any lifecycle policies to any repositories"
  default     = true
}

variable "scan_images_on_push" {
  type        = bool
  description = "Scan images on push"
  default     = true
}

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration"
  default     = null
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "policy" {
  description = "The path of the ECR policy in  (tpl file)"
  type        = string
  default     = ""
}



variable "lifecyle_enabled" {
  type        = bool
  description = "Enable lifecycle policy or not"
  default     = false
}