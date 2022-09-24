

resource "aws_emr_cluster" "cluster" {
  name          = var.emrname
  release_label = var.emrrelease
  applications  = var.emrapplications



  termination_protection            = var.termination_protection
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps

  ec2_attributes {
    subnet_id                         = var.subnetemr
    emr_managed_master_security_group = var.emr_managed_master_security_group
    emr_managed_slave_security_group  = var.emr_managed_slave_security_group
    service_access_security_group     = var.service_access_security_group
    additional_master_security_groups = var.additional_master_security_groups
    additional_slave_security_groups  = var.additional_slave_security_groups
    instance_profile                  = var.instance_profile
  }

  master_instance_group {
    instance_type = var.master_instance_type
    bid_price = var.master_bid_price
    ebs_config {
      size                 = var.master_ebs_size
      type                 = var.master_ebs_type
      volumes_per_instance = var.master_volumes_per_instance
    }
  }

  core_instance_group {
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count

    ebs_config {
      size                 = var.core_ebs_size
      type                 = var.core_ebs_type
      volumes_per_instance = var.core_volumes_per_instance
    }

    bid_price = var.core_bid_price


  }

  ebs_root_volume_size = var.ebs_root_volume_size

  tags = var.emrtags

  bootstrap_action {
    path = var.bootstrap_path
    name = var.bootstrap_action_name

  }

  configurations_json = var.configurations_json

  service_role = var.emr_service_role
}

resource "aws_emr_managed_scaling_policy" "samplepolicy" {
  cluster_id = aws_emr_cluster.cluster.id
  compute_limits {
    unit_type                       = "Instances"
    minimum_capacity_units          = 3
    maximum_capacity_units          = 6
    maximum_ondemand_capacity_units = 6
    maximum_core_capacity_units     = 6
  }
}

resource "aws_emr_instance_group" "task" {
  cluster_id     = aws_emr_cluster.cluster.id
  instance_count = var.task_instance_count
  instance_type  = var.task_instance_type
  name           = var.task_name
}
