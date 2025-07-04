module "s3_static_website" {
  source      = "../../modules/s3-static-website"
  bucket_name = var.bucket_name
  environment = var.environment
}
output "website_endpoint" {
  value = module.s3_static_website.website_endpoint
}
