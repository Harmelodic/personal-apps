resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  version    = "8.2.5"

  set = [
    {
      name  = "args.appResyncPeriod" # resync all apps very X seconds
      value = "10"
    },
    {
      name  = "configs.params.server\\.insecure" # Run Argo CD without TLS, since the Ingress will handle and terminate TLS
      value = "true"
    }
  ]
}
