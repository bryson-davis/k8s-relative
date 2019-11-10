#!/bin/bash
# download k8s 1.15.2 images
# get image-list by 'kubeadm config images list --kubernetes-version=v1.15.2'
# gcr.azk8s.cn/google-containers == k8s.gcr.io
 
images=(
flannel:v0.11.0-amd64
flannel:v0.11.0-arm64
flannel:v0.11.0-arm
flannel:v0.11.0-ppc64le
flannel:v0.11.0-s390x
)
 
for imageName in ${images[@]};do
    docker pull quay.azk8s.cn/coreos/$imageName  
    docker tag  quay.azk8s.cn/coreos/$imageName quay.io/coreos/$imageName  
    docker rmi  quay.azk8s.cn/coreos/$imageName
done