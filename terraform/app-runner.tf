resource "aws_apprunner_service" "poc" {
  service_name = "app-runner"

  source_configuration {
      
    authentication_configuration {
        access_role_arn = aws_iam_role.registry.arn
    }
    
    image_repository {
      image_configuration {
        port = "8080"
      }
      image_identifier      = "${aws_ecr_repository.poc.repository_url}:v1"
      image_repository_type = "ECR"
    }
  }
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.poc.arn
  instance_configuration {
    cpu = "1 vCPU"
    memory = "2048"
  }

  tags = {
    Name = "example-apprunner-service"
  }
}

resource "aws_apprunner_auto_scaling_configuration_version" "poc" {
  auto_scaling_configuration_name = "app-runner-poc"

  max_concurrency = 1
  max_size        = 5
  min_size        = 1

}

