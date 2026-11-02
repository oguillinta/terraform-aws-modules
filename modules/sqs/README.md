# SQS queue module

Creates one **standard** AWS SQS queue with SQS-managed server-side encryption.

## Inputs

- `queue_name` (required): queue name, e.g. `pagos-eventos`
- `delay_seconds` (optional, default `0`)
- `max_message_size` (optional, default `262144`)
- `message_retention_seconds` (optional, default `345600`)
- `receive_wait_time_seconds` (optional, default `0`)
- `visibility_timeout_seconds` (optional, default `30`)
- `tags` (optional): map of tags

## Outputs

`queue_id` (URL), `queue_arn`, `queue_name`.

## Example

```hcl
module "sqs" {
  source     = "git::https://github.com/oguillinta/terraform-aws-modules.git//modules/sqs?ref=main"
  queue_name = "pagos-eventos"
  tags = {
    Environment = "dev"
    ManagedBy   = "genai-infrastructure-platform"
  }
}
```

This module does not include IAM policies, dead-letter queues, or FIFO semantics.
