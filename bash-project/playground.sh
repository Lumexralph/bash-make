#!/usr/bin/env bash

i=3; for instance in worker-0 worker-1 worker-2; do
cat > ${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${instance},172.16.16.10${i} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}

  (( i++ ))

done

{

KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=10.32.0.1,172.16.16.100,172.16.16.101,172.16.16.102,127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes

}

# copy files into the vagrant worker nodes 103 - 105
# not so secured but it is all in my local machine anyway
i=3; for instance in worker-0 worker-1 worker-2; do
 scp -o StrictHostKeyChecking=no ca.pem ${instance}-key.pem ${instance}.pem vagrant@172.16.16.10${i}:~/
 (( i++ ))
done

# copy files into the vagrant controller nodes server, also not secured
# but we are in our local machine anyway
i=0; for instance in controller-0 controller-1 controller-2; do
  scp -o StrictHostKeyChecking=no ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem vagrant@172.16.16.10${i}:~/

    (( i++ ))
done

KUBERNETES_PUBLIC_ADDRESS=127.0.0.1

#  reate kube config for worker nodes
for instance in worker-0 worker-1 worker-2; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=${instance}.pem \
    --client-key=${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done

# create config for kube-proxy
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.pem \
    --client-key=kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}

# create kube config for controller manager
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=kube-controller-manager.pem \
    --client-key=kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}

# scheduler kube config
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=kube-scheduler.pem \
    --client-key=kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}

# admin user config
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}

# distribute the config to the nodes,  kubelet and proxy to worker instance
# copy files into the vagrant worker nodes 103 - 105
# not so secured but it is all in my local machine anyway
i=3; for instance in worker-0 worker-1 worker-2; do
 scp -o StrictHostKeyChecking=no ${instance}.kubeconfig kube-proxy.kubeconfig vagrant@172.16.16.10${i}:~/

 (( i++ ))
done

# distribute the kubernetes controller manager and scheduler on controller nodes servers
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done

# copy files into the vagrant controller nodes server, also not secured
# but we are in our local machine anyway
i=0; for instance in controller-0 controller-1 controller-2; do
  scp -o StrictHostKeyChecking=no admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig \
    vagrant@172.16.16.10${i}:~/

    (( i++ ))
done

# create encyption config, because Kubernetes encrypts data in etcd
i=0; for instance in controller-0 controller-1 controller-2; do
  scp -o StrictHostKeyChecking=no encryption-config.yaml \
    vagrant@172.16.16.10${i}:~/

    (( i++ ))
done

scp -o IdentitiesOnly=yes pki/ca/ca.pem pki/ca/ca-key.pem pki/api/kubernetes-key.pem pki/api/kubernetes.pem pki/service-account/service-account-key.pem pki/service-account/service-account.pem vagrant@192.168.0.137:~/

scp -o IdentitiesOnly=yes data-encryption/encryption-config.yaml vagrant@192.168.0.196:~/

# https://sourcedigit.com/13664-install-wget-1-16-ubuntu-14-10-ubuntu-14-04-others/

EXTERNAL_IP=$(curl -s -4 https://ifconfig.co)
INTERNAL_IP=$(ip addr show eth1 | grep -Po 'inet \K[\d.]+')

{
instance=worker-2
EXTERNAL_IP=102.89.2.158
INTERNAL_IP=192.168.0.113

  cat > pki/clients/${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "${TLS_C}",
      "L": "${TLS_L}",
      "O": "system:nodes",
      "OU": "${TLS_OU}",
      "ST": "${TLS_ST}"
    }
  ]
}
EOF

cfssl gencert \
  -ca=pki/ca/ca.pem \
  -ca-key=pki/ca/ca-key.pem \
  -config=pki/ca/ca-config.json \
  -hostname=${instance},${INTERNAL_IP},${EXTERNAL_IP} \
  -profile=kubernetes \
  pki/clients/${instance}-csr.json | cfssljson -bare pki/clients/${instance}

}

{
  KUBERNETES_PUBLIC_ADDRESS=192.168.0.161
  KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local


cat > pki/api/kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "${TLS_C}",
      "L": "${TLS_L}",
      "O": "Kubernetes",
      "OU": "${TLS_OU}",
      "ST": "${TLS_ST}"
    }
  ]
}
EOF

cfssl gencert \
  -ca=pki/ca/ca.pem \
  -ca-key=pki/ca/ca-key.pem \
  -config=pki/ca/ca-config.json \
  -hostname=10.32.0.1,192.168.0.196,192.168.0.149,192.168.0.137,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  pki/api/kubernetes-csr.json | cfssljson -bare pki/api/kubernetes
}

{
 wget https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.12.1.linux-amd64.tar.gz

export GOPATH="/home/vagrant/go"
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
}