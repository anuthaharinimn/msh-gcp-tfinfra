variable "bucket_name" {
  default = "helloworld22222"
  type = string
}

variable "archive_name" {
  default = "cf.zip"
  type = string
}

variable "function_name" {
  default = "tech_function"
  type = string
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "entry_point" {
  type        = string
  default     = "hello_world"
}

variable "role" {
  type        = string
  default     = "roles/cloudfunctions.invoker"
}

variable "functioncode" {
  type        = string
  default     = "../../../../cf.zip"
}