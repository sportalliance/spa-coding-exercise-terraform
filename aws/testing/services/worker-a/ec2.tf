data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "worker_a" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "worker_a" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.worker_a.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
}

data "aws_subnet_ids" "main" {
  vpc_id = local.vpc_id
}

resource "aws_autoscaling_group" "worker_a" {
  launch_configuration = aws_launch_configuration.worker_a.name
  vpc_zone_identifier  = local.network.private_subnets
  target_group_arns    = [aws_lb_target_group.worker_a.arn]
  health_check_type    = "ELB"

  min_size = 1
  max_size = 3

  tag {
    key                 = "Name"
    value               = "worker-a"
    propagate_at_launch = true
  }
}
