# Apps
data "google_projects" "apps_lookup" {
  filter = "name:personal-${terraform.workspace}-apps lifecycleState:ACTIVE"
}

data "google_project" "apps" {
  project_id = data.google_projects.apps_lookup.projects[0].project_id
}

variable "apps_gke_location" {
  description = "Location of where GKE cluster will be created"
  sensitive   = true
  type        = string
}

data "google_container_cluster" "apps" {
  location = var.apps_gke_location
  name     = "apps"
  project  = data.google_project.apps.project_id
}
