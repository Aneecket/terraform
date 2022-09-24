module "stage-eks-ControlPlaneSecurityGroup" {
  source      = "../../../../modules/compute/ec2/sg_new/"
  name        = "stage-eks-ControlPlaneSecurityGroup"
  description = "stage-eks-ControlPlaneSecurityGroup"
  vpc_id      = data.terraform_remote_state.stage.outputs.stage_vpc_id
  tags        = { "Name" : "stage-eks-ControlPlaneSecurityGroup" }
}



module "stage-eks-worker-nodes-sg" {
  source      = "../../../../modules/compute/ec2/sg_new/"
  name        = "stage-eks-worker-nodes-sg"
  description = "stage eks worker nodes sg"
  vpc_id      = data.terraform_remote_state.stage.outputs.stage_vpc_id
  tags        = { "Name" : "stage-eks-worker-nodes-sg" }
}

module "stage-eks-lb-sg" {
  source      = "../../../../modules/compute/ec2/sg_new/"
  name        = "stage-eks-lb-sg"
  description = "stage eks load balancer sg"
  vpc_id      = data.terraform_remote_state.stage.outputs.stage_vpc_id
  tags        = { "Name" : "stage-eks-lb-sg" }
}


