
module "storage" {
  source       = "../../../tf-modules/storage"
  bucket_name  = var.bucket_name
  region        = var.region
  archive_name = var.archive_name
  functioncode = var.functioncode
}

module "cloud_function" {
  source        = "../../../tf-modules/cf"
  function_name = var.function_name
  region        = var.region
  entry_point   = var.entry_point
  role          = var.role
  bucket_name   = module.storage.bucket_name
  archive_name  = module.storage.archive_name
}

module "load_balancer" {
  source              = "../../../tf-modules/lb"
  function_name       = module.cloud_function.function_name
  function_dependency = module.cloud_function.function_name
  region              = var.region
}

