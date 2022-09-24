locals {
  launch_configuration = var.create_lc ? aws_launch_configuration.this[0].name : var.launch_configuration
  launch_template = var.create_lt ? aws_launch_template.this[0].name : var.launch_template
  tags = concat(
  var.tags,
  local.tags_asg_format,
  )

  tags_asg_format = null_resource.tags_as_list_of_maps.*.triggers
}

resource "null_resource" "tags_as_list_of_maps" {
  count = length(keys(var.tags_as_map))

  triggers = {
    "key"                 = keys(var.tags_as_map)[count.index]
    "value"               = values(var.tags_as_map)[count.index]
    "propagate_at_launch" = "true"
  }
}
