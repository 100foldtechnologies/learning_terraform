provider "aws" {
  region = "us-east-1"
}

# Create an IAM User
resource "aws_iam_user" "admin_user" {
  name = "non-root-admin-user"
}

# Attach a policy to give the user AdministratorAccess
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create an access key for the user (Optional)
resource "aws_iam_access_key" "admin_user_key" {
  user = aws_iam_user.admin_user.name
}
