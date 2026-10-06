# Architecture

## AWS Architecture

```mermaid
flowchart TD
    DEV[Developer] --> GH[GitHub Repository]

    GH --> PR[Pull Request]
    PR --> STAGE[GitHub Actions - Staging]

    STAGE --> TEST[Terraform Validate + TFLint + Pytest]
    TEST --> BUILD[Docker Build]
    BUILD --> ECRS[Amazon ECR - Staging]
    ECRS --> ECSS[ECS Fargate - Staging]
    ECSS --> ALBS[Application Load Balancer]
    ALBS --> APPS[Flask Application]

    GH --> MAIN[main]
    MAIN --> APPROVAL[Production Approval]
    APPROVAL --> PROD[GitHub Actions - Production]

    PROD --> ECRP[Amazon ECR - Production]
    ECRP --> ECSP[ECS Fargate - Production]
    ECSP --> ALBP[Application Load Balancer]
    ALBP --> APPP[Flask Application]

    ECSS --> CW[CloudWatch Logs]
    ECSP --> CW

    GH --> OIDC[GitHub OIDC]
    OIDC --> IAM[IAM Deployment Role]

    TF[Terraform] --> VPC[VPC + Subnets]
    TF --> ECS[ECS]
    TF --> ALB[ALB]
    TF --> IAM
    TF --> ECR[ ECR ]
    TF --> CW
