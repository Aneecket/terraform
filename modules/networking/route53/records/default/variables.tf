variable "zone_id" {
  description = "ID of the hosted zone"
  type        = string
}

variable "name" {
  description = "Name of the record"
  type        = string
}

variable "private_zone" {
  description = "To destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  type        = bool
  default     = true
}


variable "type" {
  description = "Record type to be created. eg: A, CNAME, ALIAS etc"
  type        = string
  default     = null
}

variable "ttl" {
  description = "TTL for record"
  type        = string
  default     = "300"
}

variable "records" {
  type        = list(any)
  default     = [""]
  description = "(Required for non-alias records) A string list of records. To specify a single record value longer than 255 characters such as a TXT record for DKIM, add \"\" inside the Terraform configuration string (e.g. \"first255characters\"\"morecharacters\")."
}

variable "alias" {
  type        = map(any)
  default     = {}
  description = "An alias block. Conflicts with ttl & records. Alias record documented below."
}

variable "allow_overwrite" {
  type        = bool
  default     = false
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any. This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform or manual Route 53 changes outside Terraform from overwriting this record. false by default. This configuration is not recommended for most environments."
}