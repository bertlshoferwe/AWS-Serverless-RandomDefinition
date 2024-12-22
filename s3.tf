resource "aws_s3_bucket" "code_storage" {
  bucket = "code-storage"

}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.code_storage.id
  key    = "my_lambda_deployment"
  source = "my_lambda_deployment"
}

resource "aws_s3_bucket" "static_website" {
  bucket = "Random-gen-web"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static_website.bucket
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"
}