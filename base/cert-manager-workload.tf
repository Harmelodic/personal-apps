resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"

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

module "cert_manager_workload" {
  source     = "./workload"
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata.0.name
  project_id = data.google_project.apps.project_id
}

resource "google_project_iam_member" "cert_manager" {
  for_each = toset([
    "roles/dns.admin"
  ])

  member  = "serviceAccount:${module.cert_manager_workload.google_service_account.email}"
  project = data.google_project.host.project_id
  role    = each.key
}
