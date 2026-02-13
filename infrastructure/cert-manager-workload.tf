module "cert_manager_workload" {
  source     = "./workload"
  name       = "cert-manager"
  namespace  = "cert-manager" # TODO: Remove the need for this
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
