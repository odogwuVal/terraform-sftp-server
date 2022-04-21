

variable "bucket_name" {
  type        = string
  description = "SFTP Transfer S3 Bucket to transfer to/from"
}

variable "bucket_key" {
  type = string
}

variable "bucket_name_logging" {
  type        = string
  description = "SFTP Transfer S3 Bucket to use for S3 logging the transfer bucket"
}

variable "bucket_prefix_logging" {
  type        = string
  description = "SFTP Transfer S3 Bucket prefix use for S3 logging the transfer bucket"
  default     = ""
}

variable "home_dir_prefix" {
  type        = string
  description = "Prefix for home dir.  Homedirs are <S3bucket>/<home_dir_prefix><username>"
  default     = "home/"
}

variable "manage_bucket" {
  type        = bool
  description = "If true, create/manage the S3 bucket in the module"
  default     = true
}

variable "manage_bucket_logging" {
  type        = bool
  description = "If true, create/manage the S3 bucket used for logging in the module"
  default     = true
}

variable "s3_object_expiration_days" {
  description = "Number of days to keep objects in SFTP S3 bucket if managed.  No expiration if 0."
  type        = number
  default     = null
}

variable "tags" {
  # type = string
  description = "Tags to assign to buckets and roles"
  default     = {}
}

variable "sftp-user" {
  type        = map(string)
  description = "User to access the sftp server"
  default     = {
    "odogwu" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoDVgZFt2eXZsaEWw83hAcoQdLvrwLaFP30JG4a7T7k7yDqeo4s4Ee0XRFA3vfUqIC6I6Jsi8KsrMHA3hYZhNtCqqumBHGEAZ/zwz6rKtcTH6ti59JbPjueaZE7WXRgBQPU7Q/r6U1Y53AVZRSF+maeTSWT8iLYNOU6G2QFK3vwW++Fcv5p4qNBbuTIytxY3rO499KUQTCwBOqXna5aXfwMy9HaIV9fOIbmG1ngeYsvDAbdlNZoJHAPgTK1lzwe1qBjeEleqH9nfnC7ACQ4vtgS1jCBWVxwG8uXrTwq6RPIv/l3NEr1YH+iW5n2c5SjsK3VxBxvRNiy0wamK6srF1UvCqlaH/6gfMy/dvtuO8dbZMQa8CPMbNB/HmM4fKww7wBa+I6oEpbbFkBPrU4IwPhRIIGxo0fHjHesUEY4cwDY83jzo12IxtYtCKwl/hXbzNlpPYBpGbDBwZKqK8SCVx54TmF5gGbvdFSYxpSE9KtniU+0Da3Ph4IyQU905Wdp2M= devops-01@DESKTOP-7J1VCUS"
  }
}

# variable "users_read_write" {
#   type        = map(string)
#   description = "Read-Write Users"
#   default     = {}
# }

# variable "users_write_only" {
#   type        = map(string)
#   description = "Write-Only Users"
#   default     = {}
# }

variable "endpoint_type" {
  type = string
  description = "the endpoint for your SFTP server, could be public or VPC{vpc endpoints cannot be accessed over the public internet}"
}