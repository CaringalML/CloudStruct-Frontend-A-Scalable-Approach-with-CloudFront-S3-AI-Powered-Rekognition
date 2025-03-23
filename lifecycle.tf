resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.storage_bucket.id

  # Dynamic rules for intelligent tiering folders
  dynamic "rule" {
    for_each = toset(var.intelligent_tiering_folders)
    
    content {
      id     = "${replace(rule.value, "/", "")}_lifecycle"
      status = "Enabled"
      
      filter {
        prefix = rule.value
      }
      
      transition {
        days          = 0
        storage_class = "INTELLIGENT_TIERING"
      }
    }
  }

  # Cleanup rule for incomplete multipart uploads
  rule {
    id     = "cleanup_failed_uploads"
    status = "Enabled"
    
    filter {
      prefix = ""
    }
    
    abort_incomplete_multipart_upload {
      days_after_initiation = var.multipart_upload_cleanup_days
    }
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "intelligent_archive" {
  bucket = aws_s3_bucket.storage_bucket.id
  name   = "archive_configuration"

  # Archive tier for less frequently accessed data
  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = var.archive_access_days
  }

  # Deep archive tier for rarely accessed data
  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = var.deep_archive_access_days
  }
}