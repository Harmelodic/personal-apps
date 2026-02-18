terraform {
  required_version = ">=1.1.8"

  backend "gcs" {
    bucket = "harmelodic-tfstate"
    prefix = "personal-apps-infrastructure"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.20.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }
}

variable "region" {
  default     = "europe-north1"
  description = "GCP Region"
  sensitive   = true
  type        = string
}

provider "google" {
  region = var.region
}

data "google_client_config" "current" {}

# TODO: Remove when all Kubernetes manifests have been moved to `manifests`.
provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.apps.endpoint}"
  cluster_ca_certificate = base64decode(data.google_container_cluster.apps.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

provider "helm" {
  kubernetes = {
    host                   = "https://${data.google_container_cluster.apps.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.apps.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}
