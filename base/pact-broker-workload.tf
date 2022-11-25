resource "kubernetes_namespace" "pact_broker" {
  metadata {
    name = "pact-broker"
  }
}

module "pact_broker_workload" {
  source     = "./workload"
  name       = "pact-broker"
  namespace  = kubernetes_namespace.pact_broker.metadata.0.name
  project_id = data.google_project.apps.project_id
}
