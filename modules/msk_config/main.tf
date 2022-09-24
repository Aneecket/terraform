
resource "aws_msk_configuration" "this" {
  kafka_versions    = [var.kafka_versions]
  name              = var.msk_configuration_name
  server_properties = var.server_properties
  description       = var.description
  lifecycle {
    create_before_destroy = true
  }
}
