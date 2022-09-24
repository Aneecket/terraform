variable "create_ebs_volume" {
  description = "Controls if volume should be created"
  type        = bool
  default     = true
}

variable "device_name" {
  description = "The name for the device."
  type        = string
  default     = ""
}
variable "instance_id" {
  description = "The id of the instance to which the volume needs to be attached."
  type        = string
  default     = ""
}

variable "encryption" {
  description = "Controls if volume should be encrypted"
  type        = bool
  default     = null
}

variable "type" {
  description = "The type of the volume."
  type        = string
  default     = null
}

variable "az" {
  description = "Availability zones name or id"
  type        = string
  default     = ""
}

variable "size" {
  description = "The size of the volume to be created in GiBs"
  type        = number
  default     = null
}

variable "iops" {
  description = "The iops of the volume to be created. Only valid for type of io1, io2 or gp3."
  type        = number
  default     = null
}

variable "snapshot" {
  description = "A snapshot to base the EBS volume off of."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to key pair resource."
  type        = map(string)
  default     = {}
}