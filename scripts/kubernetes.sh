#!/bin/bash

source ./scripts/lib.sh

USER_HOME=$(get_user_home)

# kubectl
KUBECTL_VERSION=v1.25.3
KUBECTL_URL=https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
install_bin kubectl $KUBECTL_URL

# helm
HELM_VERSION=v3.10.2
HELM_URL=https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
install_tar helm $HELM_URL linux-amd64

# kubectx + kubens
KUBECTX_VERSION=v0.9.4
KUBECTX_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubectx
install_bin kubectx $KUBECTX_URL
KUBENS_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubens
install_bin kubens $KUBENS_URL

# kind
KIND_VERSION=v0.17.0
KIND_URL=https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-linux-amd64
install_bin kind $KIND_URL

# kustomize
KUSMTOMIZE_URL=https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.7/kustomize_v4.5.7_linux_amd64.tar.gz
install_tar kustomize $KUSMTOMIZE_URL

# kubebuilder
KUBEBUILDER_VERSION=v3.7.0
KUBEBUILDER_URL=https://github.com/kubernetes-sigs/kubebuilder/releases/download/$KUBEBUILDER_VERSION/kubebuilder_linux_amd64
install_bin kubebuilder $KUBEBUILDER_URL

# cilium
CILIUM_VERSION=v0.12.11
CILIUM_URL=https://github.com/cilium/cilium-cli/releases/download/$CILIUM_VERSION/cilium-linux-amd64.tar.gz
install_tar cilium $CILIUM_URL

# flux
FLUX_VERSION=v0.37.0
FLUX_URL=https://github.com/fluxcd/flux2/releases/download/$FLUX_VERSION/flux_0.37.0_linux_amd64.tar.gz
install_tar flux $FLUX_URL

# cert-manager
CM_VERSION=v1.10.1
CM_URL=https://github.com/cert-manager/cert-manager/releases/download/$CM_VERSION/cmctl-linux-amd64.tar.gz
install_tar cmctl $CM_URL

# kubeseal
KUBESEAL_VERSION=0.19.2
KUBESEAL_URL=https://github.com/bitnami-labs/sealed-secrets/releases/download/v$KUBESEAL_VERSION/kubeseal-$KUBESEAL_VERSION-linux-amd64.tar.gz
install_tar kubeseal $KUBESEAL_URL

# k9s
K9S_VERSION=v0.26.7
K9S_URL=https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_x86_64.tar.gz
install_tar k9s $K9S_URL
mkdir -p $USER_HOME/.config/k9s

K9S_THEME=nord
K9S_THEME_URL=https://raw.githubusercontent.com/derailed/k9s/$K9S_VERSION/skins/$K9S_THEME.yml
curl -Lo $USER_HOME/.config/k9s/skin.yml $K9S_THEME_URL

K9S_PLUGINS=(
  flux
  watch_events
)
K9S_PLUGIN_FILE=plugin.yml
K9S_PLUGIN_CONFIG=$USER_HOME/.config/k9s/plugin.yml
rm $K9S_PLUGIN_CONFIG
for i in "${!K9S_PLUGINS[@]}"; do
  K9S_PLUGIN="${K9S_PLUGINS[$i]}" 
  K9S_PLUGIN_URL=https://raw.githubusercontent.com/derailed/k9s/$K9S_VERSION/plugins/$K9S_PLUGIN.yml
  curl -Lo $K9S_PLUGIN_FILE $K9S_PLUGIN_URL
  cat $K9S_PLUGIN_FILE >> $K9S_PLUGIN_CONFIG
done
rm $K9S_PLUGIN_FILE