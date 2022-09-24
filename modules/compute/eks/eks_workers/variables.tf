variable "enabled" {
  type        = bool
  default     = true
  description = "Indicates whether the resources should be created or not"
}
variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
  default = ""
}
variable "launch_config_name" {
  type        = string
  description = "The name of the EKS cluster"
  default = ""
}
variable "asg_name" {
  type        = string
  description = "The name of the EKS cluster"
  default = ""
}
variable "use_existing_aws_iam_instance_profile" {
  type        = bool
  description = "If set to `true`, will use variable `aws_iam_instance_profile_name` to run EKS workers using an existing AWS instance profile that was created outside of this module, workaround for error like `count cannot be computed`"
  default     = true
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
  default = ""
}
variable "availability_zones" {
  description = "A list of availablity zones to launch resources in"
  type        = list(string)
  default = []
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)
  default = []
}

variable "cluster_certificate_authority_data" {
  type        = string
  description = "The base64 encoded certificate data required to communicate with the cluster"
  default = ""
}

variable "cluster_security_group_ingress_enabled" {
  type        = bool
  description = "Whether to enable the EKS cluster Security Group as ingress to workers Security Group"
  default     = true
}

variable "cluster_security_group_id" {
  type        = string
  description = "Security Group ID of the EKS cluster"
  default = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the EKS cluster"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the worker nodes"
}


variable "image_id" {
  type        = string
  description = "EC2 image ID to launch. If not provided, the module will lookup the most recent EKS AMI. See https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html for more details on EKS-optimized images"
  default     = ""
}

variable "use_custom_image_id" {
  type        = bool
  description = "If set to `true`, will use variable `image_id` for the EKS workers inside autoscaling group"
  default     = true
}

variable "eks_worker_ami_name_filter" {
  type        = string
  description = "AMI name filter to lookup the most recent EKS AMI if `image_id` is not provided"
  default     = "amazon-eks-node-*"
}

variable "eks_worker_ami_name_regex" {
  type        = string
  description = "A regex string to apply to the AMI list returned by AWS"
  default     = "^amazon-eks-node-[1-9,.]+-v[0-9]{8}$"
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
}

variable "key_name" {
  type        = string
  description = "SSH key name that should be used for the instance"
  default     = ""
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with an instance in a VPC"
  default     = false
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable/disable detailed monitoring"
  default     = true
}

variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}
variable "desired_capacity" {
  type        = number
  description = "The maximum size of the autoscale group"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  default = []
}

variable "default_cooldown" {
  type        = number
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
  default     = "EC2"
}

variable "force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = false
}
variable "wait_for_capacity_timeout" {
  description = "Delete timeout to wait for destroying autoscaling group"
  type        = string
  default     = "10m"
}

variable "load_balancers" {
  type        = list(string)
  description = "A list of elastic load balancer names to add to the autoscaling group. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead"
  default     = []
}

