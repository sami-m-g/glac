terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.20"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.6.2"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "docker" {}
