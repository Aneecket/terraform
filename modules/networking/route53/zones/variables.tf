variable "name" {
  description = "Name of the hosted zone"
  type        = string
}

variable "force_destroy" {
  description = "To destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  type        = bool
  default     = true
}

variable "vpc_ids" {
  description = "List of VPCs that will be associated with this private zone. If not given it will be a public zone."
  type        = list(any)
  default     = null
}


variable "vpc_regions" {
  description = "List of VPC's regions that will be associated with this private zone. If not given it will be a public zone."
  type        = list(any)
  default     = null
}

variable "comment" {
  description = "Default comment to add to all resources"
  type        = string
  default     = "Managed by Terraform"
}

