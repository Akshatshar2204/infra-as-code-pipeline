data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  environment = terraform.workspace
  name        = "${var.project_name}-${local.environment}"
}

resource "aws_ecr_repository" "app" {
  name                 = local.name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project     = var.project_name
    Environment = local.environment
  }
}

resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1

        description = "Keep only the last 10 images"

        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}

module "networking" {
  source = "./modules/networking"

  project_name = local.name
  vpc_cidr     = "10.0.0.0/16"

  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )
}

module "monitoring" {
  source = "./modules/monitoring"

  log_group_name    = "/ecs/${local.name}"
  retention_in_days = 7
  project_name      = local.name
}

module "security" {
  source = "./modules/security"

  project_name             = local.name
  environment              = local.environment
  vpc_id                   = module.networking.vpc_id
  github_owner             = var.github_owner
  github_repository        = var.github_repository
  github_oidc_provider_arn = var.github_oidc_provider_arn
  ecr_repository_arn       = aws_ecr_repository.app.arn
  github_owner_id          = var.github_owner_id
  github_repository_id     = var.github_repository_id
}

module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  environment  = local.environment
  aws_region   = var.aws_region

  vpc_id     = module.networking.vpc_id
  subnet_ids = module.networking.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id

  task_execution_role_arn = module.security.ecs_task_execution_role_arn
  task_role_arn           = module.security.ecs_task_role_arn

  log_group_name = module.monitoring.log_group_name

  ecr_repository_url = aws_ecr_repository.app.repository_url

  image_uri      = var.bootstrap_image
  container_port = 80

  desired_count = 2
  min_capacity  = 2
  max_capacity  = 6
}
