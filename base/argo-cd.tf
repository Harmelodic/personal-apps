resource "kubernetes_namespace" "argo_cd" {
  metadata {
    name = "argocd"

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

resource "helm_release" "argo_cd" {
  chart      = "argo-cd"
  name       = "argo-cd"
  namespace  = kubernetes_namespace.argo_cd.metadata.0.name
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.36.1"

  set {
    name  = "args.appResyncPeriod" # resync all apps very X seconds
    value = "10"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }
}
