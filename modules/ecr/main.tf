resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  dynamic "encryption_configuration" {
    for_each = var.encryption_configuration == null ? [] : [var.encryption_configuration]
    content {
      encryption_type = encryption_configuration.value.encryption_type
      kms_key         = encryption_configuration.value.kms_key
    }
  }

  image_scanning_configuration {
    scan_on_push = var.scan_images_on_push
  }

  tags = var.tags
}


resource "aws_ecr_lifecycle_policy" "policy" {
  count      = var.lifecyle_enabled ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.policy
}
