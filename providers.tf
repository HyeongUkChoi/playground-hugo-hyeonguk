terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.29.1"
    }
  }
  
  backend "gcs" {
     bucket = "gcs-playground-hugo-tfstate"
  }
}

provider "google" {
  credentials = "${file("../key/playground-hugo-20240408-7dbec6d8fb38.json")}"
  project     = "playground-hugo-20240408"
  region      = "asia-northeast3"
}
