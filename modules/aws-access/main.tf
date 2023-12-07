locals {
  github_account = "replace" # Replace with your GitHub Account. This may be a personal account or an organization.
  github_repository = "replace-me" # Replace with your GitHub Repository.
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
    { bundle = "github://${local.github_account}/${local.github_repository}/policies" }
  ]

  output = {
    location = "github://${local.github_account}/${local.github_repository}/modules/aws/access.tf"
    append = <<-EOT
      resource "aws_ssoadmin_account_assignment" "sandbox_compute_full_access_{{ .data.system.abbey.identities.aws.user_id }}" {
        instance_arn       = local.ssm_instance_arn
        permission_set_arn = local.permission_set_compute_full_access_arn

        principal_id = "{{ .data.system.abbey.identities.aws.user_id }}"
        principal_type = "USER"

        target_id   = local.organizations_account_sandbox_id
        target_type = "AWS_ACCOUNT"
      }
    EOT
  }
}
