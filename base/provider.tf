terraform {
  required_version = ">=1.1.8"

  backend "gcs" {
    bucket = "harmelodic-tfstate"
    prefix = "personal-apps-gitops"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.40.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
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

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.apps.endpoint}"
  cluster_ca_certificate = base64decode(data.google_container_cluster.apps.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.apps.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.apps.master_auth.0.cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}
