resource "aws_ecr_repository" "poc" {
  name                 = "app-runner"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_iam_role" "registry" {
  name               = "registry"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "build.apprunner.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  managed_policy_arns = toset(["arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"])
}
