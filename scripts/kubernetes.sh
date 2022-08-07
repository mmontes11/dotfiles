#!/bin/bash

source ./scripts/lib.sh

USER_HOME=$(get_user_home)

# kubectl
KUBECTL_VERSION=v1.23.6
KUBECTL_URL=https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
install_bin kubectl $KUBECTL_URL

# helm
HELM_VERSION=v3.9.0
HELM_URL=https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
install_tar helm $HELM_URL linux-amd64

# kubectx + kubens
KUBECTX_VERSION=v0.9.4
KUBECTX_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubectx
install_bin kubectx $KUBECTX_URL
KUBENS_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubens
install_bin kubens $KUBENS_URL

# kind
KIND_VERSION=v0.14.0
KIND_URL=https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-linux-amd64
install_bin kind $KIND_URL

# kustomize
KUSMTOMIZE_URL=https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.5/kustomize_v4.5.5_linux_amd64.tar.gz
install_tar kustomize $KUSMTOMIZE_URL

# kubebuilder
KUBEBUILDER_VERSION=v3.5.0
KUBEBUILDER_URL=https://github.com/kubernetes-sigs/kubebuilder/releases/download/$KUBEBUILDER_VERSION/kubebuilder_linux_amd64
install_bin kubebuilder $KUBEBUILDER_URL

# clusterctl
CLUSTERCTL_VERSION=v1.2.0
CLUSTERCTL_URL=https://github.com/kubernetes-sigs/cluster-api/releases/download/$CLUSTERCTL_VERSION/clusterctl-linux-amd64
install_bin clusterctl $CLUSTERCTL_URL

# cilium
CILIUM_VERSION=v0.11.10
CILIUM_URL=https://github.com/cilium/cilium-cli/releases/download/$CILIUM_VERSION/cilium-linux-amd64.tar.gz
install_tar cilium $CILIUM_URL

# flux
FLUX_VERSION=v0.27.4
FLUX_URL=https://github.com/fluxcd/flux2/releases/download/$FLUX_VERSION/flux_0.27.4_linux_amd64.tar.gz
install_tar flux $FLUX_URL

# kubeseal
KUBESEAL_VERSION=0.17.3
KUBESEAL_URL=https://github.com/bitnami-labs/sealed-secrets/releases/download/v$KUBESEAL_VERSION/kubeseal-$KUBESEAL_VERSION-linux-amd64.tar.gz
install_tar kubeseal $KUBESEAL_URL

# stern
STERN_VERSION=1.11.0
STERN_URL=https://github.com/wercker/stern/releases/download/$STERN_VERSION/stern_linux_amd64
install_bin stern $STERN_URL

# k9s
K9S_VERSION=v0.26.3
K9S_URL=https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_x86_64.tar.gz
install_tar k9s $K9S_URL
mkdir -p $USER_HOME/.config/k9s

K9S_THEME=nord
K9S_THEME_URL=https://raw.githubusercontent.com/derailed/k9s/$K9S_VERSION/skins/$K9S_THEME.yml
curl -Lo $USER_HOME/.config/k9s/skin.yml $K9S_THEME_URL

K9S_PLUGINS=(
  flux
  helm_values
  log_stern
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