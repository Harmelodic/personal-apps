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
