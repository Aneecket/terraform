variable "target_id" {
  description = "Target id of the event target"
  type        = string
}

variable "event_target_arn" {
  description = "Event Target arn"
  type        = string
}
variable "event_target_role_arn" {
  description = "Event Target arn"
  type        = string
}

variable "target_rule" {
  description = "target Rule"
  type        = string
}


variable "input_paths" {
  type    = map(any)
  default = {}
}

variable "input_template" {
  type    = string
  default = null

}
