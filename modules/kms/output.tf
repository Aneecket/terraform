output "aws_kms_key_id" {
  value = aws_kms_key.this.id
}
output "aws_kms_key_alias_id" {
  value = aws_kms_alias.this.id
}
