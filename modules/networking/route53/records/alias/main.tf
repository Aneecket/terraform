




resource "aws_route53_record" "alias" {
  zone_id         = var.zone_id
  name            = var.name
  type            = var.type
  allow_overwrite = var.allow_overwrite
  alias {
    name                   = var.alias["name"]
    zone_id                = var.alias["zone_id"]
    evaluate_target_health = var.alias["evaluate_target_health"]
  }
}