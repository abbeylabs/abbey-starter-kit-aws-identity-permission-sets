resource "abbey_identity" "user_1" {
  abbey_account = "replace-me@example.com" # Replace with your Abbey account email.
  source = "aws"
  metadata = jsonencode(
    {
      user_id = "replaceme" # Replace with your AWS Identity Center User ID.
    }
  )
}
