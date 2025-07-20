# resource "argocd_application" "argocd_app" {
#   metadata {
#     name      = "myapp"
#     namespace = "argocd"
#   }

#   spec {
#     project = "default"

#     source {
#       repo_url        = "https://github.com/aliashmawy/NTI_Final_Project.git"
#       path            = "argocd"
#       target_revision = "HEAD"
#     }

#     destination {
#       name      = "https://kubernetes.default.svc"
#       namespace = "default"
#     }
#   }
# }