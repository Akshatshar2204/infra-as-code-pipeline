# infra-as-code-pipeline

# Zero-Touch AWS ECS Deployment Pipeline

A fresher-level DevOps capstone project demonstrating automated infrastructure provisioning and application deployment using Terraform, GitHub Actions and AWS ECS Fargate.

## Technology Stack

- Git
- GitHub
- GitHub Actions
- Terraform
- Docker
- Amazon ECR
- Amazon ECS Fargate
- Application Load Balancer
- Amazon CloudWatch
- AWS IAM OIDC
- Python Flask
- Pytest

## CI/CD Flow

```text
Pull Request
     ↓
Terraform Format / Validate
     ↓
TFLint
     ↓
Pytest
     ↓
Docker Build
     ↓
ECR Push
     ↓
ECS Staging Deployment
     ↓
Merge to main
     ↓
Production Approval
     ↓
ECR Push
     ↓
ECS Production Deployment
     ↓
Health Monitoring
     ↓
Rollback on Failure
