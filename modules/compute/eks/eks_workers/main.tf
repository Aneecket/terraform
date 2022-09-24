locals {
  enabled = var.enabled
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  workers_role_arn  = join("", data.aws_iam_instance_profile.default.*.role_arn)
  workers_role_name = join("", data.aws_iam_instance_profile.default.*.role_name)
}

data "aws_ami" "eks_worker" {
  count = local.enabled && var.use_custom_image_id == false ? 1 : 0

  most_recent = true
  name_regex  = var.eks_worker_ami_name_regex

  filter {
    name   = "name"
    values = [var.eks_worker_ami_name_filter]
  }

  owners = ["602401143452"] # Amazon
}

data "template_file" "userdata" {
  count    = local.enabled ? 1 : 0
  template = file("${path.module}/userdata.tpl")

  vars = {
    cluster_endpoint                = var.cluster_endpoint
    certificate_authority_data      = var.cluster_certificate_authority_data
    cluster_name                    = var.cluster_name
    bootstrap_extra_args            = var.bootstrap_extra_args
    kubelet_extra_args              = var.kubelet_extra_args
    before_cluster_joining_userdata = var.before_cluster_joining_userdata
    after_cluster_joining_userdata  = var.after_cluster_joining_userdata
  }
}

data "aws_iam_instance_profile" "default" {
  count = local.enabled && var.use_existing_aws_iam_instance_profile ? 1 : 0
  name  = var.aws_iam_instance_profile_name
}

module "autoscaling_group" {
  source                             = "../../ec2/ec2-asg/"
  name                               = var.asg_name
  lc_use_name_prefix = var.lc_use_name_prefix
  lt_use_name_prefix = var. lt_use_name_prefix
  asg_use_name_prefix = var.asg_use_name_prefix
  use_lc                             = var.use_lc
  use_lt                             = var.use_lt
  lc_name                            = var.launch_config_name
  lt_name                            = var.launch_template_name
  create_lc                          = var.create_lc
  create_lt                          = var.create_lt
  tags                               = var.autoscaling_group_tags
  availability_zone                  = var.availability_zones
  vpc_zone_identifier                = var.subnet_ids
  iam_instance_profile               = var.aws_iam_instance_profile_name
  image_id                           = var.use_custom_image_id ? var.image_id : join("", data.aws_ami.eks_worker.*.id)
  security_groups                    = var.workers_security_group_id
  ebs_block_device                   = var.ebs_block_device
  root_block_device                  = var.root_block_device
  #user_data                          = base64encode(join("", data.template_file.userdata.*.rendered))
  instance_type                      = var.instance_type
  min_size                           = var.min_size
  max_size                           = var.max_size
  desired_capacity                   = var.desired_capacity
  associate_public_ip_address        = var.associate_public_ip_address
  ebs_optimized                      = var.ebs_optimized
  key_name                           = var.key_name
  enable_monitoring                  = var.enable_monitoring
  load_balancers                     = var.load_balancers
  health_check_grace_period          = var.health_check_grace_period
  health_check_type                  = var.health_check_type
  target_group_arns                  = var.target_group_arns
  default_cooldown                   = var.default_cooldown
  force_delete                       = var.force_delete
  termination_policies               = var.termination_policies
  suspended_processes                = var.suspended_processes
  placement_group                    = var.placement_group
  enabled_metrics                    = var.enabled_metrics
  protect_from_scale_in              = var.protect_from_scale_in
  spot_price                         = var.spot_price
  launch_configuration               = var.launch_configuration
  launch_template                    = var.launch_template
  default_version                    = var.default_version
  block_device_mappings              = var.block_device_mappings
  capacity_reservation_specification = var.capacity_reservation_specification
  capacity_rebalance                 = var.capacity_rebalance
  cpu_options                        = var.cpu_options
  credit_specification               = var.credit_specification
  instance_market_options            = var.instance_market_options
  metadata_options                   = var.metadata_options
  network_interfaces                 = var.network_interfaces
  placement                          = var.placement
  tag_specifications                 = var.tag_specifications
  tags_as_map                        = var.tags_as_map
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  iam_instance_profile_name = var.aws_iam_instance_profile_name
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  disable_api_termination = var.disable_api_termination
  lc_tags = var.lc_tags
  lt_tags = var.lt_tags
  lt_version = var.lt_version
  user_data =  var.new_user_data ? base64encode(join("", data.template_file.userdata.*.rendered)) : var.base_encoded_userdata

}
