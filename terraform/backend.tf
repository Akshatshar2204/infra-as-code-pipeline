terraform {
  backend "s3" {
    bucket               = "infra-as-code-pipeline-tfstate-828479100787"
    key                  = "terraform.tfstate"
    region               = "ap-south-1"
    encrypt              = true
    dynamodb_table       = "infra-as-code-pipeline-tf-locks"
    use_lockfile         = true
    workspace_key_prefix = "environment"
  }
}
