variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "artifact_registry_repo" {
  description = "Artifact Registry repository ID"
  type        = string
  default     = "glac-repo"
}

variable "runtime_service_account" {
  description = "Cloud Run runtime service account id (without domain)"
  type        = string
  default     = "glac-service-account-runtime"
}

variable "cloud_run_service" {
  description = "Cloud Run service name"
  type        = string
  default     = "glac-runtime"
}

variable "port" {
  description = "Port used for ADK web"
  type = string
  default = "8080"
}

variable "model" {
  description = "Model name used by the app"
  type        = string
  default     = "gemini-2.5-flash"
}
