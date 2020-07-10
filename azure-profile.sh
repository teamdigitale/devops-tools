function docker_run {
  docker run --rm -it \
    -v $PWD:/devops \
    -v $HOME/.kube:/root/.kube \
    -v $HOME/.azure:/root/.azure \
    -v $HOME/.local/bin:/root/.local/bin \
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
