resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.38.1"

  set {
    name  = "args.appResyncPeriod" # resync all apps very X seconds
    value = "10"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
}
