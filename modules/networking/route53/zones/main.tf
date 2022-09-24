resource "aws_route53_zone" "this" {
  name          = var.name
  comment       = var.comment
  force_destroy = var.force_destroy

  dynamic "vpc" {
    for_each = zipmap(var.vpc_ids, var.vpc_regions)
    content {
      vpc_id     = vpc.key
      vpc_region = vpc.value
    }
  }

}
