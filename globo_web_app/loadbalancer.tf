data "aws_elb_service_account" "root" {}

## aws_lb
resource "aws_lb" "nginx" {
  name               = "globoWebAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_app_s3.bucket_object.id
    prefix  = "alb-logs"
    enabled = true
  }

  #tags = local.common_tags
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-lb"
  })
}

## aws_lb_target_group
resource "aws_lb_target_group" "globo_alb_tg" {
  name = "globoWebAlbTg"
  # target_type = "alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  #tags = local.common_tags
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-tg"
  })
}

## aws_lb_listener
resource "aws_lb_listener" "globo_alb_lis" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.globo_alb_tg.arn
  }
  #tags = local.common_tags
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-listener"
  })
}
## aws_lb_target_group_attachment
resource "aws_lb_target_group_attachment" "globo_attach" {
  count            = var.instance_count[terraform.workspace]
  target_group_arn = aws_lb_target_group.globo_alb_tg.arn
  target_id        = aws_instance.nginx1[count.index].id
  port             = 80
}
