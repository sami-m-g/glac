resource "google_project_service" "artifact_registry_service" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "iam_service" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_artifact_registry_repository" "artifact_repo" {
  depends_on = [google_project_service.artifact_registry_service]

  location      = var.region
  repository_id = var.artifact_registry_repo
  description   = "Docker repository for glac images"
  format        = "DOCKER"
}

resource "google_service_account" "cloud_run_service_account" {
  account_id   = var.runtime_service_account
  display_name = "Glac Cloud Run runtime"
}

resource "google_project_iam_member" "cloud_run_aiplatform_user" {
  depends_on = [google_project_service.iam_service]

  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}

resource "docker_image" "app" {
  name = local.image_uri

  build {
    context    = "${path.module}/.."
    dockerfile = "${path.module}/../Dockerfile"
  }
}

resource "docker_registry_image" "app" {
  name = docker_image.app.name
}

resource "google_cloud_run_v2_service" "app" {
  depends_on = [
    google_project_iam_member.cloud_run_aiplatform_user,
    docker_registry_image.app
  ]

  name     = var.cloud_run_service
  location = var.region

  template {
    service_account = google_service_account.cloud_run_service_account.email

    containers {
      image = docker_registry_image.app.name

      ports {
        container_port = var.port
      }

      env {
        name  = "GOOGLE_GENAI_USE_VERTEXAI"
        value = "1"
      }

      env {
        name  = "GOOGLE_CLOUD_PROJECT"
        value = var.project_id
      }

      env {
        name  = "GOOGLE_CLOUD_LOCATION"
        value = var.region
      }

      env {
        name  = "MODEL"
        value = var.model
      }

      env {
        name = "PORT"
        value = var.port
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_invoker" {
  location = var.region
  name     = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
