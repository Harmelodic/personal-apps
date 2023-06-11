resource "kubernetes_namespace" "pact" {
  metadata {
    name = "pact"

    labels = {
      "pod-security.kubernetes.io/enforce"         = "privileged"
      "pod-security.kubernetes.io/enforce-version" = "latest"
      "pod-security.kubernetes.io/audit"           = "baseline"
      "pod-security.kubernetes.io/audit-version"   = "latest"
      "pod-security.kubernetes.io/warn"            = "restricted"
      "pod-security.kubernetes.io/warn-version"    = "latest"
    }
  }
}

module "pact_broker_workload" {
  source     = "./workload"
  name       = "broker"
  namespace  = kubernetes_namespace.pact.metadata.0.name
  project_id = data.google_project.apps.project_id
}

resource "random_password" "pact_broker_password" {
  length = 24
}

resource "kubernetes_secret" "pact_broker" {
  metadata {
    name      = "broker"
    namespace = kubernetes_namespace.pact.metadata.0.name
  }

  data = {
    password = random_password.pact_broker_password.result
  }
}
