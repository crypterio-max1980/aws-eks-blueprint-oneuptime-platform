
resource "kubernetes_secret_v1" "minio_root_credentials" {
  metadata {
    name      = "minio-root-credentials"
    namespace = "default"
  }

  data = {
    rootUser     = "root"
    rootPassword = var.minio_root_password
  }

  type = "Opaque"
}

resource "helm_release" "minio" {
  name       = "minio"
  namespace  = "default"
  repository = "https://charts.min.io/"
  chart      = "minio"
  version    = "5.4.0"

  create_namespace = false
  wait             = true
  timeout          = 600

  values = [
    yamlencode({
      mode     = "standalone"
      replicas = 1

      rootUser      = "root"
      existingSecret = kubernetes_secret_v1.minio_root_credentials.metadata[0].name

      image = {
        repository = "docker.io/pgsty/minio"
        tag        = "RELEASE.2026-08-04T00-00-00Z"
        pullPolicy = "IfNotPresent"
      }

      mcImage = {
        repository = "docker.io/pgsty/mc"
        tag        = "RELEASE.2026-09-16T00-00-00Z"
        pullPolicy = "IfNotPresent"
      }

      buckets = [
        {
          name   = "loki"
          policy = "none"
          purge  = false
        },
        {
          name   = "data"
          policy = "none"
          purge  = false
        }
      ]

      persistence = {
        enabled      = true
        storageClass = "gp3"
        size         = "50Gi"
        accessMode   = "ReadWriteOnce"
      }

      service = {
        type = "ClusterIP"
        port = 9000
      }

      consoleService = {
        type = "ClusterIP"
        port = 9001
      }

      resources = {
        requests = {
          memory = "256Mi"
          cpu    = "100m"
        }
        limits = {
          memory = "1Gi"
          cpu    = "1"
        }
      }
    })
  ]

  depends_on = [
    kubernetes_secret_v1.minio_root_credentials
  ]
}


variable "minio_root_password" {
  type      = string
  default   = "q1w2e3r4100@"
  sensitive = true
}
