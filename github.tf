provider "github" {
  token = var.github_token
}

module "github_helm_chart_repo" {
  source = "git::https://github.com/HolomuaTech/tf-github-repo.git"

  name         = var.helm_chart_repo.name
  organization = var.helm_chart_repo.organization
  description  = var.helm_chart_repo.description
  visibility   = var.helm_chart_repo.visibility
  auto_init    = var.helm_chart_repo.auto_init
  github_token = var.github_token
}
