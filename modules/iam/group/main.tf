resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}


resource "aws_iam_group_policy_attachment" "policy_attachment" {
  for_each   = toset(var.policy_arn)
  group      = aws_iam_group.this.name
  policy_arn = each.key
}
