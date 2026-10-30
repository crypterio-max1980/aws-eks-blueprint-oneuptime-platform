

resource "kubernetes_namespace_v1" "oneuptime" {
  metadata {
    name = "oneuptime"

    labels = {
      app  = "oneuptime"
    }
  }
}

resource "helm_release" "oneuptime" {
  name       = "oneuptime"
  repository = "https://helm-chart.oneuptime.com"
  chart      = "oneuptime"
  namespace  = kubernetes_namespace_v1.oneuptime.metadata[0].name

  wait    = true
  timeout = 1200

  set = [
    {
      name  = "host"
      value = "uptime.crypterio.co"
    },
    {
      name  = "httpProtocol"
      value = "https"
    },
    {
      name  = "global.storageClass"
      value = "gp3"
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.oneuptime
  ]
}
