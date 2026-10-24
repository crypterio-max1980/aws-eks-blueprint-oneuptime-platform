
resource "kubernetes_ingress_v1" "ingress_route_uptime" {
  metadata {
    name      = "ingress-route-uptime"
    namespace = "default"

    annotations = {
      "konghq.com/strip-path" = "false"
    }
  }

  spec {
    ingress_class_name = "kong"

    tls {
      hosts       = ["uptime.crypterio.co"]
      secret_name = "crt"
    }

    rule {
      host = "uptime.crypterio.co"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "oneuptime-nginx"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
