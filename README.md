# Dipartimento Trasformazione Digitale / DevOps toolkit

The repository contains a minimum set of tools used by DevOps to interact with the infrastructure.

The tools do not require any software pre-installed on your machine, but Docker.

You can pull the container and run commands inside it or execute commands directly from your computer, sourcing the [azure-profile.sh](azure-profile.sh) script. Each command will bring up the "DevOps toolkit container" and execute the command inside it.

## TL;DR

Execute commands from your machine (recommended)

```shell
# Strongly suggested to put it in your ~/.bash_profile or ~/.bashrc
source azure-profile.sh PATH_TO_YOUR DPT_BOGUS

# Note: if PATH_TO_YOUR DPT_BOGUS is not set it defaults to ~/dpt-bogus

# Done! Execute the commands you need
# { az | pass | terraform | terragrunt | helm | aks-config-download }
```

Bring the container environment up manually with docker-compose and execute commands inside the container

```shell
DPT_BOGUS_PATH=YOUR_PATH_TO_YOUR_LOCAL_DPT_BOGUS_REPO docker-compose up -d
docker exec -it devops_tools /bin/bash

# Note: if DPT_BOGUS_PATH is not set it defaults to ~/dpt-bogus

# Exit and stop the container
exit
docker-compose down
```

## Requirements

* [Docker](https://www.docker.com/products/docker-desktop)

## What commands/tools are supported

* az (latest image available)

* pass 1.7.3

* terraform 0.11.14

* terragrunt 0.18.2

* kubectl 1.18.0

* helm 3.3.0-rc.1

## aks-config-download.sh

Often you're required to download the AKS config for one of the Team's clusters. It's a simple but convoluted operation. The [aks-config-download.sh tool](aks-config-download.sh) simplifies the procedure:

```shell
aks-config-download {dpt-services | devita}
```

## Want the container only?

```shell
docker pull teamdigitale/devops-tools:latest
```

## Auto-completions

Auto-completions for each tool are included inside the container (meaning it will work if you run commands from it).
If you want auto-completion while invoking commands on your host machine you should look at scripts available online for your platform.
