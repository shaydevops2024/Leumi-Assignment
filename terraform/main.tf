module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block         = "10.0.0.0/16"
  vpc_name               = "main-vpc"
  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones     = ["us-east-1a", "us-east-1b"]
}

module "ec2_instance" {
  source = "./modules/instance"

  region           = "us-east-1"
  ami              = "ami-0e86e20dae9224db8" 
  instance_type    = "t2.micro"
  key_name         = "test"
  instance_name    = "test"
  leumi_proxy_ip   = "91.231.246.50/32"
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_ids[0]
}

module "nlb" {
  source = "./modules/nlb"

  nlb_name                = "test-nlb"
  internal                = false
  subnets                 = module.vpc.public_subnet_ids
  tg_name                 = "test-tg"
  tg_port                 = 80
  tg_protocol             = "TCP"
  vpc_id                  = module.vpc.vpc_id
  health_check_protocol   = "TCP"
  health_check_port       = 80
  target_id               = module.ec2_instance.instance_id
  listener_port           = 80
  listener_protocol       = "TCP"
}

