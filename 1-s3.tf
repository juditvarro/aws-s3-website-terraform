resource "aws_s3_bucket" "react_app_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "react_app_config" {
  bucket = aws_s3_bucket.react_app_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "react_app_bucket_ownership" {
  bucket = aws_s3_bucket.react_app_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "react_app_bucket_access" {
  bucket = aws_s3_bucket.react_app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "react_app_bucket_acl" {
  bucket = aws_s3_bucket.react_app_bucket.id
  acl    = "public-read"

  depends_on = [aws_s3_bucket_ownership_controls.react_app_bucket_ownership, aws_s3_bucket_public_access_block.react_app_bucket_access]
}

resource "aws_s3_bucket_policy" "allow_public_access_to_s3_bucket" {
  bucket = aws_s3_bucket.react_app_bucket.id
  policy = data.aws_iam_policy_document.allow_public_access_to_s3_bucket.json
}

data "aws_iam_policy_document" "allow_public_access_to_s3_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.react_app_bucket.arn}/*",
    ]
  }

  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:*",
    ]

    effect = "Deny"

    resources = [
      aws_s3_bucket.react_app_bucket.arn,
      "${aws_s3_bucket.react_app_bucket.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
