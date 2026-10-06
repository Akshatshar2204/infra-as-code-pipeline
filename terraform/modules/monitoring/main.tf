variable "log_group_name" {
  type = string
}

variable "retention_in_days" {
  type = number
}

variable "project_name" {
  type = string
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days

  tags = {
    Project = var.project_name
  }
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.ecs.name
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.ecs.arn
}
