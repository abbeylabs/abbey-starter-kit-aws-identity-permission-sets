locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  module_path = "${local.project_path}/modules/aws"
  policies_path = "${local.project_path}/policies"
}

resource "abbey_grant_kit" "aws_permission_set_compute_full_access" {
  name = "aws_permission_set_compute_full_access"
  description = <<-EOT
    Grants access to the ComputeFullAccess permission set in AWS for the Sandbox account on us-east-1.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"] # Replace with your Abbey account email.
        }
      }
    ]
  }

  policies = [
    { bundle = local.policies_path }
  ]

  output = {
    location = "${local.module_path}/access.tf"
    append = <<-EOT
      resource "aws_ssoadmin_account_assignment" "sandbox_compute_full_access_{{ .user.aws_identitystore.id }}" {
        instance_arn       = local.ssm_instance_arn
        permission_set_arn = local.permission_set_compute_full_access_arn

        principal_id = "{{ .user.aws_identitystore.id }}"
        principal_type = "USER"

        target_id   = local.organizations_account_sandbox_id
        target_type = "AWS_ACCOUNT"
      }
    EOT
  }
}
