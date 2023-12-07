locals {}

module "aws" {
  source = "../../modules/aws"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}

module "aws_access" {
  source = "../../modules/aws-access"

  abbey_token = var.abbey_token
}
