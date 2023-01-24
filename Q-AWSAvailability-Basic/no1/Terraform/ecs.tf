resource "aws_ecs_cluster" "app" {
  name = "app"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "bridge"
  container_definitions    = <<EOL
[
  {
    "name": "${aws_ecr_repository.app.name}",
    "image": "${aws_ecr_repository.app.repository_url}",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 0
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.app.name}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "app"
      }
    }
  }
]
EOL
}

resource "aws_ecs_service" "app" {
  name                               = "app"
  cluster                            = aws_ecs_cluster.app.name
  task_definition                    = aws_ecs_task_definition.app.arn
  launch_type                        = "EC2"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
  desired_count                      = "2"

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = aws_ecr_repository.app.name
    container_port   = "80"
  }

  placement_constraints {
    type = "distinctInstance"
  }
}

resource "aws_ecr_repository" "app" {
  name                 = "app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/ecs/app"
  retention_in_days = "365"
}
