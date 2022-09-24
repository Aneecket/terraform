module "eks-nlb" {
  source = "../../../modules/compute/ec2/ec2-alb/"
  name = "stage-eks-nlb"
  load_balancer_type = "network"
  vpc_id  = module.stage_vpc.vpc_id
  subnets = [element(module.stage_subnet.private_subnets,1),element(module.stage_subnet.private_subnets,2)]
  target_groups = [
    {
      name_prefix      = "stage-eks-tg"
      backend_protocol = "TCP"
      backend_port     = 80
      target_type      = "ip"
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]
  tags = {
    Entity  = "stage-eks"
    Env     = "stage"
    Name    = "stage-eks-nlb"
    Subteam = "clusterops"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}


