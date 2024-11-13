CLEAR
clear
sudo apt update && sudo apt upgrade -y
clear
sudo snap install microk8s --classic
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
mkdir .kube
sudo chown -R ubuntu ~/.kube
microk8s status --wait-ready
clear
exit
sudo chown -R ubuntu ~/.kube
clear
microk8s status --wait-ready
clear
newgrp microk8s
clear
microk8s status --wait-ready
clear
microk8s status --wait-ready
clear
microk8s add-node
clearclear
clear
microk8s get nodes
clear
microk8s add-node
clear
microk8s kubectl get nodes
microk8s add-node
clear
microk8s enable helm3
microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update
microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs  --namespace kube-system  --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet
microk8s kubectl get csidrivers
clear
microk8s get nodes
microk8s kubectl get nodes
microk8s remove-node ip-172-31-1-179
clear
microk8s kubectl get nodes
microk8s remove-node ip-172-31-1-179
clear
microk8s enable dashboard dns registry istio
microk8s enable ingress
alias kubectl="microk8s kubectl"
clear
kubectl get nodes
clear
microk8s enable dashboard
microk8s enable dns
microk8s enable registry
microk8s enable community
clear
microk8s enable istio
microk8s enable ingress
clear
mkdir NFS-config K8S-wordpress
ls
cd NFS-config/
clear
touch pvc-nfs.yaml sc-nfs.yaml
cd ..
ls
cd K8S-wordpress/
clear
mkdir ingress mysql ssl wordpress
ls
clear
cd ingress/
touch http-ingress.yaml
cd ..
cd mysql/
touch deployment-mysql.yaml pv-mysql.yaml pvc-mysql.yaml service-mysql.yaml
cd ..
ls
cd ssl/
mkdir yamls
cd yamls/
touch cluster-issuer-staging.yaml cluster-issuer.yaml ingress-routes.yaml
clear
cd ../../wordpress/
ls
touch deployment-wp.yaml pv-wp.yaml pvc-wp.yaml service-wp.yaml
cd ..
clear
ls
cd ..
ls
cd NFS-config/
ls
sudo nano sc-nfs.yaml 
sudo nano pvc-nfs.yaml 
cd ..
ls
cd K8S-wordpress/
ls
clear
ls
cd mysql/
ls
sudo nano pv-mysql.yaml 
sudo nano pvc-mysql.yaml 
sudo nano service-mysql.yaml 
sudo nano deployment-mysql.yaml 
clear
kubectl apply -f pv-mysql.yaml 
kubectl apply -f pvc-mysql.yaml 
kubectl apply -f service-mysql.yaml 
kubectl apply -f deployment-mysql.yaml 
cd ..
ls
cd wordpress/
ls
clear
ls
sudo nano pv-wp.yaml 
sudo nano pvc-wp.yaml 
sudo nano service-wp.yaml 
sudo nano deployment-wp.yaml 
cd ..
ls
cd mysql/
ls
cat pv-mysql.yaml 
cat pvc-mysql.yaml 
cat service-mysql.yaml 
cat deployment-mysql.yaml 
clear
ls
cd ..
ls
cd wordpress/
ls
clear
ls
cat service-wp.yaml 
cat pvc-wp.yaml 
cat pv-wp.yaml 
clear
ls
sudo nano deployment-wp.yaml 
clear
ls
kubectl apply -f pv-wp.yaml 
kubectl apply -f pvc-wp.yaml 
kubectl apply -f service-wp.yaml 
kubectl apply -f deployment-wp.yaml 
ls
cd ..
ls
cd ingress/
ls
sudo nano http-ingress.yaml 
kubectl apply -f http-ingress.yaml 
cd
clear
microk8s kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
ls
microk8s kubectl create namespace cert-manager
microk8s kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml
clear
kubectl get pods -n=cert-manager
ls
cd k8
cd K8S-wordpress/
LS
ls
clear
cd ssl/
clear
openssl genrsa -out letsencrypt-staging.pem 2048
openssl genrsa -out letsencrypt-private-key.pem 2048
sudo microk8s kubectl create secret generic letsencrypt-staging --from-file=letsencrypt-staging.pem
microk8s kubectl create secret generic letsencrypt-private-key --from-file=letsencrypt-private-key.pem
ls
cd yamls/
ls
sudo nano cluster-issuer-staging.yaml 
sudo nano cluster-issuer.yaml 
ls
sudo nano ingress-routes.yaml 
clear
kubectl apply -f cluster-issuer-staging.yaml 
kubectl apply -f cluster-issuer.yaml 
kubectl apply -f ingress-routes.yaml 
clear
cd
clear
ls
kubectl get nodes
kubectl get services
kubectl get pods
microk8s add-node
clear
kubectl get nodes
kubectl get pods
kubectl get services
clear
microk8s kubectl get csidrivers
showmount -e
sudo apt install nfs-common
clear
showmount -e
showmount -e 172.31.4.74
clear
kubectl get pods
kubectl get services
showmount -e 172.31.4.74
sudo systemctl restart rpcbind
telnet 172.31.4.74 2049
clear
ls -l /mnt
touch /mnt/testfile.txt
sudo touch /mnt/testfile.txt
ls -l /mnt
clear
sudo apt install -y apt-transport-https ca-certificates curl
clear
kubectl cluster-info
minikube start
microk8s enable dns dashboard storage
clear
sudo mount -t nfs 172.31.4.74:/mnt/wordpress /mnt
kubectl get pods
kubectl describe pods wordpress-67b98bbc54-t6bmw
clear
kubectl logs wordpress-67b98bbc54-t6bmw
clear
kubectl get pvc
kubectl get pv
clear
kubectl get pods
kubectl delete pods --all
clear
kubectl get pods
microk8s enable metallb
microk8s enable metallb 172.31.0.0/16
clear
