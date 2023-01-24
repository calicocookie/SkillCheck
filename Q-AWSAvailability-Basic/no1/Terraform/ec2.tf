resource "aws_launch_template" "app" {
  name                    = "app"
  description             = "app"
  disable_api_termination = false
  ebs_optimized           = true
  image_id                = var.ami_id
  instance_type           = "m5.large"
  user_data               = base64encode(local.user_data)
  key_name                = "ssh-key"

  iam_instance_profile {
    arn = aws_iam_instance_profile.app.arn
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [aws_security_group.app_ec2.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "app"
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      "Name" = "app"
    }
  }
}

resource "aws_iam_instance_profile" "app" {
  name = "app"
  role = aws_iam_role.app.name
}

resource "aws_iam_role" "app" {
  name               = "app_ec2"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.app_assume.json
}

data "aws_iam_policy_document" "app_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "app" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:Poll",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:RegisterContainerInstance",
      "ecs:Submit*",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:CreateCluster",
      "ec2:DescribeTags",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "app" {
  name   = "app-ec2-policy"
  policy = data.aws_iam_policy_document.app.json
}

resource "aws_iam_role_policy_attachment" "app" {
  role       = aws_iam_role.app.name
  policy_arn = aws_iam_policy.app.arn
}

resource "aws_autoscaling_group" "app" {
  name                = "app"
  max_size            = 2
  min_size            = 2
  health_check_type   = "EC2"
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.private_c.id]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "app"
  }
}

locals {
  user_data = <<DATA
  #cloud-config
  runcmd:
   - [ sh, -c, 'echo "ECS_CLUSTER=${aws_ecs_cluster.app.name}" >> /etc/ecs/ecs.config' ]
  DATA
}
