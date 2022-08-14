resource "kubernetes_manifest" "apps_gitops_argo_app" {
  manifest = yamldecode(file("./apps-argo-cd-gitops-app.yaml"))
}
