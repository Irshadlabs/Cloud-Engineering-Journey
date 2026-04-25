# -----------------------------------------------------------------------------------
# Resource: aws_cloudfront_distribution
# Description: Deploys a global Content Delivery Network (CDN) using CloudFront 
#              to cache content at edge locations, reducing latency for global users.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "web_cdn" {
  origin {
    domain_name = var.alb_dns_name # Your Load Balancer from Day 56
    origin_id   = "ALB-Origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only" # Security first!
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  # Caching behavior settings
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "ALB-Origin"

    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Global distribution (PriceClass_100 is cheapest for labs)
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.ssl_cert_arn # From your Day 62 ACM setup
    ssl_support_method  = "snip-only"
  }
}
