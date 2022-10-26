resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argocd"

    labels = {
      environment = terraform.workspace
    }
  }
}

resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.8.2"

  set {
    name  = "args.appResyncPeriod" # resync all apps very X seconds
    value = "10"
  }
}
