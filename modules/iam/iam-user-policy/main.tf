resource "aws_iam_user_policy" "this" {
  name   = var.name
  policy = var.policy
  user   = var.user
}

