locals {
  repo_root = abspath("../..")
  image_uri = "${var.region}-docker.pkg.dev/${var.project_id}/${var.artifact_registry_repo}/${var.cloud_run_service}:latest"
}
