variable "queue_name" {
  description = "Name of the SQS queue to create."
  type        = string

  validation {
    condition     = length(var.queue_name) > 0 && length(var.queue_name) <= 80 && can(regex("^[A-Za-z0-9_-]+$", var.queue_name))
    error_message = "queue_name must contain 1–80 letters, numbers, hyphens, or underscores."
  }
}

variable "delay_seconds" {
  description = "Time in seconds to delay delivery of new messages (0–900)."
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "Maximum message size in bytes (1024–1048576)."
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "Message retention period in seconds (60–1209600)."
  type        = number
  default     = 345600
}

variable "receive_wait_time_seconds" {
  description = "Long polling wait in seconds (0–20)."
  type        = number
  default     = 0
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds (0–43200)."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags applied to the queue."
  type        = map(string)
  default     = {}
}
