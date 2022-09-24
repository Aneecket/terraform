module "rule-stage-eks-api-whitelist_ingress_tcp_572" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = "Allow pods to communicate with the cluster API Server"
  from_port = "443"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-ControlPlaneSecurityGroup.this_security_group_id, 0)
  self              = null
  cidr_blocks = null
  ipv6_cidr_blocks = null
  source_security_group_id = element(module.stage-eks-worker-nodes-sg.this_security_group_id, 0)
  prefix_list_ids          = null
  to_port = "443"
  type = "ingress"
}

module "rule-stage-eks-kubelet-whitelist_egress_tcp_568" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = "Allow the cluster control plane to communicate with worker Kubelet and pods"
  from_port = "1025"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-ControlPlaneSecurityGroup.this_security_group_id, 0)
  self              = null
  cidr_blocks = null
  ipv6_cidr_blocks = null
  source_security_group_id = element(module.stage-eks-worker-nodes-sg.this_security_group_id, 0)
  prefix_list_ids          = null
  to_port = "65535"
  type = "egress"
}


###WORKER NODE RULES###
module "rule-088d4b9d872eb8f9b_ingress_tcp_370" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "80"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-worker-nodes-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = null
  ipv6_cidr_blocks = null
  source_security_group_id = element(module.stage-eks-lb-sg.this_security_group_id, 0)
  prefix_list_ids          = null
  to_port = "80"
  type = "ingress"
}

module "rule-088d4b9d872eb8f9b_egress_-1_352" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "0"
  protocol = "-1"
  security_group_id = element(module.stage-eks-worker-nodes-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = null
  source_security_group_id = null
  prefix_list_ids = null
  to_port = "0"
  type = "egress"
}


###LB rules####
module "rule-0f6b3b2f77b0ccee8_egress_tcp_769" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "32080"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-lb-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = null
  source_security_group_id = null
  prefix_list_ids = null
  to_port = "32080"
  type = "egress"
}

module "rule-0f6b3b2f77b0ccee8_egress_tcp_770" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "80"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-lb-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = null
  source_security_group_id = null
  prefix_list_ids = null
  to_port = "80"
  type = "egress"
}

module "rule-0f6b3b2f77b0ccee8_ingress_tcp_771" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "443"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-lb-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = null
  source_security_group_id = null
  prefix_list_ids = null
  to_port = "443"
  type = "ingress"
}

module "rule-0f6b3b2f77b0ccee8_ingress_tcp_772" {
  source = "../../../../modules/compute/ec2/sg_rules/"
  description = ""
  from_port = "80"
  protocol = "tcp"
  security_group_id = element(module.stage-eks-lb-sg.this_security_group_id, 0)
  self              = null
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = null
  source_security_group_id = null
  prefix_list_ids = null
  to_port = "80"
  type = "ingress"
}

##########################
