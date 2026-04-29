# bucket
resource "google_storage_bucket" "static-site" {
  name          = "dcbmc75week7ss"
  location      = "US-CENTRAL1"
  force_destroy = true

  uniform_bucket_level_access = true # uniformly control access to bucket and all objects in it

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}


# bucket role
resource "google_storage_bucket_iam_member" "public-access" {
  bucket = google_storage_bucket.static-site.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# files to put in bucket
resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "${path.module}/../assets/index.html"
  bucket = google_storage_bucket.static-site.name
}
resource "google_storage_bucket_object" "four_o_four" {
  name   = "404.html"
  source = "${path.module}/../assets/404.html"
  bucket = google_storage_bucket.static-site.name
}
resource "google_storage_bucket_object" "css" {
  name   = "style.css"
  source = "${path.module}/../assets/style.css"
  bucket = google_storage_bucket.static-site.name
}
resource "google_storage_bucket_object" "image" {
  name   = "welcome-image.png"
  source = "${path.module}/../assets/welcom-image.png"
  bucket = google_storage_bucket.static-site.name
}
