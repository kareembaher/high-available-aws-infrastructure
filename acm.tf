# SSL cert 

resource "aws_acm_certificate" "ssl" {
  private_key       = file("ssl/file.key")
  certificate_body  = file("ssl/file.crt")
  certificate_chain = file("ssl/file.bundle.crt")
  tags = {
    Name = "ssl"
  }
  lifecycle {
    create_before_destroy = true
  }
}
