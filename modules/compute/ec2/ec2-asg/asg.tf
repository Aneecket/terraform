####################
# Autoscaling group
####################
resource "aws_autoscaling_group" "this" {
  count = var.create_asg ? 1 : 0

  #name_prefix = "${var.name}-"
  #name = var.asg_name_without_prefix
  #name_prefix = var.use_name_prefix ? "${var.name}-" : null

  name        = var.asg_use_name_prefix ? null : var.name
  name_prefix = var.asg_use_name_prefix ? "${var.name}-" : null

  launch_configuration = var.use_lc ? local.launch_configuration : null

  dynamic "launch_template" {
    for_each = var.use_lt ? [1] : []

    content {
      name    = local.launch_template
      version = var.lt_version
    }
  }

  #availability_zones  = var.availability_zone
  vpc_zone_identifier = var.vpc_zone_identifier
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  default_cooldown      = var.default_cooldown
  protect_from_scale_in = var.protect_from_scale_in
  capacity_rebalance    = var.capacity_rebalance
  load_balancers            = var.load_balancers
  target_group_arns         = var.target_group_arns
  placement_group           = var.placement_group
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  force_delete          = var.force_delete
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  termination_policies  = var.termination_policies
  suspended_processes   = var.suspended_processes
  max_instance_lifetime = var.max_instance_lifetime

  enabled_metrics         = var.enabled_metrics
  service_linked_role_arn = var.service_linked_role_arn

  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hooks
    content {
      name                    = lookup(initial_lifecycle_hook.value, "name", null)
      default_result          = lookup(initial_lifecycle_hook.value, "default_result", null)
      heartbeat_timeout       = lookup(initial_lifecycle_hook.value, "heartbeat_timeout", null)
      lifecycle_transition    = lookup(initial_lifecycle_hook.value, "lifecycle_transition", null)
      notification_metadata   = lookup(initial_lifecycle_hook.value, "notification_metadata", null)
      notification_target_arn = lookup(initial_lifecycle_hook.value, "notification_target_arn", null)
      role_arn                = lookup(initial_lifecycle_hook.value, "role_arn", null)
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? [var.instance_refresh] : []
    content {
      strategy = lookup(instance_refresh.value, "strategy", null)
      triggers = lookup(instance_refresh.value, "triggers", null)

      dynamic "preferences" {
        for_each = lookup(instance_refresh.value, "preferences", null) != null ? [lookup(instance_refresh.value, "strategy")] : []
        content {
          instance_warmup        = lookup(preferences.value, "instance_warmup", null)
          min_healthy_percentage = lookup(preferences.value, "min_healthy_percentage", null)
        }
      }
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.use_mixed_instances_policy ? [var.mixed_instances_policy] : []
    content {
      dynamic "instances_distribution" {
        for_each = lookup(mixed_instances_policy.value, "instances_distribution", null) != null ? [lookup(mixed_instances_policy.value, "instances_distribution")] : []
        content {
          on_demand_allocation_strategy            = lookup(instances_distribution.value, "on_demand_allocation_strategy", null)
          on_demand_base_capacity                  = lookup(instances_distribution.value, "on_demand_base_capacity", null)
          on_demand_percentage_above_base_capacity = lookup(instances_distribution.value, "on_demand_percentage_above_base_capacity", null)
          spot_allocation_strategy                 = lookup(instances_distribution.value, "spot_allocation_strategy", null)
          spot_instance_pools                      = lookup(instances_distribution.value, "spot_instance_pools", null)
          spot_max_price                           = lookup(instances_distribution.value, "spot_max_price", null)
        }
      }

      launch_template {
        launch_template_specification {
          launch_template_name = local.launch_template
          version              = var.lt_version
        }

        dynamic "override" {
          for_each = lookup(mixed_instances_policy.value, "override", null) != null ? lookup(mixed_instances_policy.value, "override") : []
          content {
            instance_type     = lookup(override.value, "instance_type", null)
            weighted_capacity = lookup(override.value, "weighted_capacity", null)

            dynamic "launch_template_specification" {
              for_each = lookup(override.value, "launch_template_specification", null) != null ? lookup(override.value, "launch_template_specification") : []
              content {
                launch_template_id = lookup(launch_template_specification.value, "launch_template_id", null)
              }
            }
          }
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = local.tags
    content {
      key                 = tag.value["key"]
      value               = tag.value["value"]
      propagate_at_launch = tag.value["propagate_at_launch"]
    }
  }

}
