dpt_bogus_path=${1:-"$HOME/dpt-bogus"}

function docker_run {
  docker run \
    --rm \
    -it \
    -p 3000:3000 \
    -p 9090:9090 \
    -p 9093:9093 \
    -v $PWD:/devops \
    -v $HOME/.kube:/root/.kube \
    -v $HOME/.azure:/root/.azure \
    -v $HOME/.local/bin:/root/.local/bin \
    -v $HOME/.gnupg:/root/.gnupg \
    -v $dpt_bogus_path:/root/.password-store \
    teamdigitale/devops-tools:latest $@
}

pass() {
  docker_run pass $@
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
