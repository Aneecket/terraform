
resource "aws_iam_user" "this" {

  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}


resource "aws_iam_user_policy_attachment" "policy_attachment" {
  for_each   = toset(var.policy_arn)
  user       = aws_iam_user.this.name
  policy_arn = each.key
}

resource "aws_iam_user_group_membership" "group_membership" {
  user   = aws_iam_user.this.name
  groups = var.groups
}

resource "aws_iam_access_key" "this" {
  count = var.enable_access_key ? 1 : 0
  user  = aws_iam_user.this.name
}