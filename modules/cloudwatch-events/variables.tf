
variable "event_name" {
  description = "Desired name for the event rule"
  type        = string
}

variable "event_description" {
  description = "Desired for the event rule"
  type        = string
  default     = ""
}


variable "event_pattern" {
  description = "event pattern in toml format"
  type        = string
}

variable "event_bus_name" {
  description = "event bus name"
  type        = string
  default     = "default"
}

variable "is_enabled" {
  description = "enable or disable event "
  type        = string
  default     = "true"
}

variable "schedule_expression" {
  description = "enable schedule expression"
  type        = string
  default     = null
}


