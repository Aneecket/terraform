#Adding code for stage VPC
module "stage_vpc" {
  source               = "../../../modules/networking/vpc/vpc/"
  name                 = "stage-vpc"
  cidr                 = "172.27.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  vpc_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    Created_by = "terraform"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}
module "stage_subnet" {
  source                  = "../../../modules/networking/vpc/subnets/"
  vpc_id                  = module.stage_vpc.vpc_id
  map_public_ip_on_launch = true
  public_name             = ["stage-public-subnet-1", "stage-public-subnet-2", "stage-public-subnet-3"]
  azs                     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnets          = ["172.27.0.0/24", "172.27.1.0/24", "172.27.2.0/24"]
  private_name            = ["stage-private-subnet-1", "stage-private-subnet-2", "stage-private-subnet-3"]
  private_subnets         = ["172.27.3.0/24", "172.27.4.0/24", "172.27.5.0/24"]
  public_subnet_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
  private_subnet_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}
module "stage_eks_subnet" {
  source          = "../../../modules/networking/vpc/subnets/"
  vpc_id          = module.stage_vpc.vpc_id
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_name    = ["stage-eks-subnet-1a", "stage-eks-subnet-1b", "stage-eks-subnet-1c"]
  private_subnets = ["172.27.64.0/18", "172.27.128.0/18", "172.27.192.0/18"]
  private_subnet_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}


module "stage_igw_natgw" {
  source             = "../../../modules/networking/vpc/igw_and_natgw"
  igw_name           = "stage-vpc-igw"
  ngw_name           = "stage-vpc-ngw"
  eip_name           = "stage-vpc-ngw-eip"
  vpc_id             = module.stage_vpc.vpc_id
  enable_nat_gateway = true
  single_nat_gateway = true
  azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  natgw_subnet       = module.stage_subnet.public_subnets[0]
  public_subnets     = module.stage_subnet.public_subnets
  private_subnets    = concat(module.stage_subnet.private_subnets, module.stage_eks_subnet.private_subnets)
  igw_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
  nat_eip_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
  nat_gateway_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}
module "stage_nacl" {
  source  = "../../../modules/networking/vpc/nacl/"
  vpc_id  = module.stage_vpc.vpc_id
  subnets = concat(module.stage_subnet.public_subnets, module.stage_subnet.private_subnets, module.stage_eks_subnet.private_subnets)
  inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}
module "stage_route_table" {
  source          = "../../../modules/networking/vpc/route_tables/"
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  vpc_id          = module.stage_vpc.vpc_id
  igw_id          = module.stage_igw_natgw.igw_id
  public_name     = ["stage-vpc-public-rt"]
  private_name    = ["stage-vpc-private-rt"]
  public_subnets  = module.stage_subnet.public_subnets
  private_subnets = concat(module.stage_subnet.private_subnets, module.stage_eks_subnet.private_subnets)
  nat_gateway_ids = module.stage_igw_natgw.natgw_ids
  public_routes = []
  private_routes = []
  public_route_table_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
  private_route_table_tags = {
    Entity  = "stage-vpc"
    Env     = "stage"
    Subteam = "networking"
    Team    = "sre"
    billing =  "Insurance - Auto Insurance - Used Car Insurance - Dealer"
  }
}



module "gibpl_stage_peering" {
  source                                    = "../../../modules/networking/vpc/peering/"
  vpc_id                                    = module.stage_vpc.vpc_id
  acceptor_vpc_id                           = "vpc-04f57520d7bee85e1"
  #peer_region                               = "ap-south-1"
  auto_accept                               = true
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_allow_remote_vpc_dns_resolution = true
  tags = {
    Name = "gibpl-stage-eks-peering"
  }
}


