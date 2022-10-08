# Bucket Name
variable "bucket_name" {
  type        = string
  description = "Name of bucket"
  #default     = "${local.name_prefix}-bucket"
}

# ELB service account arn
#data "aws_elb_service_account" "elb_sa" {}

variable "elb_service_account_arn" {
  type        = string
  description = "ELB service account arn"
  #default     = data.aws_elb_service_account.arn
}

# Common tags
variable "common_tags" {
  type        = map(string)
  description = "Map of tags to be applied to all resources"
  default     = {}
}
