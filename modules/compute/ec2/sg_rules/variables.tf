  

variable "description" {
  description = "Description for the rule"
  type        = string
  default = ""
}



variable "cidr_blocks" {
  description = "cidr blocks for security group rule"
  type        = list
  default = null
}

variable "ipv6_cidr_blocks" {
  description = "ipv6_cidr blocks for security group rule"
  type        = list
  default = null
}


variable "source_security_group_id" {
  description = "source_security_group_id for security group rule"
  type        = string
  default = null
}

variable "self" {
  description = "self_security_group_id for security group rule"
  type        = string
  default = null
}

variable "type" {
  description = "Type of rule i.e ingress or egress"
  type        = string
  default = ""
}


variable "to_port" {
  description = "to port for the rule"
  type        = string
}

variable "protocol" {
  description = "protocol for the rule"
  type        = string
}

variable "prefix_list_ids" {
  description = "protocol for the rule"
  type        = list
default  = []
}

variable "from_port" {
  description = "from port for the rule"
  type        = string
}

variable "security_group_id" {
  description = "security_group_id where rule needs to be attached"
  type        = string
}
