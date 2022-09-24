#################
# Security group
#################
variable "emrname" {
  description = "name of emr cluster"
}

variable "emrrelease" {
  description = "emr release version"
  type        = string
}

variable "emrapplications" {
  description = "applications list spark,flink etc"
}

variable "termination_protection" {
  description = "true or false"
}

variable "keep_job_flow_alive_when_no_steps" {
  description = "option for long running cluster"
}

variable "subnetemr" {
  description = "emr subnet"
}

variable "emr_managed_master_security_group" {
  description = "emr master security group"
}

variable "emr_managed_slave_security_group" {
  description = "emr slave security group"
}

variable "service_access_security_group" {
  description = "emr service access security group"
}

variable "additional_master_security_groups" {
  description = "emr additional master security group"
}

variable "additional_slave_security_groups" {
  description = "emr additional slave security group"
}

variable "instance_profile" {
  description = "emr instance profile"
}


variable "master_instance_type" {
  description = "emr master_instance_type"
}

variable "master_bid_price" {
  description = "emr master_bid_price"
}

variable "master_ebs_size" {
  description = "emr master_ebs_size"
}

variable "master_ebs_type" {
  description = "emr master_ebs_type"
}

variable "master_volumes_per_instance" {
  description = "master_volumes_per_instance"
}


variable "core_instance_type" {
  description = "emr core_instance_type"
}

variable "core_instance_count" {
  description = "emr core_instance_count"
}

variable "core_ebs_size" {
  description = "emr core_ebs_size"
}

variable "core_ebs_type" {
  description = "emr core_ebs_type"
}

variable "core_volumes_per_instance" {
  description = "emr core_volumes_per_instance"
}

variable "core_bid_price" {
  description = "emr core_bid_price"
}

variable "ebs_root_volume_size" {
  description = "emr ebs_root_volume_size"
}


variable "emrtags" {
  description = "emr emrtags"
}

variable "bootstrap_path" {
  description = "emr bootstrap_path"
}


variable "bootstrap_action_name" {
  description = "emr bootstrap_action_name"
}

variable "configurations_json" {
  description = "emr configurations_json"
}


variable "emr_service_role" {
  description = "emr emr_service_role"
}

variable "task_instance_count" {
  description = "emr task_instance_count"
}

variable "task_instance_type" {
  description = "emr task_instance_type"
}

variable "task_name" {
  description = "emr task_name"
}
