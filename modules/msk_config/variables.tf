
variable "server_properties" {
  description = "A map of the contents of the server.properties file"
  type        = string
}



variable "kafka_versions" {
  description = "Kafka versions for the config"
  type        = string
}


variable "msk_configuration_name" {
  description = "name of the configurations"
  type        = string
}


variable "description" {
  description = "description of the configurations"
  type        = string
}

