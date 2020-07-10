#!/usr/bin/env bash

# Downloads the AKS configuration of one
# of the two clusters (dpt-services/devita)

dpt_services_subscription_id=737cc34a-38e9-485a-8ea8-6268ca423db1
dpt_services_aks_name=dpt-services-prod-aks-k8s-01
dpt_services_rg=dpt-services-prod-rg

devita_subscription_id=d30b533f-c88b-45ec-867e-8e321aa0b03f
devita_aks_name=devita-prod-aks-k8s-01
devita_rg=devita-prod-rg

function download_config {
  az account set -s "$1"
  az aks get-credentials -n "$2" -g "$3"
}

if [[ "$1" == "dpt-services" ]]; then
  download_config "${dpt_services_subscription_id}" "${dpt_services_aks_name}" "${dpt_services_rg}"
elif [[ "$1" == "devita" ]]; then
  download_config "${devita_subscription_id}" "${devita_aks_name}" "${devita_rg}"
else
  echo -e "\nYou must provide an AKS name: dpt-service | devita\n"
  exit -1
fi
