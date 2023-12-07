locals {
  ssm_instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  permission_set_compute_full_access_arn = data.aws_ssoadmin_permission_set.compute_full_access.arn
  organizations_account_sandbox_id = [for a in data.aws_organizations_organization.org.accounts : a.id if a.id == "replaceme"][0]
}

data "aws_organizations_organization" "org" {}

data "aws_ssoadmin_instances" "main" {}

data "aws_ssoadmin_permission_set" "compute_full_access" {
  instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  name         = "ComputeFullAccess"
}
