
# terraform-aws-modules

Reusable Terraform modules for the GenAI Infrastructure Platform lab.

This repository contains reusable AWS infrastructure components consumed by the [GenAI Infrastructure Platform](https://github.com/oguillinta/genai-infrastructure-platform).

## Modules

| Module | Purpose | Security defaults |
|---|---|---|
| S3 | Create an S3 bucket | Public access blocked, AES-256 encryption, bucket-owner-enforced ownership, versioning enabled by default |
| SQS | Create a standard SQS message queue | SQS-managed encryption at rest, configurable message retention and visibility timeout |
| DynamoDB | Create a NoSQL DynamoDB table | AWS-managed encryption at rest, on-demand billing, optional point-in-time recovery |

## Repository Structure

```text
terraform-aws-modules/
├── modules/
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── sqs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── dynamodb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## Usage

### S3 — Secure Bucket

```hcl
module "documents_bucket" {
  source = "git::https://github.com/oguillinta/terraform-aws-modules.git//modules/s3?ref=main"

  bucket_name = "example-customer-documents-dev"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    DataClass   = "internal"
  }
}
```

### SQS — Message Queue

```hcl
module "payments_queue" {
  source = "git::https://github.com/oguillinta/terraform-aws-modules.git//modules/sqs?ref=main"

  queue_name                 = "payments-events-dev"
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 30

  tags = {
    Environment = "dev"
    ManagedBy   = "genai-infrastructure-platform"
  }
}
```

### DynamoDB — NoSQL Table

```hcl
module "transactions_table" {
  source = "git::https://github.com/oguillinta/terraform-aws-modules.git//modules/dynamodb?ref=main"

  table_name    = "transactions-dev"
  hash_key      = "transaction_id"
  hash_key_type = "S"

  tags = {
    Environment = "dev"
    ManagedBy   = "genai-infrastructure-platform"
  }
}
```

## Integration with GenAI Infrastructure Platform

The modules are designed to be consumed through the assisted infrastructure provisioning workflow.

1. A user creates a GitHub Issue describing an infrastructure requirement.
2. The GenAI Infrastructure Platform discovers available Terraform modules.
3. The AI assistant selects a compatible module and identifies required parameters.
4. The orchestrator validates the request and creates a new repository using `terraform-infrastructure-template`.
5. Terraform configuration files are generated and submitted through a Pull Request.
6. Terraform validation and review are performed before any deployment.

Each module is independently reusable and can also be consumed directly through Terraform.

## Infrastructure Validation

Configure the AWS provider in the calling root module.

This repository contains reusable Terraform modules only. It does not provision AWS resources on its own.

The generated infrastructure repository is responsible for running validation, including:

```bash
terraform init
terraform fmt -check
terraform validate
```

Terraform plans and deployments require appropriate AWS credentials and infrastructure state configuration.

## Versioning

For development and academic environments, module references may use:

`?ref=main`

For production environments, pin a reviewed release tag or commit SHA to ensure reproducibility.

## Related Repositories

- [genai-infrastructure-platform](https://github.com/oguillinta/genai-infrastructure-platform) — AI-assisted orchestration and GitHub Actions.
- [terraform-infrastructure-template](https://github.com/oguillinta/terraform-infrastructure-template) — Base repository template for infrastructure projects.
- [terraform-aws-modules](https://github.com/oguillinta/terraform-aws-modules) — Reusable AWS Terraform modules.

Configure the AWS provider in the calling root module. This repository contains modules only; it does not deploy infrastructure on its own.

Validate modules against [cloud-governance](https://github.com/aldo2510/cloud-governance). Pin a reviewed commit SHA or release tag in production rather than using main.
