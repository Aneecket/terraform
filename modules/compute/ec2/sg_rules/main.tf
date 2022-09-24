resource "aws_security_group_rule" "this" {
  cidr_blocks = var.cidr_blocks
  ipv6_cidr_blocks = var.ipv6_cidr_blocks
  source_security_group_id = var.source_security_group_id
  self  = var.self
  description       = var.description
  type              = var.type
  to_port           = var.to_port
  protocol          = var.protocol
  prefix_list_ids   = var.prefix_list_ids
  from_port         = var.from_port
  security_group_id = var.security_group_id  
}
