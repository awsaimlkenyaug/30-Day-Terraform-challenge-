module "s3_static_website" {
  source = "../../modules/s3-static-website"

  bucket_name     = var.bucket_name
  index_document  = var.index_document
  error_document  = var.error_document
  tags            = var.tags
}

module "cloudfront_static_site" {
  source = "../../modules/cloudfront-static-site"

  bucket_name                = module.s3_static_website.bucket_name
  s3_bucket_website_endpoint = module.s3_static_website.website_endpoint
  default_root_object        = var.index_document
  tags                       = var.tags
}