variable "target_group_arns" {
  type        = list(string)
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default`"
  type        = list(string)
  default     = []
}

variable "suspended_processes" {
  type        = list(string)
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "placement_group" {
  type        = string
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}
variable "launch_configuration" {
  type        = string
  description = "The name of launch config to attach to ASG"
  default     = ""
}


variable "protect_from_scale_in" {
  type        = bool
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events"
  default     = false
}


variable "autoscaling_group_tags" {
  type        = list(map(string))
  default     = []
  description = "Additional tags only for the autoscaling group, e.g. \"k8s.io/cluster-autoscaler/node-template/taint/dedicated\" = \"ci-cd:NoSchedule\"."
}


variable "bootstrap_extra_args" {
  type        = string
  default     = ""
  description = "Extra arguments to the `bootstrap.sh` script to enable `--enable-docker-bridge` or `--use-max-pods`"
}

variable "kubelet_extra_args" {
  type        = string
  default     = ""
  description = "Extra arguments to pass to kubelet, like \"--register-with-taints=dedicated=ci-cd:NoSchedule --node-labels=purpose=ci-worker\""
}


variable "before_cluster_joining_userdata" {
  type        = string
  default     = ""
  description = "Additional commands to execute on each worker node before joining the EKS cluster (before executing the `bootstrap.sh` script). For mot info, see https://kubedex.com/90-days-of-aws-eks-in-production"
}

variable "after_cluster_joining_userdata" {
  type        = string
  default     = ""
  description = "Additional commands to execute on each worker node after joining the EKS cluster (after executing the `bootstrap.sh` script). For mot info, see https://kubedex.com/90-days-of-aws-eks-in-production"
}

variable "aws_iam_instance_profile_name" {
  type        = string
  default     = ""
  description = "The name of the existing instance profile that will be used in autoscaling group for EKS workers. If empty will create a new instance profile."
}

variable "workers_security_group_id" {
  type        = list(string)
  default     = [""]
  description = "The name of the existing security group that will be used in autoscaling group for EKS workers. If empty, a new security group will be created"
}

variable "use_existing_security_group" {
  type        = bool
  description = "If set to `true`, will use variable `workers_security_group_id` to run EKS workers using an existing security group that was created outside of this module, workaround for errors like `count cannot be computed`"
  default     = false
}

variable "additional_security_group_ids" {
  type        = list(string)
  default     = []
  description = "Additional list of security groups that will be attached to the autoscaling group"
}

variable "workers_role_policy_arns" {
  type        = list(string)
  default     = []
  description = "List of policy ARNs that will be attached to the workers default role on creation"
}

variable "workers_role_policy_arns_count" {
  type        = number
  default     = 0
  description = "Count of policy ARNs that will be attached to the workers default role on creation. Needed to prevent Terraform error `count can't be computed`"
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "lc_name_without_prefix" {
  description = "Name of launch configuration to be created without prefix"
  type        = string
  default     = ""
}

variable "asg_name_without_prefix" {
  description = "Name of launch configuration to be created without prefix"
  type        = string
  default     = ""
}

variable "spot_price" {
  description = "The price to use for reserving spot instances"
  type        = string
  default     = ""
}

variable "launch_template_name" {
  description = "Name of launch template to be created"
  type        = string
  default     = ""
}
variable "create_lt" {
  description = "Determines whether to create launch template or not"
  type        = bool
  default     = false
}

variable "use_lt" {
  description = "Determines whether to use a launch template in the autoscaling group or not"
  type        = bool
  default     = false
}
variable "create_lc" {
  description = "Determines whether to create launch configuration or not"
  type        = bool
  default     = false
}

variable "use_lc" {
  description = "Determines whether to use a launch configuration in the autoscaling group or not"
  type        = bool
  default     = false
}
variable "launch_template" {
  description = "Name of an existing launch template to be used (created outside of this module)"
  type        = string
  default     = null
}
variable "default_version" {
  description = "(LT) Default Version of the launch template"
  type        = string
  default     = null
}
variable "block_device_mappings" {
  description = "(LT) Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = list(any)
  default     = []
}

variable "capacity_reservation_specification" {
  description = "(LT) Targeting for EC2 capacity reservations"
  type        = any
  default     = null
}

variable "cpu_options" {
  description = "(LT) The CPU options for the instance"
  type        = map(string)
  default     = null
}

variable "credit_specification" {
  description = "(LT) Customize the credit specification of the instance"
  type        = map(string)
  default     = null
}
variable "instance_market_options" {
  description = "(LT) The market (purchasing) option for the instance"
  type        = any
  default     = null
}
variable "network_interfaces" {
  description = "(LT) Customize network interfaces to be attached at instance boot time"
  type        = list(any)
  default     = []
}

variable "placement" {
  description = "(LT) The placement of the instance"
  type        = map(string)
  default     = null
}

variable "tag_specifications" {
  description = "(LT) The tags to apply to the resources during launch"
  type        = list(any)
  default     = []
}
variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(string)
  default     = null
}
variable "capacity_rebalance" {
  description = "Indicates whether capacity rebalance is enabled"
  type        = bool
  default     = null
}
variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}
variable "disable_api_termination" {
  description = "(LT) If true, enables EC2 instance termination protection"
  type        = bool
  default     = null
}

variable "instance_initiated_shutdown_behavior" {
  description = "(LT) Shutdown behavior for the instance. Can be `stop` or `terminate`. (Default: `stop`)"
  type        = string
  default     = null
}
variable "lt_tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type        = map(string)
  default     = {}
}
variable "lc_tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type        = map(string)
  default     = {}
}
variable "lt_version" {
  description = "Launch template version. Can be version number, `$Latest`, or `$Default`"
  type        = string
  default     = null
}
variable "new_user_data" {
  description = "Determines whether to use a new userdata or use existing one"
  type        = bool
  default     = false
}
variable "base_encoded_userdata" {
  description = "Launch template version. Can be version number, `$Latest`, or `$Default`"
  type        = string
  default     = null
}
variable "lc_use_name_prefix" {
  description = "Enables/disables name prefix"
  type        = bool
  default     = null
}

variable "asg_use_name_prefix" {
  description = "Enables/disables name prefix"
  type        = bool
  default     = null
}
variable "lt_use_name_prefix" {
  description = "Enables/disables name prefix"
  type        = bool
  default     = null
}

