resource "aws_volume_attachment" "this" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.this[0].id
  instance_id = var.instance_id
}

resource "aws_ebs_volume" "this" {
  count = var.create_ebs_volume ? 1 : 0
  encrypted = var.encryption
  snapshot_id = var.snapshot
  iops = var.iops
  type = var.type
  availability_zone = var.az
  size              = var.size
  tags = var.tags
}