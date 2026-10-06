# Operations Runbook

## Check ECS Service

```bash
aws ecs describe-services \
  --cluster zero-touch-production \
  --services zero-touch-production \
  --output table
