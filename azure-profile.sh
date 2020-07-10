function docker_run {
  docker run --rm -it \
    -u $UID:$(id -g) \
    -v $PWD:/devops \
    -v $HOME/.kube:/.kube \
    -v $HOME/.azure:/.azure \
    -v $HOME/.local/bin:/usr/local/bin \
    teamdigitale/devops-tools:latest $@
}

function az {
  docker_run az $@
}

function terraform {
  docker_run terraform $@
}

function terragrunt {
  docker_run terragrunt $@
}

function kubectl {
  docker_run kubectl $@
}

function helm {
  docker_run helm $@
}

function aks-config-download {
  docker_run aks-config-download $@
}
