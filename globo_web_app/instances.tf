# INSTANCES #
resource "aws_instance" "nginx1" {
  count         = var.instance_count[terraform.workspace]
  ami           = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type = var.aws_instance_type[terraform.workspace]
  #subnet_id              = aws_subnet.subnets[(count.index % var.vpc_subnet_count)].id
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  #iam_instance_profile   = module.web_app_s3.aws_iam_instance_profile.nginx_profile.name
  iam_instance_profile = module.web_app_s3.instance_profile_object.name
  #depends_on             = [aws_iam_role_policy.allow_s3_all]
  depends_on = [module.web_app_s3]
  #tags                   = local.common_tags
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ec2_instance-${count.index}"
  })
  user_data = templatefile("${path.module}/startup_script.tpl", {
    s3_bucket_name = module.web_app_s3.bucket_object.id
  })
}