module "sg_rds" {
  source  = "git::https://github.com/TechHoldingLLC/terraform-aws-security-group.git?ref=v0.0.1"
  name    = "${var.name}-rds"
  vpc_id  = var.vpc_id
  egress  = var.egress
  ingress = var.ingress
  providers = {
    aws = aws
  }
}