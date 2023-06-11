resource "kubernetes_namespace" "harmelodic" {
  metadata {
    name = "harmelodic"

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

module "harmelodic_website_workload" {
  source     = "./workload"
  name       = "website"
  namespace  = kubernetes_namespace.harmelodic.metadata.0.name
  project_id = data.google_project.apps.project_id
}

module "harmelodic_blog_workload" {
  source     = "./workload"
  name       = "blog"
  namespace  = kubernetes_namespace.harmelodic.metadata.0.name
  project_id = data.google_project.apps.project_id
}
