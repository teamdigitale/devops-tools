function docker_run {
  docker run --rm -it \
    -v $PWD:/devops \
    -v $HOME/.kube:/root/.kube \
    -v $HOME/.azure:/root/.azure \
    -v $HOME/.local/bin:/root/.local/bin \
    teamdigitale/devops-tools:latest $@
}

az() {
  docker_run az $@
}

terraform() {
  docker_run terraform $@
}

terragrunt() {
  docker_run terragrunt $@
}

kubectl() {
  docker_run kubectl $@
}

helm() {
  docker_run helm $@
}

aks-config-download() {
  docker_run aks-config-download $@
}
