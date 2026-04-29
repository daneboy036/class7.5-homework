output "index_html" {
  value = "https://storage.googleapis.com/${google_storage_bucket_object.index.bucket}/${google_storage_bucket_object.index.name}"
}
