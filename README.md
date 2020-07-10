# Dipartimento Trasformazione Digitale / DevOps toolkit

The repository contains a minimum set of tools used by DevOps to interact with the infrastructure.

The tools do not require any software pre-installed on your machine, but Docker.

You can pull the container and run commands inside it or execute commands directly from your computer, sourcing the [azure-profile.sh](azure-profile.sh) script. Each command will bring up the "DevOps toolkit container" and execute the command inside it.

## TL;TR

```shell
source azure-profile.sh # strongly suggested to put it in your ~/.bash_profile or ~/.bashrc

# Done! Execute the commands you need
# { az | terraform | terragrunt | helm | aks-config-download }
```

## Requirements

* [Docker](https://www.docker.com/products/docker-desktop)

## What commands/tools are supported

* az

* terraform 0.11.14

* terragrunt 0.18.2

* kubectl 1.18.0

* helm 3.3.0-rc.1

## Want the container only?

```shell
docker pull teamdigitale/devops-tools:latest
```

## Auto-completions

Auto-completions for each tool are included inside the container (meaning it will work if you run commands from it).
If you want auto-completion while invoking commands on your host machine you should look at scripts available online for your platform.
