# Cost and Cleanup

## AWS Resources

This project uses:

- Amazon ECS Fargate
- Application Load Balancer
- Amazon ECR
- Amazon VPC
- Amazon CloudWatch
- AWS IAM
- Amazon S3
- Amazon DynamoDB

## Cost Management

The main resources that can continue generating usage charges are ECS Fargate tasks, Application Load Balancers, public IPv4 addresses, CloudWatch usage and data transfer.

For a learning environment, staging and production should be destroyed when they are not being used.

## Destroy Staging

```bash
cd terraform
terraform workspace select staging
terraform destroy
