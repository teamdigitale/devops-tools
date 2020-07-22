FROM mcr.microsoft.com/azure-cli:latest AS base

ENV PASS_VERSION 1.7.3
ENV TERRAFORM_VERSION 0.11.14
ENV TERRAGRUNT_VERSION 0.18.2
ENV KUBECTL_VERSION 1.18.0
ENV HELM_VERSION 3.3.0-rc.1

WORKDIR /devops

FROM base AS requirements

# Install requirements
RUN apk update \
 && apk add bash-completion \
            gnupg \
            tree \
            vim

# Configure completion
RUN mkdir -p /etc/bash_completion.d/
RUN echo -e "\nsource /usr/share/bash-completion/bash_completion" >> ~/.bashrc

FROM requirements AS pass

# Install password-store (pass)
RUN wget https://git.zx2c4.com/password-store/snapshot/password-store-${PASS_VERSION}.zip
RUN unzip password-store-${PASS_VERSION}.zip
RUN cd password-store-${PASS_VERSION} && make install
RUN rm -rf password-store-${PASS_VERSION} password-store-${PASS_VERSION}.zip

FROM pass AS terraform

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN chmod +x terraform
RUN mv terraform /usr/local/bin

# Install Terragrunt
RUN curl -LO https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
RUN chmod +x terragrunt_linux_amd64
RUN mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

FROM terraform AS kubernetes

# Install Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/kubectl

# Configure Kubectl completion
RUN echo -e "source <(kubectl completion bash)" >> ~/.bashrc
RUN kubectl completion bash >/etc/bash_completion.d/kubectl

# Install Helm
RUN curl -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
RUN tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz
RUN rm helm-v${HELM_VERSION}-linux-amd64.tar.gz
RUN chmod +x linux-amd64/helm
RUN mv linux-amd64/helm /usr/local/bin/

# Configure Helm completion
RUN echo -e "source <(helm completion bash)" >> ~/.bashrc
RUN helm completion bash >/etc/bash_completion.d/helm

FROM kubernetes AS scripts

# Copy AKS download scripts
COPY aks-config-download.sh .
RUN chmod +x aks-config-download.sh
RUN mv aks-config-download.sh /usr/local/bin/aks-config-download
