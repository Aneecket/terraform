resource "aws_lb" "main" {
  count                            = var.enable ? 1 : 0
  name                             = var.name
  internal                         = var.internal
  load_balancer_type               = var.load_balancer_type
  security_groups                  = var.security_groups
  subnets                          = var.subnets
  enable_deletion_protection       = var.enable_deletion_protection
  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type
  tags                             = var.tags
  drop_invalid_header_fields       = false

  timeouts {
    create = var.load_balancer_create_timeout
    delete = var.load_balancer_delete_timeout
    update = var.load_balancer_update_timeout
  }
  access_logs {
    enabled = var.access_logs
    bucket  = var.log_bucket_name
    prefix  = var.prefix
  }
  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping

    content {
      subnet_id     = subnet_mapping.value.subnet_id
      allocation_id = lookup(subnet_mapping.value, "allocation_id", null)
    }
  }
}


resource "aws_lb_listener" "https" {
  count = var.enable == true && var.https_enabled == true && var.load_balancer_type == "application" ? length(var.https_listeners) : 0

  load_balancer_arn = var.lb_new ? element(aws_lb.main.*.arn, count.index) : var.lb_arn
  port            = var.https_listeners[count.index]["port"]
  protocol        = lookup(var.https_listeners[count.index], "protocol", "HTTPS")
  certificate_arn = var.https_listeners[count.index]["certificate_arn"]
  ssl_policy      = lookup(var.https_listeners[count.index], "ssl_policy", var.ssl_policy)
  #alpn_policy     = lookup(var.https_listeners[count.index], "alpn_policy", "None")

  dynamic "default_action" {
    for_each = length(keys(var.https_listeners[count.index])) == 0 ? [] : [var.https_listeners[count.index]]

    # Defaults to forward action if action_type not specified
    content {
      type             = lookup(default_action.value, "action_type", "forward")
      #target_group_arn = contains([null, "", "forward"], lookup(default_action.value, "action_type", "")) ? aws_lb_target_group.main[lookup(default_action.value, "target_group_index", count.index)].id : null
      target_group_arn = aws_lb_target_group.main[lookup(var.https_listeners[count.index], "target_group_index", count.index)].id
      dynamic "redirect" {
        for_each = length(keys(lookup(default_action.value, "redirect", {}))) == 0 ? [] : [lookup(default_action.value, "redirect", {})]

        content {
          path        = lookup(redirect.value, "path", null)
          host        = lookup(redirect.value, "host", null)
          port        = lookup(redirect.value, "port", null)
          protocol    = lookup(redirect.value, "protocol", null)
          query       = lookup(redirect.value, "query", null)
          status_code = redirect.value["status_code"]
        }
      }

      dynamic "fixed_response" {
        for_each = length(keys(lookup(default_action.value, "fixed_response", {}))) == 0 ? [] : [lookup(default_action.value, "fixed_response", {})]

        content {
          content_type = fixed_response.value["content_type"]
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }
      }

    }
  }

}



resource "aws_lb_listener" "http" {
  count = var.enable == true && var.http_enabled == true && var.load_balancer_type == "application" ? length(var.http_listeners) : 0

  load_balancer_arn = var.lb_new ? element(aws_lb.main.*.arn, count.index) : var.lb_arn
  port            = var.http_listeners[count.index]["port"]
  protocol        = lookup(var.http_listeners[count.index], "protocol", "HTTPS")

  dynamic "default_action" {
    for_each = length(keys(var.http_listeners[count.index])) == 0 ? [] : [var.http_listeners[count.index]]

    # Defaults to forward action if action_type not specified
    content {
      type             = lookup(default_action.value, "action_type", "forward")
      #target_group_arn = contains([null, "", "forward"], lookup(default_action.value, "action_type", "")) ? aws_lb_target_group.main[lookup(default_action.value, "target_group_index", count.index)].id : null
      target_group_arn = aws_lb_target_group.main[lookup(var.http_listeners[count.index], "target_group_index", count.index)].id
      dynamic "redirect" {
        for_each = length(keys(lookup(default_action.value, "redirect", {}))) == 0 ? [] : [lookup(default_action.value, "redirect", {})]

        content {
          path        = lookup(redirect.value, "path", null)
          host        = lookup(redirect.value, "host", null)
          port        = lookup(redirect.value, "port", null)
          protocol    = lookup(redirect.value, "protocol", null)
          query       = lookup(redirect.value, "query", null)
          status_code = redirect.value["status_code"]
        }
      }

      dynamic "fixed_response" {
        for_each = length(keys(lookup(default_action.value, "fixed_response", {}))) == 0 ? [] : [lookup(default_action.value, "fixed_response", {})]

        content {
          content_type = fixed_response.value["content_type"]
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }
      }

    }
  }
}


