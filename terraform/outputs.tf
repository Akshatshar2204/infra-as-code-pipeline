output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  value = module.compute.cluster_name
}

output "ecs_service_name" {
  value = module.compute.service_name
}

output "ecs_task_family" {
  value = module.compute.task_family
}

output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

output "github_deploy_role_arn" {
  value = module.security.github_deploy_role_arn
}
