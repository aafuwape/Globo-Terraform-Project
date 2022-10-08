module "web_app_s3" {
  source                  = "./modules/globo-web-apps-s3"
  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}

## S3 Bucket Object
resource "aws_s3_object" "website_content" {
  for_each = {
    website = "/website/Globo_logo_Vert.png"
    logo    = "/website/index.html"
  }
  bucket = module.web_app_s3.bucket_object.id
  key    = each.value
  source = ".${each.value}"
  #tags   = local.common_tags
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-object"
  })
}


