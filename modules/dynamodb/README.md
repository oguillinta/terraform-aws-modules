# DynamoDB table module

Creates one DynamoDB table using **on-demand (PAY_PER_REQUEST)** capacity and a single partition key. Encryption at rest uses AWS-managed encryption. Point-in-time recovery is optional and disabled by default.

## Inputs

- `table_name` (required): table name, e.g. `pagos-transacciones`
- `hash_key` (required): partition key name, e.g. `transaction_id`
- `hash_key_type` (optional, default `S`): `S`, `N`, or `B`
- `point_in_time_recovery_enabled` (optional, default `false`)
- `tags` (optional): map of tags

## Outputs

`table_id`, `table_arn`, `table_name`.

## Example

```hcl
module "dynamodb" {
  source     = "git::https://github.com/oguillinta/terraform-aws-modules.git//modules/dynamodb?ref=main"
  table_name = "pagos-transacciones"
  hash_key   = "transaction_id"
  tags = {
    Environment = "dev"
    ManagedBy   = "genai-infrastructure-platform"
  }
}
```

This module does not provision a sort key, global secondary indexes, or streams.
