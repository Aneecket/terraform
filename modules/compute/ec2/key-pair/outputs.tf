output "this_key_pair_key_name" {
  description = "The key pair name."
  value       = concat(aws_key_pair.this.*.key_name, [""])[0]
}

output "this_key_pair_key_pair_id" {
  description = "The key pair ID."
  value       = concat(aws_key_pair.this.*.key_pair_id, [""])[0]
}