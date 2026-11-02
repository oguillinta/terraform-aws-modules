variable "table_name" {
  description = "Name of the DynamoDB table to create."
  type        = string

  validation {
    condition     = length(var.table_name) >= 3 && length(var.table_name) <= 255 && can(regex("^[A-Za-z0-9_.-]+$", var.table_name))
    error_message = "table_name must be 3–255 characters using letters, numbers, underscores, hyphens, or periods."
  }
}

variable "hash_key" {
  description = "Partition key attribute name, e.g. transaction_id."
  type        = string

  validation {
    condition     = length(trimspace(var.hash_key)) > 0
    error_message = "hash_key cannot be empty."
  }
}

variable "hash_key_type" {
  description = "Partition key type: S (string), N (number), or B (binary)."
  type        = string
  default     = "S"

  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "hash_key_type must be S, N, or B."
  }
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery (additional AWS charges may apply)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the table."
  type        = map(string)
  default     = {}
}
