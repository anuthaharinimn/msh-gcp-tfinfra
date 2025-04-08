variable "bucket_name" {
  type        = string
}
variable "region" {
  type        = string
}
variable "archive_name" {
  type        = string
}
variable "functioncode" {
  type        = string
  default     = "../../../cf.zip"
}