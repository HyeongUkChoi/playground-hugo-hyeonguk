resource "google_storage_bucket" "gcs-playground-hugo-tfstate" {
    name = "gcs-playground-hugo-tfstate"
    location = "asia-northeast3"
    versioning {
        enabled = "true"
    }
}