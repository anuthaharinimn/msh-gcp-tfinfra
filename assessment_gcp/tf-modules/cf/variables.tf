variable "function_name" {
  type        = string
}
variable "region" {
  type        = string
}
variable "entry_point" {
  type        = string
}
variable "role" {
  type        = string
}
variable "bucket_name" {
  type        = string
}
variable "archive_name" {
  type        = string
}
variable "memory" {
  default     = "128"
  type        = string
}