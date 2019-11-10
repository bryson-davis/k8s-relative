#!/bin/bash
# download k8s 1.15.2 images
# get image-list by 'kubeadm config images list --kubernetes-version=v1.15.2'
# gcr.azk8s.cn/google-containers == k8s.gcr.io
#images=(
#kube-apiserver:v1.15.2
#kube-controller-manager:v1.15.2
#kube-scheduler:v1.15.2
#kube-proxy:v1.15.2
#pause:3.1
#etcd:3.3.10
#coredns:1.3.1
#)
if [ $# -ne 1 ];then
    echo "please user in: ./`basename $0` KUBERNETES-VERSION"
    exit 1
fi
version=$1
 
images=`kubeadm config images list --kubernetes-version=${version} |awk -F'/' '{print $2}'`
 
for imageName in ${images[@]};do
    docker pull gcr.azk8s.cn/google-containers/$imageName
    docker tag  gcr.azk8s.cn/google-containers/$imageName k8s.gcr.io/$imageName
    docker rmi  gcr.azk8s.cn/google-containers/$imageName
done