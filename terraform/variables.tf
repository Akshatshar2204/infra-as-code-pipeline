variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "zero-touch"
}

variable "github_owner" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "github_oidc_provider_arn" {
  type = string
}

variable "bootstrap_image" {
  type    = string
  default = "nginx:alpine"
}
