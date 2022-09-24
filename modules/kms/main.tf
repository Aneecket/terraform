resource "aws_kms_key" "this" {
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  description              = var.description
  enable_key_rotation      = var.enable_key_rotation
  is_enabled               = var.is_enabled
  key_usage                = "ENCRYPT_DECRYPT"
  policy                   = var.policy
  tags                     = var.tags
  tags_all                 = var.tags_all
}

resource "aws_kms_alias" "this" {
  name                     = var.alias_name
  target_key_id            = aws_kms_key.this.key_id
}