resource "kubernetes_namespace" "pact" {
  metadata {
    name = "pact"
  }
}

module "pact_broker_workload" {
  source     = "./workload"
  name       = "broker"
  namespace  = kubernetes_namespace.pact.metadata.0.name
  project_id = data.google_project.apps.project_id
}