resource "aws_lb_listener" "nhttps" {
  count = var.enable == true && var.https_enabled == true && var.load_balancer_type == "network" ? length(var.https_listeners) : 0

  load_balancer_arn = var.lb_new ? element(aws_lb.main.*.arn, count.index) : var.lb_arn
  port              = var.https_listeners[count.index]["port"]
  protocol          = lookup(var.https_listeners[count.index], "protocol", "HTTPS")
  certificate_arn   = var.https_listeners[count.index]["certificate_arn"]
  ssl_policy        = var.https_listeners[count.index]["ssl_policy"]
  alpn_policy       = var.https_listeners[count.index]["alpn_policy"]
  default_action {
//    target_group_arn = aws_lb_target_group.main[lookup(var.https_listeners[count.index], "target_group_index", count.index)].id
    target_group_arn = var.https_listeners[count.index]["target_group_arn"]
    type             = "forward"
  }
}


resource "aws_lb_listener" "nhttp" {
  count = var.enable == true && var.load_balancer_type == "network" ? length(var.http_tcp_listeners) : 0

  load_balancer_arn = var.lb_new ? element(aws_lb.main.*.arn, count.index) : var.lb_arn
  port              = var.http_tcp_listeners[count.index]["port"]
  protocol          = var.http_tcp_listeners[count.index]["protocol"]
  default_action {
    target_group_arn = aws_lb_target_group.main[lookup(var.http_tcp_listeners[count.index], "target_group_index", count.index)].id
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "http_listener_rule" {
  count = length(var.http_listener_rules) == 0 ? 0 : length(var.http_listener_rules)

  listener_arn = var.listener_new ? aws_lb_listener.http[lookup(var.http_listener_rules[count.index], "http_listener_index", count.index)].arn : var.http_listener_arn
  priority     = lookup(var.http_listener_rules[count.index], "priority", null)

  # redirect actions
  dynamic "action" {
    for_each = [
    for action_rule in var.http_listener_rules[count.index].actions :
    action_rule
    if action_rule.type == "redirect"
    ]

    content {
      type = action.value["type"]
      redirect {
        host        = lookup(action.value, "host", null)
        path        = lookup(action.value, "path", null)
        port        = lookup(action.value, "port", null)
        protocol    = lookup(action.value, "protocol", null)
        query       = lookup(action.value, "query", null)
        status_code = action.value["status_code"]
      }
    }
  }

  # forward actions
  dynamic "action" {
    for_each = [
    for action_rule in var.http_listener_rules[count.index].actions :
    action_rule
    if action_rule.type == "forward"
    ]

    content {
      type             = action.value["type"]
      target_group_arn = aws_lb_target_group.main[lookup(action.value, "target_group_index", count.index)].id
    }
  }

  # Path Pattern condition
  dynamic "condition" {
    for_each = [
    for condition_rule in var.http_listener_rules[count.index].conditions :
    condition_rule
    if length(lookup(condition_rule, "path_patterns", [])) > 0
    ]

    content {
      path_pattern {
        values = condition.value["path_patterns"]
      }
    }
  }

  # Host header condition
  dynamic "condition" {
    for_each = [
    for condition_rule in var.http_listener_rules[count.index].conditions :
    condition_rule
    if length(lookup(condition_rule, "host_headers", [])) > 0
    ]

    content {
      host_header {
        values = condition.value["host_headers"]
      }
    }
  }


}

resource "aws_lb_listener_rule" "https_listener_rule" {
  count = length(var.https_listener_rules) == 0 ? 0 : length(var.https_listener_rules)

  listener_arn = var.listener_new ? aws_lb_listener.https[lookup(var.https_listener_rules[count.index], "https_listener_index", count.index)].arn : var.https_listener_arn
  priority     = lookup(var.https_listener_rules[count.index], "priority", null)




  # redirect actions
  dynamic "action" {
    for_each = [
    for action_rule in var.https_listener_rules[count.index].actions :
    action_rule
    if action_rule.type == "redirect"
    ]

    content {
      type = action.value["type"]
      redirect {
        host        = lookup(action.value, "host", null)
        path        = lookup(action.value, "path", null)
        port        = lookup(action.value, "port", null)
        protocol    = lookup(action.value, "protocol", null)
        query       = lookup(action.value, "query", null)
        status_code = action.value["status_code"]
      }
    }
  }


  # forward actions
  dynamic "action" {
    for_each = [
    for action_rule in var.https_listener_rules[count.index].actions :
    action_rule
    if action_rule.type == "forward"
    ]

    content {
      type             = action.value["type"]
      target_group_arn = aws_lb_target_group.main[lookup(action.value, "target_group_index", count.index)].id
    }
  }

  # Path Pattern condition
  dynamic "condition" {
    for_each = [
    for condition_rule in var.https_listener_rules[count.index].conditions :
    condition_rule
    if length(lookup(condition_rule, "path_patterns", [])) > 0
    ]

    content {
      path_pattern {
        values = condition.value["path_patterns"]
      }
    }
  }

  # Host header condition
  dynamic "condition" {
    for_each = [
    for condition_rule in var.https_listener_rules[count.index].conditions :
    condition_rule
    if length(lookup(condition_rule, "host_headers", [])) > 0
    ]

    content {
      host_header {
        values = condition.value["host_headers"]
      }
    }
  }

}





# Module      : LOAD BALANCER TARGET GROUP
# Description : Provides a Target Group resource for use with Load Balancer resources.
resource "aws_lb_target_group" "main" {
  count                              = var.enable ? length(var.target_groups) : 0
  name                               = lookup(var.target_groups[count.index], "name", null)
  port                               = lookup(var.target_groups[count.index], "backend_port", null)
  protocol                           = lookup(var.target_groups[count.index], "backend_protocol", null) != null ? upper(lookup(var.target_groups[count.index], "backend_protocol")) : null
  vpc_id                             = var.vpc_id
  target_type                        = lookup(var.target_groups[count.index], "target_type", null)
  deregistration_delay               = lookup(var.target_groups[count.index], "deregistration_delay", null)
  slow_start                         = lookup(var.target_groups[count.index], "slow_start", null)
  proxy_protocol_v2                  = lookup(var.target_groups[count.index], "proxy_protocol_v2", null)
  lambda_multi_value_headers_enabled = lookup(var.target_groups[count.index], "lambda_multi_value_headers_enabled", null)
  tags                               = lookup(var.target_groups[count.index], "tags", {})
  dynamic "health_check" {
    for_each = length(keys(lookup(var.target_groups[count.index], "health_check", {}))) == 0 ? [] : [lookup(var.target_groups[count.index], "health_check", {})]

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }



  dynamic "stickiness" {
    for_each = length(keys(lookup(var.target_groups[count.index], "stickiness", {}))) == 0 ? [] : [lookup(var.target_groups[count.index], "stickiness", {})]

    content {
      enabled         = lookup(stickiness.value, "enabled", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      type            = lookup(stickiness.value, "type", null)
    }
  }
}



resource "aws_lb_target_group_attachment" "attachment" {
  count = var.enable && var.load_balancer_type == "application"  && var.tg_group_attachment_enable && var.target_type == "" ? var.instance_count : 0

  target_group_arn = element(aws_lb_target_group.main.*.arn, count.index)
  target_id        = element(var.target_id, count.index)
  port             = lookup(var.target_groups[count.index], "backend_port", null)
}

resource "aws_lb_target_group_attachment" "nattachment" {
  count = var.enable && var.tg_group_attachment_enable && var.load_balancer_type == "network" ? length(var.https_listeners) : 0

  target_group_arn = element(aws_lb_target_group.main.*.arn, count.index)
  target_id        = element(var.target_id, 0)
  port             = lookup(var.target_groups[count.index], "backend_port", null)
}

resource "aws_elb" "main" {
  count = var.clb_enable && var.load_balancer_type == "classic" == true ? 1 : 0

  name                        = var.clb_name
  instances                   = var.target_id
  internal                    = var.internal
  cross_zone_load_balancing   = var.enable_cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout
  security_groups             = var.security_groups
  subnets                     = var.subnets

  dynamic "listener" {
    for_each = var.listeners
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = listener.value.ssl_certificate_id
    }
  }

  health_check {
    target              = var.health_check_target
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    unhealthy_threshold = var.health_check_unhealthy_threshold
    healthy_threshold   = var.health_check_healthy_threshold
  }

  tags = var.clb_tags
}