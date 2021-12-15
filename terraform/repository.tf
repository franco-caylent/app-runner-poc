/*
resource "aws_ecrpublic_repository" "poc" {

  repository_name = "app-runner"
}
*/
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
  managed_policy_arns = toset([aws_iam_policy.registry_all.arn])
}

resource "aws_iam_policy" "registry_all" {
  name   = "poc-apprunner-registry-all"
  path   = "/"
  policy = data.aws_iam_policy_document.registry_iam.json
}

data "aws_iam_policy_document" "registry_iam" {
  statement {
    sid = "1"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability"
    ]
    resources = ["*"]
  }
}
