resource "aws_iam_role" "this" {
  name                  = var.role_name
  path                  = var.role_path
  max_session_duration  = var.max_session_duration
  description           = var.description
  managed_policy_arns   = var.managed_policy_arns
  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn
  assume_role_policy    = var.assume_role_policy
  dynamic "inline_policy" {
    for_each = var.inline_policy
    content {
      name   = inline_policy.value["name"][0]
      policy = inline_policy.value["policy"][0]
    }
  }
  tags = var.tags
}

