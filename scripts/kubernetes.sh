#!/bin/bash

source ./scripts/lib.sh

# kubectl
KUBECTL_VERSION=v1.21.3
KUBECTL_URL=https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
install_bin kubectl $KUBECTL_URL

# helm
HELM_VERSION=v3.8.0
HELM_URL=https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
install_tar helm $HELM_URL linux-amd64

# k9s
K9S_VERSION=v0.25.15
K9S_URL=https://github.com/derailed/k9s/releases/download/$K9S_VERSION/k9s_Linux_x86_64.tar.gz
install_tar k9s $K9S_URL

# kubectx + kubens
KUBECTX_VERSION=v0.9.4
KUBECTX_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubectx
install_bin kubectx $KUBECTX_URL
KUBENS_URL=https://github.com/ahmetb/kubectx/releases/download/$KUBECTX_VERSION/kubens
install_bin kubens $KUBENS_URL

# kind
KIND_VERSION=v0.11.1
KIND_URL=https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-linux-amd64
install_bin kind $KIND_URL

# kustomize
KUSMTOMIZE_URL=https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.5.2/kustomize_v4.5.2_linux_amd64.tar.gz
install_tar kustomize $KUSMTOMIZE_URL

# kubebuilder
KUBEBUILDER_VERSION=v3.3.0
KUBEBUILDER_URL=https://github.com/kubernetes-sigs/kubebuilder/releases/download/$KUBEBUILDER_VERSION/kubebuilder_linux_amd64
install_bin kubebuilder $KUBEBUILDER_URL
