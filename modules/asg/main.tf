# Reusable AWS EC2 Autoscaling Group Terraform Module
resource "aws_launch_template" "this" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = var.security_groups
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix         = "${var.name_prefix}-asg-"
  vpc_zone_identifier = var.subnet_ids

  min_size     = var.min_size
  max_size     = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.name_prefix
    propagate_at_launch = true
  }
}

# Variables
variable "name_prefix" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string; default = "t3.micro" }
variable "subnet_ids" { type = list(string) }
variable "security_groups" { type = list(string) }
variable "min_size" { type = number; default = 1 }
variable "max_size" { type = number; default = 3 }
variable "desired_capacity" { type = number; default = 1 }

# Outputs
output "asg_id" { value = aws_autoscaling_group.this.id }
output "asg_arn" { value = aws_autoscaling_group.this.arn }
